From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: SRF: Fix latency resource target value computations
Date: Tue,  6 Oct 2009 18:50:13 +0530
Message-ID: <1254835213-19453-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60198 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225AbZJFNU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 09:20:57 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n96DKFNO023912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Oct 2009 08:20:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The Shared resource framework currently considers the highest requested
level for a resource as the target level to be set. This works for OPP
and frequency resources as they are used to model performace based
constraints. However for latency based constraints/resources the least requested
level should be the one considered for the target level. This patch fixes
the issue by having an additional flag to identify the different types
of resources. Currently supported ones are Performace resources and
latency resources.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c         |    4 ++--
 arch/arm/mach-omap2/resource34xx.h         |   16 ++++++++++++++++
 arch/arm/plat-omap/include/mach/resource.h |    9 ++++++++-
 arch/arm/plat-omap/resource.c              |   20 ++++++++++++++------
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 491e1dc..e1a540e 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -41,7 +41,7 @@
 void init_latency(struct shared_resource *resp)
 {
 	resp->no_of_users = 0;
-	resp->curr_level = RES_DEFAULTLEVEL;
+	resp->curr_level = RES_LATENCY_DEFAULTLEVEL;
 	*((u8 *)resp->resource_data) = 0;
 	return;
 }
@@ -65,7 +65,7 @@ int set_latency(struct shared_resource *resp, u32 latency)
 		resp->curr_level = latency;
 
 	pm_qos_req_added = resp->resource_data;
