from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello Cloud Native!"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
