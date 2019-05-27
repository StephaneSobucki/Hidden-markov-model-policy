%% Par iteration de politique
%On commence par une politique initialisee au hasard. On calcule les
%utilites associees a la politique, puis on calcule une nouvelle politique,
%etat par etat qui maximise les recompenses en utilisant les utilites calculees precedemment. 
%On reitere jusqu'a ce que la politique reste inchangee.

FixedNodes=[10,11,5]; % cases dont la politique est fixe et nulle

% initialisation arbitraire de la politique
Politique = ones(1,12);
Politique(FixedNodes) = 0;

% affichage de la politique initiale
AffichePolitique(Politique,Plan,Map_plan2node),title('Politique initiale');

% valeur d'escompte
escompte = 1;
    
counter = 0;

nbr_states = 12;

tic;
%Tant que l'on a pas atteint la politique optimale
changed = true;
while changed
    changed = false;
    M = eye(nbr_states);% MU = R
    for s = 1:12
        M(s,s) = -1;
        if(not(ismember(s,FixedNodes)))%Pour tous les etats que l'on peut modifier
            neighbours = find(T(s,Politique(s),:) > 0);%Retourne un tableau des voisins de l'etat i
            for n = 1:length(neighbours)%On remplit la matrice M avec les probabilités d'arriver a chaque voisin de l'etat i
                M(s,neighbours(n)) = M(s,neighbours(n)) + T(s,Politique(s),neighbours(n));
            end
        end
    end
    %On obtient le vecteur des utilites en inversant la matrice M
    %On utilise pinv parce que la matrice M est mal conditionnee
    U = pinv(M)*(-1*[R(1,1);R(2,1);R(3,1);R(1,2);R(2,2);R(3,2);R(1,3);R(2,3);R(3,3);R(1,4);R(2,4);R(3,4)]);
    %On met la politique a jour avec les nouvelles utilites
    for s = 1:12
        argmax = 0;
        if(not(ismember(s,FixedNodes)))
            neighbours = find(T(s,Politique(s),:) > 0);
            %On calcule la recompense associe a la politique courante
            for n = 1:length(neighbours)
                argmax = argmax + U(neighbours(n))*T(s,Politique(s),neighbours(n));
            end
            %Si on trouve une meilleure action que celle donnee par la
            %politique courante, on met a jour la politique avec l'action
            %qui maximise la recompense
            for a = 1:length(A)
                if(a ~=Politique(s))
                    neighbours = find(T(s,A(a),:) > 0);
                    somme = 0;
                    for n = 1:length(neighbours)
                        somme = somme +U(neighbours(n))*T(s,A(a),neighbours(n)); 
                    end
                    if(somme > argmax)
                        argmax = somme;
                        a_best = a;
                        Politique(s) = a_best;%Mise a jour de la politique avec l'action qui maximise la recompense
                        changed = true;
                    end
                end
            end
        end
    end
    %Si la politique n'est pas change, on a atteint la politique optimale
    counter = counter + 1;
    %AfficheUtilites(reshape(U(:,end),RowMax,ColMax),Map_plan2node,counter); pause();
    %AffichePolitique(Politique,Plan,Map_plan2node), title(['Politique temporaire : iteration',num2str(counter)]), pause();
end
toc;
AffichePolitique(Politique,Plan,Map_plan2node), title(['Politique finale : iteration',num2str(counter)]);
                