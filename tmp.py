# Supondo que sua lista JSON já esteja carregada em uma variável
# chamada "dados" (como uma lista Python)

tamanho_lote = 1000

for i in range(0, len(dados), tamanho_lote):
    lote = dados[i:i + tamanho_lote]
    # Aqui você processa o lote
    print(f"Processando registros {i} até {i + len(lote) - 1}")
    # exemplo: enviar lote para uma função
    # processar(lote)
