# Decrypt: ruby -r './env_retriever.rb' -e 'EnvRetriever.decrypt_files'
# Encrypt: ruby -r './env_retriever.rb' -e 'EnvRetriever.encrypt_files'


require 'openssl'

# Encrypts files using master.key
module Encryptor
  # Encrypts a file with AES-256-CBC
  # @param filepath [String] relative path to non-encrypted file
  # @param key [String] the cipher key
  def self.encrypt(filepath:, key:)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.encrypt
    cipher.key = key

    iv = cipher.random_iv
    encrypted_file = "#{filepath}.enc"

    raise StandardError, "Encrypted file #{encrypted_file} already exists." if File.exist?(encrypted_file)

    File.open(encrypted_file, 'wb') do |outf|
      outf.write(iv)

      File.open(filepath, 'rb') do |inf|
        buf = String.new
        while inf.read(4096, buf)
          outf.write(cipher.update(buf))
        end
        outf.write(cipher.final)
      end
    end
    puts "Encryption successful! Encrypted file: #{encrypted_file}"
  end

  # Decrypt the file with AES-256-CBC
  # @param filepath [String] relative path to encrypted file with '.enc' file format
  # @param key [String] the cipher key
  def self.decrypt(filepath:, key:)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.decrypt
    cipher.key = key

    decrypted_file = filepath
    raise StandardError, "Decrypted file #{decrypted_file} already exists." if File.exist?(decrypted_file)

    File.open("#{filepath}.enc", 'rb') do |inf|
      iv = inf.read(cipher.iv_len)
      cipher.iv = iv

      File.open(decrypted_file, 'wb') do |outf|
        buf = String.new
        while inf.read(4096, buf)
          outf.write(cipher.update(buf))
        end
        outf.write(cipher.final)
      end
    end

    puts "Decryption successful! Decrypted file: #{decrypted_file}"
  end
end

# Encrypts and decrypts .env files with master.key
module EnvRetriever
  ENV_FILES = %w[.env.development .env.test .env.production].freeze # <- REPLACE THIS WITH YOUR .env FILES
  MASTER_KEY_PATH = 'config/master.key'

  def self.encrypt_files(delete_original: false)
    ENV_FILES.each do |file|
      Encryptor.encrypt(filepath: file, key: File.read(MASTER_KEY_PATH).strip)
      delete_file(filepath: file) if delete_original
    end
  end

  def self.decrypt_files(delete_original: false)
    ENV_FILES.each do |file|
      Encryptor.decrypt(filepath: file, key: File.read(MASTER_KEY_PATH).strip)
      delete_file(filepath: "#{file}.enc") if delete_original
    end
  end

  def self.delete_file(filepath:)
    File.delete(filepath)
  end
end
