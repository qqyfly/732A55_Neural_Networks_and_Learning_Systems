Notes:
Dot product/unit vector
$$
\overrightarrow{a} \cdot \overrightarrow{b} = ||\overrightarrow{a}|| ||\overrightarrow{b}|| cos(\theta)
\\
cos(\theta) = \frac{||\overrightarrow{a_{b}}|| }{ ||\overrightarrow{a}||}
$$

$$
\hat{a} = \frac{\overrightarrow{a}}{||\overrightarrow{a}||}
$$

$$
||\overrightarrow{a_{b}} || = ||\overrightarrow{a}||cos(\theta)
=||\overrightarrow{a}||\frac{\overrightarrow{a} \cdot \overrightarrow{b}}{||\overrightarrow{a}|| ||\overrightarrow{b}||}
=\frac{\overrightarrow{a} \cdot \overrightarrow{b}}{||\overrightarrow{b}||}
$$


because unit vector on B is same as A's mapping on B, we got the following.

$$
\overrightarrow{a_{b}} = \hat{a_{b}}||\overrightarrow{a_{b}} || 
=\hat{b}||\overrightarrow{a_{b}} || \\
$$

substitute some terms and we get 

$$
\overrightarrow{a_{b}}=\hat{b}\frac{\overrightarrow{a} \cdot \overrightarrow{b}}{||\overrightarrow{b}||}
$$

2.1
$$
\overrightarrow{X}' = (\overrightarrow{X} - \overrightarrow{Y_{p}})
\\
\overrightarrow{X_{0}} = \overrightarrow{X_{w}}
\\
||\overrightarrow{X_{w}}|| = \frac{\overrightarrow{X'} \cdot \overrightarrow{W}}
{||\overrightarrow{W}||} 
=\frac{(\overrightarrow{X} - \overrightarrow{X_p}) \cdot \overrightarrow{W}}{||\overrightarrow{W}||}
$$

when point on the plane, we have

$$
||\overrightarrow{X'_{w}}|| = 0
\\
\frac{(\overrightarrow{X} - \overrightarrow{X_p}) \cdot \overrightarrow{W}}{||\overrightarrow{W}||} = 0 =>
\\
(\overrightarrow{X} - \overrightarrow{X_p}) \cdot \overrightarrow{W} = 0 =>
\\
\overrightarrow{X}\overrightarrow{W} - \overrightarrow{X_p}\overrightarrow{W} = 0 =>
\\
\text{set:}  -\overrightarrow{X_p}\overrightarrow{W}=b =>
\\
\overrightarrow{X}\overrightarrow{W} +b = 0


$$

3.1 
The batch learning is we feed the existing data which is already on hard disk
however the online learning, means it will the system will use the live data and feed
the new live to the system and then do the calculation

4.1
$$
y = W^{T}X = w_1x_1 + \ldots+ w_nx_n = \sum{w_{i}x_{i}}
\\
\frac{d(y)}{d(w_{i})} = x_{i}
\\
\frac{d(y)}{d(w)} = x
$$
4.2
$$
y = X^{T}WX = \sum\sum{x_{i}w_{i,j}x_{j}}
\\
\frac{d(y)}{d(x_k)} = \sum{w_{ik}x_{i}} + \sum{w_{jk}x_{j}}
\\
\frac{d(y)}{d(x)} = WX + W^TX

$$
4.3
$$
y = ||W||^4 = (\sqrt{w^2_1 + \ldots + w^2_n})^4 = (w^2_1 + \ldots + w^2_n)^2
\\
\frac{d(y)}{d(w_i)} = 4(w^tw)w_{i}
\\
\frac{d(y)}{d(w)} = 4(W^{T}W)W
$$

5.1

$$
f'(x) = 6X + [1,1]^{T}
$$

if $f'(x) = 0$, then  $x = [-1/6,-1/6]^T$

5.2

we have n = 0.05 and $x_{old}=[1,1]^T$

so we have  

1st iterator
$$
x_{1} = [1,1]^{T} - 0.05 * (6 * [1,1] + [1,1]) = [0.65,0.65]
$$

2nd iterator

$$
x_{2} = [0.65,0.65]^{T} - 0.05 * (6 * [0.65,0.65] + [1,1]) = [0.405,0.405]

$$
