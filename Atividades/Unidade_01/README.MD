Deve ser implementado um programa que realize uma simulação de operações de leitura de vários endereços de uma memória
principal fictícia e, com isso, faça a checagem em uma memória cache, levantando assim o total de
acertos e falhas obtidos.
A sequência de endereços é disponibilizada em um arquivo texto (chamado de “enderecos.dat”). Ela
consiste em uma série de números inteiros variando de 0 até um valor inferior à 8.192 (8K, que é o
espaço total da memória principal fictícia).
O programa desenvolvido deve abrir o arquivo e realizar a sua leitura. Para cada inteiro lido do
arquivo, o programa deve simular os acertos e falhas de uma cache com mapeamento direto (simulação
1) e, depois, de uma cache com mapeamento associativo em conjunto de 2 vias (simulação 2). Para
cada simulação, deve-se contabilizar o total de acertos e falhas. A figura sintetiza o problema a ser
tratado.
A cache com mapeamento direto (simulação 1) tem 256 linhas, onde cada linha comporta um bloco de
4 endereços (ou 4 words). A cache com mapeamento associativo em conjunto de 2 vias (simulação 2)
tem 128 conjuntos (e, consequentemente, a mesma quantidade de linhas no total da cache com
mapeamento direto). Também tem 4 endereços por linha.

