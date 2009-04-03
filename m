From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 07/10] OMAP3: SR: Replace printk's with pr_* calls
Date: Fri, 3 Apr 2009 21:39:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C23@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935936AbZDCQJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:09:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33G9EZP023340
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:09:20 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33G9DNW014935
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:39:13 +0530 (IST)
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
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
@@ -77,7 +77,7 @@ static inline u32 sr_read_reg(struct oma
 static int sr_clk_enable(struct omap_sr *sr)
 {
 	if (clk_enable(sr->clk) != 0) {
-		printk(KERN_ERR "Could not enable %s\n", sr->clk->name);
+		pr_err("Could not enable %s\n", sr->clk->name);
 		return -1;
 	}
 
@@ -169,7 +169,7 @@ static void sr_set_clk_length(struct oma
 		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
 		break;
 	default :
-		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk_speed);
+		pr_err("Invalid sysclk value: %d\n", sys_clk_speed);
 		break;
 	}
 }
@@ -408,7 +408,7 @@ static int sr_reset_voltage(int srid)
 	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
 		loop_cnt++;
 		if (retries_cnt > 10) {
-			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
 			return SR_FAIL;
 		}
@@ -473,7 +473,7 @@ static int sr_enable(struct omap_sr *sr,
 	}
 
 	if (nvalue_reciprocal == 0) {
-		printk(KERN_NOTICE "OPP%d doesn't support SmartReflex\n",
+		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
 		return SR_FALSE;
 	}
@@ -562,12 +562,12 @@ void sr_start_vddautocomap(int srid, u32
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
@@ -592,7 +592,7 @@ int sr_stop_vddautocomap(int srid)
 		sr_reset_voltage(srid);
 		return SR_TRUE;
 	} else {
-		printk(KERN_WARNING "SR%d: VDD autocomp is not active\n",
+		pr_warning("SR%d: VDD autocomp is not active\n",
 								srid);
 		return SR_FALSE;
 	}
@@ -708,7 +708,7 @@ int sr_voltagescale_vcbypass(u32 target_
 	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
 		loop_cnt++;
 		if (retries_cnt > 10) {
-			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
 			return SR_FAIL;
 		}
@@ -748,7 +748,7 @@ static ssize_t omap_sr_vdd1_autocomp_sto
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
-		printk(KERN_ERR "sr_vdd1_autocomp: Invalid value\n");
+		pr_err("sr_vdd1_autocomp: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -786,7 +786,7 @@ static ssize_t omap_sr_vdd2_autocomp_sto
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
-		printk(KERN_ERR "sr_vdd2_autocomp: Invalid value\n");
+		pr_err("sr_vdd2_autocomp: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -838,15 +838,15 @@ static int __init omap3_sr_init(void)
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