-	if (latency == RES_DEFAULTLEVEL)
+	if (latency == RES_LATENCY_DEFAULTLEVEL)
 		/* No more users left, remove the pm_qos_req if present */
 		if (*pm_qos_req_added) {
 			pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index 3c70eef..918a76c 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -49,6 +49,7 @@ static struct shared_resource_ops lat_res_ops = {
 static struct shared_resource mpu_latency = {
 	.name 		= "mpu_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data  = &mpu_qos_req_added,
 	.ops 		= &lat_res_ops,
 };
@@ -56,6 +57,7 @@ static struct shared_resource mpu_latency = {
 static struct shared_resource core_latency = {
 	.name 		= "core_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &core_qos_req_added,
 	.ops 		= &lat_res_ops,
 };
@@ -91,6 +93,7 @@ static struct shared_resource_ops pd_lat_res_ops = {
 static struct shared_resource core_pwrdm_latency = {
 	.name		= "core_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &core_qos_req_added,
 	.ops		= &lat_res_ops,
 };
@@ -106,6 +109,7 @@ static struct pd_latency_db iva2_pwrdm_lat_db = {
 static struct shared_resource iva2_pwrdm_latency = {
 	.name		= "iva2_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &iva2_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -129,6 +133,7 @@ static struct pd_latency_db sgx_pwrdm_lat_db = {
 static struct shared_resource gfx_pwrdm_latency = {
 	.name		= "gfx_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &gfx_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -136,6 +141,7 @@ static struct shared_resource gfx_pwrdm_latency = {
 static struct shared_resource sgx_pwrdm_latency = {
 	.name 		= "sgx_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data  = &sgx_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -151,6 +157,7 @@ static struct pd_latency_db dss_pwrdm_lat_db = {
 static struct shared_resource dss_pwrdm_latency = {
 	.name		= "dss_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &dss_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -166,6 +173,7 @@ static struct pd_latency_db cam_pwrdm_lat_db = {
 static struct shared_resource cam_pwrdm_latency = {
 	.name		= "cam_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &cam_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -181,6 +189,7 @@ static struct pd_latency_db per_pwrdm_lat_db = {
 static struct shared_resource per_pwrdm_latency = {
 	.name		= "per_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &per_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -196,6 +205,7 @@ static struct pd_latency_db neon_pwrdm_lat_db = {
 static struct shared_resource neon_pwrdm_latency = {
 	.name		= "neon_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data	= &neon_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -211,6 +221,7 @@ static struct pd_latency_db usbhost_pwrdm_lat_db = {
 static struct shared_resource usbhost_pwrdm_latency = {
 	.name		= "usbhost_pwrdm_latency",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data  = &usbhost_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -226,6 +237,7 @@ static struct pd_latency_db emu_pwrdm_lat_db = {
 static struct shared_resource emu_pwrdm_latency = {
 	.name           = "emu_pwrdm",
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_LATENCY,
 	.resource_data  = &emu_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -251,6 +263,7 @@ static struct shared_resource_ops opp_res_ops = {
 static struct shared_resource vdd1_opp = {
 	.name           = "vdd1_opp",
 	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags          = RES_TYPE_PERFORMANCE,
 	.ops            = &opp_res_ops,
 };
 
@@ -264,6 +277,7 @@ static struct bus_throughput_db l3_throughput_db = {
 static struct shared_resource vdd2_opp = {
 	.name           = "vdd2_opp",
 	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags          = RES_TYPE_PERFORMANCE,
 	.resource_data  = &l3_throughput_db,
 	.ops            = &opp_res_ops,
 };
@@ -279,6 +293,7 @@ static struct shared_resource_ops freq_res_ops = {
 static struct shared_resource mpu_freq = {
 	.name           = "mpu_freq",
 	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_PERFORMANCE,
 	.resource_data  = &linked_res,
 	.ops            = &freq_res_ops,
 };
@@ -286,6 +301,7 @@ static struct shared_resource mpu_freq = {
 static struct shared_resource dsp_freq = {
 	.name           = "dsp_freq",
 	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= RES_TYPE_PERFORMANCE,
 	.resource_data  = &linked_res,
 	.ops            = &freq_res_ops,
 };
diff --git a/arch/arm/plat-omap/include/mach/resource.h b/arch/arm/plat-omap/include/mach/resource.h
index f91d8ce..46b942f 100644
--- a/arch/arm/plat-omap/include/mach/resource.h
+++ b/arch/arm/plat-omap/include/mach/resource.h
@@ -25,7 +25,12 @@
 #include <linux/device.h>
 #include <mach/cpu.h>
 
-#define RES_DEFAULTLEVEL	0x0
+#define RES_PERFORMANCE_DEFAULTLEVEL	0
+#define RES_LATENCY_DEFAULTLEVEL	-1
+
+/* Types of resources */
+#define RES_TYPE_PERFORMANCE	0x1
+#define RES_TYPE_LATENCY	0x2
 
 struct shared_resource_ops; /* forward declaration */
 
@@ -35,6 +40,8 @@ struct shared_resource {
 	char *name;
 	/* Used to represent the OMAP chip types containing this res */
 	const struct omap_chip_id omap_chip;
+	/* Resource type flags */
+	const u8 flags;
 	/* Total no of users at any point of this resource */
 	u8 no_of_users;
 	/* Current level of this resource */
diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index dbbc763..ac19aa2 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -106,10 +106,20 @@ static int update_resource_level(struct shared_resource *resp)
 	int ret;
 
 	/* Regenerate the target_value for the resource */
-	target_level = RES_DEFAULTLEVEL;
-	list_for_each_entry(user, &resp->users_list, node)
-		if (user->level > target_level)
-			target_level = user->level;
+	if (resp->flags & RES_TYPE_PERFORMANCE) {
+		target_level = RES_PERFORMANCE_DEFAULTLEVEL;
+		list_for_each_entry(user, &resp->users_list, node)
+			if (user->level > target_level)
+				target_level = user->level;
+	} else if (resp->flags & RES_TYPE_LATENCY) {
+		target_level = RES_LATENCY_DEFAULTLEVEL;
+		list_for_each_entry(user, &resp->users_list, node)
+			if (user->level < target_level)
+				target_level = user->level;
+	} else {
+		pr_debug("SRF: Unknown resource type\n");
+		return -EINVAL;
+	}
 
 	pr_debug("SRF: Changing Level for resource %s to %ld\n",
 				resp->name, target_level);
@@ -182,7 +192,6 @@ void free_user(struct users_list *user)
 		kfree(user);
 	} else {
 		user->usage = UNUSED;
-		user->level = RES_DEFAULTLEVEL;
 		user->dev = NULL;
 	}
 }
@@ -213,7 +222,6 @@ void resource_init(struct shared_resource **resources)
 	for (ind = 0; ind < MAX_USERS; ind++) {
 		usr_list[ind].usage = UNUSED;
 		usr_list[ind].dev = NULL;
-		usr_list[ind].level = RES_DEFAULTLEVEL;
 	}
 
 	if (resources)
-- 
1.5.4.7

