function [predict_y] = libSDR_Run(test_x,w,w0)
    %�������ǹ����õ�
    w=w(:);
    sx=size(test_x);
    if(sx(2)~=length(w))
        test_x=test_x';
    end
    ty=test_x*w;
    predict_y=(ty>=w0);
end

