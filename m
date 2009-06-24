From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 08:32:13 -0700
Message-ID: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:58892 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760576AbZFXPcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 11:32:15 -0400
Received: by pxi28 with SMTP id 28so438820pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 08:32:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Rather than simply setting force-idle mode on boot, do a reset of the
OTG module.  This really ensures that any bootloader/bootstrap code
that leaves it active will not prevent future retention.  After reset,
OTG module will be in force-idle, force-standby mode.

In addition, ensure that the iclk is enabled before attempting a write
to the module SYSCONFIG register.

Problem reported by Mike Chan <mikechan@google.com>

Tested-by: Mike Chan <mikechan@google.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Updates from v1
- use ioremap()+__raw_write instead of deprecated omap_write()
- Re: defines in omap2430.h, this header is not exported outside
  drivers/usb, so define it locally yere

 arch/arm/mach-omap2/usb-musb.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d85296d..31adbe6 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -26,18 +26,41 @@
 
 #include <linux/usb/musb.h>
 
+#include <asm/sizes.h>
+
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
 
-#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+#define OTG_SYSCONFIG	   0x404
+#define OTG_SYSC_SOFTRESET BIT(1)
 
 static void __init usb_musb_pm_init(void)
 {
-	/* Ensure force-idle mode for OTG controller */
-	if (cpu_is_omap34xx())
-		omap_writel(0, OTG_SYSCONFIG);
+	struct clk *iclk;
+	void __iomem *otg_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
+	if (WARN_ON(!otg_base))
+		return;
+
+	iclk = clk_get(NULL, "hsotgusb_ick");
+	if (WARN_ON(!iclk))
+		return;
+
+	clk_enable(iclk);
+
+	/* Reset OTG controller.  After reset, it will be in
+	 * force-idle, force-standby mode. */
+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
+
+	clk_disable(iclk);
+	clk_put(iclk);
+	iounmap(otg_base);
 }
 
 #ifdef CONFIG_USB_MUSB_SOC
-- 
1.6.3.2

