From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 06/21] ARM: OMAP4: VC: calculate ramp times
Date: Tue, 25 Sep 2012 19:33:38 +0300
Message-ID: <1348590833-12335-7-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59748 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997Ab2IYQeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 12:34:18 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP4 VC code now uses voltage deltas + slew rates for calculating
actual ramp times for voltage changes. Both retention / sleep +
off mode voltage ramp times are setup at the same time during
initialization.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index bba0d7c..26750fe 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -310,12 +310,106 @@ static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 	omap3_set_off_timings(voltdm);
 }
 
+/**
+ * omap4_calc_volt_ramp - calculates voltage ramping delays on omap4
+ * @voltdm: channel to calculate values for
+ * @voltage_diff: voltage difference in microvolts
+ *
+ * Calculates voltage ramp prescaler + counter values for a voltage
+ * difference on omap4. Returns a field value suitable for writing to
+ * VOLTSETUP register for a channel in following format:
+ * bits[8:9] prescaler ... bits[0:5] counter. See OMAP4 TRM for reference.
+ */
+static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff)
+{
+	u32 prescaler;
+	u32 cycles;
+	u32 time;
+
+	time = voltage_diff / voltdm->pmic->slew_rate;
+
+	cycles = voltdm->sys_clk.rate / 1000 * time / 1000;
+
+	cycles /= 64;
+	prescaler = 0;
+
+	/* shift to next prescaler until no overflow */
+
+	/* scale for div 256 = 64 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
+
+	/* scale for div 512 = 256 * 2 */
+	if (cycles > 63) {
+		cycles /= 2;
+		prescaler++;
+	}
+
+	/* scale for div 2048 = 512 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
+
+	/* check for overflow => invalid ramp time */
+	if (cycles > 63) {
+		pr_warn("%s: invalid setuptime for vdd_%s\n", __func__,
+			voltdm->name);
+		return 0;
+	}
+
+	cycles++;
+
+	return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
+		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
+}
+
+/**
+ * omap4_set_timings - set voltage ramp timings for a channel
+ * @voltdm: channel to configure
+ * @off_mode: whether off-mode values are used
+ *
+ * Calculates and sets the voltage ramp up / down values for a channel.
+ */
+static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
+{
+	u32 val;
+	u32 ramp;
+	int offset;
+
+	if (off_mode) {
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->off);
+		offset = voltdm->vfsm->voltsetup_off_reg;
+	} else {
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->ret);
+		offset = voltdm->vfsm->voltsetup_reg;
+	}
+
+	if (!ramp)
+		return;
+
+	val = voltdm->read(offset);
+
+	val |= ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+
+	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
+
+	voltdm->write(val, offset);
+}
+
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
 	static bool is_initialized;
 	u32 vc_val;
 
+	omap4_set_timings(voltdm, true);
+	omap4_set_timings(voltdm, false);
+
 	if (is_initialized)
 		return;
 
-- 
1.7.4.1

