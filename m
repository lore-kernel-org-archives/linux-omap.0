From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent clk
 set
Date: Tue, 12 Jun 2012 10:30:30 +0800
Message-ID: <CA+Y31wfHiKEWFbwkec_fFHS3kKms_OccTKGQcetuE9F132vbDQ@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
 <4FD608C5.9000900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6079156646077766510=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FD608C5.9000900@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: khilman@ti.com, zumeng chen <zumeng.chen@gmail.com>, tony@atomide.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6079156646077766510==
Content-Type: multipart/alternative; boundary=14dae93403e10edb7104c23d4044

--14dae93403e10edb7104c23d4044
Content-Type: text/plain; charset=ISO-8859-1

2012/6/11 Jon Hunter <jon-hunter@ti.com>

>
> On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> > A typo fix for this cosmetic change and mute a failed message from
> > a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.
> >
> > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > ---
> >  drivers/mfd/omap-usb-host.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> > index 7e96bb2..9aaaf3c 100644
> > --- a/drivers/mfd/omap-usb-host.c
> > +++ b/drivers/mfd/omap-usb-host.c
> > @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct
> platform_device *pdev)
> >               goto err_usbtll_p2_fck;
> >       }
> >
> > +#ifndef CONFIG_MACH_OMAP3EVM
> > +     /* for OMAP3 , the clk set parent fails */
> >       if (is_ehci_phy_mode(pdata->port_mode[0])) {
> > -             /* for OMAP3 , the clk set paretn fails */
> >               ret = clk_set_parent(omap->utmi_p1_fck,
> >                                       omap->xclk60mhsp1_ck);
> >               if (ret != 0)
>
> This begs the question, why is port_mode[0] set to ehci phy mode if this
> is failing? Something does not seem right here but this does not look
> like the right fix.
>
Actually, for omap3530evm, there is only port-mode[1] is valid, so
port_mode[0]
will be skipped by "if". And it will report "xclk60mhsp2_ck set parent
failed"

But why I bracket both of them, because, both xclk60mhsp2_ck and
xclk60mhsp1_ck
have dummy_ck clk for omap3530evm. So we can skip them directly.

Regards,
Zumeng

>
> Cheers
> Jon
>

--14dae93403e10edb7104c23d4044
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/11 Jon Hunter <span dir=3D"ltr">&=
lt;<a href=3D"mailto:jon-hunter@ti.com" target=3D"_blank">jon-hunter@ti.com=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im"><br>
On 06/11/2012 09:00 AM, Zumeng Chen wrote:<br>
&gt; A typo fix for this cosmetic change and mute a failed message from<br>
&gt; a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.<b=
r>
&gt;<br>
&gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com=
">zumeng.chen@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/mfd/omap-usb-host.c | =A0 =A04 +++-<br>
&gt; =A01 files changed, 3 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c=
<br>
&gt; index 7e96bb2..9aaaf3c 100644<br>
&gt; --- a/drivers/mfd/omap-usb-host.c<br>
&gt; +++ b/drivers/mfd/omap-usb-host.c<br>
&gt; @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct platf=
orm_device *pdev)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; +#ifndef CONFIG_MACH_OMAP3EVM<br>
&gt; + =A0 =A0 /* for OMAP3 , the clk set parent fails */<br>
&gt; =A0 =A0 =A0 if (is_ehci_phy_mode(pdata-&gt;port_mode[0])) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 /* for OMAP3 , the clk set paretn fails */<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap-&gt;utmi_p1_fc=
k,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 omap-&gt;xclk60mhsp1_ck);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)<br>
<br>
</div>This begs the question, why is port_mode[0] set to ehci phy mode if t=
his<br>
is failing? Something does not seem right here but this does not look<br>
like the right fix.<br></blockquote><div>Actually, for omap3530evm, there i=
s only port-mode[1] is valid, so port_mode[0]<br>will be skipped by &quot;i=
f&quot;. And it will report &quot;xclk60mhsp2_ck set parent failed&quot;<br=
>
<br>But why I bracket both of them, because, both xclk60mhsp2_ck and xclk60=
mhsp1_ck<br>have dummy_ck clk for omap3530evm. So we can skip them directly=
.<br><br>Regards,<br>Zumeng<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">

<br>
Cheers<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Jon<br>
</font></span></blockquote></div><br>

--14dae93403e10edb7104c23d4044--


--===============6079156646077766510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6079156646077766510==--
