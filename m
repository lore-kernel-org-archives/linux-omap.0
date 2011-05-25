From: Peter Teoh <htmldeveloper@gmail.com>
Subject: Re: Self modifying code in ARM 11 architectures
Date: Thu, 26 May 2011 00:28:06 +0800
Message-ID: <BANLkTimx0TThB3i6Yf0jZqAg97QJ1T+_Pg@mail.gmail.com>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0989438611294081759=="
Return-path: <kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org>
In-Reply-To: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org
Errors-To: kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org
To: Ashok Babu <ashok3d@gmail.com>
Cc: linux-omap@vger.kernel.org, Kernelnewbies@kernelnewbies.org
List-Id: linux-omap@vger.kernel.org

--===============0989438611294081759==
Content-Type: multipart/alternative; boundary=90e6ba53a168816ba104a41c308f

--90e6ba53a168816ba104a41c308f
Content-Type: text/plain; charset=ISO-8859-1

On Tue, May 24, 2011 at 6:15 PM, Ashok Babu <ashok3d@gmail.com> wrote:

> Hi All,
>
> I am no success in booting up the ARM1176 processor with the linux-2.6.32
> kernel.
>
> While googling about the ARM Harvard architecture, I came to know that we
> have to flush/invalidate the D-Cache and I-Cache
> when using the self modifying codes.
>
> So here my questions/doubts :
> 1) Is'nt it the kernel itself is self modifying code with lots of function
> pointers ?
>     If yes, how is synchronization b/w d-cache and i-cache handled in the
> kernel ?
> 2) Can this be the reason for the kernel not booting for me ?
>     Because If i disable the I-Cache in the config, then the kernel boots
> up without any issues.
>
> Any pointers on this will be of great help.
>
> Here:

http://blogs.arm.com/software-enablement/141-caches-and-self-modifying-code/

read the part on "The Solution" - it describe function pointer on a
register, and what u are supposed to do with cache transfer.   (java is full
of JIT compilation)
<http://blogs.arm.com/software-enablement/141-caches-and-self-modifying-code/>


> Thanks & Best Regards
> Ashok
>
>
>
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>


-- 
Regards,
Peter Teoh

--90e6ba53a168816ba104a41c308f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, May 24, 2011 at 6:15 PM, Ashok B=
abu <span dir=3D"ltr">&lt;<a href=3D"mailto:ashok3d@gmail.com" target=3D"_b=
lank">ashok3d@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

Hi All,<div><br></div><div>I am no success in booting up the ARM1176 proces=
sor with the linux-2.6.32 kernel.</div><div><br></div><div>While googling a=
bout the ARM=A0Harvard=A0architecture, I came to know that we have to flush=
/invalidate the D-Cache and I-Cache=A0</div>


<div>when using the self modifying codes.</div><div><br></div><div>So here =
my questions/doubts :</div><div>1) Is&#39;nt it the kernel itself is self m=
odifying code with lots of function pointers ?</div><div>=A0 =A0 If yes, ho=
w is synchronization b/w d-cache and i-cache handled in the kernel ?</div>


<div>2) Can this be the reason for the kernel not booting for me ?</div><di=
v>=A0 =A0 Because If i disable the I-Cache in the config, then the kernel b=
oots up without any issues.</div><div><br></div><div>Any pointers on this w=
ill be of great help.</div>


<div><br></div></blockquote><div>Here:</div><div><br></div><div><a href=3D"=
http://blogs.arm.com/software-enablement/141-caches-and-self-modifying-code=
/" target=3D"_blank">http://blogs.arm.com/software-enablement/141-caches-an=
d-self-modifying-code/</a></div>

<div><br></div><div>read the part on &quot;The Solution&quot; - it describe=
 function pointer on a register, and what u are supposed to do with cache t=
ransfer. =A0 (java is full of JIT compilation)</div><div><a href=3D"http://=
blogs.arm.com/software-enablement/141-caches-and-self-modifying-code/" targ=
et=3D"_blank"></a>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div></div><div>Thanks &amp; Best Regards</div><div>Ashok</div><font color=
=3D"#888888"><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0<br=
><div><br></div><div><br></div></div>
</font><br>_______________________________________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org" target=3D"_blank">Kernel=
newbies@kernelnewbies.org</a><br>
<a href=3D"http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" t=
arget=3D"_blank">http://lists.kernelnewbies.org/mailman/listinfo/kernelnewb=
ies</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br>Peter T=
eoh<br>

--90e6ba53a168816ba104a41c308f--


--===============0989438611294081759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============0989438611294081759==--
