function [W] = libSDR_LDA(label_y,data_x,varargin)
%��ά����������ȡFisher
%����������libSDR_XXXX(�ĸ�)
%yΪ��ǩ��������ʱֻ֧������
%xΪ���ݾ��󣬲����ݺᣬֻҪ��y���뼴�ɣ���lib���Լ���ת����~
%����y������������ôÿһ��x����������������
%varargin=[dim,beta,Method]
%dim�Ƿֽ����W�е�w������������w֮���������ģ�w�ķ�������1��
%beta�Ǹ�������Ĳ�����
%Method�Ƕ����άʱ�ķ������������ȵ���Fisher�Ժ���������ֵ��ȡ����ֱ������ֵ��ȡ��Ĭ�ϣ�
if nargin > 5
    ReadMe
    error('����̫������ ~��~ ')
elseif nargin == 5 
    dim=round(varargin{1});
    beta=varargin{2};
    Method=varargin{3};%0-EP 1-PP
elseif nargin == 4 
    dim=round(varargin{1});
    beta=varargin{2};
    Method=0;
elseif nargin == 3
    dim=round(varargin{1});
    beta=1;
    Method=0;
else
    dim=1;
    beta=1;
    Method=0;
end
%��ά����
[len,data_dim] = size(data_x);

if data_dim>=len
    disp('���ݸ���С��ά�ȣ�����PCA��ά����');
    [Wpca,data_x] = libSDR_PCA(data_x,[],len-1);
end

classes=length(unique(label_y));
if classes<2
    error('ֻ��һ�����׼���ô���� ~��~ ');
elseif classes==2
    disp('��⵽�����ж��ִ࣬�ж���LDA��')
    if dim==1
        W=libSDR_SCSF(label_y,data_x,beta);
    elseif dim>1
        W=libSDR_SCMF(label_y,data_x,dim,beta);
    else
        error('��������Ҫ����1Ӵ~');
    end
else
    disp(['��⵽',num2str(classes),'������,ִ�ж�����ࡣ'])
    if Method==0
        W=libSDR_MCEP(label_y,data_x,dim,beta);
    elseif Method==1
        W=libSDR_MCPP(label_y,data_x,dim,beta);
    else
        ReadMe
        error('����ֻ��ѡ��EP(0,Ĭ��)��PP(1)Ӵ~');
    end
end
if exist('Wpca','var')
    W = Wpca*W;
end
end

