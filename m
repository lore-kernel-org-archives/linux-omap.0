From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Tue, 10 Aug 2010 12:39:49 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270A49F6D@dbde02.ent.ti.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com>
 <AANLkTi=YOEOhGmJU-2LE=V3m01+u3X5aNBsQ+gC8aNdP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59630 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab0HJHKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 03:10:02 -0400
In-Reply-To: <AANLkTi=YOEOhGmJU-2LE=V3m01+u3X5aNBsQ+gC8aNdP@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

=20

>-----Original Message-----
>From: Bob Liu [mailto:lliubbo@gmail.com]=20
>Sent: Saturday, August 07, 2010 7:54 AM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;=20
>Mankad, Maulik Ojas; Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
>
>On Sat, Aug 7, 2010 at 1:27 AM, Hema HK <hemahk@ti.com> wrote:
>> From: Hema HK =A0<hemahk@ti.com>
>>
>> With OMAP core-off support musb was not functional as=20
>context was getting
>> lost after wakeup from core-off. And also musb was blocking=20
>the core-off
>> after loading the gadget driver even with no cable connected=20
>sometimes.
>>
>> Added the conext save/restore api in the platform layer which will
>> be called in the idle and wakeup path.
>>
>> Changed the usb sysconfig settings as per the usbotg functional spec=
=2E
>> When the device is not active, configure to force idle and=20
>force standby mode.
>> When it is being used, configure in smart standby and smart=20
>idle mode.
>> So while attempting to coreoff the usb is configured to=20
>force standby and
>> force idle mode, after wakeup configured in smart idle and=20
>smart standby.
>>
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++
>> =A0arch/arm/mach-omap2/usb-musb.c =A0 =A0 =A0 =A0| =A0 21 ++++++++++=
++++
>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A02 +
>> =A0drivers/usb/musb/musb_core.c =A0 =A0 =A0 =A0 =A0| =A0 11 -------
>> =A0drivers/usb/musb/omap2430.c =A0 =A0 =A0 =A0 =A0 | =A0 48=20
>+++++++++++++++++++++++++++++++---
>> =A05 files changed, 71 insertions(+), 15 deletions(-)
>>
>> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c =A0 =A0=20
>2010-08-06 09:23:01.153862710 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c =A02010-08-06=20
>10:44:06.393863125 -0400
>> @@ -39,6 +39,7 @@
>> =A0#include <plat/gpmc.h>
>> =A0#include <plat/dma.h>
>> =A0#include <plat/dmtimer.h>
>> +#include <plat/usb.h>
>>
>> =A0#include <asm/tlbflush.h>
>>
>> @@ -416,6 +417,8 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (core_next_state =3D=3D PWRDM_POWE=
R_OFF) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_core_save_conte=
xt();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_prcm_save_conte=
xt();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Save MUSB context *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_context_save_rest=
ore(1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>> @@ -458,6 +461,8 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_prcm_restore_co=
ntext();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_sram_restore_co=
ntext();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_sms_restore_con=
text();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* restore MUSB contex=
t */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_context_save_rest=
ore(0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_resume_idle(0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_resume_idle(1);
>> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c =A0=20
>2010-08-06 09:24:23.690112596 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c =A0 =A0 =A0 =A0
>2010-08-06 10:44:06.385862697 -0400
>> @@ -120,6 +120,27 @@
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> +void musb_context_save_restore(int save)
>> +{
>> + =A0 =A0 =A0 struct omap_hwmod *oh =3D omap_hwmod_lookup("usb_otg_h=
s");
>> + =A0 =A0 =A0 struct omap_device *od =3D oh->od;
>> + =A0 =A0 =A0 struct platform_device *pdev =3D &od->pdev;
>> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
>> +
>> + =A0 =A0 =A0 if (drv) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct musb_hdrc_platform_data *pdata =
=3D=20
>dev->platform_data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct dev_pm_ops *pm =3D drv->p=
m;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pdata->is_usb_active(dev)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (save)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm->su=
spend(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm->re=
sume_noirq(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +}
>> +
>> =A0#else
>> =A0void __init usb_musb_init(struct omap_musb_board_data *board_data=
)
>> =A0{
>> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h=20
>=A0 =A02010-08-06 09:23:01.137862514 -0400
>> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h=20
>2010-08-06 10:44:06.381864367 -0400
>> @@ -79,6 +79,8 @@
>>
>> =A0extern void usb_ohci_init(const struct=20
>ohci_hcd_omap_platform_data *pdata);
>>
>> +/* For saving and restoring the musb context during off/wakeup*/
>> +extern void musb_context_save_restore(int save);
>> =A0#endif
>>
>>
>> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c =A0 =A0=20
>2010-08-06 09:24:21.069863329 -0400
>> +++ linux-omap-pm/drivers/usb/musb/musb_core.c =A02010-08-06=20
>10:44:06.369863527 -0400
>> @@ -2427,11 +2427,6 @@
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0musb_save_context(musb);
>> -
>> - =A0 =A0 =A0 if (musb->set_clock)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->set_clock(musb->clock, 0);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(musb->clock);
>> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&musb->lock, flags);
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> @@ -2443,12 +2438,6 @@
>>
>> =A0 =A0 =A0 =A0if (!musb->clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
>Is this check can be deleted also ?
>Because our blackfin platform have no clock support now.

I think this can be removed.=20

>Thanks.
>
>> -
>> - =A0 =A0 =A0 if (musb->set_clock)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->set_clock(musb->clock, 1);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(musb->clock);
>> -
>> =A0 =A0 =A0 =A0musb_restore_context(musb);
>>
>> =A0 =A0 =A0 =A0/* for static cmos like DaVinci, register values were=
=20
>preserved
>> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c =A0 =A0 =A0
>2010-08-06 09:24:21.069863329 -0400
>> +++ linux-omap-pm/drivers/usb/musb/omap2430.c =A0 2010-08-06=20
>10:44:30.093914217 -0400
>> @@ -189,6 +189,19 @@
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +int is_musb_active(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct musb *musb;
>> +
>> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
>> + =A0 =A0 =A0 /* usbcore insists dev->driver_data is a "struct hcd *=
" */
>> + =A0 =A0 =A0 musb =3D hcd_to_musb(dev_get_drvdata(dev));
>> +#else
>> + =A0 =A0 =A0 musb =3D dev_get_drvdata(dev);
>> +#endif
>> + =A0 =A0 =A0 return musb->is_active;
>> +}
>> +
>> =A0int __init musb_platform_init(struct musb *musb)
>> =A0{
>> =A0 =A0 =A0 =A0u32 l;
>> @@ -250,6 +263,7 @@
>> =A0 =A0 =A0 =A0if (is_host_enabled(musb))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0musb->board_set_vbus =3D omap_set_vbu=
s;
>>
>> + =A0 =A0 =A0 plat->is_usb_active =3D is_musb_active;
>> =A0 =A0 =A0 =A0setup_timer(&musb_idle_timer, musb_do_idle, (unsigned=
=20
>long) musb);
>>
>> =A0 =A0 =A0 =A0return 0;
>> @@ -259,15 +273,42 @@
>> =A0void musb_platform_save_context(struct musb *musb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct musb_context_registers *musb_c=
ontext)
>> =A0{
>> - =A0 =A0 =A0 musb_context->otg_sysconfig =3D=20
>musb_readl(musb->mregs, OTG_SYSCONFIG);
>> - =A0 =A0 =A0 musb_context->otg_forcestandby =3D=20
>musb_readl(musb->mregs, OTG_FORCESTDBY);
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* As per the omap-usbotg specification, configure=20
>it to forced standby
>> + =A0 =A0 =A0 =A0* and =A0force idle mode when no activity on usb.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 void __iomem *musb_base =3D musb->mregs;
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OTG_SY=
SCONFIG) & ~(NOSTDBY |=20
>SMARTSTDBY));
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OTG_SYSCONFIG) &=20
>~(AUTOIDLE));
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OTG_SY=
SCONFIG) & ~(NOIDLE |=20
>SMARTIDLE));
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_FORCESTDBY, 1);
>> =A0}
>>
>> =A0void musb_platform_restore_context(struct musb *musb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct musb_context_registers *musb_c=
ontext)
>> =A0{
>> - =A0 =A0 =A0 musb_writel(musb->mregs, OTG_SYSCONFIG,=20
>musb_context->otg_sysconfig);
>> - =A0 =A0 =A0 musb_writel(musb->mregs, OTG_FORCESTDBY,=20
>musb_context->otg_forcestandby);
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* As per the omap-usbotg specification, configure=20
>it smart standby
>> + =A0 =A0 =A0 =A0* and smart idle during operation.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 void __iomem *musb_base =3D musb->mregs;
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OTG_SY=
SCONFIG) | (SMARTSTDBY));
>> +
>> + =A0 =A0 =A0 musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OTG_SY=
SCONFIG) | (SMARTIDLE));
>> =A0}
>> =A0#endif
>>
>> Index: linux-omap-pm/include/linux/usb/musb.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-pm.orig/include/linux/usb/musb.h 2010-08-06=20
>09:23:01.161864151 -0400
>> +++ linux-omap-pm/include/linux/usb/musb.h =A0 =A0 =A02010-08-06=20
>10:44:06.401862567 -0400
>> @@ -126,6 +126,9 @@
>>
>> =A0 =A0 =A0 =A0/* Architecture specific board data =A0 =A0 */
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*board_data;
>> +
>> + =A0 =A0 =A0 /* check usb device active state*/
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*is_usb_active)(struct de=
vice *dev);
>> =A0};
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>--=20
>Regards,
>--Bob
>--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
