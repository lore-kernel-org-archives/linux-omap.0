From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for
	omap-serial driver
Date: Thu, 5 May 2011 11:18:46 +0530
Message-ID: <BANLkTinNVTq9OGUHj4ZDCTXvRE7Jgf0MKg@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-5-git-send-email-govindraj.raja@ti.com>
	<87hb9aqk53.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0237288326=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87hb9aqk53.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0237288326==
Content-Type: multipart/alternative; boundary=bcaec517a88a67247304a280ee66

--bcaec517a88a67247304a280ee66
Content-Type: text/plain; charset=ISO-8859-1

On Thu, May 5, 2011 at 2:05 AM, Kevin Hilman <khilman@ti.com> wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> > Adapts omap-serial driver to use pm_runtime api's.
> >
> > 1.) Populate reg values to uart port which can be used for context
> restore.
> > 2.) Moving context_restore func to driver from serial.c
> > 3.) Adding port_enable/disable func to enable/disable given uart port.
> >     enable port using get_sync and disable using autosuspend.
> > 4.) using runtime irq safe api to make get_sync be called from irq
> context.
> >
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> > ---
> >  arch/arm/mach-omap2/serial.c                  |   16 ++
> >  arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
> >  drivers/tty/serial/omap-serial.c              |  211
> ++++++++++++++++++++++---
> >  3 files changed, 203 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 8c1a4c7..314d82f 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct
> omap_board_data *bdata)
> >       }
> >  }
> >
> > +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool
> enable)
> > +{
> > +     struct omap_uart_port_info *up = pdev->dev.platform_data;
> > +
> > +     /* Set or clear wake-enable bit */
> > +     if (up->wk_en && up->wk_mask) {
> > +             u32 v = __raw_readl(up->wk_en);
> > +             if (enable)
> > +                     v |= up->wk_mask;
> > +             else
> > +                     v &= ~up->wk_mask;
> > +             __raw_writel(v, up->wk_en);
> > +     }
> > +}
>
> Rather than having the driver do this via the PRCM, can you do an
> experiment?  Can you try to leave the module-level wakeup enabled all
> the time in the PRCM, and the driver can then enable/disable
> module-level wakeups simply by toggling ENAWAKEUP in the module's
> SYSCONFIG?  If that works, than you can just use
> omap_hwmod_enable_wakeup() for this and not need the above function.
>


If we leave PRCM uart module level bit enabled all time and we disable
wakeup using sysfs

echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wakeup

it wakes up after clock disable, however unsetting the bit ensures
it doesn't
wakeup after uart clocks are cut.

As Paul suggested, How about adding omap_device/omap_hwmod function
to set and unset the bit?

Using

.module_bit = OMAP3430_EN_UART1_SHIFT,

from hwmod data?



