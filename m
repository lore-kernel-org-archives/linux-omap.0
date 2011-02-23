From: Sanjeev Premi <premi@ti.com>
Subject: [RFC 1/3] omap: voltage: Allow custom vp_init() implementation
Date: Wed, 23 Feb 2011 23:28:31 +0530
Message-ID: <1298483913-20344-2-git-send-email-premi@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154Ab1BWR6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 12:58:43 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NHwep0004038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:58:42 -0600
In-Reply-To: <1298483913-20344-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Current implementation expects AVS to be available
on the processor - by default. May not be true.

This patch allows the vp_init() to be implemented
per processor (or family) - same as vc_init().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 12be525..bbc36e7 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -312,6 +312,8 @@ static struct dentry *voltage_dir;
 
 /* Init function pointers */
 static void (*vc_init) (struct omap_vdd_info *vdd);
+static void (*vp_init) (struct omap_vdd_info *vdd);
+
 static int (*vdd_data_configure) (struct omap_vdd_info *vdd);
 
 static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
@@ -416,7 +418,7 @@ static void vp_latch_vsel(struct omap_vdd_info *vdd)
 }
 
 /* Generic voltage init functions */
-static void __init vp_init(struct omap_vdd_info *vdd)
+static void __init omap_vp_init(struct omap_vdd_info *vdd)
 {
 	u32 vp_val;
 	u16 mod;
@@ -1557,11 +1559,13 @@ static int __init omap_voltage_early_init(void)
 		vdd_info = omap3_vdd_info;
 		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
 		vc_init = omap3_vc_init;
+		vp_init = omap_vp_init;
 		vdd_data_configure = omap3_vdd_data_configure;
 	} else if (cpu_is_omap44xx()) {
 		vdd_info = omap4_vdd_info;
 		nr_scalable_vdd = OMAP4_NR_SCALABLE_VDD;
 		vc_init = omap4_vc_init;
+		vp_init = omap_vp_init;
 		vdd_data_configure = omap4_vdd_data_configure;
 	} else {
 		pr_warning("%s: voltage driver support not added\n", __func__);
-- 
1.7.2.2

