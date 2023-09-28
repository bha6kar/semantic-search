FROM python:3.9

WORKDIR /app
# Create a directory to be used as a volume
RUN mkdir /app/output
VOLUME ["/app/output"]
# Set the default environment variables for CPU and memory constraints
ENV CPU_CONSTRAINTS="1.5"
ENV MEMORY_CONSTRAINTS="2g"
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY tmp/custommodel /app/tmp/custommodel
COPY data /app/data
COPY src /app

CMD ["sh", "-c", "echo \"CPU constraints: $CPU_CONSTRAINTS\" && echo \"Memory constraints: $MEMORY_CONSTRAINTS\" && python offline_ingestion.py  --cpus $CPU_CONSTRAINTS --memory $MEMORY_CONSTRAINTS"]
