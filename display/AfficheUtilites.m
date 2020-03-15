function AfficheUtilites(U,Map_plan2node,iteration)

% Inputs :
% - U             : vecteur contenant l'utilite associee a chaque case de la grille
% - Map_plan2node : matrice de correspondance entre numero de case et position de la case dans la grille
% - iteration     : iteration de l'algorithme (necessaire pour l'affichage du titre)

figure(2),imagesc(U), colormap jet, colorbar, axis square, grid on,
for i = 1:length(U(:))
    [RowPos,ColPos] = find(Map_plan2node==i);
    text(ColPos-0.1,RowPos,num2str(U(RowPos,ColPos)),'FontSize',15,'Color',[0,0,0]);
end
title(['Utilites : iteration',num2str(iteration)]),colorbar;