From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 09/09] voltage scaling support
Date: Tue, 8 Jul 2008 17:09:34 +0530
Message-ID: <031001c8e0ef$4b2b65c0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58806 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbYGHLjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdZu3001886
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:40 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxO005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:34 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds Voltage scaling support

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/board-3430sdp.c |   12 ++++++++++++
 arch/arm/mach-omap2/resource34xx.c  |   17 ++++++++++++++++-
 arch/arm/mach-omap2/resource34xx.h  |    3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-07-08 11:33:54.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-07-08 14:10:23.944803055 +0530
@@ -88,6 +88,18 @@ struct vdd_prcm_config iva2_rate_table[]
 	{S430M, VDD1_OPP5, 0},
 };
 
+u8 vdd1_volts[MAX_VDD1_OPP] = {
+	/* Vsel corresponding to 0.9V (OPP1), 1.00V (OPP2),
+	 * 1.20V (OPP3), 1.27V (OPP4), 1.35 (OPP5)
+	 */
+	0x18, 0x20, 0x30, 0x36, 0x3C
+};
+
+u8 vdd2_volts[MAX_VDD2_OPP] = {
+	/* Vsel corresponding to 0.9V (OPP1), 1.00V (OPP2), 1.15 (OPP3) */
+	0x18, 0x20, 0x2C
+};
+
 static struct resource sdp3430_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP34XX_ETHR_START,
Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-07-08 12:09:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-07-08 15:20:08.480788833 +0530
@@ -19,6 +19,7 @@
 #include <linux/pm_qos_params.h>
 #include <asm/arch/powerdomain.h>
 #include <asm/arch/clockdomain.h>
+#include "smartreflex.h"
 #include "resource34xx.h"
 
 /**
@@ -174,10 +175,24 @@ int set_opp(struct shared_resource *resp
 {
 #ifdef CONFIG_MACH_OMAP_3430SDP
 	unsigned long mpu_freq;
+
+	if (resp->curr_level == target_level)
+		return 0;
+
 	if (strcmp(resp->name, "vdd1_opp") == 0) {
 		mpu_freq = get_freq(vdd1_rate_table + MAX_VDD1_OPP,
 					target_level);
-		clk_set_rate(vdd1_clk, mpu_freq);
+		if (resp->curr_level > target_level) {
+			/* Scale Frequency and then voltage */
+			clk_set_rate(vdd1_clk, mpu_freq);
+			sr_voltagescale_vcbypass(PRCM_VDD1,
+					vdd1_volts[target_level-1]);
+		} else {
+			/* Scale Voltage and then frequency */
+			sr_voltagescale_vcbypass(PRCM_VDD1,
+					vdd1_volts[target_level-1]);
+			clk_set_rate(vdd1_clk, mpu_freq);
+		}
 		resp->curr_level = curr_vdd1_prcm_set->opp;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		/* Not supported yet */
Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.h	2008-07-08 12:08:12.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h	2008-07-08 14:17:35.407119891 +0530
@@ -33,6 +33,9 @@ extern unsigned int get_opp(struct vdd_p
 extern struct vdd_prcm_config vdd1_rate_table[];
 extern struct vdd_prcm_config vdd2_rate_table[];
 extern struct vdd_prcm_config iva2_rate_table[];
+extern u8 vdd1_volts[];
+extern u8 vdd2_volts[];
+extern int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
 /**
  * mpu_latency/core_latency are used to control the cpuidle C state.
  */

