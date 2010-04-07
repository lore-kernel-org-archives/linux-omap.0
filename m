From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/6] omap4: add i2c1 peripherals data
Date: Wed,  7 Apr 2010 13:17:25 +0530
Message-ID: <1270626446-10841-6-git-send-email-santosh.shilimkar@ti.com>
References: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-4-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-5-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab0DGHrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 03:47:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o377lUS2022657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 02:47:32 -0500
In-Reply-To: <1270626446-10841-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch adds i2c1 peripherals data to
omap4430 sdp board file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |  179 ++++++++++++++++++++++++++++++++++-
 1 files changed, 178 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b6c9446..32cbd72 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -18,6 +18,8 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
+#include <linux/i2c/twl.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -78,6 +80,25 @@ static int __init omap_l2_cache_init(void)
 early_initcall(omap_l2_cache_init);
 #endif
 
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
@@ -111,10 +132,166 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct regulator_init_data sdp4430_vaux1 = {
+	.constraints = {
+		.min_uV			= 1000000,
+		.max_uV			= 3000000,
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
+		.min_uV			= 1200000,
+		.max_uV			= 2800000,
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
+		.min_uV			= 1000000,
+		.max_uV			= 3000000,
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
+		.min_uV			= 1200000,
+		.max_uV			= 3000000,
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
+		.min_uV			= 1800000,
+		.max_uV			= 2500000,
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
+		.min_uV			= 1200000,
+		.max_uV			= 2900000,
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
+		.min_uV			= 2100000,
+		.max_uV			= 2100000,
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
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
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
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
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
+		.min_uV			= 3300000,
+		.max_uV			= 3300000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct twl4030_platform_data sdp4430_twldata = {
+	.irq_base	= TWL6030_IRQ_BASE,
+	.irq_end	= TWL6030_IRQ_END,
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
+};
+
+static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl6030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = OMAP44XX_IRQ_SYS_1N,
+		.platform_data = &sdp4430_twldata,
+	},
+};
+
 static int __init omap4_i2c_init(void)
 {
 	/* Phoenix Audio IC needs I2C1 to start with 400 KHz and less */
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	omap_register_i2c_bus(4, 400, NULL, 0);
-- 
1.6.0.4

