Objetivo Geral
Desenvolver um contrato inteligente que funcione como um banco simples para armazenamento de ETH. O contrato deve atender aos requisitos funcionais e seguir boas práticas de desenvolvimento abordadas em aula.

Requisitos de Desenvolvimento
1. Configuração Inicial
    - O contrato deve ter um construtor que receba como parâmetro o limite máximo de ETH que o banco pode armazenar (*bankCap*).
    - Este limite deve ser armazenado em uma variável imutável e usado para validar depósitos futuros.
2. Depósito de Fundos
    - O contrato deve permitir que os usuários façam depósitos de ETH.
    - Antes de aceitar o depósito, deve verificar se o saldo atual do contrato mais o valor depositado excede o limite estabelecido no *bankCap*.
    - Em caso de violação do limite, a transação deve reverter com uma mensagem de erro apropriada.
    - Um evento deve ser emitido ao final de cada depósito bem-sucedido.
3. Saque de Fundos
    - O contrato deve permitir que os usuários realizem saques de valores previamente depositados.
    - Deve haver um limite fixo por saque, definido como uma constante no contrato.
    - O valor solicitado para saque não pode exceder o saldo do usuário nem o limite por saque. Caso isso ocorra, a transação deve reverter com uma mensagem de erro apropriada.
    - Ao final de cada saque bem-sucedido, um evento deve ser emitido.
4. Consulta de Saldo
    - O contrato deve permitir que qualquer pessoa consulte o saldo de ETH armazenado no contrato.
    - Deve ser implementada uma função de visualização para retornar este saldo.
5. Controle e Validação
    - Use modificadores para validar condições que se repetem nas funções.
    - Centralize a lógica de transferências de ETH em uma função interna para evitar duplicação de código.
6. Mensagens de Erro e Eventos
    - Utilize mensagens de erro customizadas para lidar com casos como:
        - Tentativa de depósito que exceda o limite do banco (*bankCap*).
        - Saque de valor maior que o saldo do usuário.
        - Falha na transferência de ETH.
    - Implemente eventos para notificar:
        - Depósitos bem-sucedidos (com endereço do usuário e valor).
        - Saques bem-sucedidos (com endereço do usuário e valor).

Critérios de Implementação Técnica
1. Variáveis
    - Use variáveis immutable para parâmetros do construtor que não mudam.
    - Use constant para valores fixos no contrato.
    - Use mapeamentos para armazenar o saldo de cada usuário.
2. Boas Práticas
    - Nomeie funções, eventos e variáveis de forma descritiva e consistente com os padrões abordados em aula.
    - Adicione comentários explicativos para cada elemento do contrato.
    - Priorize a legibilidade e a organização do código.
3. Segurança
    - Use revert para mensagens de erro, fornecendo informações úteis para o desenvolvedor.

Instruções para Entrega
1. Estrutura do Contrato
    - Crie o contrato em um arquivo .sol.
    - O nome do contrato deve ser KipuBank.
    - Faça o deploy na Sepolia e verifique seu contrato no explorador de blocos.
2. Implementação
    - Certifique-se de implementar todas as funcionalidades descritas nos requisitos.
    - Siga as práticas recomendadas apresentadas em aula.
3. Entrega Final
    - Submeta o endereço do seu contrato verificado no Sepolia Etherscan.
