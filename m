From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/13] omap4: add i2c1 peripherals data
Date: Mon, 17 May 2010 19:42:53 -0700
Message-ID: <20100518024253.21705.48677.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59003 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab0ERCm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:42:56 -0400
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch adds i2c1 peripherals data to
omap4430 sdp board file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |  177 +++++++++++++++++++++++++++++++++++
 1 files changed, 176 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 41fed92..921cde3 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -19,6 +19,8 @@
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/spi/spi.h>
+#include <linux/i2c/twl.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -135,13 +137,186 @@ static struct omap_musb_board_data musb_board_data = {
 	.mode			= MUSB_PERIPHERAL,
 	.power			= 100,
 };
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
 static int __init omap4_i2c_init(void)
 {
 	/*
 	 * Phoenix Audio IC needs I2C1 to
 	 * start with 400 KHz or less
 	 */
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
+			ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	omap_register_i2c_bus(4, 400, NULL, 0);

