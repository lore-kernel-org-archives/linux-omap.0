From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 06/11] omap3+: vc: use new vc_params and vp_params in parameter calculations
Date: Wed, 5 Oct 2011 20:17:06 +0300
Message-ID: <1317835031-8201-7-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33970 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934481Ab1JERRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:37 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHbvL019519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHapf027581
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:36 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHaDW001745
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:36 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |  166 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 138 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 16fa912..c50e598 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -1,14 +1,18 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
 #include <plat/cpu.h>
+#include <plat/prcm.h>
 
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "scrm44xx.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -194,44 +198,156 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
-static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
+static void omap3_set_ret_timings(struct voltagedomain *voltdm)
 {
-	/*
-	 * Voltage Manager FSM parameters init
-	 * XXX This data should be passed in from the board file
-	 */
-	voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET);
-	voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	unsigned long voltsetup1;
+	struct clk *sys_ck;
+	u32 sys_clk_rate;
+
+	sys_ck = clk_get(NULL, "sys_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: unable to get sys_ck to calculate "
+			"vdd_%s timings\n", __func__, voltdm->name);
+		return;
+	}
+	sys_clk_rate = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	voltsetup1 = (voltdm->vc_param->on - voltdm->vc_param->ret) /
+			voltdm->pmic->slew_rate;
+
+	voltsetup1 = voltsetup1 * sys_clk_rate / 8 / 1000000 + 1;
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
+		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
+		voltdm->vfsm->voltsetup_reg);
+
+	/* set voltsetup 2 to 0 */
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+}
+
+static void omap3_set_off_timings(struct voltagedomain *voltdm)
+{
+	unsigned long clksetup;
+	unsigned long voltsetup2;
+
+	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
+
+	/* voltsetup 2 in us */
+	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
+
+	/* convert to 32k clk cycles */
+	voltsetup2 = voltsetup2 * 32768 / 1000000 + 1;
+
+	voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	/* set voltsetup1 to 0 */
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
+		voltdm->vfsm->voltsetup_reg);
+
+	/* set voltoffset */
+	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
+	omap3_set_off_timings(voltdm);
+}
 
-	if (is_initialized)
-		return;
+static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
+		u32 clk_rate)
+{
+	u32 prescaler;
+	u32 cycles;
+	u32 time;
+
+	time = voltage_diff / voltdm->pmic->slew_rate;
+
+	cycles = clk_rate / 1000 * time;
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
+		pr_warning("%s: invalid setuptime for vdd_%s\n", __func__,
+			voltdm->name);
+		return 0;
+	}
 
-	omap3_vfsm_init(voltdm);
+	cycles++;
 
-	is_initialized = true;
+	return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
+		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
 }
 
+static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
+{
+	struct clk *sys_ck;
+	u32 sys_clk_rate;
+	u32 val;
+	u32 ramp;
+
+	sys_ck = clk_get(NULL, "sys_clkin_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: unable to get sys_ck to calculate "
+			"vdd_%s timings\n", __func__, voltdm->name);
+		return;
+	}
+	sys_clk_rate = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	/* configure the setup times */
+	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
+
+	if (off_mode)
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->off,
+			sys_clk_rate);
+	else
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->ret,
+			sys_clk_rate);
+
+	if (!ramp)
+		return;
+
+	val |= ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+
+	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
+
+	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+}
 
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
 	u32 vc_val;
 
-	if (is_initialized)
-		return;
+	omap4_set_timings(voltdm, true);
 
 	/* XXX These are magic numbers and do not belong! */
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
-
-	is_initialized = true;
 }
 
 /**
@@ -305,7 +421,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
 	vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
 	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
-	vc->setup_time = voltdm->pmic->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -329,10 +444,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
-	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
-	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
-	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
+	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->on);
+	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->onlp);
+	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->ret);
+	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->off);
 	val = ((on_vsel << vc->common->cmd_on_shift) |
 	       (onlp_vsel << vc->common->cmd_onlp_shift) |
 	       (ret_vsel << vc->common->cmd_ret_shift) |
@@ -343,11 +458,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
 
-	/* Configure the setup times */
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
-		    voltdm->vfsm->voltsetup_reg);
-
 	omap_vc_i2c_init(voltdm);
 
 	if (cpu_is_omap34xx())
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

