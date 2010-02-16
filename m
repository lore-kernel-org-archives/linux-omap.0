From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: add regulator board data for TWL6030
Date: Tue, 16 Feb 2010 21:11:34 +0530
Message-ID: <1266334896-30686-22-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-14-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-17-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-18-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-19-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-20-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-21-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0BPPnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:43:10 -0500
In-Reply-To: <1266334896-30686-21-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Balaji T K <balajitk@ti.com>

add TWL6030 regulator board data in board-4430sdp.c

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |  161 +++++++++++++++++++++++++++++++++++
 1 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ad0a9a5..cbdbfa4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -49,6 +50,25 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
+
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
+	{
+		.supply = "vmmc",
+	},
+	{
+		.supply = "vmmc",
+	},
+	{
+		.supply = "vmmc",
+	},
+	{
+		.supply = "vmmc",
+	},
+	{
+		.supply = "vmmc",
+	},
+};
+
 static void __init gic_init_irq(void)
 {
 	void __iomem *base;
@@ -82,9 +102,150 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct regulator_init_data sdp4430_vaux1 = {
+	.constraints = {
+		.min_uV		 	= 1000000,
+		.max_uV		 	= 3000000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vaux2 = {
+	.constraints = {
+		.min_uV		 	= 1200000,
+		.max_uV		 	= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vaux3 = {
+	.constraints = {
+		.min_uV		 	= 1000000,
+		.max_uV		 	= 3000000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VMMC1 for MMC1 card */
+static struct regulator_init_data sdp4430_vmmc = {
+	.constraints = {
+		.min_uV		 	= 1200000,
+		.max_uV		 	= 3000000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 5,
+	.consumer_supplies      = sdp4430_vmmc_supply,
+};
+
+static struct regulator_init_data sdp4430_vpp = {
+	.constraints = {
+		.min_uV		 	= 1800000,
+		.max_uV		 	= 2500000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vusim = {
+	.constraints = {
+		.min_uV		 	= 1200000,
+		.max_uV		 	= 2900000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vana = {
+	.constraints = {
+		.min_uV		 	= 2100000,
+		.max_uV		 	= 2100000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vcxio = {
+	.constraints = {
+		.min_uV		 	= 1800000,
+		.max_uV		 	= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vdac = {
+	.constraints = {
+		.min_uV		 	= 1800000,
+		.max_uV		 	= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sdp4430_vusb = {
+	.constraints = {
+		.min_uV		 	= 3300000,
+		.max_uV		 	= 3300000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
+
+	/* Regulators */
+	.vmmc		= &sdp4430_vmmc,
+	.vpp		= &sdp4430_vpp,
+	.vusim		= &sdp4430_vusim,
+	.vana		= &sdp4430_vana,
+	.vcxio		= &sdp4430_vcxio,
+	.vdac		= &sdp4430_vdac,
+	.vusb		= &sdp4430_vusb,
+	.vaux1		= &sdp4430_vaux1,
+	.vaux2		= &sdp4430_vaux2,
+	.vaux3		= &sdp4430_vaux3,
 };
 
 static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
-- 
1.6.0.4

