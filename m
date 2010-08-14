From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 9/13] dmtimer: hwmod: OMAP3: add device names to flck nodes
Date: Sat, 14 Aug 2010 21:06:01 +0530
Message-ID: <1281800161-15060-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab0HNEgr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:36:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds device name info to OMAP3 dmtimer fclk nodes so
that the fclk nodes can be retrieved by doing a clk_get with the
corresponding device pointers.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/clock3xxx_data.c

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 138646d..9aabbe7
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3248,8 +3248,8 @@ static struct omap_clk omap3xxx_clks[] = {
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
@@ -3334,7 +3334,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
@@ -3349,14 +3349,14 @@ static struct omap_clk omap3xxx_clks[] = {
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
+	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_3XXX),
+	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_3XXX),
+	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_3XXX),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_3XXX),
 	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
 	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
 	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
@@ -3396,7 +3396,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
+	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
-- 
1.6.0.4

