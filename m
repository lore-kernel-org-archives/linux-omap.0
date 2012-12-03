From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 4/4] ARM: OMAP4460: Workaround ABE DPLL failing to turn-on
Date: Mon, 3 Dec 2012 14:41:15 -0600
Message-ID: <1354567275-6447-5-git-send-email-jon-hunter@ti.com>
References: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47242 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab2LCUlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Dec 2012 15:41:31 -0500
In-Reply-To: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
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
 arch/arm/mach-omap2/cclock44xx_data.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 44ef54f..30da1ad 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -40,6 +40,14 @@
 #define OMAP4430_MODULEMODE_HWCTRL_SHIFT		0
 #define OMAP4430_MODULEMODE_SWCTRL_SHIFT		1
 
+/*
+ * OMAP4 ABE DPLL default frequency. In OMAP4460 TRM version V, section
+ * "3.6.3.2.3 CM1_ABE Clock Generator" states that the "DPLL_ABE_X2_CLK
+ * must be set to 196.608 MHz" and hence, the DPLL locked frequency is
+ * half of this value.
+ */
+#define OMAP4_DPLL_ABE_DEFFREQ				98304000
+
 /* Root clocks */
 
 DEFINE_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
@@ -1966,6 +1974,7 @@ int __init omap4xxx_clk_init(void)
 {
 	u32 cpu_clkflg;
 	struct omap_clk *c;
+	int rc;
 
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
@@ -1994,5 +2003,18 @@ int __init omap4xxx_clk_init(void)
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
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

