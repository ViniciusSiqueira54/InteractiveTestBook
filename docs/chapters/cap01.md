# Test Frameworks: JUnit+Hamcrest

## Vídeo Aula 
[![Test Frameworks: JUnit+Hamcrest](https://youtu.be/GeQGAlpsUTk/0.jpg)](https://youtu.be/GeQGAlpsUTk "Test Frameworks: JUnit+Hamcrest")

## Definições

### JUnit

O JUnit é um framework open-source, que se assemelha ao raio de testes software java, criado por Erich Gamma e Kent Beck, com suporte à criação de testes automatizados na linguagem de programação Java.

Esse framework facilita a criação e manutenção do código para a automação de testes com apresentação dos resultados. Com ele, pode ser verificado se cada método de uma classe funciona da forma esperada, exibindo possíveis erros ou falhas podendo ser utilizado tanto para a execução de baterias de testes como para extensão.

Com JUnit, o programador tem a possibilidade de usar esta ferramenta para criar um modelo padrão de testes, muitas vezes de forma automatizada.

O teste de unidade testa o menor dos componentes de um sistema de maneira isolada. Cada uma dessas unidades define um conjunto de estímulos (chamada de métodos), e de dados de entrada e saída associados a cada estímulo. As entradas são parâmetros e as saídas são o valor de retorno, exceções ou o estado do objeto. Tipicamente um teste unitário executa um método individualmente e compara uma saída conhecida após o processamento da mesma. Por exemplo:

```java 
Assert.assertEquals(2, algumMetodo(1));
```
A expressão acima verifica se a saída de algumMetodo() é 2 quando esse método recebe o parâmetro 1. Normalmente o desenvolvedor já realiza testes semelhantes a esse pequeno exemplo, o que é chamado de testes unitários em linha. Assim sendo, o conceito chave de um teste de unidade é exercitar um código e qual o resultado esperado.

O JUnit permite a realização de testes de unidades, conhecidos como "caixa branca", facilitando assim a correção de métodos e objetos.
Algumas vantagens de se utilizar JUnit:
    1. Permite a criação rápida de código de teste enquanto possibilita um aumento na qualidade do sistema sendo desenvolvido e testado;
    2. Não é necessário escrever o próprio framework;
    3. Amplamente utilizado pelos desenvolvedores da comunidade código-aberto, possuindo um grande número de exemplos;
    4. Uma vez escritos, os testes são executados rapidamente sem que, para isso, seja interrompido o processo de desenvolvimento;
    5. JUnit checa os resultados dos testes e fornece uma resposta imediata;
    6. Pode-se criar uma hierarquia de testes que permitirá testar apenas uma parte do sistema ou todo ele;
    7. Escrever testes com JUnit permite que o programador perca menos tempo depurando seu código;
    8. JUnit é LIVRE.
A experiência adquirida com o JUnit tem sido importante na consolidação do Test Driven Development (desenvolvimento direcionado a testes). Além disso, ele foi adaptado a outras linguagens, tais como C♯ (NUnit), Python, Fortran, e C++.

### Hamcrest

O Hamcrest é uma estrutura que ajuda a escrever testes de software na linguagem de programação Java. Ele suporta a criação de correspondentes de asserção personalizados, permitindo que as regras de correspondência sejam definidas declarativamente. Esses correspondentes têm usos em estruturas de teste de unidade, como JUnit e jMock.

