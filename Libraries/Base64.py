import base64


def base64_encode(message):
    res=base64.b64encode(bytes(str(message), encoding="UTF-8"))
    return res.decode(encoding="UTF-8")
