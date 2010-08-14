From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12/13] dmtimer: hwmod: OMAP2: add device names to flck nodes
Date: Sat, 14 Aug 2010 21:03:42 +0530
Message-ID: <1281800022-14985-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab0HNEe3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:34:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds device name info to OMAP2 dmtimer fclk nodes so
that the fclk nodes can be retrieved by doing a clk_get with the
corresponding device pointers.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   12 ++++++++++++
 arch/arm/mach-omap2/clock2430_data.c |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/clock2420_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/clock2430_data.c

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 37d65d6..2e606c1
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1788,6 +1788,18 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_242X),
+	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_242X),
+	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_242X),
+	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_242X),
+	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_242X),
+	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_242X),
+	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_242X),
+	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_242X),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_242X),
+	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_242X),
+	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_242X),
+	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index b33118f..f9104c3
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1874,6 +1874,18 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_243X),
+	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_243X),
+	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_243X),
+	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_243X),
+	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_243X),
+	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_243X),
+	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_243X),
+	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_243X),
+	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_243X),
+	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_243X),
+	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_243X),
+	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_243X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
-- 
1.6.0.4

