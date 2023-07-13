


//TIPO ESTRUTURADO COM DUAS VIAS P/ CONJUNTO
struct cacheAC{
    int tag;
    bool bitValidade, reposicao;
};

int main (void){
    cacheAC cache[128][2];
    int tagMemoriaPrincipal;
    int posicaoCache;
    int acertos = 0, falhas = 0;
    std::ifstream memPrincipal;
    std::string via;

    memPrincipal.open("C:\\Users\\jhoni\\Desktop\\Cache\\enderecos.dat");

    if(memPrincipal.is_open())
    {
        for (unsigned int i=0; i<128; i++)
            {
                for (unsigned int j=0; j<2; j++)
                {
                    cache[i][j].bitValidade = false;
                }
            }
        while(getline(memPrincipal, via))
        {
            posicaoCache = stoi(via) & 508;
            posicaoCache = posicaoCache >> 2;
            tagMemoriaPrincipal = stoi(via) & 15872;
            tagMemoriaPrincipal = tagMemoriaPrincipal >> 9;

            if (cache[posicaoCache][0].bitValidade && cache[posicaoCache][1].bitValidade)
            {
                if(cache[posicaoCache][0].tag == tagMemoriaPrincipal)
                {
                    acertos++;
                }else if(cache[posicaoCache][1].tag == tagMemoriaPrincipal)
                {
                    acertos++;
                }else if(cache[posicaoCache][0].reposicao)
                {
                    falhas++;
                    cache[posicaoCache][0].tag = tagMemoriaPrincipal;
                    cache[posicaoCache][0].reposicao = false;
                    cache[posicaoCache][1].reposicao = true;
                }else
                {
                    falhas++;
                    cache[posicaoCache][1].tag = tagMemoriaPrincipal;
                    cache[posicaoCache][1].reposicao = false;
                    cache[posicaoCache][0].reposicao = true;
                }
            }else
            {
                if(cache[posicaoCache][0].bitValidade)
                {
                    if(cache[posicaoCache][0].tag == tagMemoriaPrincipal)
                    {
                        acertos++;
                    }else
                    {
                        falhas++;
                        cache[posicaoCache][1].tag = tagMemoriaPrincipal;
                        cache[posicaoCache][1].bitValidade = true;
                        cache[posicaoCache][1].reposicao = false;
                        cache[posicaoCache][0].reposicao = true;
                    }
                }else if(cache[posicaoCache][1].bitValidade)
                {
                    if(cache[posicaoCache][1].tag == tagMemoriaPrincipal)
                    {
                        acertos++;
                    }else
                    {
                        falhas++;
                        cache[posicaoCache][0].tag = tagMemoriaPrincipal;
                        cache[posicaoCache][0].bitValidade = true;
                        cache[posicaoCache][0].reposicao = false;
                        cache[posicaoCache][1].reposicao = true;
                    }
                }else
                {
                    falhas++;
                    cache[posicaoCache][0].tag = tagMemoriaPrincipal;
                    cache[posicaoCache][0].bitValidade = true;
                    cache[posicaoCache][0].reposicao = false;
                    cache[posicaoCache][1].reposicao = true;
                }
            }
        }
    }

    std::cout << "acertos: " << acertos << std::endl << "falhas: " << falhas << std::endl ;
    return 0;
}
