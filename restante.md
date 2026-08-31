"Analise o código atual e identifique melhorias que ainda possam ser feitas futuramente em relação a organização, soft-coding, reutilização, arquitetura ou possíveis problemas.

Não preciso implementar essas alterações agora. Quero registrá-las em um arquivo restante.txt.

Para cada melhoria, use o seguinte formato:

- Título da melhoria (Categoria)
• Objetivo/ponto principal
• Segundo ponto relevante

Depois, inclua uma explicação curta de 1 a 3 linhas sobre o que deverá ser alterado e por quê.

Priorize apenas mudanças que realmente tenham utilidade futura e evite refatorações prematuras ou puramente estéticas."

- Normalizar o Facing (Movimento)
  • Fazer `facing` guardar exclusivamente UP, DOWN, LEFT ou RIGHT.
  • Hoje, em movimento diagonal, um dos eixos ainda mantém valor diferente de zero. Isso pode causar direção visual incorreta e depois afetar golpes, ferramentas e interação.

- Remover chamada duplicada de animação (Animação)
  • Chamar `update_animation()` apenas uma vez por ciclo.
  • Atualmente tanto o `if` quanto o `else` executam exatamente a mesma função, então a condição é desnecessária.

- Selecionar apenas um alvo de interação (Interação)
  • Fazer `try_interact()` escolher um único objeto entre as áreas detectadas.
  • Atualmente o `for` interage com todos os objetos próximos. Futuramente deverá priorizar, por exemplo, o mais próximo ou o que estiver na direção do `facing`.

- Limitar o zoom da câmera (Câmera)
  • Definir valores mínimo e máximo para o zoom.
  • Atualmente é possível chegar a zero ou valores negativos. Para pixel art, também pode ser interessante futuramente restringir o zoom a escalas inteiras.

- Separar processamento de movimento (Organização)
  • Futuramente extrair partes de `_physics_process()` para funções como `update_facing()` e controle de zoom.
  • Não é necessário agora, mas ajudará quando movimento, animações, stamina, terreno e estados do personagem começarem a crescer.

- Evoluir estados de animação (Animação)
  • Quando existirem animações de caminhada/uso, separar a direção (`up`, `down`, etc.) do estado (`idle`, `walk`, `use`).
  • Isso permitirá formar animações como `walk_left` ou `idle_right` sem criar vários blocos de `if` repetidos.