>
> >  static void omap_uart_idle_init(struct omap_uart_port_info *uart,
> >                               unsigned short num)
> >  {
> > @@ -332,6 +347,7 @@ void __init omap_serial_init_port(struct
> omap_board_data *bdata)
> >
> >       pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
> >       pdata->flags = UPF_BOOT_AUTOCONF;
> > +     pdata->enable_wakeup = omap_uart_wakeup_enable;
> >       if (bdata->id == omap_uart_con_id)
> >               pdata->console_uart = true;
> >
>
>
<<SNIP>>


> > +     pm_runtime_use_autosuspend(&pdev->dev);
> > +     pm_runtime_set_autosuspend_delay(&pdev->dev,
> > +                     OMAP_UART_AUTOSUSPEND_DELAY);
> > +
> > +     pm_runtime_enable(&pdev->dev);
> > +     pm_runtime_irq_safe(&pdev->dev);
> > +
> > +     if (omap_up_info->console_uart) {
> > +             od = to_omap_device(up->pdev);
> > +             omap_hwmod_idle(od->hwmods[0]);
>
> Driver should have know knowlege of the underlying hwmod.
>
> I assume this is here because of the usage of HWMOD_INIT_NO_IDLE and
> HWMOD_INIT_NO_RESET, right?


   Yes correct.



>  With proper runtime PM, we should be able to
> remove the need for using those flags.
>


For omap-uart used for earlyprintk's the early_console driver will
use printch from debug macro to print through uart.

During omap-hwmod is getting initialized

--> _setup
   --> _idle
    ---> _disable_clocks

at this point of time while printch is happening and
hwmod disables uart clocks I dont have uart-console
driver available which can enable clocks back.

So I have to use those flags when earlyprintk is enabled.

--
Thanks,
Govindraj.R




>
> Kevin
>
> > +             serial_omap_port_enable(up);
> > +             serial_omap_port_disable(up);
> > +     }
> > +
> >       ui[pdev->id] = up;
> >       serial_omap_add_console_port(up);
> >
> >       ret = uart_add_one_port(&serial_omap_reg, &up->port);
> >       if (ret != 0)
> > -             goto do_release_region;
> > +             goto err1;
> >
> > +     dev_set_drvdata(&pdev->dev, up);
> >       platform_set_drvdata(pdev, up);
> > +
> >       return 0;
> >  err:
> >       dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> >                               pdev->id, __func__, ret);
> > +err1:
> > +     kfree(up);
> >  do_release_region:
> >       release_mem_region(mem->start, (mem->end - mem->start) + 1);
> >       return ret;
> > @@ -1318,20 +1421,76 @@ static int serial_omap_remove(struct
> platform_device *dev)
> >
> >       platform_set_drvdata(dev, NULL);
> >       if (up) {
> > +             pm_runtime_disable(&up->pdev->dev);
> >               uart_remove_one_port(&serial_omap_reg, &up->port);
> >               kfree(up);
> >       }
> >       return 0;
> >  }
> >
> > +static void omap_uart_restore_context(struct uart_omap_port *up)
> > +{
> > +     u16 efr = 0;
> > +
> > +     serial_out(up, UART_OMAP_MDR1, up->mdr1);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     efr = serial_in(up, UART_EFR);
> > +     serial_out(up, UART_EFR, UART_EFR_ECB);
> > +     serial_out(up, UART_LCR, 0x0); /* Operational mode */
> > +     serial_out(up, UART_IER, 0x0);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     serial_out(up, UART_DLL, up->dll);
> > +     serial_out(up, UART_DLM, up->dlh);
> > +     serial_out(up, UART_LCR, 0x0); /* Operational mode */
> > +     serial_out(up, UART_IER, up->ier);
> > +     serial_out(up, UART_FCR, up->fcr);
> > +     serial_out(up, UART_LCR, 0x80);
> > +     serial_out(up, UART_MCR, up->mcr);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     serial_out(up, UART_EFR, efr);
> > +     serial_out(up, UART_LCR, UART_LCR_WLEN8);
> > +     /* UART 16x mode */
> > +     serial_out(up, UART_OMAP_MDR1, up->mdr1);
> > +}
> > +
> > +static int omap_serial_runtime_suspend(struct device *dev)
> > +{
> > +     struct uart_omap_port *up = dev_get_drvdata(dev);
> > +
> > +     if (!up)
> > +             goto done;
> > +
> > +     if (device_may_wakeup(dev))
> > +             up->enable_wakeup(up->pdev, true);
> > +     else
> > +             up->enable_wakeup(up->pdev, false);
> > +done:
> > +     return 0;
> > +}
> > +
> > +static int omap_serial_runtime_resume(struct device *dev)
> > +{
> > +     struct uart_omap_port *up = dev_get_drvdata(dev);
> > +
> > +     if (up)
> > +             omap_uart_restore_context(up);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops omap_serial_dev_pm_ops = {
> > +     .suspend = serial_omap_suspend,
> > +     .resume = serial_omap_resume,
> > +     .runtime_suspend = omap_serial_runtime_suspend,
> > +     .runtime_resume = omap_serial_runtime_resume,
> > +};
> > +
> >  static struct platform_driver serial_omap_driver = {
> >       .probe          = serial_omap_probe,
> >       .remove         = serial_omap_remove,
> > -
> > -     .suspend        = serial_omap_suspend,
> > -     .resume         = serial_omap_resume,
> >       .driver         = {
> >               .name   = DRIVER_NAME,
> > +             .pm = &omap_serial_dev_pm_ops,
> >       },
> >  };
>

--bcaec517a88a67247304a280ee66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, May 5, 2011 at 2:05 AM, Kevin Hi=
lman <span dir=3D"ltr">&lt;<a href=3D"mailto:khilman@ti.com">khilman@ti.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div><div></div><div class=3D"h5">&quot;Govindraj.R&quot; &lt;<a href=3D"ma=
ilto:govindraj.raja@ti.com">govindraj.raja@ti.com</a>&gt; writes:<br>
<br>
&gt; Adapts omap-serial driver to use pm_runtime api&#39;s.<br>
&gt;<br>
&gt; 1.) Populate reg values to uart port which can be used for context res=
tore.<br>
&gt; 2.) Moving context_restore func to driver from serial.c<br>
&gt; 3.) Adding port_enable/disable func to enable/disable given uart port.=
<br>
&gt; =A0 =A0 enable port using get_sync and disable using autosuspend.<br>
&gt; 4.) using runtime irq safe api to make get_sync be called from irq con=
text.<br>
&gt;<br>
&gt; Signed-off-by: Govindraj.R &lt;<a href=3D"mailto:govindraj.raja@ti.com=
">govindraj.raja@ti.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 16 ++<br>
&gt; =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 +<br>
&gt; =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A021=
1 ++++++++++++++++++++++---<br>
&gt; =A03 files changed, 203 insertions(+), 26 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial=
.c<br>
&gt; index 8c1a4c7..314d82f 100644<br>
&gt; --- a/arch/arm/mach-omap2/serial.c<br>
&gt; +++ b/arch/arm/mach-omap2/serial.c<br>
&gt; @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct =
omap_board_data *bdata)<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static void omap_uart_wakeup_enable(struct platform_device *pdev, boo=
l enable)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct omap_uart_port_info *up =3D pdev-&gt;dev.platform_dat=
a;<br>
&gt; +<br>
&gt; + =A0 =A0 /* Set or clear wake-enable bit */<br>
&gt; + =A0 =A0 if (up-&gt;wk_en &amp;&amp; up-&gt;wk_mask) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 u32 v =3D __raw_readl(up-&gt;wk_en);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D up-&gt;wk_mask;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v &amp;=3D ~up-&gt;wk_mask;<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(v, up-&gt;wk_en);<br>
&gt; + =A0 =A0 }<br>
&gt; +}<br>
<br>
</div></div>Rather than having the driver do this via the PRCM, can you do =
an<br>
experiment? =A0Can you try to leave the module-level wakeup enabled all<br>
the time in the PRCM, and the driver can then enable/disable<br>
module-level wakeups simply by toggling ENAWAKEUP in the module&#39;s<br>
SYSCONFIG? =A0If that works, than you can just use<br>
omap_hwmod_enable_wakeup() for this and not need the above function.<br></b=
lockquote><div><br></div><div><br></div><div>If we leave PRCM uart module l=
evel bit enabled all time and we disable</div><div>wakeup using sysfs</div>

