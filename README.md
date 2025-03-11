# Estrategia para migrar los datos al servidor remoto:
Para poder migrar los datos completos del Excel a MySql opté por convetir los datos de Excel a CSV, y utilizar Python para dividir los  CSV en fragmentos para poder subirlos en partes sin saturar el servidor.

Este script puede verse completo en el archivo `upload_data.py`

El primer paso para realizar la migracion es tomar la cantidad total de registros y dividirla entre 8, este numero de divisiones lo tome arbitrariamente, puede aumentarse/reducirse segun se requiera, a estas divisiones les llamaremos "batchs".
https://github.com/Coolhatena/backend1-migracion/blob/3c51309d3a10f744ad663484683fb795ac0dcd58/upload_data.py#L5-L21

Para subir cada batch a la base de datos se utilizará la siguiente funcion, la cual independientemente del tamaño del batch lo dividira en fragmentos de 1000 e irá subiendolos uno a uno hasta completar la subida del batch completo. 
Cabe destacar que esta funcion considera por defecto comas como los separadores de la informacion, puede modificarse para utilizar otro caracter como separador, y una oportunidad de mejora seria aceptar el separador como un parametro opcional. 
https://github.com/Coolhatena/backend1-migracion/blob/3c51309d3a10f744ad663484683fb795ac0dcd58/upload_data.py#L22-L33

En el scope principal del script separa la informacion en batchs del tamaño calculado anteriormente, y llama la funcion ´insert_batch´ mostrada anteriormente para subir el batch de informacion.
Como metodo para prevenir la subida continua de toda la informacion, agregué un timer de 5 minutos entre cada batch completo subido, esto considerando que la informacion podria llegar a subirse al mismo tiempo que mis compañeros, evitando asi consumir todo el ancho de banda para subida,
pero en caso de que se quiera reducir o eliminar este timer, puede ser modificado cambiando el valor de la variable `mins`, en la cual se establece la cantidad de minutos de espera entre batchs. 

https://github.com/Coolhatena/backend1-migracion/blob/3c51309d3a10f744ad663484683fb795ac0dcd58/upload_data.py#L33-L47
