From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP3: Fix voltage control for deeper idle
 states
Date: Wed, 7 May 2014 09:38:13 -0700
Message-ID: <20140507163813.GG9502@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-5-git-send-email-tony@atomide.com>
 <20140411151445.GA5350@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36104 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbaEGQiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 12:38:18 -0400
Content-Disposition: inline
In-Reply-To: <20140411151445.GA5350@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

* Tony Lindgren <tony@atomide.com> [140411 08:18]:
> * Tony Lindgren <tony@atomide.com> [140410 16:52]:
> And here we're missing a write to clksetup, without that the off idle
> timings are not correct.. Below is an incremental diff on top of this
> patch.

Here's this one updated to the changes made in patch 2 of this
series.

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 5 May 2014 17:27:36 -0700
Subject: [PATCH] ARM: OMAP3: Fix voltage control for deeper idle states

Currently we're attempting to use a static value for the
voltctrl register that only works for controlling the PMIC
over I2C4. For using sys_off_mode signaling, we need to update
update clksetup, voltsetup1, voltsetup2 and voltctrl registers
dynamically depending on the idle state.

So let's fix this by configuring things for I2C4 controlled idle
and sys_off_mode pin controlled idle, and then write the
configured register values depending on the idle state. This
is similar what N900 kernel is doing too.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 728d64d..0d1629c 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -220,35 +220,64 @@ static inline u32 omap_usec_to_32k(u32 usec)
 	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
 }
 
+struct omap3_vc_timings {
+	u32 voltsetup1;
+	u32 voltsetup2;
+};
+
 struct omap3_vc {
 	struct voltagedomain *vd;
 	u32 voltctrl;
+	u32 voltsetup1;
+	u32 voltsetup2;
+	struct omap3_vc_timings timings[2];
 };
 static struct omap3_vc vc;
 
 void omap3_vc_set_pmic_signaling(int core_next_state)
 {
 	struct voltagedomain *vd = vc.vd;
-	u32 voltctrl;
+	struct omap3_vc_timings *c = vc.timings;
+	u32 voltctrl, voltsetup1, voltsetup2;
 
 	voltctrl = vc.voltctrl;
+	voltsetup1 = vc.voltsetup1;
+	voltsetup2 = vc.voltsetup2;
+
 	switch (core_next_state) {
 	case PWRDM_POWER_OFF:
 		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
 			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
 		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
+		if (voltctrl & OMAP3430_PRM_VOLTCTRL_SEL_OFF)
+			voltsetup2 = c->voltsetup2;
+		else
+			voltsetup1 = c->voltsetup1;
 		break;
 	case PWRDM_POWER_RET:
 	default:
+		c++;
 		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
 			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
 		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_RET;
+		voltsetup1 = c->voltsetup1;
 		break;
 	}
+
 	if (voltctrl != vc.voltctrl) {
 		vd->write(voltctrl, OMAP3_PRM_VOLTCTRL_OFFSET);
 		vc.voltctrl = voltctrl;
 	}
+	if (voltsetup1 != vc.voltsetup1) {
+		vd->write(c->voltsetup1,
+			  OMAP3_PRM_VOLTSETUP1_OFFSET);
+		vc.voltsetup1 = voltsetup1;
+	}
+	if (voltsetup2 != vc.voltsetup2) {
+		vd->write(c->voltsetup2,
+			  OMAP3_PRM_VOLTSETUP2_OFFSET);
+		vc.voltsetup2 = voltsetup2;
+	}
 }
 
 #define PRM_POLCTRL_TWL_MASK	(OMAP3430_PRM_POLCTRL_CLKREQ_POL | \
@@ -301,6 +330,18 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
 	omap3_vc_set_pmic_signaling(PWRDM_POWER_ON);
 }
 
