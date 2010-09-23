From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 13:29:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9EB@dbde02.ent.ti.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
 <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab0IWH7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 03:59:36 -0400
In-Reply-To: <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

 Hi,

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Thursday, September 23, 2010 12:19 PM
>To: Kalliguddi, Hema
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Mankad, Maulik Ojas; Balbi, Felipe; Tony Lindgren; Kevin 
>Hilman; Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
>
>Hi,
>
>On Wed, Sep 22, 2010 at 07:30:46PM -0500, Kalliguddi, Hema wrote:
>>With OMAP core-off support musb was not functional as context 
>was getting
>>lost after wakeup from core-off. And also musb was blocking 
>the core-off
>>after loading the gadget driver even with no cable connected 
>sometimes.
>>
>>Added the idle and wakeup APIs in the platform layer which will
>>be called in the idle and wakeup path.
>>
>>Used the pm_runtime_put_sysc API to configure the
>
>pm_runtime_put_sync(), typo.
>
>>musb to force idle/standby modes, saving the context and 
>disable the clk in
>>while idling if there is no activity on the usb bus.
>
>this part is a bit fuzzy, care to re-phrase ?
>
Ok. I will re-phrase it. 

>>Used the pm_runtime_get_sync API to configure the musb to
>>no idle/standby modes, enable the clock and restore the context
>>after wakeup when there is no activity on the usb bus.
>>
>>Signed-off-by: Hema HK <hemahk@ti.com>
>>Signed-off-by: Maulik Mankad <x0082077@ti.com>
>>Cc: Felipe Balbi <balbi@ti.com>
>>Cc: Tony Lindgren <tony@atomide.com>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Cousson, Benoit <b-cousson@ti.com>
>>Cc: Paul Walmsley <paul@pwsan.com>
>>
>>---
>> arch/arm/mach-omap2/cpuidle34xx.c     |    1
>> arch/arm/mach-omap2/pm34xx.c          |    3
>> arch/arm/mach-omap2/usb-musb.c        |  107 
>++++++++++++++++++++++++++++++++++
>> arch/arm/plat-omap/include/plat/usb.h |    2
>> drivers/usb/musb/musb_core.c          |   15 ++++
>> drivers/usb/musb/omap2430.c           |   14 ++++
>> include/linux/usb/musb.h              |    9 ++
>> 7 files changed, 149 insertions(+), 2 deletions(-)
>>
>>Index: linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>>===================================================================
>>--- linux-omap-pm.orig/arch/arm/mach-omap2/cpuidle34xx.c
>>+++ linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>>@@ -31,6 +31,7 @@
>> #include <plat/clockdomain.h>
>> #include <plat/control.h>
>> #include <plat/serial.h>
>>+#include <plat/usb.h>
>>
>> #include "pm.h"
>>
>>Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>>===================================================================
>>--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
>>+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>>@@ -38,6 +38,7 @@
>> #include <plat/prcm.h>
>> #include <plat/gpmc.h>
>> #include <plat/dma.h>
>>+#include <plat/usb.h>
>>
>> #include <asm/tlbflush.h>
>>
>>@@ -324,11 +325,13 @@ static void restore_table_entry(void)
>> void omap3_device_idle(void)
>> {
>> 	omap2_gpio_prepare_for_idle();
>>+	musb_prepare_for_idle();
>> }
>>
>> void omap3_device_resume(void)
>> {
>> 	omap2_gpio_resume_after_idle();
>>+	musb_wakeup_from_idle();
>> }
>>
>> void omap_sram_idle(void)
>>Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>>===================================================================
>>--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>>+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>>@@ -25,16 +25,21 @@
>> #include <linux/io.h>
>>
>> #include <linux/usb/musb.h>
>>+#include <linux/pm_runtime.h>
>>
>> #include <mach/hardware.h>
>> #include <mach/irqs.h>
>> #include <plat/usb.h>
>> #include <plat/omap_device.h>
>>+#include <plat/powerdomain.h>
>>
>> #ifdef CONFIG_USB_MUSB_SOC
>> static const char name[] = "musb_hdrc";
>> #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
>>
>>+struct omap_hwmod *oh_p;
>>+static struct powerdomain *core_pwrdm;
>>+
>> static struct musb_hdrc_config musb_config = {
>> 	.multipoint	= 1,
>> 	.dyn_fifo	= 1,
>>@@ -58,6 +63,10 @@ static struct musb_hdrc_platform_data mu
>> 	 * "mode", and should be passed to usb_musb_init().
>> 	 */
>> 	.power		= 50,			/* up to 100 mA */
>>+
>>+	/* OMAP supports offmode */
>>+	.save_context	= 1,
>>+	.restore_context	= 1,
>> };
>>
>> static u64 musb_dmamask = DMA_BIT_MASK(32);
>>@@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
>> 	const char *oh_name = "usb_otg_hs";
>> 	struct musb_hdrc_platform_data *pdata;
>>
>>+	core_pwrdm = pwrdm_lookup("per_pwrdm");
>
>per or core ???
>
Oh! It should be core. Now I understand why save/restore counts were not matching with
Core-off counts.
Thanks for pointing this out.

