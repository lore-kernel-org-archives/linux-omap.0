From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: clock data: add some aliases for use by CPUFreq
 only (was Re: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes)
Date: Wed, 19 Sep 2012 22:18:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192217190.8278@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com> <201209142103.49421.rjw@sisk.pl> <alpine.DEB.2.00.1209192202430.8278@utopia.booyaka.com> <201209200012.12275.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2ISWSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 18:18:25 -0400
In-Reply-To: <201209200012.12275.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here's the updated patch for this one, queued for 3.7.

- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 19 Sep 2012 16:14:02 -0600
Subject: [PATCH] ARM: OMAP2+: clock data: add some aliases for use by CPUFreq only

These clkdev aliases should make it possible to remove the
cpu_is_omap*() calls and the omap_device*() call from
drivers/cpufreq/omap-cpufreq.c during the next merge window.  Those
are interfering with multi-subarch ARM kernels.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    1 +
 arch/arm/mach-omap2/clock2430_data.c |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index ebf3dfb..0b53f3f 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1900,6 +1900,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_242X),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_242X),
 	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_242X),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_242X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index cacabb0..d3ecdf7 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1993,6 +1993,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"timer_32k_ck",  &func_32k_ck,   CK_243X),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
 	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e786ab..0450351 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3469,6 +3469,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
+	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
 };
 
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 70058fb..1b006f1 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3327,6 +3327,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.10.4

