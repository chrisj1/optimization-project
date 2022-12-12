function [a, newI]= runtesthyperparams(I, mu, alpha, Omega, testName,itrs)
    a = swt2(I,1,1);
    norms = [];
    for i = 1:itrs
    
        %compute the gradient of f
    
        f_grad  = sign(a); %2 * a;
    
        %compute the b matrix
    
        b = iswt2(a,1,1);
        
        for j = 1:size(Omega)
            b(Omega(j)) = I(Omega(j));
        end
    
        % compute the h gradient
    
        h_grad = 2*swt2(iswt2(a,1,1)-b,1,1);
    
        grad = f_grad + mu*h_grad;
    
        a = a - alpha * (grad);
        
        norms(i) = norm(grad, "fro")^2;

        if mod(i,100) == 0
            [alpha, mu, i]
        end
    end

    newI = iswt2(a,1,1);
    
    f = figure('Name',sprintf("Results for %s", testName), 'visible','off');
    tcl = tiledlayout(2,2);

    nexttile
    imshow(I,[])
    title('Original Image')
    colorbar

    nexttile
    imshow(newI, []);
    title('New Image')
    colorbar

    nexttile
    imshow(newI-I, [])
    title('Difference Image')
    colorbar

    nexttile
    plot(norms)
    title("$||\nabla f||_F^2$",'Interpreter','latex')
    t = sprintf("Results for %s with $\\alpha$ = %0.3d, $\\mu$ = %0.3d" ...
        , testName, alpha, mu);
    title(tcl, t ,'Interpreter','latex')
    name = sprintf("results/%s.fig", t);

    t2 = sprintf("results/Results_%s_a_%0.3d_m_%0.3d.png" ...
        , testName, alpha, mu);
%     savefig(t2);
    saveas(f, t2, 'png');
end