From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/4] ARM: OMAP4: Update timer clock aliases
Date: Mon, 3 Dec 2012 14:41:12 -0600
Message-ID: <1354567275-6447-2-git-send-email-jon-hunter@ti.com>
References: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55719 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab2LCUlX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Dec 2012 15:41:23 -0500
In-Reply-To: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
names of the OMAP4 timers 5-7 because the default address for the timers
was changed from the L3 address to the MPU private address. When booting
with device-tree, this introduces a regression when attempting to set
the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
the clock aliases for timer 5-7 to reflect the updated device-tree name
for the timers.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: updated to apply after the CCF conversion]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index aa56c3e..a1f0b55 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1935,10 +1935,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("49038000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
 };
 
-- 
1.7.9.5

