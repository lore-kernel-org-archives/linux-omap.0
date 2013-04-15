From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 4/6] ARM: OMAP3+: ABB: add aliases for sysclk used in ABB driver
Date: Mon, 15 Apr 2013 16:28:09 +0300
Message-ID: <1366032491-4162-5-git-send-email-andrii.tseglytskyi@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46176 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3DON2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 09:28:20 -0400
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

This patch introduces aliases for SYS clock nedded for ABB
driver, which will be introduced in the following patch.

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |    1 +
 arch/arm/mach-omap2/cclock44xx_data.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 45cd264..9784332 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3540,6 +3540,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck),
 	CLK(NULL,	"cpufreq_ck",	&dpll1_ck),
+	CLK("483072f0.regulator-abb1",	"abb_sys_ck",	&sys_ck),
 };
 
 static const char *enable_init_clks[] = {
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 88e37a4..0b7914d 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1684,6 +1684,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
 	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck),
+	CLK("4a307bd0.regulator-abb1",	"abb_sys_ck",	&sys_clkin_ck),
+	CLK("4a307bd8.regulator-abb2",	"abb_sys_ck",	&sys_clkin_ck),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.9.5

