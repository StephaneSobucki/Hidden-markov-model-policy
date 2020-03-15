function AffichePolitique(Politique,Plan,Map_plan2node)

% Inputs :
% - Politique     : vecteur contenant l'action associee a chaque case de la grille
% - Plan          : matrice definie dans TP3.m
% - Map_plan2node : matrice de correspondance entre numero de case et position de la case dans la grille

figure(3),imagesc(Plan), colormap gray, colorbar, axis square, grid on,
for i = 1:length(Politique(:))
    [RowPos,ColPos] = find(Map_plan2node==i);
    if Politique(i) == 1
        text(ColPos-0.1,RowPos,'\uparrow','FontSize',15);
    elseif Politique(i) == 2
        text(ColPos-0.1,RowPos,'\leftarrow','FontSize',15);
    elseif Politique(i) == 3
        text(ColPos-0.1,RowPos,'\downarrow','FontSize',15);
    elseif Politique(i) == 4
        text(ColPos-0.1,RowPos,'\rightarrow','FontSize',15);
    else
        text(ColPos-0.1,RowPos,'o','FontSize',15,'Color',[0.5,0.5,0.5]);
    end
end
title('Politique optimale'),colorbar;