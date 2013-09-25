From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 33/36] ARM: OMAP3: use DT clock init if DT data is available
Date: Wed, 25 Sep 2013 11:48:39 +0300
Message-ID: <1380098922-30340-34-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35091 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab3IYIvT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 04:51:19 -0400
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

OMAP3 platforms support both DT and non-DT boot at the moment, make
the clock init work according to the used setup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.h |    4 ++++
 arch/arm/mach-omap2/io.c        |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 78d9f56..a5e2308 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -9,6 +9,10 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
 
 int omap3xxx_clk_init(void);
+int omap3430_clk_init(void);
+int omap3630_clk_init(void);
+int ti81xx_clk_init(void);
+int am35xx_clk_init(void);
 int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1f23182..315a148 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -488,21 +488,29 @@ void __init omap3_init_early(void)
 void __init omap3430_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3430_clk_init;
 }
 
 void __init omap35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3430_clk_init;
 }
 
 void __init omap3630_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3630_clk_init;
 }
 
 void __init am35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = am35xx_clk_init;
 }
 
 void __init ti81xx_init_early(void)
@@ -520,7 +528,10 @@ void __init ti81xx_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap3xxx_clk_init;
+	if (of_have_populated_dt())
+		omap_clk_init = ti81xx_clk_init;
+	else
+		omap_clk_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
-- 
1.7.9.5

