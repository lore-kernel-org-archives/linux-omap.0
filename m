From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 22:32:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>
References: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbZFXRCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 13:02:41 -0400
In-Reply-To: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>Hilman
>Sent: Wednesday, June 24, 2009 10:32 AM
>To: linux-omap@vger.kernel.org
>Subject: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
>
>Rather than simply setting force-idle mode on boot, do a reset of the
>OTG module.  This really ensures that any bootloader/bootstrap code
>that leaves it active will not prevent future retention.  After reset,
>OTG module will be in force-idle, force-standby mode.
>
>In addition, ensure that the iclk is enabled before attempting a write
>to the module SYSCONFIG register.

This patch solves MUSB issue, but is not generic for all IP blocks on omap.

ROM code or u-boot could leave the module sysconfig in a non-idle state.

I recommend just like CONFIG_OMAP_RESET_CLOCKS for clocks, same could be done generically for all SYSCONFIG registers in some prcm code and not driver specific.

>
>Problem reported by Mike Chan <mikechan@google.com>
>
>Tested-by: Mike Chan <mikechan@google.com>
>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>---
>Updates from v1
>- use ioremap()+__raw_write instead of deprecated omap_write()
>- Re: defines in omap2430.h, this header is not exported outside
>  drivers/usb, so define it locally yere
>
> arch/arm/mach-omap2/usb-musb.c |   31 +++++++++++++++++++++++++++----
> 1 files changed, 27 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
>index d85296d..31adbe6 100644
>--- a/arch/arm/mach-omap2/usb-musb.c
>+++ b/arch/arm/mach-omap2/usb-musb.c
>@@ -26,18 +26,41 @@
>
> #include <linux/usb/musb.h>
>
>+#include <asm/sizes.h>
>+
> #include <mach/hardware.h>
> #include <mach/irqs.h>
> #include <mach/mux.h>
> #include <mach/usb.h>
>
>-#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
>+#define OTG_SYSCONFIG	   0x404
>+#define OTG_SYSC_SOFTRESET BIT(1)

This is already defined in drivers/usb/musb/omap2430.h
Could we reuse? 

#if     defined(CONFIG_ARCH_OMAP2430)
#define OMAP_HSOTG_BASE         (OMAP243X_HS_BASE)
#elif   defined(CONFIG_ARCH_OMAP3430)
#define OMAP_HSOTG_BASE         (OMAP34XX_HSUSB_OTG_BASE)
#endif
#define OMAP_HSOTG(offset)      (OMAP_HSOTG_BASE + 0x400 + (offset))
#define OTG_REVISION            OMAP_HSOTG(0x0)
#define OTG_SYSCONFIG           OMAP_HSOTG(0x4)


>
> static void __init usb_musb_pm_init(void)
> {
>-	/* Ensure force-idle mode for OTG controller */
>-	if (cpu_is_omap34xx())
>-		omap_writel(0, OTG_SYSCONFIG);
>+	struct clk *iclk;
>+	void __iomem *otg_base;
>+
>+	if (!cpu_is_omap34xx())
>+		return;

Why is this sys-config reset done only for omap34xx()
This should be valid for any old 24xx() as well as new 44xx() omaps

>+
>+	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
>+	if (WARN_ON(!otg_base))
>+		return;
>+
>+	iclk = clk_get(NULL, "hsotgusb_ick");
>+	if (WARN_ON(!iclk))
>+		return;
>+
>+	clk_enable(iclk);
>+
>+	/* Reset OTG controller.  After reset, it will be in
>+	 * force-idle, force-standby mode. */
>+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
>+
>+	clk_disable(iclk);
>+	clk_put(iclk);
>+	iounmap(otg_base);
> }
>
> #ifdef CONFIG_USB_MUSB_SOC
>--
>1.6.3.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

