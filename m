From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: reset USB OTG module on boot
Date: Tue, 23 Jun 2009 17:27:17 -0700
Message-ID: <1245803237-30891-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:45656 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZFXA1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 20:27:17 -0400
Received: by pzk27 with SMTP id 27so300517pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 17:27:19 -0700 (PDT)
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
If no comments/issues, this will be applied to PM branch and
backported to pm-2.6.29.

 arch/arm/mach-omap2/usb-musb.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d85296d..85731b8 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -32,12 +32,27 @@
 #include <mach/usb.h>
 
 #define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+#define OTG_SYSC_SOFTRESET BIT(1)
 
 static void __init usb_musb_pm_init(void)
 {
-	/* Ensure force-idle mode for OTG controller */
-	if (cpu_is_omap34xx())
-		omap_writel(0, OTG_SYSCONFIG);
+	struct clk *iclk;
+
+	if (!cpu_is_omap34xx())
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
+	omap_writel(OTG_SYSC_SOFTRESET, OTG_SYSCONFIG);
+
+	clk_disable(iclk);
+	clk_put(iclk);
 }
 
 #ifdef CONFIG_USB_MUSB_SOC
-- 
1.6.3.2

