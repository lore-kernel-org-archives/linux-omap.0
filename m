From: felipe.balbi@nokia.com
Subject: [PATCH 2/3] arm: omap: let pm code always handle musb pm init
Date: Wed, 19 May 2010 12:40:17 +0300
Message-ID: <1274262018-32631-2-git-send-email-felipe.balbi@nokia.com>
References: <1274262018-32631-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42377 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0ESJm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:42:58 -0400
In-Reply-To: <1274262018-32631-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

musb pm has special needs on omap3430, let pm init
code handle usb_musb_pm_init() so we can always
release all resources after initializing PM.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c          |    9 +++------
 arch/arm/mach-omap2/usb-musb.c        |   29 +++++++++--------------------
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 48857a4..cec9d8b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -516,12 +516,6 @@ void omap_sram_idle(void)
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
-			/*
-			 * Errata 1.164 fix : OTG autoidle can prevent
-			 * sleep
-			 */
-			if (cpu_is_omap3430())
-				usb_musb_disable_autoidle();
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
@@ -1242,6 +1236,9 @@ static int __init omap3_pm_init(void)
 	pm_dbg_regset_init(2);
 
 	omap3_save_scratchpad_contents();
+
+	/* Errata 1.164 fix : OTG autoidle can prevent sleep */
+	usb_musb_pm_init();
 err1:
 	return ret;
 err2:
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 085e22e..de3e768 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -44,12 +44,12 @@ static struct platform_device dummy_pdev = {
 	},
 };
 
-static void __iomem *otg_base;
-static struct clk *otg_clk;
-
-static void __init usb_musb_pm_init(void)
+void __init usb_musb_pm_init(void)
 {
-	struct device *dev = &dummy_pdev.dev;
+	struct device		*dev = &dummy_pdev.dev;
+	void __iomem		*otg_base;
+	struct clk		*otg_clk;
+	unsigned long		r;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -81,6 +81,10 @@ static void __init usb_musb_pm_init(void)
 				__raw_readl(otg_base + OTG_SYSSTATUS)))
 		cpu_relax();
 
+	r = __raw_readl(otg_base + OTG_SYSCONFIG);
+	r &= ~(1 << 0);
+	__raw_writel(r, otg_base + OTG_SYSCONFIG);
+
 	clk_disable(otg_clk);
 
 out1:
@@ -90,18 +94,6 @@ out0:
 	iounmap(otg_base);
 }
 
-void usb_musb_disable_autoidle(void)
-{
-	if (otg_clk) {
-		unsigned long reg;
-
-		clk_enable(otg_clk);
-		reg = __raw_readl(otg_base + OTG_SYSCONFIG);
-		__raw_writel(reg & ~1, otg_base + OTG_SYSCONFIG);
-		clk_disable(otg_clk);
-	}
-}
-
 #ifdef CONFIG_USB_MUSB_SOC
 
 static struct resource musb_resources[] = {
@@ -181,13 +173,10 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 
 	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-
-	usb_musb_pm_init();
 }
 
 #else
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	usb_musb_pm_init();
 }
 #endif /* CONFIG_USB_MUSB_SOC */
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index ec7c025..cae3508 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -56,7 +56,7 @@ extern void usb_musb_init(struct omap_musb_board_data *board_data);
 extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
 
 /* This is needed for OMAP3 errata 1.164: enabled autoidle can prevent sleep */
-extern void usb_musb_disable_autoidle(void);
+extern void usb_musb_pm_init(void);
 
 #endif
 
-- 
1.7.1

