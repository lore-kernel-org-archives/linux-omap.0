From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 5/9] OMAP2/3/4: Adding device names to dmtimer fclk nodes
Date: Sat, 29 May 2010 20:07:07 +0530
Message-ID: <1275143831-7629-6-git-send-email-thara@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
 <1275143831-7629-4-git-send-email-thara@ti.com>
 <1275143831-7629-5-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46498 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756365Ab0E2OhV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 10:37:21 -0400
In-Reply-To: <1275143831-7629-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds device name info to OMAP2/3/4 dmtimer fclk nodes so that the
fclk nodes can be retrieved by doing a clk_get with the corresponding
device pointers.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   24 ++++++++++++------------
 arch/arm/mach-omap2/clock2430_data.c |   24 ++++++++++++------------
 arch/arm/mach-omap2/clock3xxx_data.c |   22 +++++++++++-----------
 arch/arm/mach-omap2/clock44xx_data.c |   22 +++++++++++-----------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d932b14..e1fb85e 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1765,29 +1765,29 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_242X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
+	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
+	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_242X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
+	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_242X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
+	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_242X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
+	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_242X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
+	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_242X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
+	CLK("dmtimer.7",	"gpt8_fck",	&gpt8_fck,	CK_242X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_242X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_242X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0438b6e..e574b2c 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1851,29 +1851,29 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_243X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
+	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_243X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
+	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_243X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
+	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_243X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
+	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_243X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
+	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_243X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
+	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_243X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
+	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_243X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_243X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
+	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_243X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
+	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_243X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
+	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_243X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..7a317d8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3319,8 +3319,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
 	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
+	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_3XXX),
+	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_3XXX),
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
@@ -3405,7 +3405,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
@@ -3420,14 +3420,14 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
+	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_3XXX),
+	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_3XXX),
+	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_3XXX),
+	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_3XXX),
+	CLK("dmtimer.4",	"fck",	&gpt6_fck,	CK_3XXX),
+	CLK("dmtimer.5",	"fck",	&gpt7_fck,	CK_3XXX),
+	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_3XXX),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_3XXX),
 	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
 	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
 	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a1b4cae..2edc0a3 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2575,17 +2575,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
 	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
 	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&gpt1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&gpt10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&gpt11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&gpt2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&gpt3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&gpt4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&gpt5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&gpt6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&gpt7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&gpt8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&gpt9_fck,	CK_443X),
+	CLK("dmtimer.0",	"fck",		&gpt1_fck,	CK_443X),
+	CLK("dmtimer.9",	"fck",		&gpt10_fck,	CK_443X),
+	CLK("dmtimer.10",	"fck",		&gpt11_fck,	CK_443X),
+	CLK("dmtimer.1",	"fck",		&gpt2_fck,	CK_443X),
+	CLK("dmtimer.2",	"fck",		&gpt3_fck,	CK_443X),
+	CLK("dmtimer.3",	"fck",		&gpt4_fck,	CK_443X),
+	CLK("dmtimer.4",	"fck",		&gpt5_fck,	CK_443X),
+	CLK("dmtimer.5",	"fck",		&gpt6_fck,	CK_443X),
+	CLK("dmtimer.6",	"fck",		&gpt7_fck,	CK_443X),
+	CLK("dmtimer.7",	"fck",		&gpt8_fck,	CK_443X),
+	CLK("dmtimer.8",	"fck",		&gpt9_fck,	CK_443X),
 	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
 	CLK(NULL,	"hsi_ick",			&hsi_ick,	CK_443X),
 	CLK("i2c_omap.1",	"fck",				&i2c1_fck,	CK_443X),
-- 
1.7.0.rc1.33.g07cf0f

