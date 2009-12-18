From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 1/1] OMAP3: PM: Fix OTG autoidle workaround
Date: Fri, 18 Dec 2009 12:39:23 +0200
Message-ID: <1261132763-16697-1-git-send-email-eduardo.valentin@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A71@dbde02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29908 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbZLRKjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 05:39:53 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A71@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kristo Tero <Tero.Kristo@nokia.com>, Balbi Felipe <felipe.balbi@nokia.com>, Gadiyar Anand <gadiyar@ti.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch fix the OTG autoidle workaround so now
usb gadget modules can be properly loaded.

Besides it also adds a cpu check, because this hardware
but is present only in OMAP34xx chips.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c   |    3 ++-
 arch/arm/mach-omap2/usb-musb.c |    9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c301261..db75975 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -505,7 +505,8 @@ void omap_sram_idle(void)
 			 * Errata 1.164 fix : OTG autoidle can prevent
 			 * sleep
 			 */
-			usb_musb_disable_autoidle();
+			if (cpu_is_omap3430())
+				usb_musb_disable_autoidle();
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index bb3cee4..cbd4e45 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -81,7 +81,14 @@ static void __init usb_musb_pm_init(void)
 
 void usb_musb_disable_autoidle(void)
 {
-	__raw_writel(0, otg_base + OTG_SYSCONFIG);
+	if (otg_clk) {
+		unsigned long reg;
+
+		clk_enable(otg_clk);
+		reg = __raw_readl(otg_base + OTG_SYSCONFIG);
+		__raw_writel(reg & ~1, otg_base + OTG_SYSCONFIG);
+		clk_disable(otg_clk);
+	}
 }
 
 #ifdef CONFIG_USB_MUSB_SOC
-- 
1.6.5.7.g9ecb2

