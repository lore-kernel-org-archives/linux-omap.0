From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 07/08] OMAP3: SR: Remove redundunt defines
Date: Tue, 24 Mar 2009 16:18:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9A4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755109AbZCXKst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:48:49 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OAmfmF022158
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:48:47 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OAmfHV025278
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:18:41 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch removes the local defines (PRCM_VDD1/2) in smartreflex
driver and uses the already existing global definitions (VDD1_OPP/VDD2_OPP)
from omap34xx.h file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/resource34xx.c |    6 +++---
 arch/arm/mach-omap2/smartreflex.c  |    8 ++++----
 arch/arm/mach-omap2/smartreflex.h  |    3 ---
 3 files changed, 7 insertions(+), 10 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.c	2009-03-24 14:25:28.045987206 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.c	2009-03-24 14:41:36.122985549 +0530
@@ -217,7 +217,7 @@
 		/* Send pre notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
 #endif
-		t_opp = ID_VDD(PRCM_VDD1) |
+		t_opp = ID_VDD(VDD1_OPP) |
 			ID_OPP_NO(mpu_opps[target_level].opp_id);
 
 		/* For VDD1 OPP3 and above, make sure the interconnect
@@ -257,7 +257,7 @@
 			return 0;
 		l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
 					target_level);
-		t_opp = ID_VDD(PRCM_VDD2) |
+		t_opp = ID_VDD(VDD2_OPP) |
 			ID_OPP_NO(l3_opps[target_level].opp_id);
 		if (resp->curr_level > target_level) {
 			/* Scale Frequency and then voltage */
@@ -278,7 +278,7 @@
 			if (ret) {
 #ifdef CONFIG_OMAP_SMARTREFLEX
 				/* Setting clock failed, revert voltage */
-				t_opp = ID_VDD(PRCM_VDD2) |
+				t_opp = ID_VDD(VDD2_OPP) |
 					ID_OPP_NO(l3_opps[resp->curr_level].
 							opp_id);
 				sr_voltagescale_vcbypass(t_opp,
Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:41:21.798416209 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:41:36.123985519 +0530
@@ -677,7 +677,7 @@
 	vdd = get_vdd(target_opp);
 	target_opp_no = get_opp_no(target_opp);
 
-	if (vdd == PRCM_VDD1) {
+	if (vdd == VDD1_OPP) {
 		sr_status = sr_stop_vddautocomap(SR1);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -686,7 +686,7 @@
 					OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
 		reg_addr = R_VDD1_SR_CONTROL;
 
-	} else if (vdd == PRCM_VDD2) {
+	} else if (vdd == VDD2_OPP) {
 		sr_status = sr_stop_vddautocomap(SR2);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -725,9 +725,9 @@
 	udelay(T2_SMPS_UPDATE_DELAY);
 
 	if (sr_status) {
-		if (vdd == PRCM_VDD1)
+		if (vdd == VDD1_OPP)
 			sr_start_vddautocomap(SR1, target_opp_no);
-		else if (vdd == PRCM_VDD2)
+		else if (vdd == VDD2_OPP)
 			sr_start_vddautocomap(SR2, target_opp_no);
 	}
 
Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.h	2009-03-24 14:25:28.046987177 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.h	2009-03-24 14:41:36.123985519 +0530
@@ -171,9 +171,6 @@
 /* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
 #define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
 
-/* VDDs*/
-#define PRCM_VDD1	1
-#define PRCM_VDD2	2
 #define PRCM_MAX_SYSC_REGS 30
 
 /*
