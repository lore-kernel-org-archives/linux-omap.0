From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 11:04:09 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DF0F@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
	<20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37189 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab0IXFeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 01:34:18 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,
 
>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org 
>[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Kalliguddi, Hema
>Sent: Thursday, September 23, 2010 9:10 PM
>To: Kevin Hilman; Balbi, Felipe
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Basak, Partha; Tony Lindgren; Cousson, Benoit; Paul Walmsley
>Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
> 
>
>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>Sent: Thursday, September 23, 2010 9:00 PM
>>To: Balbi, Felipe
>>Cc: Kalliguddi, Hema; linux-omap@vger.kernel.org; 
>>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; 
>>Cousson, Benoit; Paul Walmsley
>>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis 
>for musb.
>>
>>Felipe Balbi <balbi@ti.com> writes:
>>
>>> Hi,
>>>
>>> On Wed, Sep 22, 2010 at 07:30:30PM -0500, Kalliguddi, Hema wrote:
>>>>Calling runtime pm APIs pm_runtime_put_sync() and 
>>pm_runtime_get_sync()
>>>>for enabling/disabling the clocks,sysconfig settings.
>>>>
>>>>Also need to put the USB in force standby and force idle 
>>mode when usb not used
>>>>and set it back to no idle and no stndby after wakeup.
>>>>For OMAP3 auto idle bit has to be disabled because of the 
>>errata.So using
>>>>HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>>
>>[...]
>>
>>>>@@ -2424,13 +2425,16 @@ static int musb_suspend(struct device *d
>>>> 		 * they will even be wakeup-enabled.
>>>> 		 */
>>>> 	}
>>>>+	pm_runtime_put_sync(dev);
>>>>
>>>>+#ifndef CONFIG_PM_RUNTIME
>>>> 	musb_save_context(musb);
>>>>
>>>> 	if (musb->set_clock)
>>>> 		musb->set_clock(musb->clock, 0);
>>>> 	else
>>>> 		clk_disable(musb->clock);
>>>>+#endif
>>>
>>> I would rather remove these, adding ifdefs is bad :-( Unless 
>>other archs
>>> (blackfin, davinci) would have problems if we remove those.
>>
>>I didn't like these #ifdefs either, but davinci doesn't have 
>>runtime PM,
>>and I don't think blackfin does either.
>>
>>But, rather than the ifdef here, this could be done with different
>>pointers in struct dev_pm_ops based on the arch.
>>
>>Also, this shouldn't be based on CONFIG_PM_RUNTIME, but rather on the
>>arch.  We can still enable runtime PM on davinci for other subsystems
>>(PCI, USB core, etc.) but not have it supported for on-chip devices.
>>
>Is it a good idea to use the musb->set_clock function pointer 
>for OMAP architure and
>call the runtime pm apis from this function defined in the usb 
>platform driver(omap2430)
>
>>Kevin

Here is the patch which is making use of already existing platform set_clock functions pointer.
With this we don't need to use #ifdefs.
If it looks good I will post it again along with series.

 arch/arm/mach-omap2/usb-musb.c |   18 +++++++++++++++++
 drivers/usb/musb/musb_core.c   |   12 +++++++++++
 drivers/usb/musb/omap2430.c    |   43 ++++++++++++++---------------------------
 3 files changed, 45 insertions(+), 28 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 
 #include <linux/usb/musb.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/sizes.h>
 
@@ -46,6 +47,7 @@ static struct platform_device dummy_pdev
 
 static void __iomem *otg_base;
 static struct clk *otg_clk;
+static struct omap_hwmod *oh_p;
 
 static void __init usb_musb_pm_init(void)
 {
@@ -129,6 +131,20 @@ static struct omap_device_pm_latency oma
 	},
 };
 
+void omap_set_clock(struct clk *clock , int is_on)
+{
+
+	struct omap_hwmod *oh = oh_p;
+	struct omap_device *od = oh->od;
+	struct platform_device *pdev = &od->pdev;
+	struct device *dev = &pdev->dev;
+
+	if(is_on)
+		pm_runtime_get_sync(dev);
+	else
+		pm_runtime_put_sync(dev);
+}
+
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	struct omap_hwmod *oh;
@@ -154,8 +170,10 @@ void __init usb_musb_init(struct omap_mu
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
+	musb_plat.set_clock = omap_set_clock;
 
 	pdata = &musb_plat;
+	oh_p = oh;
 
 	od = omap_device_build(name, bus_id, oh, pdata,
 			       sizeof(*pdata), omap_musb_latency,
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
+++ linux-omap-pm/drivers/usb/musb/musb_core.c
@@ -98,6 +98,7 @@
 #include <linux/kobject.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 
 #ifdef	CONFIG_ARM
 #include <mach/hardware.h>
@@ -2457,9 +2458,20 @@ static int musb_resume_noirq(struct devi
 	return 0;
 }
 
+static int musb_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int musb_runtime_resume(struct device *dev)
+{
+	return 0;
+}
 static const struct dev_pm_ops musb_dev_pm_ops = {
 	.suspend	= musb_suspend,
 	.resume_noirq	= musb_resume_noirq,
+	.runtime_suspend = musb_runtime_suspend,
+	.runtime_resume	 = musb_runtime_resume,
 };
 
 #define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
Index: linux-omap-pm/drivers/usb/musb/omap2430.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
+++ linux-omap-pm/drivers/usb/musb/omap2430.c
@@ -31,6 +31,8 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -206,21 +208,6 @@ int __init musb_platform_init(struct mus
 
 	musb_platform_resume(musb);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	l &= ~NOSTDBY;		/* remove possible nostdby */
-	l |= SMARTSTDBY;	/* enable smart standby */
-	l &= ~AUTOIDLE;		/* disable auto idle */
-	l &= ~NOIDLE;		/* remove possible noidle */
-	l |= SMARTIDLE;		/* enable smart idle */
-	/*
-	 * MUSB AUTOIDLE don't work in 3430.
-	 * Workaround by Richard Woodruff/TI
-	 */
-	if (!cpu_is_omap3430())
-		l |= AUTOIDLE;		/* enable auto idle */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -253,15 +240,21 @@ int __init musb_platform_init(struct mus
 void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
+	/*
+	 * As per the omap-usbotg specification, configure it to forced standby
+	 * and  force idle mode when no activity on usb.
+	 */
+	musb_writel(musb->mregs, OTG_FORCESTDBY, ENABLEFORCE);
 }
 
 void musb_platform_restore_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
-	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
+	/*
+	 * As per the omap-usbotg specification, configure it smart standby
+	 * and smart idle during operation.
+	 */
+	musb_writel(musb->mregs, OTG_FORCESTDBY, 0);
 }
 #endif
 
@@ -277,10 +270,6 @@ static int musb_platform_suspend(struct 
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l |= ENABLEWAKEUP;	/* enable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	otg_set_suspend(musb->xceiv, 1);
 
 	if (musb->set_clock)
@@ -294,23 +283,21 @@ static int musb_platform_suspend(struct 
 static int musb_platform_resume(struct musb *musb)
 {
 	u32 l;
+	struct device *dev = musb->controller;
 
 	if (!musb->clock)
 		return 0;
 
 	otg_set_suspend(musb->xceiv, 0);
 
+	pm_runtime_enable(dev);
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
 	else
 		clk_enable(musb->clock);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
-	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
+	l |= ENABLEFORCE;	/* enable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 
 	return 0;




>>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>