>>@@ -97,6 +107,7 @@ void __init usb_musb_init(struct omap_mu
>> 	musb_plat.extvbus = board_data->extvbus;
>>
>> 	pdata = &musb_plat;
>>+	oh_p = oh;
>>
>> 	od = omap_device_build(name, bus_id, oh, pdata,
>> 			       sizeof(struct musb_hdrc_platform_data),
>>@@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
>> 	put_device(dev);
>> }
>>
>>+void musb_prepare_for_idle()
>>+{
>>+	int core_next_state;
>>+	struct omap_hwmod *oh = oh_p;
>>+	struct omap_device *od;
>>+	struct platform_device *pdev;
>>+	struct musb_hdrc_platform_data *pdata;
>>+	struct device *dev;
>>+
>>+	if (!core_pwrdm)
>>+		return;
>>+
>>+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>+	if (core_next_state >= PWRDM_POWER_INACTIVE)
>>+		return;
>>+	if (!oh)
>>+		return;
>>+
>>+	od = oh->od;
>>+	pdev = &od->pdev;
>>+
>>+	if (!pdev)
>>+		return;
>>+	dev = &pdev->dev;
>>+
>>+	if (dev->driver) {
>>+		pdata = dev->platform_data;
>>+
>>+	if (pdata->is_usb_active)
>
>indentation is wrong. And you can save some of it:

Maulik is pointed this out and I will fixing it.
>
>	if (!dev->driver)
>		return;
>	
>	pdata = dev->platform_data;
>
>	if (!pdata->is_usb_active)
>		return;
>	
>	if (!pdata->is_usb_active(dev)) {
>		switch (core_next_state) {
>		case PWRDM_POWER_OFF:
>			pdata->save_context = 1;
>			pm_runtime_put_sync(dev);
>			break;
>		case PWRDM_POWER_RET:
>			pdata->save_context = 0;
>			pm_runtime_put_sync(dev);
>			break;
>		default:
>			pr_debug("what ??\n");
>		}
>	}
>
>>Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>>===================================================================
>>--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
>>+++ linux-omap-pm/drivers/usb/musb/musb_core.c
>>@@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *d
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	unsigned long	flags;
>> 	struct musb	*musb = dev_to_musb(&pdev->dev);
>>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>>
>> 	if (!musb->clock)
>> 		return 0;
>>@@ -2425,6 +2426,9 @@ static int musb_suspend(struct device *d
>> 		 * they will even be wakeup-enabled.
>> 		 */
>> 	}
>>+
>>+	if (plat->save_context)
>>+		plat->save_context = 1;
>
>what ??
>
>if plat->save_context is 1, then set it to 1 ???
>
This is mistake. I messed it up. I had another flag
for offmode support, which I removed later.
i will correct this.

>>@@ -2443,10 +2447,13 @@ static int musb_resume_noirq(struct devi
>> {
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	struct musb	*musb = dev_to_musb(&pdev->dev);
>
>just now I notice these, hah, funny :-p pdev isn't even 
>needed. Has been
>there for quite a while I believe.
>
>Commit 48fea965 should have changed that line, but that's ok, we will
>clean it later.
>
Yehh :-)
If it is OK, I can clean it up with this patch only.

>>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>>
>> 	if (!musb->clock)
>> 		return 0;
>>
>>+	if (plat->restore_context)
>>+		plat->restore_context = 1;
>
>also here?? there's something wrong.
>
Yes...

>>@@ -2468,16 +2475,20 @@ static int musb_resume_noirq(struct devi
>> static int musb_runtime_suspend(struct device *dev)
>> {
>> 	struct musb	*musb = dev_to_musb(dev);
>>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>>
>>-	musb_save_context(musb);
>>+	if (plat->save_context)
>>+		musb_save_context(musb);
>
>this looks better.
>
>>@@ -126,6 +128,17 @@ struct musb_hdrc_platform_data {
>>
>> 	/* Architecture specific board data	*/
>> 	void		*board_data;
>>+
>>+	/* check usb device active state*/
>>+	int		(*is_usb_active)(struct device *dev);
>
>where is it used ??
>
This you got it already.
>-- 
>balbi
>