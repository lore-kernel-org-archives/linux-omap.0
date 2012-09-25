From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 09/21] ARM: OMAP3+: voltage: use oscillator data to calculate setup times
Date: Tue, 25 Sep 2012 19:33:41 +0300
Message-ID: <1348590833-12335-10-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758042Ab2IYQeV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:34:21 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

We now use the previously defined oscillator setup / shutdown times
to calculate the register values for CLKSETUP.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 26750fe..a587506 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -11,14 +11,20 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/bug.h>
+#include <linux/io.h>
+
+#include <asm/div64.h>
 
 #include <plat/cpu.h>
 
+#include "iomap.h"
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "pm.h"
+#include "scrm44xx.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -206,6 +212,18 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
+/* Convert microsecond value to number of 32kHz clock cycles */
+static inline u32 omap_usec_to_32k(u32 usec)
+{
+	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
+}
+
+/* Set oscillator setup time for omap3 */
+static void omap3_set_clksetup(u32 usec, struct voltagedomain *voltdm)
+{
+	voltdm->write(omap_usec_to_32k(usec), OMAP3_PRM_CLKSETUP_OFFSET);
+}
+
 /**
  * omap3_set_i2c_timings - sets i2c sleep timings for a channel
  * @voltdm: channel to configure
@@ -222,6 +240,12 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
 	unsigned long voltsetup1;
 	u32 tgt_volt;
 
+	/*
+	 * Oscillator is shut down only if we are using sys_off_mode pad,
+	 * thus we set a minimal setup time here
+	 */
+	omap3_set_clksetup(1, voltdm);
+
 	if (off_mode)
 		tgt_volt = voltdm->vc_param->off;
 	else
@@ -262,6 +286,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	unsigned long voltsetup2;
 	unsigned long voltsetup2_old;
 	u32 val;
+	u32 tstart, tshut;
 
 	/* check if sys_off_mode is used to control off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -271,6 +296,9 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 		return;
 	}
 
+	omap_pm_get_oscillator(&tstart, &tshut);
+	omap3_set_clksetup(tstart, voltdm);
+
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
 	/* voltsetup 2 in us */
@@ -367,6 +395,30 @@ static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff)
 }
 
 /**
+ * omap4_usec_to_val_scrm - convert microsecond value to SCRM module bitfield
+ * @usec: microseconds
+ * @shift: number of bits to shift left
+ * @mask: bitfield mask
+ *
+ * Converts microsecond value to OMAP4 SCRM bitfield. Bitfield is
+ * shifted to requested position, and checked agains the mask value.
+ * If larger, forced to the max value of the field (i.e. the mask itself.)
+ * Returns the SCRM bitfield value.
+ */
+static u32 omap4_usec_to_val_scrm(u32 usec, int shift, u32 mask)
+{
+	u32 val;
+
+	val = omap_usec_to_32k(usec) << shift;
+
+	/* Check for overflow, if yes, force to max value */
+	if (val > mask)
+		val = mask;
+
+	return val;
+}
+
+/**
  * omap4_set_timings - set voltage ramp timings for a channel
  * @voltdm: channel to configure
  * @off_mode: whether off-mode values are used
@@ -378,6 +430,7 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	u32 val;
 	u32 ramp;
 	int offset;
+	u32 tstart, tshut;
 
 	if (off_mode) {
 		ramp = omap4_calc_volt_ramp(voltdm,
@@ -399,6 +452,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
 
 	voltdm->write(val, offset);
+
+	omap_pm_get_oscillator(&tstart, &tshut);
+
+	val = omap4_usec_to_val_scrm(tstart, OMAP4_SETUPTIME_SHIFT,
+		OMAP4_SETUPTIME_MASK);
+	val |= omap4_usec_to_val_scrm(tshut, OMAP4_DOWNTIME_SHIFT,
+		OMAP4_DOWNTIME_MASK);
+
+	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
 }
 
 /* OMAP4 specific voltage init functions */
-- 
1.7.4.1

