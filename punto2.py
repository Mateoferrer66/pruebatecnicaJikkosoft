def encontrar_indices_suma(lista, objetivo):
    diccionario = {}
    for i, numero in enumerate(lista):
        complemento = objetivo - numero
        if complemento in diccionario:
            return [diccionario[complemento], i]
        diccionario[numero] = i
    return None

numeros = [2, 7, 3, 6]
objetivo = 10

resultado = encontrar_indices_suma(numeros, objetivo)
print(resultado)  # Output esperado: [0, 1]