<div>=A0</div><div>echo=A0disabled=A0&gt; /sys/devices/platform/omap/omap_u=
art.0/power/wakeup</div><div><br></div><div>it wakes up after clock=A0disab=
le, however unsetting the bit ensures it=A0doesn&#39;t</div><div>wakeup aft=
er uart clocks are cut.</div>

<div><br></div><div>As Paul suggested, How about adding=A0<span class=3D"Ap=
ple-style-span" style=3D"border-collapse: collapse; color: rgb(32, 32, 32);=
 font-family: &#39;Droid Sans&#39;, arial, sans-serif; font-size: 13px; ">o=
map_device/omap_hwmod function</span></div>

<div><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; c=
olor: rgb(32, 32, 32); font-family: &#39;Droid Sans&#39;, arial, sans-serif=
; font-size: 13px; ">to set and unset the bit?</span></div><div><br></div>
<div>
Using</div><div><br></div><div><font class=3D"Apple-style-span" color=3D"#2=
02020" face=3D"&#39;Droid Sans&#39;, arial, sans-serif"><span class=3D"Appl=
e-style-span" style=3D"border-collapse: collapse;">.module_bit =3D OMAP3430=
_EN_UART1_SHIFT,</span></font></div>

<div><font class=3D"Apple-style-span" color=3D"#202020" face=3D"&#39;Droid =
Sans&#39;, arial, sans-serif"><span class=3D"Apple-style-span" style=3D"bor=
der-collapse: collapse;"><br></span></font></div><div><font class=3D"Apple-=
style-span" color=3D"#202020" face=3D"&#39;Droid Sans&#39;, arial, sans-ser=
if"><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;">f=
rom hwmod data?</span></font></div>

