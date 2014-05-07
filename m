From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
Date: Wed, 7 May 2014 09:34:32 -0700
Message-ID: <20140507163431.GF9502@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-3-git-send-email-tony@atomide.com>
 <5348FFFA.5040207@ti.com>
 <20140412150205.GB32292@atomide.com>
 <535770EE.8060603@ti.com>
 <20140423204926.GB6053@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27911 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbaEGQek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 12:34:40 -0400
Content-Disposition: inline
In-Reply-To: <20140423204926.GB6053@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>

* Tony Lindgren <tony@atomide.com> [140423 13:49]:
> * Tero Kristo <t-kristo@ti.com> [140423 00:51]:
> > On 04/12/2014 06:02 PM, Tony Lindgren wrote:
> > >* Tero Kristo <t-kristo@ti.com> [140412 02:01]:
> > >>On 04/11/2014 02:47 AM, Tony Lindgren wrote:>
> > >>>@@ -282,6 +283,7 @@ void omap_sram_idle(void)
> > >>>
> > >>>   	/* CORE */
> > >>>   	if (core_next_state < PWRDM_POWER_ON) {
> > >>>+		omap3_vc_set_pmic_signaling(core_next_state);
> > >>>   		if (core_next_state == PWRDM_POWER_OFF) {
> > >>>   			omap3_core_save_context();
> > >>>   			omap3_cm_save_context();
> > >>
> > >>I think this implementation is sub-optimal, as it only scales
> > >>voltages if core is entering idle state. MPU only idle is possible,
> > >>however you do not scale voltages in this case.
> > >
> > >Hmm that's same as PWRDM_POWER_RET? That's working too.
> > >Or do you have something else in mind that I'm not aware
> > >of?
> > 
> > No, I mean the case where core_next_state == PWRDM_POWER_ON, but
> > mpu_next_state <= PWRDM_POWER_RET. You could scale MPU voltage in this case
> > but you don't with this implementation.
> 
> OK makes sense to pass both mpu_next_state and core_next_state  
> to the function then.

I've changed things around to implement the register caching
Grazvydas suggested, and calling omap3_vc_set_pmic_signaling()
always omap_sram_idle(). The default signaling is to use
I2C4 control except for core-off that uses the sys_off_mode,
so there should not be any blockers for core-on + mpu-off.

And after playing with enable_off_mode I'm seeing at least
all cpuidle states being hit.

# cat /sys/devices/system/cpu/cpu0/cpuidle/state*/usage
603
7378
7087
342
17
1
45

> > >OK, sounds like you already have a patch for that in your
> > >3.14-rc4-cm-prm-driver-wip branch?
> > 
> > Yes, there is a patch for that.
> 
> OK I'll pick it from there. 

I ended up doing the read/write in a slightly different way as
we can pass the pwrdm to the init function.
 
Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 5 May 2014 17:27:35 -0700
Subject: [PATCH] ARM: OMAP3: Fix idle mode signaling for sys_clkreq and sys_off_mode

While debugging legacy mode vs device tree booted PM regressions,
I noticed that omap3 is not toggling sys_clkreq and sys_off_mode
pins like it should.

The sys_clkreq and sys_off_mode pins are not toggling because of
the following issues:

1. The default polarity for the sys_off_mode pin is wrong.
   OFFMODE_POL needs to be cleared for sys_off_mode to go down when
   hitting off-idle, while CLKREQ_POL needs to be set so sys_clkreq
   goes down when hitting retention.

2. The values for voltctrl register need to be updated dynamically.
   We need to set either the retention idle bits, or off idle bits
   in the voltctrl register depending the idle mode we're targeting
   to hit.

Let's fix these two issues as otherwise the system will just
hang if any twl4030 PMIC idle scripts are loaded. The only case
where the system does not hang is if only retention idle over I2C4
is configured by the bootloader.

Note that even without the twl4030 PMIC scripts, these fixes will
do the proper signaling of sys_clkreq and sys_off_mode pins, so
the fixes are needed to fix monitoring of PM states with LEDs or
an oscilloscope.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87099bb..3c8bb8f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,6 +50,7 @@
 #include "sdrc.h"
 #include "sram.h"
 #include "control.h"
+#include "vc.h"
 
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
@@ -288,6 +289,9 @@ void omap_sram_idle(void)
 		}
 	}
 
