From: Sanjeev Premi <premi@ti.com>
Subject: [RFC 2/3] am35xx: voltage: Add basic initialization
Date: Wed, 23 Feb 2011 23:28:32 +0530
Message-ID: <1298483913-20344-3-git-send-email-premi@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304Ab1BWR6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 12:58:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NHwfxY004046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:58:43 -0600
In-Reply-To: <1298483913-20344-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds basic initialization in
the voltage layer for AM35xx processors.

In absence of AVS, functions vp_init() and
vc_init() are empty.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   45 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index bbc36e7..63dac11 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -194,6 +194,30 @@ static struct omap_vdd_info omap3_vdd_info[] = {
 
 #define OMAP3_NR_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
 
+/*
+ * AM3517 VDD structures
+ * TODO: The values in vp_offs are just a copy of OMAP3 for now.
+ *       Assignments need to be looked again; but appears that
+ *       they won't ever be used.
+ */
+static struct omap_vdd_info am3517_vdd_info[] = {
+        {
+                .vp_offs = {
+                        .vpconfig       = OMAP3_PRM_VP1_CONFIG_OFFSET,
+                        .vstepmin       = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
+                        .vstepmax       = OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
+                        .vlimitto       = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
+                        .vstatus        = OMAP3_PRM_VP1_STATUS_OFFSET,
+                        .voltage        = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
+                },
+                .voltdm = {
+                        .name = "mpu",
+                },
+        },
+};
+
+#define AM3517_NR_SCALABLE_VDD 0
+
 /* OMAP4 VDD sturctures */
 static struct omap_vdd_info omap4_vdd_info[] = {
 	{
@@ -1551,11 +1575,30 @@ int __init omap_voltage_late_init(void)
 }
 
 /**
+ * AM35xx - dummy initialization of voltage controller
+ */
+static void __init am3517_vc_init(struct omap_vdd_info *vdd)
+{
+}
+/**
+ * AM35xx - dummy initialization of voltage processor
+ */
+static void __init am3517_vp_init(struct omap_vdd_info *vdd)
+{
+}
+
+/**
  * omap_voltage_early_init()- Volatage driver early init
  */
 static int __init omap_voltage_early_init(void)
 {
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		vdd_info	= am3517_vdd_info;
+		nr_scalable_vdd	= AM3517_NR_SCALABLE_VDD;
+		vc_init		= am3517_vc_init;
+		vp_init		= am3517_vp_init;
+		vdd_data_configure = omap3_vdd_data_configure;
+	} else if (cpu_is_omap34xx()) {
 		vdd_info = omap3_vdd_info;
 		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
 		vc_init = omap3_vc_init;
-- 
1.7.2.2

