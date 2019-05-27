function AfficheRecompences(R,Map_plan2node)

% Inputs :
% - R             : matrice contenant la récompence associée à chaque case de la grille
% - Map_plan2node : matrice de correspondance entre numéro de case et position de la case dans la grille 

figure(2), imagesc(R), colormap jet, colorbar, axis square, grid on, title('Récompenses');
for i = 1:length(R(:))
    [RowPos,ColPos] = find(Map_plan2node==i);
    text(ColPos-0.1,RowPos,num2str(R(RowPos,ColPos)),'FontSize',15,'Color',[0,0,0]);
end
title('Récompences'),colorbar;