+static void omap3_init_voltsetup1(struct voltagedomain *voltdm,
+				  struct omap3_vc_timings *c, u32 idle)
+{
+	unsigned long val;
+
+	val = (voltdm->vc_param->on - idle) / voltdm->pmic->slew_rate;
+	val *= voltdm->sys_clk.rate / 8 / 1000000 + 1;
+	val <<= __ffs(voltdm->vfsm->voltsetup_mask);
+	c->voltsetup1 &= ~voltdm->vfsm->voltsetup_mask;
+	c->voltsetup1 |= val;
+}
+
 /**
  * omap3_set_i2c_timings - sets i2c sleep timings for a channel
  * @voltdm: channel to configure
@@ -311,31 +352,21 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
  * or retention. Off mode has additionally an option to use sys_off_mode
  * pad, which uses a global signal to program the whole power IC to
  * off-mode.
+ *
+ * Note that pmic is not controlling the voltage scaling during
+ * retention signaled over I2C4, so we can keep voltsetup2 as 0.
+ * And the oscillator is not shut off over I2C4, so no need to
+ * set clksetup.
  */
-static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
+static void omap3_set_i2c_timings(struct voltagedomain *voltdm)
 {
-	unsigned long voltsetup1;
-	u32 tgt_volt;
-
-	if (off_mode)
-		tgt_volt = voltdm->vc_param->off;
-	else
-		tgt_volt = voltdm->vc_param->ret;
-
-	voltsetup1 = (voltdm->vc_param->on - tgt_volt) /
-			voltdm->pmic->slew_rate;
+	struct omap3_vc_timings *c = vc.timings;
 
-	voltsetup1 = voltsetup1 * voltdm->sys_clk.rate / 8 / 1000000 + 1;
-
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
-		voltdm->vfsm->voltsetup_reg);
-
-	/*
-	 * pmic is not controlling the voltage scaling during retention,
-	 * thus set voltsetup2 to 0
-	 */
-	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	/* Configure PRWDM_POWER_OFF over I2C4 */
+	omap3_init_voltsetup1(voltdm, c, voltdm->vc_param->off);
+	c++;
+	/* Configure PRWDM_POWER_RET over I2C4 */
+	omap3_init_voltsetup1(voltdm, c, voltdm->vc_param->ret);
 }
 
 /**
@@ -344,22 +375,49 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
  *
  * Calculates and sets up off-mode timings for a channel. Off-mode
  * can use either I2C based voltage scaling, or alternatively
- * sys_off_mode pad can be used to send a global command to power IC.
- * This function first checks which mode is being used, and calls
- * omap3_set_i2c_timings() if the system is using I2C control mode.
+ * sys_off_mode pad can be used to send a global command to power IC.n,
  * sys_off_mode has the additional benefit that voltages can be
  * scaled to zero volt level with TWL4030 / TWL5030, I2C can only
  * scale to 600mV.
+ *
+ * Note that omap is not controlling the voltage scaling during
+ * off idle signaled by sys_off_mode, so we can keep voltsetup1
+ * as 0.
  */
 static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
+	struct omap3_vc_timings *c = vc.timings;
+	u32 tstart, tshut, clksetup, voltoffset;
+
+	if (c->voltsetup2)
+		return;
+
+	omap_pm_get_oscillator(&tstart, &tshut);
+	if (tstart == ULONG_MAX) {
+		pr_debug("PM: oscillator start-up time not initialized, using 10ms\n");
+		clksetup = omap_usec_to_32k(10000);
+	} else {
+		clksetup = omap_usec_to_32k(tstart);
+	}
+
+	/*
+	 * For twl4030 errata 27, we need to allow minimum ~488.32 us wait to
+	 * switch from HFCLKIN to internal oscillator. That means timings
+	 * have voltoffset fixed to 0xa in rounded up 32 KiHz cycles. And
+	 * that means we can calculate the value based on the oscillator
+	 * start-up time since voltoffset2 = clksetup - voltoffset.
+	 */
+	voltoffset = omap_usec_to_32k(488);
+	c->voltsetup2 = clksetup - voltoffset;
+	voltdm->write(clksetup, OMAP3_PRM_CLKSETUP_OFFSET);
+	voltdm->write(voltoffset, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
 	omap3_vc_init_pmic_signaling(voltdm);
 	omap3_set_off_timings(voltdm);
-	omap3_set_i2c_timings(voltdm, true);
+	omap3_set_i2c_timings(voltdm);
 }
 
 /**
