From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4460: Workaround ABE DPLL failing to turn-on
Date: Wed, 7 Nov 2012 12:43:02 -0600
Message-ID: <1352313782-21602-4-git-send-email-jon-hunter@ti.com>
References: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab2KGSnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 13:43:10 -0500
In-Reply-To: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

With the latest mainline u-boot bootloader (v2012.10), timers (5-8) in
the ABE power domain are failing to turn-on. The timers never come out
of the disabled state when setting the module-mode field to enable.

The problem was exposed when u-boot was updated to NOT configure and
lock the ABE DPLL on start-up. If the ABE DPLL is configured and locked
by u-boot the problem does not occur. However, if the ABE DPLL is in the
idle low-power bypass state and we attempt to enable a timer in the ABE
power domain, it remains stuck in the disabled state. It appears to be a
problem the timer interface clock as this comes from the ABE DPLL.

If we place the ABE DPLL in the MN-bypass state and not the idle
low-power state, then this problem is not seen.

This problem only appears to occur on OMAP4460 and not OMAP4430.

Workaround this problem by locking the ABE DPLL for OMAP4460 in the
kernel on boot. By locking the ABE DPLL, when clocks from the ABE DPLL
are not being requested the DPLL will transition into a low-power stop
mode.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8a9cbad..1844661 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -46,6 +46,14 @@
 #define OMAP4430_MODULEMODE_HWCTRL			0
 #define OMAP4430_MODULEMODE_SWCTRL			1
 
+/*
+ * OMAP4 ABE DPLL default frequency. In OMAP4460 TRM version V, section
+ * "3.6.3.2.3 CM1_ABE Clock Generator" states that the "DPLL_ABE_X2_CLK
+ * must be set to 196.608 MHz" and hence, the DPLL locked frequency is
+ * half of this value.
+ */
+#define OMAP4_DPLL_ABE_DEFFREQ				98304000
+
 /* Root clocks */
 
 static struct clk extalt_clkin_ck = {
@@ -3354,6 +3362,7 @@ int __init omap4xxx_clk_init(void)
 {
 	struct omap_clk *c;
 	u32 cpu_clkflg;
+	int rc;
 
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
@@ -3400,5 +3409,18 @@ int __init omap4xxx_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
+	/*
+	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
+	 * state when turning the ABE clock domain. Workaround this by
+	 * locking the ABE DPLL on boot.
+	 */
+	if (cpu_is_omap446x()) {
+		rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
+		if (!rc)
+			rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
+		if (rc)
+			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+	}
+
 	return 0;
 }
-- 
1.7.9.5