+	/* Configure PMIC signaling for I2C4 or sys_off_mode */
+	omap3_vc_set_pmic_signaling(core_next_state);
+
 	omap3_intc_prepare_idle();
 
 	/*
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index cebad56..106132d 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -123,8 +123,15 @@
 #define OMAP3430_GLOBAL_SW_RST_SHIFT			1
 #define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
 #define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
-#define OMAP3430_SEL_OFF_MASK				(1 << 3)
-#define OMAP3430_AUTO_OFF_MASK				(1 << 2)
+#define OMAP3430_PRM_VOLTCTRL_SEL_VMODE			(1 << 4)
+#define OMAP3430_PRM_VOLTCTRL_SEL_OFF			(1 << 3)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_OFF			(1 << 2)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_RET			(1 << 1)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP		(1 << 0)
 #define OMAP3430_SETUP_TIME2_MASK			(0xffff << 16)
 #define OMAP3430_SETUP_TIME1_MASK			(0xffff << 0)
+#define OMAP3430_PRM_POLCTRL_OFFMODE_POL		(1 << 3)
+#define OMAP3430_PRM_POLCTRL_CLKOUT_POL			(1 << 2)
+#define OMAP3430_PRM_POLCTRL_CLKREQ_POL			(1 << 1)
+#define OMAP3430_PRM_POLCTRL_EXTVOL_POL			(1 << 0)
 #endif
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 49ac797..705eb35 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -220,6 +220,87 @@ static inline u32 omap_usec_to_32k(u32 usec)
 	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
 }
 
+struct omap3_vc {
+	struct voltagedomain *vd;
+	u32 voltctrl;
+};
+static struct omap3_vc vc;
+
+void omap3_vc_set_pmic_signaling(int core_next_state)
+{
+	struct voltagedomain *vd = vc.vd;
+	u32 voltctrl;
+
+	voltctrl = vc.voltctrl;
+	switch (core_next_state) {
+	case PWRDM_POWER_OFF:
+		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
+			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
+		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
+		break;
+	case PWRDM_POWER_RET:
+	default:
+		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
+			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
+		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_RET;
+		break;
+	}
+	if (voltctrl != vc.voltctrl) {
+		vd->write(voltctrl, OMAP3_PRM_VOLTCTRL_OFFSET);
+		vc.voltctrl = voltctrl;
+	}
+}
+
+#define PRM_POLCTRL_TWL_MASK	(OMAP3430_PRM_POLCTRL_CLKREQ_POL | \
+					OMAP3430_PRM_POLCTRL_CLKREQ_POL)
+#define PRM_POLCTRL_TWL_VAL	OMAP3430_PRM_POLCTRL_CLKREQ_POL
+
+/*
+ * Configure signal polarity for sys_clkreq and sys_off_mode pins
+ * as the default values are wrong and can cause the system to hang
+ * if any twl4030 scripts are loaded.
+ */
+static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
+{
+	u32 val;
+
+	if (vc.vd)
+		return;
+
+	vc.vd = voltdm;
+
+	val = voltdm->read(OMAP3_PRM_POLCTRL_OFFSET);
+	if (!(val & OMAP3430_PRM_POLCTRL_CLKREQ_POL) ||
+	    (val & OMAP3430_PRM_POLCTRL_CLKREQ_POL)) {
+		val |= OMAP3430_PRM_POLCTRL_CLKREQ_POL;
+		val &= ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
+		pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity to 0x%x\n",
+			 val);
+		voltdm->write(val, OMAP3_PRM_POLCTRL_OFFSET);
+	}
+
+	/*
+	 * By default let's use I2C4 signaling for retention idle
+	 * and sys_off_mode pin signaling for off idle. This way we
+	 * have sys_clk_req pin go down for retention and both
+	 * sys_clk_req and sys_off_mode pins will go down for off
+	 * idle. And we can also scale voltages to zero for off-idle.
+	 * Note that no actual voltage scaling during off-idle will
+	 * happen unless the board specific twl4030 PMIC scripts are
+	 * loaded.
+	 */
+	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
+	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
+		val |= OMAP3430_PRM_VOLTCTRL_SEL_OFF;
+		pr_debug("PM: setting voltctrl sys_off_mode signaling to 0x%x\n",
+			 val);
+		voltdm->write(val, OMAP3_PRM_VOLTCTRL_OFFSET);
+	}
+	vc.voltctrl = val;
+
+	omap3_vc_set_pmic_signaling(PWRDM_POWER_ON);
+}
+
 /* Set oscillator setup time for omap3 */
 static void omap3_set_clksetup(u32 usec, struct voltagedomain *voltdm)
 {
@@ -292,7 +373,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 
 	/* check if sys_off_mode is used to control off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
-	if (!(val & OMAP3430_SEL_OFF_MASK)) {
+	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
 		/* No, omap is controlling them over I2C */
 		omap3_set_i2c_timings(voltdm, true);
 		return;
@@ -337,6 +418,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
+	omap3_vc_init_pmic_signaling(voltdm);
 	omap3_set_off_timings(voltdm);
 }
 
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 91c8d75..cdbdd78 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -117,6 +117,9 @@ extern struct omap_vc_param omap4_mpu_vc_data;
 extern struct omap_vc_param omap4_iva_vc_data;
 extern struct omap_vc_param omap4_core_vc_data;
 
+void omap3_vc_set_pmic_signaling(int core_next_state);
+
+
 void omap_vc_init_channel(struct voltagedomain *voltdm);
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