<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5"><br>
&gt; =A0static void omap_uart_idle_init(struct omap_uart_port_info *uart,<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned s=
hort num)<br>
&gt; =A0{<br>
&gt; @@ -332,6 +347,7 @@ void __init omap_serial_init_port(struct omap_boar=
d_data *bdata)<br>
&gt;<br>
&gt; =A0 =A0 =A0 pdata-&gt;uartclk =3D OMAP24XX_BASE_BAUD * 16;<br>
&gt; =A0 =A0 =A0 pdata-&gt;flags =3D UPF_BOOT_AUTOCONF;<br>
&gt; + =A0 =A0 pdata-&gt;enable_wakeup =3D omap_uart_wakeup_enable;<br>
&gt; =A0 =A0 =A0 if (bdata-&gt;id =3D=3D omap_uart_con_id)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata-&gt;console_uart =3D true;<br>
&gt;<br><br></div></div></blockquote><div><br></div><div>&lt;&lt;SNIP&gt;&g=
t;</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div><div class=3D"h5=
">
&gt; + =A0 =A0 pm_runtime_use_autosuspend(&amp;pdev-&gt;dev);<br>
&gt; + =A0 =A0 pm_runtime_set_autosuspend_delay(&amp;pdev-&gt;dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_DELAY)=
;<br>
&gt; +<br>
&gt; + =A0 =A0 pm_runtime_enable(&amp;pdev-&gt;dev);<br>
&gt; + =A0 =A0 pm_runtime_irq_safe(&amp;pdev-&gt;dev);<br>
&gt; +<br>
&gt; + =A0 =A0 if (omap_up_info-&gt;console_uart) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 od =3D to_omap_device(up-&gt;pdev);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 omap_hwmod_idle(od-&gt;hwmods[0]);<br>
<br>
</div></div>Driver should have know knowlege of the underlying hwmod.<br>
<br>
I assume this is here because of the usage of HWMOD_INIT_NO_IDLE and<br>
HWMOD_INIT_NO_RESET, right? </blockquote><div><br></div><div>=A0=A0 Yes cor=
rect.</div><div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">=A0=
With proper runtime PM, we should be able to<br>


remove the need for using those flags.<br></blockquote><div><br></div><div>=
<br></div><div><meta http-equiv=3D"content-type" content=3D"text/html; char=
set=3Dutf-8"><span class=3D"Apple-style-span" style=3D"border-collapse: col=
lapse; font-family: arial, sans-serif; font-size: 13px; ">For omap-uart use=
d for earlyprintk&#39;s the early_console driver will</span><span class=3D"=
Apple-style-span" style=3D"border-collapse: collapse; font-family: arial, s=
ans-serif; font-size: 13px; "><br>

</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">use printch from debug =
macro to print through uart.</span><span class=3D"Apple-style-span" style=
=3D"border-collapse: collapse; font-family: arial, sans-serif; font-size: 1=
3px; "><br>

</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; "><br></span></div><div><=
span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-fa=
mily: arial, sans-serif; font-size: 13px; ">During omap-hwmod is getting in=
itialized<br>

<br>--&gt; _setup<br>=A0 =A0--&gt; _idle<br>=A0 =A0 ---&gt; _disable_clocks=
<br><br>at this point of time while printch is happening and<br>hwmod disab=
les uart clocks I dont have uart-console<br>driver available which can enab=
le clocks back.<br>

<br>So I have to use those flags when earlyprintk=A0is enabled.</span></div=
><div><br></div><div>--</div><div>Thanks,</div><div>Govindraj.R</div><div><=
br></div><div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">


<font color=3D"#888888"><br>
Kevin<br>
</font><div><div></div><div class=3D"h5"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(up);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; =A0 =A0 =A0 ui[pdev-&gt;id] =3D up;<br>
&gt; =A0 =A0 =A0 serial_omap_add_console_port(up);<br>
&gt;<br>
&gt; =A0 =A0 =A0 ret =3D uart_add_one_port(&amp;serial_omap_reg, &amp;up-&g=
t;port);<br>
&gt; =A0 =A0 =A0 if (ret !=3D 0)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err1;<br>
&gt;<br>
&gt; + =A0 =A0 dev_set_drvdata(&amp;pdev-&gt;dev, up);<br>
&gt; =A0 =A0 =A0 platform_set_drvdata(pdev, up);<br>
&gt; +<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0err:<br>
&gt; =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;[UART%d]: failure [%s]: %=
d\n&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;i=
d, __func__, ret);<br>
&gt; +err1:<br>
&gt; + =A0 =A0 kfree(up);<br>
&gt; =A0do_release_region:<br>
&gt; =A0 =A0 =A0 release_mem_region(mem-&gt;start, (mem-&gt;end - mem-&gt;s=
tart) + 1);<br>
&gt; =A0 =A0 =A0 return ret;<br>
&gt; @@ -1318,20 +1421,76 @@ static int serial_omap_remove(struct platform_=
device *dev)<br>
&gt;<br>
&gt; =A0 =A0 =A0 platform_set_drvdata(dev, NULL);<br>
&gt; =A0 =A0 =A0 if (up) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(&amp;up-&gt;pdev-&gt;dev)=
;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_remove_one_port(&amp;serial_omap_reg,=
 &amp;up-&gt;port);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(up);<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static void omap_uart_restore_context(struct uart_omap_port *up)<br>
