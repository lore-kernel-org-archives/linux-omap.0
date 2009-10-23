From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 11/11] OMAP3: PM: Disable OTG autoidle when waking up from off-mode
Date: Fri, 23 Oct 2009 19:03:55 +0300
Message-ID: <1256313835-2391-12-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-10-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-11-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19360 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZJWQSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:40 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIgTe028139
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 11:18:45 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPiF022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:37 +0300
In-Reply-To: <1256313835-2391-11-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
This patch force disables autoidle during wakeup from off-mode. See omap
errata 1.164.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c          |    6 ++++++
 arch/arm/mach-omap2/usb-musb.c        |   14 ++++++++------
 arch/arm/plat-omap/include/mach/usb.h |    3 +++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5eb7321..070a0a2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -39,6 +39,7 @@
 #include <mach/gpmc.h>
 #include <mach/dma.h>
 #include <mach/dmtimer.h>
+#include <mach/usb.h>
 
 #include <asm/tlbflush.h>
 
@@ -496,6 +497,11 @@ void omap_sram_idle(void)
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
+			/*
+			 * Errata 1.164 fix : OTG autoidle can prevent
+			 * sleep
+			 */
+			usb_musb_disable_autoidle();
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 8dde0b7..f4b86c0 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -44,10 +44,11 @@ static struct platform_device dummy_pdev = {
 	},
 };
 
+static void __iomem *otg_base;
+static struct clk *otg_clk;
+
 static void __init usb_musb_pm_init(void)
 {
-	void __iomem *otg_base;
-	struct clk *otg_clk;
 	struct device *dev = &dummy_pdev.dev;
 
 	if (!cpu_is_omap34xx())
@@ -74,12 +75,13 @@ static void __init usb_musb_pm_init(void)
 			cpu_relax();
 	}
 
-	if (otg_clk) {
+	if (otg_clk)
 		clk_disable(otg_clk);
-		clk_put(otg_clk);
-	}
+}
 
-	iounmap(otg_base);
+void usb_musb_disable_autoidle(void)
+{
+	__raw_writel(0, otg_base + OTG_SYSCONFIG);
 }
 
 #ifdef CONFIG_USB_MUSB_SOC
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index a4068a4..310ee17 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -46,6 +46,9 @@ extern void usb_musb_init(void);
 
 extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
 
+/* This is needed for OMAP3 errata 1.164: enabled autoidle can prevent sleep */
+extern void usb_musb_disable_autoidle(void);
+
 #endif
 
 void omap_usb_init(struct omap_usb_config *pdata);
-- 
1.5.4.3

