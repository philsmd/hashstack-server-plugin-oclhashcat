#!/usr/bin/env python

import sys
import base64
import binascii
import json
import traceback

for filename in sys.argv[1:]:
    with open(filename, "rb") as f:
        data = f.read()
        if b"guid" in data:
            sys.stderr.write("This appears to be a My Wallet v1 wallet, but only v2 is supported!\n")
            sys.exit(1)

        try:
            decoded_data = json.loads(data.decode("utf-8"))
            if "version" in decoded_data and str(decoded_data["version"]) == "2":
                payload = base64.b64decode(decoded_data["payload"])
                iterations = decoded_data["pbkdf2_iterations"]
                print("$blockchain$v2$%s$%s$%s" % (
                    filename, iterations, len(payload),
                    binascii.hexlify(payload).decode(("ascii"))))
        except:
            traceback.print_exc()
            pass
