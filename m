From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v11 1/8] OMAP2+: dmtimer: add device names to flck nodes
Date: Thu, 24 Feb 2011 16:56:44 +0530
Message-ID: <1298546811-27055-2-git-send-email-tarun.kanti@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41063 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab1BXLYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 06:24:43 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1OBOe9t027438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 05:24:42 -0600
In-Reply-To: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
retrieved by doing a clk_get with the corresponding device pointers or
device names.

NOTE: gpt1_fck is modified in patch-10 when we switch to platform device
driver. This is to make sure that each patch compiles and boots.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   58 +++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock2430_data.c |   58 +++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock3xxx_data.c |   46 ++++++++++++++++++++------
 arch/arm/mach-omap2/clock44xx_data.c |   42 ++++++++++++++++++------
 4 files changed, 161 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0a992bc..ee93d3c 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1803,27 +1803,27 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
+	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
+	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_242X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
+	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_242X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
+	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_242X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
+	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_242X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
+	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_242X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
+	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_242X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
+	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_242X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	CLK("omap_timer.10",	"fck",	&gpt10_fck,	CK_242X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	CLK("omap_timer.11",	"fck",	&gpt11_fck,	CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	CLK("omap_timer.12",	"fck",	&gpt12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
@@ -1878,6 +1878,42 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
+	CLK("omap_timer.1",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.2",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.3",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.4",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.5",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.6",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.7",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.8",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.9",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.10",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.11",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.12",	"32k_ck",	&func_32k_ck,	CK_243X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index c047dcd..24553ce 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1907,27 +1907,27 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
+	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_243X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
+	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_243X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
+	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_243X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
+	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_243X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
+	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_243X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
+	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_243X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
+	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_243X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
+	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_243X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
+	CLK("omap_timer.10",	"fck",	&gpt10_fck,	CK_243X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
+	CLK("omap_timer.11",	"fck",	&gpt11_fck,	CK_243X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
+	CLK("omap_timer.12",	"fck",	&gpt12_fck,	CK_243X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
@@ -1993,6 +1993,42 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
+	CLK("omap_timer.1",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.2",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.3",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.4",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.5",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.6",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.7",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.8",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.9",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.10",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.11",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.12",	"32k_ck",  &func_32k_ck,   CK_243X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
+	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f14d986..6a17982 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3281,8 +3281,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
+	CLK("omap_timer.10",	"fck",	&gpt10_fck,	CK_3XXX),
+	CLK("omap_timer.11",	"fck",	&gpt11_fck,	CK_3XXX),
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
@@ -3393,14 +3393,14 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
+	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_3XXX),
+	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_3XXX),
+	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_3XXX),
+	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_3XXX),
+	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_3XXX),
+	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_3XXX),
+	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_3XXX),
+	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_3XXX),
 	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
 	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
 	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
@@ -3441,7 +3441,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
+	CLK("omap_timer.12",	"fck",	&gpt12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
@@ -3454,6 +3454,30 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
+	CLK("omap_timer.1",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.2",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.3",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.4",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.5",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.6",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.7",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.8",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.9",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.10",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.11",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.12",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_3XXX),
 };
 
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index de9ec8d..11997a3 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3182,16 +3182,16 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
 	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
+	CLK("omap_timer.10",	"fck",			&timer10_fck,	CK_443X),
+	CLK("omap_timer.11",	"fck",			&timer11_fck,	CK_443X),
+	CLK("omap_timer.2",	"fck",			&timer2_fck,	CK_443X),
+	CLK("omap_timer.3",	"fck",			&timer3_fck,	CK_443X),
+	CLK("omap_timer.4",	"fck",			&timer4_fck,	CK_443X),
+	CLK("omap_timer.5",	"fck",			&timer5_fck,	CK_443X),
+	CLK("omap_timer.6",	"fck",			&timer6_fck,	CK_443X),
+	CLK("omap_timer.7",	"fck",			&timer7_fck,	CK_443X),
+	CLK("omap_timer.8",	"fck",			&timer8_fck,	CK_443X),
+	CLK("omap_timer.9",	"fck",			&timer9_fck,	CK_443X),
 	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
@@ -3275,6 +3275,28 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
+	CLK("omap_timer.1",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.2",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.3",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.4",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.5",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.6",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.7",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.8",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.9",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.10",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.11",	"32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.1",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.2",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.3",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.4",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.9",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.10",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.11",	"sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.5",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.6",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.7",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.8",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.6.0.4

