# example.py
import os
print('Hello {{ .first_name }} {{ .last_name }}')
print(f"The files in {os.getcwd()} are: {os.listdir()}") 