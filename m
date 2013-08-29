From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 29/45] ARM: OMAP3: use DT clock init if DT data is available
Date: Thu, 29 Aug 2013 16:16:21 +0300
Message-ID: <1377782197-10611-30-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab3H2NSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:18:41 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
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
index 205bb1d..fd4bb71 100644
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

