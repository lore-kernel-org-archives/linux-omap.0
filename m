From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Sat, 7 Aug 2010 10:24:03 +0800
Message-ID: <AANLkTi=YOEOhGmJU-2LE=V3m01+u3X5aNBsQ+gC8aNdP@mail.gmail.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50191 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0HGCYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 22:24:06 -0400
In-Reply-To: <1281115624-1174-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Sat, Aug 7, 2010 at 1:27 AM, Hema HK <hemahk@ti.com> wrote:
> From: Hema HK =C2=A0<hemahk@ti.com>
>
> With OMAP core-off support musb was not functional as context was get=
ting
> lost after wakeup from core-off. And also musb was blocking the core-=
off
> after loading the gadget driver even with no cable connected sometime=
s.
>
> Added the conext save/restore api in the platform layer which will
> be called in the idle and wakeup path.
>
> Changed the usb sysconfig settings as per the usbotg functional spec.
> When the device is not active, configure to force idle and force stan=
dby mode.
> When it is being used, configure in smart standby and smart idle mode=
=2E
> So while attempting to coreoff the usb is configured to force standby=
 and
> force idle mode, after wakeup configured in smart idle and smart stan=
dby.
>
> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>
> =C2=A0arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A04 ++
> =C2=A0arch/arm/mach-omap2/usb-musb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 21 ++++++++++++++
> =C2=A0arch/arm/plat-omap/include/plat/usb.h | =C2=A0 =C2=A02 +
> =C2=A0drivers/usb/musb/musb_core.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 11 -------
> =C2=A0drivers/usb/musb/omap2430.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 48 +++++++++++++++++++++++++++++++---
> =C2=A05 files changed, 71 insertions(+), 15 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 201=
0-08-06 09:23:01.153862710 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c =C2=A02010-08-06 10:44=
:06.393863125 -0400
> @@ -39,6 +39,7 @@
> =C2=A0#include <plat/gpmc.h>
> =C2=A0#include <plat/dma.h>
> =C2=A0#include <plat/dmtimer.h>
> +#include <plat/usb.h>
>
> =C2=A0#include <asm/tlbflush.h>
>
> @@ -416,6 +417,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (core_next_=
state =3D=3D PWRDM_POWER_OFF) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_core_save_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_prcm_save_context();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* Save MUSB context */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 musb_context_save_restore(1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -458,6 +461,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_prcm_restore_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_sram_restore_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap2_sms_restore_context();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* restore MUSB context */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 musb_context_save_restore(0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_resu=
me_idle(0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_resu=
me_idle(1);
> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c =C2=A0 2010-08-=
06 09:24:23.690112596 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A02010-08-06 10:44:06.385862697 -0400
> @@ -120,6 +120,27 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +void musb_context_save_restore(int save)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod *oh =3D omap_hwmod_lookup("u=
sb_otg_hs");
> + =C2=A0 =C2=A0 =C2=A0 struct omap_device *od =3D oh->od;
> + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D &od->pdev;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &pdev->dev;
> + =C2=A0 =C2=A0 =C2=A0 struct device_driver *drv =3D dev->driver;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (drv) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct musb_hdrc_p=
latform_data *pdata =3D dev->platform_data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct dev_p=
m_ops *pm =3D drv->pm;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pdata->is_usb=
_active(dev)) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (save)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm->suspend(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm->resume_noirq(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0#else
> =C2=A0void __init usb_musb_init(struct omap_musb_board_data *board_da=
ta)
> =C2=A0{
> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h =C2=A0 =C2=
=A02010-08-06 09:23:01.137862514 -0400
> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h 2010-08-06 10=
:44:06.381864367 -0400
> @@ -79,6 +79,8 @@
>
> =C2=A0extern void usb_ohci_init(const struct ohci_hcd_omap_platform_d=
ata *pdata);
>
> +/* For saving and restoring the musb context during off/wakeup*/
> +extern void musb_context_save_restore(int save);
> =C2=A0#endif
>
>
> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c =C2=A0 =C2=A0 201=
0-08-06 09:24:21.069863329 -0400
> +++ linux-omap-pm/drivers/usb/musb/musb_core.c =C2=A02010-08-06 10:44=
:06.369863527 -0400
> @@ -2427,11 +2427,6 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0musb_save_context(musb);
> -
> - =C2=A0 =C2=A0 =C2=A0 if (musb->set_clock)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 musb->set_clock(mu=
sb->clock, 0);
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(musb->=
clock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&musb->lock, flags)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> @@ -2443,12 +2438,6 @@
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!musb->clock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

Is this check can be deleted also ?
Because our blackfin platform have no clock support now.
Thanks.

> -
> - =C2=A0 =C2=A0 =C2=A0 if (musb->set_clock)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 musb->set_clock(mu=
sb->clock, 1);
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(musb->c=
lock);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0musb_restore_context(musb);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for static cmos like DaVinci, register =
values were preserved
> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c =C2=A0 =C2=A0 =C2=A0=
2010-08-06 09:24:21.069863329 -0400
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c =C2=A0 2010-08-06 10:44=
:30.093914217 -0400
> @@ -189,6 +189,19 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +int is_musb_active(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct musb *musb;
> +
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> + =C2=A0 =C2=A0 =C2=A0 /* usbcore insists dev->driver_data is a "stru=
ct hcd *" */
> + =C2=A0 =C2=A0 =C2=A0 musb =3D hcd_to_musb(dev_get_drvdata(dev));
> +#else
> + =C2=A0 =C2=A0 =C2=A0 musb =3D dev_get_drvdata(dev);
> +#endif
> + =C2=A0 =C2=A0 =C2=A0 return musb->is_active;
> +}
> +
> =C2=A0int __init musb_platform_init(struct musb *musb)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 l;
> @@ -250,6 +263,7 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_host_enabled(musb))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0musb->board_se=
t_vbus =3D omap_set_vbus;
>
> + =C2=A0 =C2=A0 =C2=A0 plat->is_usb_active =3D is_musb_active;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setup_timer(&musb_idle_timer, musb_do_idle=
, (unsigned long) musb);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -259,15 +273,42 @@
> =C2=A0void musb_platform_save_context(struct musb *musb,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct musb_co=
ntext_registers *musb_context)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 musb_context->otg_sysconfig =3D musb_readl(mus=
b->mregs, OTG_SYSCONFIG);
> - =C2=A0 =C2=A0 =C2=A0 musb_context->otg_forcestandby =3D musb_readl(=
musb->mregs, OTG_FORCESTDBY);
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* As per the omap-usbotg specification, =
configure it to forced standby
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and =C2=A0force idle mode when no acti=
vity on usb.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *musb_base =3D musb->mregs;
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_rea=
dl(musb_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OTG_SYSCONFIG) & ~(NOSTDBY | SMARTS=
TDBY));
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_rea=
dl(musb_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OTG_SYS=
CONFIG) & ~(AUTOIDLE));
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_rea=
dl(musb_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OTG_SYSCONFIG) & ~(NOIDLE | SMARTID=
LE));
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_FORCESTDBY, 1);
> =C2=A0}
>
> =C2=A0void musb_platform_restore_context(struct musb *musb,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct musb_co=
ntext_registers *musb_context)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 musb_writel(musb->mregs, OTG_SYSCONFIG, musb_c=
ontext->otg_sysconfig);
> - =C2=A0 =C2=A0 =C2=A0 musb_writel(musb->mregs, OTG_FORCESTDBY, musb_=
context->otg_forcestandby);
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* As per the omap-usbotg specification, =
configure it smart standby
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and smart idle during operation.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *musb_base =3D musb->mregs;
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_FORCESTDBY, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_rea=
dl(musb_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OTG_SYSCONFIG) | (SMARTSTDBY));
> +
> + =C2=A0 =C2=A0 =C2=A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_rea=
dl(musb_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OTG_SYSCONFIG) | (SMARTIDLE));
> =C2=A0}
> =C2=A0#endif
>
> Index: linux-omap-pm/include/linux/usb/musb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-pm.orig/include/linux/usb/musb.h 2010-08-06 09:23:01.1=
61864151 -0400
> +++ linux-omap-pm/include/linux/usb/musb.h =C2=A0 =C2=A0 =C2=A02010-0=
8-06 10:44:06.401862567 -0400
> @@ -126,6 +126,9 @@
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Architecture specific board data =C2=A0=
 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*board_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* check usb device active state*/
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(*is_usb_active)(struct device *dev);
> =C2=A0};
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

--=20
Regards,
--Bob
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
