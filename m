From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 5/6] ARM: OMAP2+: Add pdata quirk for sys_clkout2 for omap3 DBB056
Date: Tue, 21 Jan 2014 20:47:39 +0100
Message-ID: <1390333660-30573-6-git-send-email-chf.fritz@googlemail.com>
References: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35007 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaAUTsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 14:48:21 -0500
In-Reply-To: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, bcousson@baylibre.com, Archit Taneja <archit@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Full device tree support for clock control is not yet accomplished. Until
then, configure the 24Mhz of sys_clkout2 to feed an USB-Hub here.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index bce8020..07d05f6 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -95,6 +95,43 @@ static void __init omap3_zoom_legacy_init(void)
 
 static void __init omap3_dbb056_legacy_init(void)
 {
+	struct clk *clkout2;
+	struct clk *cm96fck;
+
+	/* Reparent clkout2 to 96M_FCK */
+	pr_info("a83x-quirk: Late Reparent clkout2 to 96M_FCK\n");
+	clkout2 = clk_get(NULL, "clkout2_src_ck");
+	if(clkout2 < 0) {
+		pr_err("a83x-quirk: couldn't get clkout2_src_ck\n");
+		return;
+	}
+	cm96fck = clk_get(NULL, "cm_96m_fck");
+	if(cm96fck < 0) {
+		pr_err("a83x-quirk: couldn't get cm_96m_fck\n");
+		return;
+	}
+	if(clk_set_parent(clkout2, cm96fck) < 0) {
+		pr_err("a83x-quirk: couldn't reparent clkout2_src_ck\n");
+		return;
+	}
+
+	/* Set clkout2 to 24MHz for internal usb hub*/
+	pr_info("a83x-quirk: Set clkout2 to 24MHz for internal usb hub\n");
+	clkout2 = clk_get(NULL, "sys_clkout2");
+	if(clkout2 < 0) {
+		pr_err("a83x-quirk: couldn't get sys_clkout2\n");
+		return;
+	}
+	if(clk_set_rate(clkout2, 24000000) < 0) {
+		printk(KERN_ERR "board-omap3evm: couldn't set sys_clkout2 rate\n");
+		return;
+	}
+	if(clk_prepare_enable(clkout2) < 0) {
+		pr_err("a83x-quirk: couldn't enable sys_clkout2\n");
+		return;
+	}
+
+	/* Initialize display */
 	omap3_dbb056_display_init_of();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
-- 
1.7.10.4

