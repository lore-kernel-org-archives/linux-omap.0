From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 3/7] 3430SDP init updates
Date: Tue, 20 Jan 2009 02:49:36 -0800
Message-ID: <200901200249.36448.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44266 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756487AbZATLBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:20 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

OMAP 3430 SDP init updates:

 - Provide a more correct address for the Ethernet chip, getting
   rid of a warning during system boot
 - Hook up the various MMC card cage switches (init MMC later)
 - Configure pullups on the unused twl4030 GPIOs
 - Set up the GPIOs coupled to the (optional) SPI display
 - Initialize various regulators

Note that some SDP boards (all rev2 versions?) use a twl5030 not
the older twl4030 chip.  This isn't changed here.  It'd be a bit of
work to detect (fetch configuration data from the FPGA), and doesn't
much matter since the main change would be that VAUX2 could support
more voltages, but it's supposed to be fixed at 2.8V.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-3430sdp.c |  182 ++++++++++++++++++++++++++++++----
 1 file changed, 161 insertions(+), 21 deletions(-)

--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -23,6 +23,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -58,8 +59,6 @@
 
 static struct resource sdp3430_smc91x_resources[] = {
 	[0] = {
-		.start	= OMAP34XX_ETHR_START,
-		.end	= OMAP34XX_ETHR_START + SZ_4K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -260,8 +259,8 @@ static inline void __init sdp3430_init_s
 		return;
 	}
 
-	sdp3430_smc91x_resources[0].start = cs_mem_base + 0x0;
-	sdp3430_smc91x_resources[0].end   = cs_mem_base + 0xf;
+	sdp3430_smc91x_resources[0].start = cs_mem_base + 0x300;
+	sdp3430_smc91x_resources[0].end   = cs_mem_base + 0x30f;
 	udelay(100);
 
 	if (omap_rev() > OMAP3430_REV_ES1_0)
@@ -316,10 +315,51 @@ static struct twl4030_bci_platform_data 
       .tblsize		= ARRAY_SIZE(sdp3430_batt_table),
 };
 
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		/* 8 bits (default) requires S6.3 == ON,
+		 * so the SIM card isn't used; else 4 bits.
+		 */
+		.wires		= 8,
+		.gpio_wp	= 4,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 8,
+		.gpio_wp	= 7,
+	},
+	{}	/* Terminator */
+};
+
+static int sdp3430_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* gpio + 0 is "mmc0_cd" (input/IRQ),
+	 * gpio + 1 is "mmc1_cd" (input/IRQ)
+	 */
+	mmc[0].gpio_cd = gpio + 0;
+	mmc[1].gpio_cd = gpio + 1;
+	twl4030_mmc_init(mmc);
+
+	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
+	gpio_request(gpio + 7, "sub_lcd_en_bkl");
+	gpio_direction_output(gpio + 7, 0);
+
+	/* gpio + 15 is "sub_lcd_nRST" (output) */
+	gpio_request(gpio + 15, "sub_lcd_nRST");
+	gpio_direction_output(gpio + 15, 0);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
+				| BIT(16) | BIT(17),
+	.setup		= sdp3430_twl_gpio_setup,
 };
 
 static struct twl4030_usb_data sdp3430_usb_data = {
@@ -411,6 +451,111 @@ static struct twl4030_power_data sdp3430
 	.size		= ARRAY_SIZE(twl4030_scripts),
 };
 
+/*
+ * Apply all the fixed voltages since most versions of U-Boot
+ * don't bother with that initialization.
+ */
+
+/* VAUX1 for mainboard (irda and sub-lcd) */
+static struct regulator_init_data sdp3430_vaux1 = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX2 for camera module */
+static struct regulator_init_data sdp3430_vaux2 = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX3 for LCD board */
+static struct regulator_init_data sdp3430_vaux3 = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX4 for OMAP VDD_CSI2 (camera) */
+static struct regulator_init_data sdp3430_vaux4 = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
+static struct regulator_init_data sdp3430_vmmc1 = {
+	.constraints = {
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VMMC2 for MMC2 card */
+static struct regulator_init_data sdp3430_vmmc2 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 1850000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
+static struct regulator_init_data sdp3430_vsim = {
+	.constraints = {
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VDAC for DSS driving S-Video */
+static struct regulator_init_data sdp3430_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -422,6 +567,15 @@ static struct twl4030_platform_data sdp3
 	.keypad		= &sdp3430_kp_data,
 	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
+
+	.vaux1		= &sdp3430_vaux1,
+	.vaux2		= &sdp3430_vaux2,
+	.vaux3		= &sdp3430_vaux3,
+	.vaux4		= &sdp3430_vaux4,
+	.vmmc1		= &sdp3430_vmmc1,
+	.vmmc2		= &sdp3430_vmmc2,
+	.vsim		= &sdp3430_vsim,
+	.vdac		= &sdp3430_vdac,
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
@@ -435,29 +589,16 @@ static struct i2c_board_info __initdata 
 
 static int __init omap3430_i2c_init(void)
 {
+	/* i2c1 for PMIC only */
 	omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
 			ARRAY_SIZE(sdp3430_i2c_boardinfo));
+	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
 	omap_register_i2c_bus(2, 400, NULL, 0);
+	/* i2c3 on display connector (for DVI, tfp410) */
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 8,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{
-		.mmc		= 2,
-		.wires		= 8,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-
 extern void __init sdp3430_flash_init(void);
 
 static void __init omap_3430sdp_init(void)
@@ -479,7 +620,6 @@ static void __init omap_3430sdp_init(voi
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init();
-	twl4030_mmc_init(mmc);
 }
 
 static void __init omap_3430sdp_map_io(void)
