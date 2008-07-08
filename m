From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 07/09] OPP and Frequency resource modeling
Date: Tue, 8 Jul 2008 17:09:31 +0530
Message-ID: <030e01c8e0ef$499869b0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:36455 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754679AbYGHLjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:39 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdW3U013247
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:38 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxM005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:31 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds OPP/Frequency resources to Shared Resource F/w

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/resource34xx.c |  101 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/resource34xx.h |   75 +++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-07-08 12:07:23.116783872 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-07-08 12:09:40.885367278 +0530
@@ -146,3 +146,104 @@ int set_pd_latency(struct shared_resourc
 	}
 	return 0;
 }
+
+static struct clk *vdd1_clk;
+static struct clk *vdd2_clk;
+static struct device dummy_srf_dev;
+
+/**
+ * init_opp - Initialize the OPP resource
+ */
+void init_opp(struct shared_resource *resp)
+{
+	resp->no_of_users = 0;
+	/* Initialize the current level of the OPP resource
+	* to the  opp set by u-boot.
+	*/
+	if (strcmp(resp->name, "vdd1_opp") == 0) {
+		resp->curr_level = curr_vdd1_prcm_set->opp;
+		vdd1_clk = clk_get(NULL, "virt_vdd1_prcm_set");
+	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
+		resp->curr_level = curr_vdd2_prcm_set->opp;
+		vdd2_clk = clk_get(NULL, "virt_vdd2_prcm_set");
+	}
+	return;
+}
+
+int set_opp(struct shared_resource *resp, u32 target_level)
+{
+#ifdef CONFIG_MACH_OMAP_3430SDP
+	unsigned long mpu_freq;
+	if (strcmp(resp->name, "vdd1_opp") == 0) {
+		mpu_freq = get_freq(vdd1_rate_table + MAX_VDD1_OPP,
+					target_level);
+		clk_set_rate(vdd1_clk, mpu_freq);
+		resp->curr_level = curr_vdd1_prcm_set->opp;
+	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
+		/* Not supported yet */
+	}
+#endif
+	return 0;
+}
+
+/**
+ * validate_opp - Validates if valid VDD1 OPP's are passed as the
+ * target_level.
+ * VDD2 OPP levels are passed as L3 throughput, which are then mapped
+ * to an appropriate OPP.
+ */
+int validate_opp(struct shared_resource *resp, u32 target_level)
+{
+	return 0;
+}
+
+/**
+ * init_freq - Initialize the frequency resource.
+ */
+void init_freq(struct shared_resource *resp)
+{
+#ifdef CONFIG_MACH_OMAP_3430SDP
+	char *linked_res_name;
+	resp->no_of_users = 0;
+
+	linked_res_name = (char *)resp->resource_data;
+	/* Initialize the current level of the Freq resource
+	* to the frequency set by u-boot.
+	*/
+	if (strcmp(resp->name, "mpu_freq") == 0)
+		/* MPU freq in Mhz */
+		resp->curr_level = curr_vdd1_prcm_set->speed;
+	else if (strcmp(resp->name, "dsp_freq") == 0)
+		/* DSP freq in Mhz */
+		resp->curr_level = get_freq(iva2_rate_table + MAX_VDD2_OPP,
+						curr_vdd1_prcm_set->opp);
+#endif
+	return;
+}
+
+int set_freq(struct shared_resource *resp, u32 target_level)
+{
+#ifdef CONFIG_MACH_OMAP_3430SDP
+	unsigned int vdd1_opp;
+
+	if (strcmp(resp->name, "mpu_freq") == 0)
+		vdd1_opp = get_opp(vdd1_rate_table + MAX_VDD1_OPP,
+							target_level);
+	else if (strcmp(resp->name, "dsp_freq") == 0)
+		vdd1_opp = get_opp(iva2_rate_table + MAX_VDD1_OPP,
+							target_level);
+
+	if (vdd1_opp == MIN_VDD1_OPP)
+		resource_release("vdd1_opp", &dummy_srf_dev);
+	else
+		resource_request("vdd1_opp", &dummy_srf_dev, vdd1_opp);
+
+	resp->curr_level = target_level;
+#endif
+	return 0;
+}
+
+int validate_freq(struct shared_resource *resp, u32 target_level)
+{
+	return 0;
+}
Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.h	2008-07-08 12:07:23.116783872 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h	2008-07-08 12:08:12.300207216 +0530
@@ -22,8 +22,17 @@
 #define __ARCH_ARM_MACH_OMAP2_RESOURCE_H
 
 #include <asm/arch/resource.h>
