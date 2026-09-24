clc
clear
close all

% --- Mokymo duomenys ---
mokymo_paveikslas = 'train_data_skaiciai.png';
eiluciu_kiekis    = 5;  
klasiu_kiekis     = 7;   
neuronu_sk        = 7; 

% --- Testinis paveikslėlis ---
testo_paveikslas = 'test_skaicius.png';

% --- Simbolių žodynas: tinklo išėjimo indeksas -> spausdinamas ženklas ---
simboliu_zodynas = containers.Map({1,2,3,4,5,6,7}, {'1','2','3','4','5','6','7'});

% --- Požymių išgavimas ir tinklo mokymas ---
istrauktos_savybes = pozymiai_raidems_atpazinti(mokymo_paveikslas, eiluciu_kiekis);
Ivestys = cell2mat(istrauktos_savybes);

Norimi_atsakymai = repmat(eye(klasiu_kiekis), 1, eiluciu_kiekis);
rbf_tinklas = newrb(Ivestys, Norimi_atsakymai, 0, 1, neuronu_sk);

% --- Testinio vaizdo atpažinimas ---
naujos_savybes = pozymiai_raidems_atpazinti(testo_paveikslas, 1);
Ivestys_test   = cell2mat(naujos_savybes);
Atsakas_test   = sim(rbf_tinklas, Ivestys_test);
[~, laimeje_test] = max(Atsakas_test);

atpazinta_seka = repmat(' ', 1, numel(laimeje_test));
for k = 1:numel(laimeje_test)
    atpazinta_seka(k) = simboliu_zodynas(laimeje_test(k));
end

fprintf('Atpažinta skaičių seka: %s\n', atpazinta_seka);