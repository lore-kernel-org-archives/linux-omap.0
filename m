From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 08/14] arm: omap3+: voltage: use oscillator data to calculate setup times
Date: Tue, 21 Feb 2012 16:04:52 +0200
Message-ID: <1329833098-19900-9-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35686 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab2BUOGB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:06:01 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

We now use the previously defined oscillator setup / shutdown times
to calculate the register values for CLKSETUP.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index af061c3..2fe4ce2 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -13,6 +13,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/div64.h>
+
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
@@ -22,6 +24,7 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "scrm44xx.h"
+#include "pm.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -209,6 +212,21 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
+/* Convert microsecond value to number of 32kHz clock cycles */
+static u32 omap_usec_to_32k(u32 usec)
+{
+	/* DIV_ROUND_UP expanded to 64bit to avoid overflow */
+	u64 val = 32768ULL * (u64)usec + 1000000ULL - 1;
+	do_div(val, 1000000ULL);
+	return val;
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
@@ -225,6 +243,12 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
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
@@ -265,6 +289,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	unsigned long voltsetup2;
 	unsigned long voltsetup2_old;
 	u32 val;
+	u32 tstart, tshut;
 
 	/* check if sys_off_mode is used to control off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -274,6 +299,9 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 		return;
 	}
 
+	omap_pm_get_oscillator(&tstart, &tshut);
+	omap3_set_clksetup(tstart, voltdm);
+
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
 	/* voltsetup 2 in us */
@@ -370,6 +398,30 @@ static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff)
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
@@ -380,6 +432,7 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 {
 	u32 val;
 	u32 ramp;
+	u32 tstart, tshut;
 
 	/* configure the setup times */
 	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
@@ -399,6 +452,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
 
 	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
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

