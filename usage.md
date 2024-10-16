## 1. Set `master.key` file

---

## 2. Decrypt `.env` files

```bash
ruby -r './env_retriever.rb' -e 'EnvRetriever.decrypt_files' 
```

---
## 3. Take up the database with compose in corresponding environment

- Development environment:  
     ```bash
     docker-compose --env-file .env.development -f docker-compose.development.yml up
     ```
  
- Production environment:
     ```bash
     docker-compose --env-file .env.production -f docker-compose.production.yml up
     ```

- Test environment:
     ```bash
     docker-compose --env-file .env.test -f docker-compose.test.yml up
     ```

>**_IF_ the port is occupied**
>
>1. Check what occupied the port.
>    ```bash
>    sudo lsof -i :port
>    ```
>
>2. If Docker:
>
>    - **Option1.** Stop all services in your Compose file.
>    ```bash
>    docker-compose down
>    ```
>
>    - **Option2.** Stop a specific container
>    
>    ```bash
>    docker stop <container-id>
>    ```

---