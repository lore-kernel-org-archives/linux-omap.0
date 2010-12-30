From: sawant@ti.com
Subject: [PATCH] OMAP PM: Expose vc registers in debugfs
Date: Thu, 30 Dec 2010 17:34:29 +0530
Message-ID: <1293710669-3014-1-git-send-email-sawant@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab0L3MEs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Dec 2010 07:04:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBUC4i2L015968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 30 Dec 2010 06:04:46 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Sawant <sawant@ti.com>

From: Anand Sawant <sawant@ti.com>

This patch will expose the following voltage controller registers
as part of voltage layer debugfs.
1. PRM_VC_BYPASS_VAL
2. PRM_VC_CMD_VAL - for all VDDs

This patch will help in debugging voltage scaling issues.

Tested on Zoom3 & OMAP4430 SDP.

Patch rebased to latest Kevin's PM branch.

Signed-off-by: Anand S Sawant <sawant@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index ed6079c..a9b52e4 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -336,6 +336,11 @@ static void omap4_voltage_write_reg(u32 val, u16 mod, u8 offset)
 }
 
 /* Voltage debugfs support */
+
+/**
+ * Gets the current vp output voltage (auto-compensated) for the
+ * voltage domain.
+ */
 static int vp_volt_debug_get(void *data, u64 *val)
 {
 	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
@@ -359,6 +364,10 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	return 0;
 }
 
+/**
+ * Gets the current nominal OPP voltage (non auto-compensated) for the
+ * voltage domain.
+ */
 static int nom_volt_debug_get(void *data, u64 *val)
 {
 	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
@@ -456,6 +465,7 @@ static void __init vp_init(struct omap_vdd_info *vdd)
 	vdd->write_reg(vp_val, mod, vdd->vp_offs.vlimitto);
 }
 
+/* Creates debugfs entries for key vp & vc parameters */
 static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 {
 	char *name;
@@ -501,6 +511,11 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
 				vdd->debug_dir, (void *) vdd,
 				&nom_volt_debug_fops);
+
+	(void) debugfs_create_x8("vc_bypass_val", S_IRUGO, vdd->debug_dir,
+				&(vdd->vc_reg.bypass_val_reg));
+	(void) debugfs_create_x8("vc_cmdval", S_IRUGO, vdd->debug_dir,
+				&(vdd->vc_reg.cmdval_reg));
 }
 
 /* Voltage scale and accessory APIs */
-- 
1.7.0.4

