From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 1/13] dmtimer: hwmod: OMAP4: add device names to flck nodes
Date: Sat, 14 Aug 2010 21:09:01 +0530
Message-ID: <1281800341-15260-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52910 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692Ab0HNEjr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:39:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Partha Basak <p-basak2@ti.com>, Thara Gopinath <thara@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com> 

This patch adds device name info to OMAP4 dmtimer fclk nodes so
that the fclk nodes can be retrieved by doing a clk_get with the
corresponding device pointers.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/clock44xx_data.c

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a0e369e..24e4dc3
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2574,17 +2574,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
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
+	CLK("dmtimer.0",	"fck",		&timer1_fck,	CK_443X),
+	CLK("dmtimer.9",	"fck",		&timer10_fck,	CK_443X),
+	CLK("dmtimer.10",	"fck",		&timer11_fck,	CK_443X),
+	CLK("dmtimer.1",	"fck",		&timer2_fck,	CK_443X),
+	CLK("dmtimer.2",	"fck",		&timer3_fck,	CK_443X),
+	CLK("dmtimer.3",	"fck",		&timer4_fck,	CK_443X),
+	CLK("dmtimer.4",	"fck",		&timer5_fck,	CK_443X),
+	CLK("dmtimer.5",	"fck",		&timer6_fck,	CK_443X),
+	CLK("dmtimer.6",	"fck",		&timer7_fck,	CK_443X),
+	CLK("dmtimer.7",	"fck",		&timer8_fck,	CK_443X),
+	CLK("dmtimer.8",	"fck",		&timer9_fck,	CK_443X),
 	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
-- 
1.6.0.4

