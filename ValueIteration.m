run("CreateScenario.m");
%% Par iteration de valeur
%On initialise les utilites de chaque etat avec leurs recompenses
%associees. Puis, on calcule les nouvelles utilites a chaque etat afin de
%maximiser les recompenses. On itere jusqu'a la convergence,
%c'est-a-dire jusqu'a ce que les utilites ne changent plus. Ensuite, on
%calcule la politique associee.

% cases dont les utilitees sont fixes durant l'algorithme
FixedNodes=[5,10,11]; 

% initialisation des utilites
U = [R(1,1); R(2,1); R(3,1); R(1,2); R(2,2); R(3,2); R(1,3); R(2,3); R(3,3); R(1,4); R(2,4); R(3,4)];

% affichage des utilites initiales
AfficheUtilites(reshape(U(:,end),RowMax,ColMax),Map_plan2node,0);pause();

% valeur d'escompte
escompte = 1;

%nombre d'etats 
nbr_states = 12;

tic;
%% Iteration des utilites
while true
    U = [U, U(:,end)];
    for s = 1:nbr_states
        [RowPos,ColPos] = find(Map_plan2node == s);%Retourne la position dans le plan de l'etat s
        argmax = -10;
        if(not(ismember(s,FixedNodes)))%Si s n'est pas un etat avec une utilite fixee
            %On cherche l'action qui maximise la recompense
            for a = 1:length(A)
                somme = 0;
                neighbours = find(T(s,A(a),:) > 0);%Tableau avec les indices des voisins de s
                for n = 1:length(neighbours)
                    somme = somme +U(neighbours(n),end-1)*T(s,A(a),neighbours(n));%Correspond a la somme T(s,a,s')*U(s') que l'on cherche � maximiser
                end
                if(somme > argmax)
                    argmax = somme;
                end
            end
            U(s,end) = R(RowPos,ColPos) + escompte * argmax;%Nouvelle valeur d'utilitee pour l'etat s
        end
    end
    if(sqrt(sum((U(:,end)-U(:,end-1)).^2))/nbr_states < 10E-5)%Si l'ecart quadratique moyen est infinitesimal, on a atteint la convergence
        break;
    end
end

%% Recherche de la politique optimale

Politique = zeros(1,12);
for s = 1:nbr_states
    argmax = -10;
    if(not(ismember(s,FixedNodes)))%Pour les etats dont la politique n'est pas fixee a 0
        %On cherche l'action a, qui maximise la recompense pour l'etat s
        for a = 1:length(A)
            somme = 0;
            neighbours = find(T(s,A(a),:) > 0);
            for n = 1:length(neighbours)
                somme = somme + U(neighbours(n),end)*T(s,A(a),neighbours(n)); 
            end
            if(somme > argmax)
                argmax = somme;
                a_best = a;
            end
        end
        Politique(s) = a_best;%L'action trouvee est la politique pour l'etat s
    end
end
toc;

figure(4);
hold on;
for s = 1:12
    plot(0:1:size(U,2)-1,U(s,:));
end
hold off;
xlabel('Nombre d''iterations');
ylabel('Estimation des utilites');
axis tight;        
AfficheUtilites(reshape(U(:,end),RowMax,ColMax),Map_plan2node,size(U,2));
AffichePolitique(Politique,Plan,Map_plan2node);
