From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent clk
 set
Date: Wed, 13 Jun 2012 00:54:45 +0800
Message-ID: <CA+Y31wdgFmjbWyfgo1Q5m=8iYujWy0m4jB_X7W5G-xOXrnFdZA@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
 <4FD608C5.9000900@ti.com>
 <CA+Y31wfHiKEWFbwkec_fFHS3kKms_OccTKGQcetuE9F132vbDQ@mail.gmail.com>
 <4FD76DEF.7090309@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4644384160145904873=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FD76DEF.7090309@ti.com>
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
Cc: khilman@ti.com, tony@atomide.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============4644384160145904873==
Content-Type: multipart/alternative; boundary=14dae934071be32a2504c24952de

--14dae934071be32a2504c24952de
Content-Type: text/plain; charset=ISO-8859-1

2012/6/13 Jon Hunter <jon-hunter@ti.com>

>
> On 06/11/2012 09:30 PM, Zumeng Chen wrote:
> >
> >
> > 2012/6/11 Jon Hunter <jon-hunter@ti.com <mailto:jon-hunter@ti.com>>
> >
> >
> >     On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> >     > A typo fix for this cosmetic change and mute a failed message from
> >     > a unnecessary setting of some parent clk for usbhs_omap on
> OMAP3EVM.
> >     >
> >     > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com
> >     <mailto:zumeng.chen@gmail.com>>
> >     > ---
> >     >  drivers/mfd/omap-usb-host.c |    4 +++-
> >     >  1 files changed, 3 insertions(+), 1 deletions(-)
> >     >
> >     > diff --git a/drivers/mfd/omap-usb-host.c
> b/drivers/mfd/omap-usb-host.c
> >     > index 7e96bb2..9aaaf3c 100644
> >     > --- a/drivers/mfd/omap-usb-host.c
> >     > +++ b/drivers/mfd/omap-usb-host.c
> >     > @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct
> >     platform_device *pdev)
> >     >               goto err_usbtll_p2_fck;
> >     >       }
> >     >
> >     > +#ifndef CONFIG_MACH_OMAP3EVM
> >     > +     /* for OMAP3 , the clk set parent fails */
> >     >       if (is_ehci_phy_mode(pdata->port_mode[0])) {
> >     > -             /* for OMAP3 , the clk set paretn fails */
> >     >               ret = clk_set_parent(omap->utmi_p1_fck,
> >     >                                       omap->xclk60mhsp1_ck);
> >     >               if (ret != 0)
> >
> >     This begs the question, why is port_mode[0] set to ehci phy mode if
> this
> >     is failing? Something does not seem right here but this does not look
> >     like the right fix.
> >
> > Actually, for omap3530evm, there is only port-mode[1] is valid, so
> > port_mode[0]
> > will be skipped by "if". And it will report "xclk60mhsp2_ck set parent
> > failed"
> >
> > But why I bracket both of them, because, both xclk60mhsp2_ck and
> > xclk60mhsp1_ck
> > have dummy_ck clk for omap3530evm. So we can skip them directly.
>
> How about something like this ...
>
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 62ec5c4..c1335f1 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk
> *parent)
>        if (!arch_clock || !arch_clock->clk_set_parent)
>                return ret;
>
> +       /* If the clock is a dummy clock just return */
> +       if (!strcmp(clk->name, dummy_ck.name))
> +               return 0;
> +
>
Yes, this is a good fixes, thanks I'll try it.

Regards,
Zumeng