&gt; +{<br>
&gt; + =A0 =A0 u16 efr =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up-&gt;mdr1);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */<br>
&gt; + =A0 =A0 efr =3D serial_in(up, UART_EFR);<br>
&gt; + =A0 =A0 serial_out(up, UART_EFR, UART_EFR_ECB);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */<br>
&gt; + =A0 =A0 serial_out(up, UART_IER, 0x0);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */<br>
&gt; + =A0 =A0 serial_out(up, UART_DLL, up-&gt;dll);<br>
&gt; + =A0 =A0 serial_out(up, UART_DLM, up-&gt;dlh);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0x0); /* Operational mode */<br>
&gt; + =A0 =A0 serial_out(up, UART_IER, up-&gt;ier);<br>
&gt; + =A0 =A0 serial_out(up, UART_FCR, up-&gt;fcr);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0x80);<br>
&gt; + =A0 =A0 serial_out(up, UART_MCR, up-&gt;mcr);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, 0xBF); /* Config B mode */<br>
&gt; + =A0 =A0 serial_out(up, UART_EFR, efr);<br>
&gt; + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);<br>
&gt; + =A0 =A0 /* UART 16x mode */<br>
&gt; + =A0 =A0 serial_out(up, UART_OMAP_MDR1, up-&gt;mdr1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int omap_serial_runtime_suspend(struct device *dev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);<br>
&gt; +<br>
&gt; + =A0 =A0 if (!up)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto done;<br>
&gt; +<br>
&gt; + =A0 =A0 if (device_may_wakeup(dev))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 up-&gt;enable_wakeup(up-&gt;pdev, true);<br>
&gt; + =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 up-&gt;enable_wakeup(up-&gt;pdev, false);<br=
>
&gt; +done:<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int omap_serial_runtime_resume(struct device *dev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct uart_omap_port *up =3D dev_get_drvdata(dev);<br>
&gt; +<br>
&gt; + =A0 =A0 if (up)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_restore_context(up);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dev_pm_ops omap_serial_dev_pm_ops =3D {<br>
&gt; + =A0 =A0 .suspend =3D serial_omap_suspend,<br>
&gt; + =A0 =A0 .resume =3D serial_omap_resume,<br>
&gt; + =A0 =A0 .runtime_suspend =3D omap_serial_runtime_suspend,<br>
&gt; + =A0 =A0 .runtime_resume =3D omap_serial_runtime_resume,<br>
&gt; +};<br>
&gt; +<br>
&gt; =A0static struct platform_driver serial_omap_driver =3D {<br>
&gt; =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,<br>
&gt; =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,<br>
&gt; -<br>
&gt; - =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,<br>
&gt; - =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,<br>
&gt; =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &amp;omap_serial_dev_pm_ops,<br>
&gt; =A0 =A0 =A0 },<br>
&gt; =A0};<br>
</div></div></blockquote></div><br>

--bcaec517a88a67247304a280ee66--


--===============0237288326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0237288326==--