+#include <linux/clk.h>
+#include <asm/arch/clock.h>
 #include <asm/arch/powerdomain.h>
 
+extern struct vdd_prcm_config *curr_vdd1_prcm_set;
+extern struct vdd_prcm_config *curr_vdd2_prcm_set;
+extern unsigned int get_freq(struct  vdd_prcm_config *, unsigned long);
+extern unsigned int get_opp(struct vdd_prcm_config *, unsigned long);
+extern struct vdd_prcm_config vdd1_rate_table[];
+extern struct vdd_prcm_config vdd2_rate_table[];
+extern struct vdd_prcm_config iva2_rate_table[];
 /**
  * mpu_latency/core_latency are used to control the cpuidle C state.
  */
@@ -207,7 +216,68 @@ static struct shared_resource emu_pwrdm_
 	.ops		= &pd_lat_res_ops,
 };
 
+void init_opp(struct shared_resource *resp);
+int set_opp(struct shared_resource *resp, u32 target_level);
+int validate_opp(struct shared_resource *resp, u32 target_level);
+void init_freq(struct shared_resource *resp);
+int set_freq(struct shared_resource *resp, u32 target_level);
+int validate_freq(struct shared_resource *resp, u32 target_level);
+
+struct bus_throughput_db {
+	/* Throughput for each OPP/Freq of the bus */
+	unsigned long throughput[3];
+};
+
+static struct shared_resource_ops opp_res_ops = {
+	.init		= init_opp,
+	.change_level 	= set_opp,
+	.validate_level	= validate_opp,
+};
+
+static struct shared_resource vdd1_opp = {
+	.name           = "vdd1_opp",
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.ops		= &opp_res_ops,
+};
+
+/* Throughput in KiB/s */
+static struct bus_throughput_db l3_throughput_db = {
+	.throughput[0] = 0,
+	.throughput[1] = 100,
+	.throughput[2] = 250,
+};
+
+static struct shared_resource vdd2_opp = {
+	.name           = "vdd2_opp",
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.resource_data  = &l3_throughput_db,
+	.ops            = &opp_res_ops,
+};
+
+static char linked_res[] = "vdd1_opp";
+
+static struct shared_resource_ops freq_res_ops = {
+	.init		= init_freq,
+	.change_level 	= set_freq,
+	.validate_level	= validate_freq,
+};
+
+static struct shared_resource mpu_freq = {
+	.name           = "mpu_freq",
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.resource_data  = &linked_res,
+	.ops            = &freq_res_ops,
+};
+
+static struct shared_resource dsp_freq = {
+	.name           = "dsp_freq",
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.resource_data  = &linked_res,
+	.ops            = &freq_res_ops,
+};
+
 static struct shared_resource *resources_omap[] __initdata = {
+	/* mpu/core latency resources */
 	&mpu_latency,
 	&core_latency,
 	/* Power Domain Latency resources */
@@ -220,6 +290,11 @@ static struct shared_resource *resources
 	&neon_pwrdm_latency,
 	&usbhost_pwrdm_latency,
 	&emu_pwrdm_latency,
+	/* OPP/frequency resources */
+	&vdd1_opp,
+	&vdd2_opp,
+	&mpu_freq,
+	&dsp_freq,
 	NULL
 };
 

