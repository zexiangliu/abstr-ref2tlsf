clc;clear all;
filename = 'test_abs';

% build the FTS (abstraction)
ts = TransSyst(4,9);
  % transitions s1--a-->s2
s1 = [1,1,2,2,4,2,3,3,4,4,3];
a =  [1,2,3,4,5,6,7,8,9,5,7];
s2 = [1,2,1,4,2,3,2,3,4,3,4];
ts.add_transition(s1,s2,a);
  % progress group (U,G(U))
U = [5,7];
G = [3,4];
ts.add_progress_group(U,G);
ts.trans_array_enable();

% specification: []A_list && <>[]B_list && (&&_i []<>C_list{i})
A_list = [1,2,3,4];
B_list = [];
C_list = {[1],[3,4]};
W = win_primal(ts, A_list, B_list, C_list, 'exists', 'forall');

% encode the spec into TLSF format
abstr2TLSF_brief(filename,ts,A_list,B_list,C_list,W,62);
