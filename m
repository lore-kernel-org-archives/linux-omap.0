From: =?ISO-8859-2?Q?Dejan_Ga=E8nik?= <dejan.gacnik@gmail.com>
Subject: Re: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
Date: Thu, 27 Sep 2012 16:12:07 +0200
Message-ID: <CAFoWwXv2GjWt2+sCYqM+vbtJ5xJBJAJMSuZhjKLKtURQ0eziVw@mail.gmail.com>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
 <20120924171858.GG28835@atomide.com>
 <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
 <20120924231619.GA28941@n2100.arm.linux.org.uk>
 <20120925003758.GP28835@atomide.com>
 <506165CA.7070406@visionsystems.de>
 <20120925081449.GF31374@n2100.arm.linux.org.uk>
 <50616B21.3070909@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2322423539488512051=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50616B21.3070909@visionsystems.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: yegor_sub1@visionsystems.de
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

--===============2322423539488512051==
Content-Type: multipart/alternative; boundary=bcaec554d2444725e804caaf8617

--bcaec554d2444725e804caaf8617
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear Tony



Thank you for applying this patch. I am quite new in such things as is
posting patched to the community, therefore Yegor help me on this manner.



Anyway, I have one more challenging question/request.


I and my colleagues have developed a brand new very enhanced board having
AM35xx CPU, 512MB DDR2, DVI, true dual Ethernet support (not using PRUSS),
CAN, SPI, I2C, 7 USBs, etc=85Board is already materialized and operational.


According to our board we have create new machine type in the kernel
(version: linux-3.2-psp04.06.00.07.sdk) and all other required stuff to
support our board, modify some things, like adding support for dual eth,
etc. Our goal is to provide this new board to the market (let say with
large quantity) and therefore I am wondering how to start or if it is even
possible to transfer our kernel change the main stream of this distro?
During this kernel modification process we have been looking to not
changing anything in kernel, what could affect other machine types.



Thank you for you answer, and looking forward to receive your replay.





Best regards,
Dejan


2012/9/25 Yegor Yefremov <yegor_sub1@visionsystems.de>

>  On 25.09.2012 10:14, Russell King - ARM Linux wrote:
> > On Tue, Sep 25, 2012 at 10:05:30AM +0200, Yegor Yefremov wrote:
> >> How should I change the patch to make it proper? SA1111 is broken
> anyway:
> > No it isn't.  This is what it produces _today_, and has done for the la=
st
> > 5-10 years without modification
> >
> > # CONFIG_CLEANCACHE is not set
> > # CONFIG_FRONTSWAP is not set
> > CONFIG_FORCE_MAX_ZONEORDER=3D9
> > CONFIG_LEDS=3Dy
> > CONFIG_LEDS_CPU=3Dy
> >
> >> config FORCE_MAX_ZONEORDER
> >>         int "Maximum zone order" if ARCH_SHMOBILE
> >>         range 11 64 if ARCH_SHMOBILE
> >>         default "9" if SA1111
> >>         default "11"
> >>
> >> AFAIK if ARCH_SHMOBILE defines dependency on ARCH_SHMOBILE,
> > No it doens't.
> >
> >       int "Maximum zone order" if ARCH_SHMOBILE
> >
> > is far from being the same as:
> >
> >       int "Maximum zone order"
> >       depends on ARCH_SHMOBILE
> >
> > The former defines a condition upon which the option is offered in GUIs=
 -
> > or to put it another way, it defines the visibility of the option.
> >
> > The latter defines a dependency which must be met for the option to be
> > both visible and appear in the resulting configuration file.
> >
> >> so SA1111 won't be evaluated (at least if I select SA1111
> > And did you check that SA1111 remains selected?  I bet you didn't.  Or
> > maybe you tested your patched version.  Whatever.  The original works,
> > and has been known to work for years.  Your patch breaks it.  It's
> > really as simple as that.
>
> Thanks for explanation. I think I've got it now. Please review the v2
> version.
>
> Yegor
>
>

--bcaec554d2444725e804caaf8617
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">Dear Tony</font></font>=
</span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">Thank you for applying =
this patch. I am quite new in such things as is posting patched to the comm=
unity, therefore Yegor help me on this manner. </font></font></span></p>

<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">Anyway, I have one more=
 challenging question/request.</font></font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<div style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"E=
N-GB"><font size=3D"3"><font face=3D"Times New Roman">I and my colleagues h=
ave developed a brand new very enhanced board having AM35xx CPU, 512MB DDR2=
, DVI, true dual Ethernet support (not using PRUSS), CAN, SPI, I2C, 7 USBs,=
 etc=85<span style=3D"FONT-FAMILY:&#39;Times New Roman&#39;;FONT-SIZE:12pt"=
 lang=3D"EN-GB">Board is already materialized and operational.</span></font=
></font></span></div>

