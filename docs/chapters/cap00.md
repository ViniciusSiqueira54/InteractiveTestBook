# Exemplo de titulo h1

Vamos supor que eu queira escrever algo em **negrito**, é simple, é só por dois asteriscos, um antes e um depois da palavra, já em *itálico*, só um já é o suficiente.

para códigos é o seguinte, precisamos por:

pra uma linha única, um acento grave ` no inicio e no final dessa linha:

`a = float(22/5)`

ou para multiplas linhas, podemos utilizar tanto 3 acentos ` ou 3 ~, ex:

```python
a = float(22/5) 
b = int(4.5) 
c = int(3.9) 
d = int(0xff563) 
e = float(int(3.9)) 
f = int(float(3.9)) 
g = int(float(3)) 
h = round(3.9) 
i = round(3) 
j = int(round(3.9)) 
print(a,b,c,d,e,f,g,h,i,j)
```

## BubbleSort

Vamos ver abaixo o seguinte algoritmo de BubbleSort para a ordenação de uma
lista de elementos.

Como exemplo vamos utilizar a seguinte lista de elementos:

```python
alist = [54,26,93,17,77,31,44,55,20]
print(alist)
```


Tendo essa lista como exemplo, agora podemos passar ela pro algoritmo, pra ele
encarregar de ordenar esses elementos e retornar a mesma ordenada.

```python
def bubbleSort(alist):
    for passnum in range(len(alist)-1,0,-1):
        for i in range(passnum):
            if alist[i]>alist[i+1]:
                temp = alist[i]
                alist[i] = alist[i+1]
                alist[i+1] = temp


bubbleSort(alist)
print(alist)
```
Veja essse exemplo em execução pelo [binder](https://hub.gke.mybinder.org/user/viniciussiqueir-ractivetestbook-nw0eizlr/notebooks/chapters/Cap_00_exemplo.ipynb)

# Exemplo de titulo h2
teste de titulo h2


# Exemplo de titulo h3
teste de titulo h3
