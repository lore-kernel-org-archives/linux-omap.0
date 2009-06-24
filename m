From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v3] OMAP2/3/4: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 11:27:34 -0700
Message-ID: <1245868054-20375-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:56032 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZFXS1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 14:27:33 -0400
Received: by pzk27 with SMTP id 27so812216pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 11:27:36 -0700 (PDT)
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
Updates from v2
- reset for OMAP2 as well (needs update for OMAP4, see FIXME)

 arch/arm/mach-omap2/usb-musb.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d85296d..1ea2ac7 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -26,18 +26,47 @@
 
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
+	u32 phys_base;
+	void __iomem *otg_base;
+
+	if (cpu_is_omap243x())
+		phys_base = OMAP2_OTG_BASE;
+	else if (cpu_is_omap34xx())
+		phys_base = OMAP34XX_HSUSB_OTG_BASE;
+	else
+		/* FIXME: add OMAP4 support */
+		return;
+
+	otg_base = ioremap(phys_base, SZ_4K);
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