<div style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"E=
N-GB"><font size=3D"3"><font face=3D"Times New Roman"><span style=3D"FONT-F=
AMILY:&#39;Times New Roman&#39;;FONT-SIZE:12pt" lang=3D"EN-GB"></span></fon=
t></font></span><span style lang=3D"EN-GB"><font size=3D"3" face=3D"Times N=
ew Roman">=A0</font></span></div>

<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">According to our board =
we have create new machine type in the kernel (version: linux-3.2-psp04.06.=
00.07.sdk) and all other required stuff to support our board, modify some t=
hings, like adding support for dual eth, etc. Our goal is to provide this n=
ew board to the market (let say with large quantity) and therefore I am won=
dering how to start or if it is even possible to transfer our kernel change=
 the main stream of this distro? During this kernel modification process we=
 have been looking to not changing anything in kernel, what could affect ot=
her machine types. </font></font></span></p>

<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">Thank you for you answe=
r, and looking forward to receive your replay.</font></font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3" face=3D"Times New Roman">=A0</font></span></p>
<p style=3D"MARGIN:0cm 0cm 0pt" class=3D"MsoNormal"><span style lang=3D"EN-=
GB"><font size=3D"3"><font face=3D"Times New Roman">Best regards,<br>Dejan<=
/font></font></span></p><br><br>
<div class=3D"gmail_quote">2012/9/25 Yegor Yefremov <span dir=3D"ltr">&lt;<=
a href=3D"mailto:yegor_sub1@visionsystems.de" target=3D"_blank">yegor_sub1@=
visionsystems.de</a>&gt;</span><br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div class=3D"HOEnZb">
<div class=3D"h5">On <a href=3D"tel:25.09.2012%2010" value=3D"+12509201210"=
>25.09.2012 10</a>:14, Russell King - ARM Linux wrote:<br>&gt; On Tue, Sep =
25, 2012 at 10:05:30AM +0200, Yegor Yefremov wrote:<br>&gt;&gt; How should =
I change the patch to make it proper? SA1111 is broken anyway:<br>
&gt; No it isn&#39;t. =A0This is what it produces _today_, and has done for=
 the last<br>&gt; 5-10 years without modification<br>&gt;<br>&gt; # CONFIG_=
CLEANCACHE is not set<br>&gt; # CONFIG_FRONTSWAP is not set<br>&gt; CONFIG_=
FORCE_MAX_ZONEORDER=3D9<br>
&gt; CONFIG_LEDS=3Dy<br>&gt; CONFIG_LEDS_CPU=3Dy<br>&gt;<br>&gt;&gt; config=
 FORCE_MAX_ZONEORDER<br>&gt;&gt; =A0 =A0 =A0 =A0 int &quot;Maximum zone ord=
er&quot; if ARCH_SHMOBILE<br>&gt;&gt; =A0 =A0 =A0 =A0 range 11 64 if ARCH_S=
HMOBILE<br>&gt;&gt; =A0 =A0 =A0 =A0 default &quot;9&quot; if SA1111<br>
&gt;&gt; =A0 =A0 =A0 =A0 default &quot;11&quot;<br>&gt;&gt;<br>&gt;&gt; AFA=
IK if ARCH_SHMOBILE defines dependency on ARCH_SHMOBILE,<br>&gt; No it doen=
s&#39;t.<br>&gt;<br>&gt; =A0 =A0 =A0 int &quot;Maximum zone order&quot; if =
ARCH_SHMOBILE<br>
&gt;<br>&gt; is far from being the same as:<br>&gt;<br>&gt; =A0 =A0 =A0 int=
 &quot;Maximum zone order&quot;<br>&gt; =A0 =A0 =A0 depends on ARCH_SHMOBIL=
E<br>&gt;<br>&gt; The former defines a condition upon which the option is o=
ffered in GUIs -<br>
&gt; or to put it another way, it defines the visibility of the option.<br>=
&gt;<br>&gt; The latter defines a dependency which must be met for the opti=
on to be<br>&gt; both visible and appear in the resulting configuration fil=
e.<br>
&gt;<br>&gt;&gt; so SA1111 won&#39;t be evaluated (at least if I select SA1=
111<br>&gt; And did you check that SA1111 remains selected? =A0I bet you di=
dn&#39;t. =A0Or<br>&gt; maybe you tested your patched version. =A0Whatever.=
 =A0The original works,<br>
&gt; and has been known to work for years. =A0Your patch breaks it. =A0It&#=
39;s<br>&gt; really as simple as that.<br><br></div></div>Thanks for explan=
ation. I think I&#39;ve got it now. Please review the v2 version.<br><span =
class=3D"HOEnZb"><font color=3D"#888888"><br>
Yegor<br><br></font></span></blockquote></div><br>

--bcaec554d2444725e804caaf8617--


--===============2322423539488512051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2322423539488512051==--
