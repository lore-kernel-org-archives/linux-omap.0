From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH] ARM: OMAP2PLUS: DSS: Disable LCD3 output when resetting DSS
Date: Thu, 28 Jun 2012 15:14:02 +0530
Message-ID: <1340876642-5289-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46259 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab2F1JoR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:44:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The dispc_disable_outputs() function currently disables all LCD managers except
LCD3. This patch adds disabling functionality for LCD3 manager thereby
maintaining consistency of Display Subsystem for in case Display Controller is
reset when LCD3 manager is in use.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 arch/arm/mach-omap2/display.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 5fb47a1..af1ed7d 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -37,6 +37,7 @@
 
 #define DISPC_CONTROL		0x0040
 #define DISPC_CONTROL2		0x0238
+#define DISPC_CONTROL3		0x0848
 #define DISPC_IRQSTATUS		0x0018
 
 #define DSS_SYSCONFIG		0x10
@@ -52,6 +53,7 @@
 #define EVSYNC_EVEN_IRQ_SHIFT	2
 #define EVSYNC_ODD_IRQ_SHIFT	3
 #define FRAMEDONE2_IRQ_SHIFT	22
+#define FRAMEDONE3_IRQ_SHIFT	30
 #define FRAMEDONETV_IRQ_SHIFT	24
 
 /*
@@ -376,7 +378,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 static void dispc_disable_outputs(void)
 {
 	u32 v, irq_mask = 0;
-	bool lcd_en, digit_en, lcd2_en = false;
+	bool lcd_en, digit_en, lcd2_en = false, lcd3_en = false;
 	int i;
 	struct omap_dss_dispc_dev_attr *da;
 	struct omap_hwmod *oh;
@@ -405,7 +407,13 @@ static void dispc_disable_outputs(void)
 		lcd2_en = v & LCD_EN_MASK;
 	}
 
-	if (!(lcd_en | digit_en | lcd2_en))
+	/* store value of LCDENABLE for LCD3 */
+	if (da->manager_count > 3) {
+		v = omap_hwmod_read(oh, DISPC_CONTROL3);
+		lcd3_en = v & LCD_EN_MASK;
+	}
+
+	if (!(lcd_en | digit_en | lcd2_en | lcd3_en))
 		return; /* no managers currently enabled */
 
 	/*
@@ -426,10 +434,12 @@ static void dispc_disable_outputs(void)
 
 	if (lcd2_en)
 		irq_mask |= 1 << FRAMEDONE2_IRQ_SHIFT;
+	if (lcd3_en)
+		irq_mask |= 1 << FRAMEDONE3_IRQ_SHIFT;
 
 	/*
 	 * clear any previous FRAMEDONE, FRAMEDONETV,
-	 * EVSYNC_EVEN/ODD or FRAMEDONE2 interrupts
+	 * EVSYNC_EVEN/ODD, FRAMEDONE2 or FRAMEDONE3 interrupts
 	 */
 	omap_hwmod_write(irq_mask, oh, DISPC_IRQSTATUS);
 
@@ -445,12 +455,19 @@ static void dispc_disable_outputs(void)
 		omap_hwmod_write(v, oh, DISPC_CONTROL2);
 	}
 
+	/* disable LCD3 manager */
+	if (da->manager_count > 3) {
+		v = omap_hwmod_read(oh, DISPC_CONTROL3);
+		v &= ~LCD_EN_MASK;
+		omap_hwmod_write(v, oh, DISPC_CONTROL3);
+	}
+
 	i = 0;
 	while ((omap_hwmod_read(oh, DISPC_IRQSTATUS) & irq_mask) !=
 	       irq_mask) {
 		i++;
 		if (i > FRAMEDONE_IRQ_TIMEOUT) {
-			pr_err("didn't get FRAMEDONE1/2 or TV interrupt\n");
+			pr_err("didn't get FRAMEDONE1/2/3 or TV interrupt\n");
 			break;
 		}
 		mdelay(1);
-- 
1.7.1

