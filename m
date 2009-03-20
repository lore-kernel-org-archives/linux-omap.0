From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 05/07] OMAP3: SR: Reset voltage level on SR disable
Date: Fri, 20 Mar 2009 18:02:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EEF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36682 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbZCTMcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 08:32:31 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KCWMp5012710
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 07:32:29 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KCWMcj023379
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:02:22 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch resets the voltage level for each OPP on SR disable.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   49 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:26.106235150 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:27.065205965 +0530
@@ -379,6 +379,51 @@ static void sr_configure(struct omap_sr 
 	sr->is_sr_reset = 0;
 }
 
+static int sr_reset_voltage(int srid)
+{
+	u32 target_opp_no, vsel = 0;
+	u32 reg_addr = 0;
+	u32 loop_cnt = 0, retries_cnt = 0;
+	u32 vc_bypass_value;
+
+	if (srid == SR1) {
+		target_opp_no = resource_get_level("vdd1_opp");
+		vsel = mpu_opps[target_opp_no].vsel;
+		reg_addr = R_VDD1_SR_CONTROL;
+	} else if (srid == SR2) {
+		target_opp_no = resource_get_level("vdd2_opp");
+		vsel = l3_opps[target_opp_no].vsel;
+		reg_addr = R_VDD2_SR_CONTROL;
+	}
+
+	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
+			(reg_addr << OMAP3430_REGADDR_SHIFT) |
+			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
+
+	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
+			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
+		loop_cnt++;
+		if (retries_cnt > 10) {
+			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+								"write\n");
+			return SR_FAIL;
+		}
+		if (loop_cnt > 50) {
+			retries_cnt++;
+			loop_cnt = 0;
+			udelay(10);
+		}
+		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+	}
+	return SR_PASS;
+}
+
 static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 {
 	u32 nvalue_reciprocal, v;
@@ -541,6 +586,8 @@ int sr_stop_vddautocomap(int srid)
 		sr_disable(sr);
 		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
+		/* Reset the volatage for current OPP */
+		sr_reset_voltage(srid);
 		return SR_TRUE;
 	} else {
 		printk(KERN_WARNING "SR%d: VDD autocomp is not active\n",
@@ -609,6 +656,8 @@ void disable_smartreflex(int srid)
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VP2_CONFIG_OFFSET);
 			}
+			/* Reset the volatage for current OPP */
+			sr_reset_voltage(srid);
 		}
 	}
 }