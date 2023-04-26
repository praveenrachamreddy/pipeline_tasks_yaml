import http.server
import socketserver
import json
import logging
import os
import time

PORT = 8080

# Set up logging to print to console and write to file
log_file_path = '/var/log/myapp/myapp.log'
if os.path.exists(log_file_path):
    mode = 'a'  # Append mode
else:
    mode = 'w'  # Write mode
logging.basicConfig(level=logging.DEBUG, filename=log_file_path, filemode=mode)

class FormRequestHandler(http.server.SimpleHTTPRequestHandler):
    submitted_forms = set()  # Set to keep track of submitted forms

    def do_POST(self):
        # Parse the form data
        content_length = int(self.headers['Content-Length'])
        form_data = self.rfile.read(content_length).decode('utf-8')
        form_dict = dict(x.split('=') for x in form_data.split('&'))

        # Convert the form data to a JSON string
        json_string = json.dumps(form_dict)

        # Check if the form has already been submitted
        log_file_path = '/var/log/myapp/myapp.log'
        if os.path.exists(log_file_path):
            with open(log_file_path, 'r') as f:
                log_data = f.read()
            if log_data.strip() != "":
                self.send_error(400, "Form already submitted")
                return

        # Log the JSON string to the console and file
        logging.debug('JSON data: %s', json_string)

        # Extract the boolean value from the JSON string
        data = json.loads(json_string)
        is_approved = True if data['approval'] == 'true' else False
        logging.debug('Is approved: %s', is_approved)

        # Send a response
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

        # Print the "Submitted successfully" message in the middle of the screen and make it bigger
        message = '<html><body><div style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); font-size: 2em;"><span style="color:green">Submitted successfully.</span></div></body></html>'
        self.wfile.write(message.encode())

        # Add the submitted form to the set
        # FormRequestHandler.submitted_forms.add(json_string)

        # Log the JSON string to the file
        with open(log_file_path, 'a') as f:
            f.write(json_string + '\n')

        # Delay for 1 minute before allowing new requests
        time.sleep(2)

with socketserver.TCPServer(("", PORT), FormRequestHandler) as httpd:
    logging.info("serving at port %s", PORT)
    httpd.serve_forever()
