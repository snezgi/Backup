 function [posit,A] = importdata(experiment,confront)
% experiment is the name of the file to load
% confront is a string vector to be compared with the first line of the file to load

% it saves the names of the variables in a file, going in a new line at every comma
dat = fopen(experiment,'r');
a = fgets(dat);
A = fscanf(dat,'%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f     ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f ,%f',[56,     Inf]);
A = A';
b = 0;

fid = fopen("prova",'w');

for i = 1:size(a,2)
    if a(i)==","
        b = [b,i];
        c = [b+1,i+1];
    end
end

b = b(2:end);

for i = 1:length(b)
    for j = c(i):b(i)-1
        fprintf(fid,a(j))
    end
    fprintf(fid,"\n")
end
for i = c(end):size(a,2)
    fprintf(fid,a(i))
end

fclose(fid)

% it defines a string vector reading each line from the file prova created above
fid = fopen("prova",'r');

for i = 1:length(c)-1
    s(i) = {fgets(fid)};
end

fclose(fid);

% it confronts the vector confront with the string vector s
m = length(confront);
n = length(s);

for i = 1:m
    f = length(confront{1,i});

    for j = 1:n
        g = length(s{1,j})-1;
        if f==g
            k = f;
            vect(j) = (strncmp(s(1,j),confront(1,i),k)); % for each i only one element differs from zero

            if vect(j)==1                               % it saves the position of the element that differs from zero at every cicle
                posit(i) = j;
            end
        end
end
