From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 06/08] OMAP3: SR: Replace printk's with pr_* calls
Date: Tue, 24 Mar 2009 16:25:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757194AbZCXKzq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:55:46 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OAtckl026592
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:55:44 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OAtceg026497
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:25:38 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Rajendra Nayak <rnayak@ti.com>

This patch replaces all the printk(KERN_* with pr_* calls.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:41:06.054889481 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:41:21.798416209 +0530
@@ -78,7 +78,7 @@
 static int sr_clk_enable(struct omap_sr *sr)
 {
 	if (clk_enable(sr->clk) != 0) {
-		printk(KERN_ERR "Could not enable %s\n", sr->clk->name);
+		pr_err("Could not enable %s\n", sr->clk->name);
 		return -1;
 	}
 
@@ -170,7 +170,7 @@
 		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
 		break;
 	default :
-		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk_speed);
+		pr_err("Invalid sysclk value: %d\n", sys_clk_speed);
 		break;
 	}
 }
@@ -409,7 +409,7 @@
 	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
 		loop_cnt++;
 		if (retries_cnt > 10) {
-			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
 			return SR_FAIL;
 		}
@@ -474,7 +474,7 @@
 	}
 
 	if (nvalue_reciprocal == 0) {
-		printk(KERN_NOTICE "OPP%d doesn't support SmartReflex\n",
+		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
 		return SR_FALSE;
 	}
@@ -563,12 +563,12 @@
 	}
 
 	if (sr->is_autocomp_active == 1)
-		printk(KERN_WARNING "SR%d: VDD autocomp is already active\n",
+		pr_warning("SR%d: VDD autocomp is already active\n",
 									srid);
 
 	sr->is_autocomp_active = 1;
 	if (!sr_enable(sr, target_opp_no)) {
-		printk(KERN_WARNING "SR%d: VDD autocomp not activated\n", srid);
+		pr_warning("SR%d: VDD autocomp not activated\n", srid);
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
@@ -593,7 +593,7 @@
 		sr_reset_voltage(srid);
 		return SR_TRUE;
 	} else {
-		printk(KERN_WARNING "SR%d: VDD autocomp is not active\n",
+		pr_warning("SR%d: VDD autocomp is not active\n",
 								srid);
 		return SR_FALSE;
 	}
@@ -709,7 +709,7 @@
 	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
 		loop_cnt++;
 		if (retries_cnt > 10) {
-			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
 			return SR_FAIL;
 		}
@@ -749,7 +749,7 @@
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
-		printk(KERN_ERR "sr_vdd1_autocomp: Invalid value\n");
+		pr_err("sr_vdd1_autocomp: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -787,7 +787,7 @@
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
-		printk(KERN_ERR "sr_vdd2_autocomp: Invalid value\n");
+		pr_err("sr_vdd2_autocomp: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -839,15 +839,15 @@
 	sr_set_nvalues(&sr2);
 	sr_configure_vp(SR2);
 
-	printk(KERN_INFO "SmartReflex driver initialized\n");
+	pr_info("SmartReflex driver initialized\n");
 
 	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
 	if (ret)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+		pr_err("sysfs_create_file failed: %d\n", ret);
 
 	ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
 	if (ret)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+		pr_err("sysfs_create_file failed: %d\n", ret);
 
 	return 0;
 }
