From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 09:49:10 +0300
Message-ID: <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285201846-26599-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 22, 2010 at 07:30:46PM -0500, Kalliguddi, Hema wrote:
>With OMAP core-off support musb was not functional as context was getting
>lost after wakeup from core-off. And also musb was blocking the core-off
>after loading the gadget driver even with no cable connected sometimes.
>
>Added the idle and wakeup APIs in the platform layer which will
>be called in the idle and wakeup path.
>
>Used the pm_runtime_put_sysc API to configure the

pm_runtime_put_sync(), typo.

>musb to force idle/standby modes, saving the context and disable the clk in
>while idling if there is no activity on the usb bus.

this part is a bit fuzzy, care to re-phrase ?

>Used the pm_runtime_get_sync API to configure the musb to
>no idle/standby modes, enable the clock and restore the context
>after wakeup when there is no activity on the usb bus.
>
>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
>---
> arch/arm/mach-omap2/cpuidle34xx.c     |    1
> arch/arm/mach-omap2/pm34xx.c          |    3
> arch/arm/mach-omap2/usb-musb.c        |  107 ++++++++++++++++++++++++++++++++++
> arch/arm/plat-omap/include/plat/usb.h |    2
> drivers/usb/musb/musb_core.c          |   15 ++++
> drivers/usb/musb/omap2430.c           |   14 ++++
> include/linux/usb/musb.h              |    9 ++
> 7 files changed, 149 insertions(+), 2 deletions(-)
>
>Index: linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-omap2/cpuidle34xx.c
>+++ linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>@@ -31,6 +31,7 @@
> #include <plat/clockdomain.h>
> #include <plat/control.h>
> #include <plat/serial.h>
>+#include <plat/usb.h>
>
> #include "pm.h"
>
>Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
>+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>@@ -38,6 +38,7 @@
> #include <plat/prcm.h>
> #include <plat/gpmc.h>
> #include <plat/dma.h>
>+#include <plat/usb.h>
>
> #include <asm/tlbflush.h>
>
>@@ -324,11 +325,13 @@ static void restore_table_entry(void)
> void omap3_device_idle(void)
> {
> 	omap2_gpio_prepare_for_idle();
>+	musb_prepare_for_idle();
> }
>
> void omap3_device_resume(void)
> {
> 	omap2_gpio_resume_after_idle();
>+	musb_wakeup_from_idle();
> }
>
> void omap_sram_idle(void)
>Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>@@ -25,16 +25,21 @@
> #include <linux/io.h>
>
> #include <linux/usb/musb.h>
>+#include <linux/pm_runtime.h>
>
> #include <mach/hardware.h>
> #include <mach/irqs.h>
> #include <plat/usb.h>
> #include <plat/omap_device.h>
>+#include <plat/powerdomain.h>
>
> #ifdef CONFIG_USB_MUSB_SOC
> static const char name[] = "musb_hdrc";
> #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
>
>+struct omap_hwmod *oh_p;
>+static struct powerdomain *core_pwrdm;
>+
> static struct musb_hdrc_config musb_config = {
> 	.multipoint	= 1,
> 	.dyn_fifo	= 1,
>@@ -58,6 +63,10 @@ static struct musb_hdrc_platform_data mu
> 	 * "mode", and should be passed to usb_musb_init().
> 	 */
> 	.power		= 50,			/* up to 100 mA */
>+
>+	/* OMAP supports offmode */
>+	.save_context	= 1,
>+	.restore_context	= 1,
> };
>
> static u64 musb_dmamask = DMA_BIT_MASK(32);
>@@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
> 	const char *oh_name = "usb_otg_hs";
> 	struct musb_hdrc_platform_data *pdata;
>
>+	core_pwrdm = pwrdm_lookup("per_pwrdm");

per or core ???

>@@ -97,6 +107,7 @@ void __init usb_musb_init(struct omap_mu
> 	musb_plat.extvbus = board_data->extvbus;
>
> 	pdata = &musb_plat;
>+	oh_p = oh;
>
> 	od = omap_device_build(name, bus_id, oh, pdata,
> 			       sizeof(struct musb_hdrc_platform_data),
>@@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
> 	put_device(dev);
> }
>
>+void musb_prepare_for_idle()
>+{
>+	int core_next_state;
>+	struct omap_hwmod *oh = oh_p;
>+	struct omap_device *od;
>+	struct platform_device *pdev;
>+	struct musb_hdrc_platform_data *pdata;
>+	struct device *dev;
>+
>+	if (!core_pwrdm)
>+		return;
>+
>+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>+	if (core_next_state >= PWRDM_POWER_INACTIVE)
>+		return;
>+	if (!oh)
>+		return;
>+
>+	od = oh->od;
>+	pdev = &od->pdev;
>+
>+	if (!pdev)
>+		return;
>+	dev = &pdev->dev;
>+
>+	if (dev->driver) {
>+		pdata = dev->platform_data;
>+
>+	if (pdata->is_usb_active)

indentation is wrong. And you can save some of it:

	if (!dev->driver)
		return;
	
	pdata = dev->platform_data;

	if (!pdata->is_usb_active)
		return;
	
	if (!pdata->is_usb_active(dev)) {
		switch (core_next_state) {
		case PWRDM_POWER_OFF:
			pdata->save_context = 1;
			pm_runtime_put_sync(dev);
			break;
		case PWRDM_POWER_RET:
			pdata->save_context = 0;
			pm_runtime_put_sync(dev);
			break;
		default:
			pr_debug("what ??\n");
		}
	}

>Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>===================================================================
>--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
>+++ linux-omap-pm/drivers/usb/musb/musb_core.c
>@@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *d
> 	struct platform_device *pdev = to_platform_device(dev);
> 	unsigned long	flags;
> 	struct musb	*musb = dev_to_musb(&pdev->dev);
>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>
> 	if (!musb->clock)
> 		return 0;
>@@ -2425,6 +2426,9 @@ static int musb_suspend(struct device *d
> 		 * they will even be wakeup-enabled.
> 		 */
> 	}
>+
>+	if (plat->save_context)
>+		plat->save_context = 1;

what ??

if plat->save_context is 1, then set it to 1 ???

>@@ -2443,10 +2447,13 @@ static int musb_resume_noirq(struct devi
> {
> 	struct platform_device *pdev = to_platform_device(dev);
> 	struct musb	*musb = dev_to_musb(&pdev->dev);

just now I notice these, hah, funny :-p pdev isn't even needed. Has been
there for quite a while I believe.

Commit 48fea965 should have changed that line, but that's ok, we will
clean it later.

>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>
> 	if (!musb->clock)
> 		return 0;
>
>+	if (plat->restore_context)
>+		plat->restore_context = 1;

also here?? there's something wrong.

>@@ -2468,16 +2475,20 @@ static int musb_resume_noirq(struct devi
> static int musb_runtime_suspend(struct device *dev)
> {
> 	struct musb	*musb = dev_to_musb(dev);
>+	struct musb_hdrc_platform_data *plat = dev->platform_data;
>
>-	musb_save_context(musb);
>+	if (plat->save_context)
>+		musb_save_context(musb);

this looks better.

>@@ -126,6 +128,17 @@ struct musb_hdrc_platform_data {
>
> 	/* Architecture specific board data	*/
> 	void		*board_data;
>+
>+	/* check usb device active state*/
>+	int		(*is_usb_active)(struct device *dev);

where is it used ??

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