>        spin_lock_irqsave(&clockfw_lock, flags);
>        if (clk->usecount == 0) {
>                ret = arch_clock->clk_set_parent(clk, parent);
>
> Can you give this a try?
>
> Cheers
> Jon
>

--14dae934071be32a2504c24952de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/13 Jon Hunter <span dir=3D"ltr">&=
lt;<a href=3D"mailto:jon-hunter@ti.com" target=3D"_blank">jon-hunter@ti.com=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
On 06/11/2012 09:30 PM, Zumeng Chen wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2012/6/11 Jon Hunter &lt;<a href=3D"mailto:jon-hunter@ti.com">jon-hunt=
er@ti.com</a> &lt;mailto:<a href=3D"mailto:jon-hunter@ti.com">jon-hunter@ti=
.com</a>&gt;&gt;<br>
<div class=3D"im">&gt;<br>
&gt;<br>
&gt; =A0 =A0 On 06/11/2012 09:00 AM, Zumeng Chen wrote:<br>
&gt; =A0 =A0 &gt; A typo fix for this cosmetic change and mute a failed mes=
sage from<br>
&gt; =A0 =A0 &gt; a unnecessary setting of some parent clk for usbhs_omap o=
n OMAP3EVM.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.c=
hen@gmail.com">zumeng.chen@gmail.com</a><br>
</div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:zumeng.chen@gmail.com">zume=
ng.chen@gmail.com</a>&gt;&gt;<br>
<div><div class=3D"h5">&gt; =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 &gt; =A0drivers/mfd/omap-usb-host.c | =A0 =A04 +++-<br>
&gt; =A0 =A0 &gt; =A01 files changed, 3 insertions(+), 1 deletions(-)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/om=
ap-usb-host.c<br>
&gt; =A0 =A0 &gt; index 7e96bb2..9aaaf3c 100644<br>
&gt; =A0 =A0 &gt; --- a/drivers/mfd/omap-usb-host.c<br>
&gt; =A0 =A0 &gt; +++ b/drivers/mfd/omap-usb-host.c<br>
&gt; =A0 =A0 &gt; @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe=
(struct<br>
&gt; =A0 =A0 platform_device *pdev)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +#ifndef CONFIG_MACH_OMAP3EVM<br>
&gt; =A0 =A0 &gt; + =A0 =A0 /* for OMAP3 , the clk set parent fails */<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 if (is_ehci_phy_mode(pdata-&gt;port_mode[0]))=
 {<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 /* for OMAP3 , the clk set pare=
tn fails */<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap-&=
gt;utmi_p1_fck,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 omap-&gt;xclk60mhsp1_ck);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)<br>
&gt;<br>
&gt; =A0 =A0 This begs the question, why is port_mode[0] set to ehci phy mo=
de if this<br>
&gt; =A0 =A0 is failing? Something does not seem right here but this does n=
ot look<br>
&gt; =A0 =A0 like the right fix.<br>
&gt;<br>
&gt; Actually, for omap3530evm, there is only port-mode[1] is valid, so<br>
&gt; port_mode[0]<br>
&gt; will be skipped by &quot;if&quot;. And it will report &quot;xclk60mhsp=
2_ck set parent<br>
&gt; failed&quot;<br>
&gt;<br>
&gt; But why I bracket both of them, because, both xclk60mhsp2_ck and<br>
&gt; xclk60mhsp1_ck<br>
&gt; have dummy_ck clk for omap3530evm. So we can skip them directly.<br>
<br>
</div></div>How about something like this ...<br>
<br>
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c<br>
index 62ec5c4..c1335f1 100644<br>
--- a/arch/arm/plat-omap/clock.c<br>
+++ b/arch/arm/plat-omap/clock.c<br>
@@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent=
)<br>
 =A0 =A0 =A0 =A0if (!arch_clock || !arch_clock-&gt;clk_set_parent)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;<br>
<br>
+ =A0 =A0 =A0 /* If the clock is a dummy clock just return */<br>
+ =A0 =A0 =A0 if (!strcmp(clk-&gt;name, <a href=3D"http://dummy_ck.name" ta=
rget=3D"_blank">dummy_ck.name</a>))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+<br></blockquote><div>Yes, this is a good fixes, thanks I&#39;ll try it.<b=
r><br>Regards,<br>Zumeng <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">

 =A0 =A0 =A0 =A0spin_lock_irqsave(&amp;clockfw_lock, flags);<br>
 =A0 =A0 =A0 =A0if (clk-&gt;usecount =3D=3D 0) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D arch_clock-&gt;clk_set_parent(clk, =
parent);<br>
<br>
Can you give this a try?<br>
<br>
Cheers<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Jon<br>
</font></span></blockquote></div><br>

--14dae934071be32a2504c24952de--


--===============4644384160145904873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4644384160145904873==--
