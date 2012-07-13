From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC RESEND 3/4] ARM: OMAP4: Add timer clock aliases for device-tree
Date: Fri, 13 Jul 2012 17:26:52 -0500
Message-ID: <1342218413-30116-4-git-send-email-jon-hunter@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60877 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab2GMW3S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 18:29:18 -0400
In-Reply-To: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

For OMAP4, the dmtimers are located in the Wake-up, ABE and Peripheral (PER)
power domains. Hence, when the dmtimer is configured to use the "timer_sys_ck"
as its functional clock the actual clock used is different depending on whether
the clock is in the Wake-up, ABE or PER domain. So when we look-up the dmtimer's
"timer_sys_ck" we need to specify the timer device name as well as clock alias
to find the right clock.

Currently, the device names for the timers have the format "omap_timer.X" where
X is the timer instance number. When using to device tree, the format of the
device name created by device-tree is different and has the format
"<reg-address>.<device-name>" (this is assuming that the device-tree "reg"
property is specified). This causes the look-up for the OMAP4 "timer_sys_ck" to
fail. To fix this add new timer clock alias for using device-tree.

Please note that adding a 2nd set of clock aliases for the same clocks to only
temporary until device-tree migration is complete. Then we can remove the legacy
aliases. Hence, I have marked the legacy aliases with a "TODO" to remove them.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d7f55e4..7dfeaf0 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3314,6 +3314,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("usbhs_omap",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
 	CLK(NULL,	"timer_32k_ck",	&sys_32k_ck,	CK_443X),
+	/* TODO: Remove "omap_timer.X" aliases once DT migration is complete */
 	CLK("omap_timer.1",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("omap_timer.2",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("omap_timer.3",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
@@ -3325,6 +3326,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4a318000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("48032000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("48034000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("48036000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("49038000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4903a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.9.5

