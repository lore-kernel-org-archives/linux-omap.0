From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v7 5/8] omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure
Date: Thu,  1 Jul 2010 15:42:02 +0530
Message-ID: <1277979122-2113-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59111 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab0GAKPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:15:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Renaming vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure,
since there is no VDD0. It's VDD1 voltage domain with processor voltage &
VDD2 voltage domain with CORE voltage.

VDD1 voltage specific values are stored in PRM_VC_CMD_VAL_0 register &
VDD2 voltage specific values are stored in PRM_VC_CMD_VAL_1 register.

PRM_VC_CMD_VAL_n (n = 0/1 for VDD1/VDD2):
ON_voltage[31:24], ONLP_voltage[23:16], RET_voltage[15:8], OFF_voltage[14:0]

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/voltage.c |   34 +++++++++++++++++-----------------
 arch/arm/mach-omap2/voltage.h |   10 +++++-----
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1be1ccf..a496d19 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -147,14 +147,14 @@ struct __initdata prm_setup_vc omap3430_vc_config = {
 		.voltoffset = 0x32,
 	},
 	/* VC COMMAND VALUES for VDD1/VDD2 */
-	.vdd0_on = 0x30,        /* 1.2v */
-	.vdd0_onlp = 0x20,      /* 1.0v */
-	.vdd0_ret = 0x1e,       /* 0.975v */
-	.vdd0_off = 0x00,       /* 0.6v */
-	.vdd1_on = 0x2c,        /* 1.15v */
+	.vdd1_on = 0x30,        /* 1.2v */
 	.vdd1_onlp = 0x20,      /* 1.0v */
-	.vdd1_ret = 0x1e,       /* .975v */
+	.vdd1_ret = 0x1e,       /* 0.975v */
 	.vdd1_off = 0x00,       /* 0.6v */
+	.vdd2_on = 0x2c,        /* 1.15v */
+	.vdd2_onlp = 0x20,      /* 1.0v */
+	.vdd2_ret = 0x1e,       /* 0.975v */
+	.vdd2_off = 0x00,       /* 0.6v */
 };
 
 /*
@@ -178,14 +178,14 @@ struct __initdata prm_setup_vc omap3630_vc_config = {
 		.voltoffset = 0x32,
 	},
 	/* VC COMMAND VALUES for VDD1/VDD2 */
-	.vdd0_on = 0x28,	/* 1.1v */
-	.vdd0_onlp = 0x20,	/* 1.0v */
-	.vdd0_ret = 0x13,	/* 0.83v */
-	.vdd0_off = 0x00,	/* 0.6v */
-	.vdd1_on = 0x2B,	/* 1.1375v */
+	.vdd1_on = 0x28,	/* 1.1v */
 	.vdd1_onlp = 0x20,	/* 1.0v */
 	.vdd1_ret = 0x13,	/* 0.83v */
 	.vdd1_off = 0x00,	/* 0.6v */
+	.vdd2_on = 0x2B,	/* 1.1375v */
+	.vdd2_onlp = 0x20,	/* 1.0v */
+	.vdd2_ret = 0x13,	/* 0.83v */
+	.vdd2_off = 0x00,	/* 0.6v */
 };
 
 static struct prm_setup_vc vc_config;
@@ -279,17 +279,17 @@ static void __init init_voltagecontroller(void)
 			VC_VOLRA0_SHIFT));
 
 	voltage_write_reg(vc_reg.cmdval0_reg,
-			(vc_config.vdd0_on << VC_CMD_ON_SHIFT) |
-			(vc_config.vdd0_onlp << VC_CMD_ONLP_SHIFT) |
-			(vc_config.vdd0_ret << VC_CMD_RET_SHIFT) |
-			(vc_config.vdd0_off << VC_CMD_OFF_SHIFT));
-
-	voltage_write_reg(vc_reg.cmdval1_reg,
 			(vc_config.vdd1_on << VC_CMD_ON_SHIFT) |
 			(vc_config.vdd1_onlp << VC_CMD_ONLP_SHIFT) |
 			(vc_config.vdd1_ret << VC_CMD_RET_SHIFT) |
 			(vc_config.vdd1_off << VC_CMD_OFF_SHIFT));
 
+	voltage_write_reg(vc_reg.cmdval1_reg,
+			(vc_config.vdd2_on << VC_CMD_ON_SHIFT) |
+			(vc_config.vdd2_onlp << VC_CMD_ONLP_SHIFT) |
+			(vc_config.vdd2_ret << VC_CMD_RET_SHIFT) |
+			(vc_config.vdd2_off << VC_CMD_OFF_SHIFT));
+
 	voltage_write_reg(vc_ch_conf_reg, VC_CMD1 | VC_RAV1);
 
 	voltage_write_reg(vc_i2c_cfg_reg, VC_MCODE_SHIFT | VC_HSEN);
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 9ca20e5..bfd5048 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -28,15 +28,15 @@ struct prm_setup_vc {
 	/* CLK & VOLT SETUPTIME for OFF */
 	struct setuptime_vc off;
 	/* PRM_VC_CMD_VAL_0 specific bits */
-	u16 vdd0_on;
-	u16 vdd0_onlp;
-	u16 vdd0_ret;
-	u16 vdd0_off;
-	/* PRM_VC_CMD_VAL_1 specific bits */
 	u16 vdd1_on;
 	u16 vdd1_onlp;
 	u16 vdd1_ret;
 	u16 vdd1_off;
+	/* PRM_VC_CMD_VAL_1 specific bits */
+	u16 vdd2_on;
+	u16 vdd2_onlp;
+	u16 vdd2_ret;
+	u16 vdd2_off;
 };
 
 #define VOLTSCALE_VPFORCEUPDATE		1
-- 
1.7.0.4

