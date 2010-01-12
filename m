From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv2 4/4] Regulator: OMAP: Use common regulator supplies and init data structs
Date: Tue, 12 Jan 2010 14:44:08 +0530
Message-ID: <1263287648-10248-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab0ALJOR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 04:14:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Removing the common supplies and regulator init data structs for various
OMAP3 platforms and referring them from the twl4030 common file.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |  135 ++-----------------------
 arch/arm/mach-omap2/board-cm-t35.c           |   47 +--------
 arch/arm/mach-omap2/board-igep0020.c         |   24 +----
 arch/arm/mach-omap2/board-ldp.c              |   24 +----
 arch/arm/mach-omap2/board-omap3beagle.c      |   47 +--------
 arch/arm/mach-omap2/board-omap3evm.c         |   47 +--------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   47 +--------
 arch/arm/mach-omap2/board-overo.c            |   23 +----
 arch/arm/mach-omap2/board-zoom-peripherals.c |   71 ++------------
 9 files changed, 47 insertions(+), 418 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..39860fb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -44,6 +44,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -343,18 +344,6 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp3430_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply sdp3430_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-static struct regulator_consumer_supply sdp3430_vmmc2_supply = {
-	.supply			= "vmmc",
-};
-
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -368,9 +357,9 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	 */
-	sdp3430_vmmc1_supply.dev = mmc[0].dev;
-	sdp3430_vsim_supply.dev = mmc[0].dev;
-	sdp3430_vmmc2_supply.dev = mmc[1].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc2_supply.dev = mmc[1].dev;
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request(gpio + 7, "sub_lcd_en_bkl");
@@ -400,108 +389,6 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
-/*
- * Apply all the fixed voltages since most versions of U-Boot
- * don't bother with that initialization.
- */
-
-/* VAUX1 for mainboard (irda and sub-lcd) */
-static struct regulator_init_data sdp3430_vaux1 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-/* VAUX2 for camera module */
-static struct regulator_init_data sdp3430_vaux2 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-/* VAUX3 for LCD board */
-static struct regulator_init_data sdp3430_vaux3 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-/* VAUX4 for OMAP VDD_CSI2 (camera) */
-static struct regulator_init_data sdp3430_vaux4 = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data sdp3430_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vmmc1_supply,
-};
-
-/* VMMC2 for MMC2 card */
-static struct regulator_init_data sdp3430_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 1850000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vmmc2_supply,
-};
-
-/* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data sdp3430_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vsim_supply,
-};
-
 /* VDAC for DSS driving S-Video */
 static struct regulator_init_data sdp3430_vdac = {
 	.constraints = {
@@ -565,13 +452,13 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.usb		= &sdp3430_usb_data,
 	.codec		= &sdp3430_codec,
 
-	.vaux1		= &sdp3430_vaux1,
-	.vaux2		= &sdp3430_vaux2,
-	.vaux3		= &sdp3430_vaux3,
-	.vaux4		= &sdp3430_vaux4,
-	.vmmc1		= &sdp3430_vmmc1,
-	.vmmc2		= &sdp3430_vmmc2,
-	.vsim		= &sdp3430_vsim,
+	.vaux1		= &twl4030_vaux1_data,
+	.vaux2		= &twl4030_vaux2_data,
+	.vaux3		= &twl4030_vaux3_data,
+	.vaux4		= &twl4030_vaux4_data,
+	.vmmc1		= &twl4030_vmmc1_data,
+	.vmmc2		= &twl4030_vmmc2_data,
+	.vsim		= &twl4030_vsim_data,
 	.vdac		= &sdp3430_vdac,
 	.vpll2		= &sdp3430_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2626a9f..0e42749 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -47,6 +47,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define CM_T35_GPIO_PENDOWN	57
 
@@ -304,44 +305,6 @@ static void __init cm_t35_init_ads7846(void)
 static inline void cm_t35_init_ads7846(void) {}
 #endif
 
-static struct regulator_consumer_supply cm_t35_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply cm_t35_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data cm_t35_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &cm_t35_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data cm_t35_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &cm_t35_vsim_supply,
-};
-
 static struct twl4030_usb_data cm_t35_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -416,8 +379,8 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	cm_t35_vmmc1_supply.dev = mmc[0].dev;
-	cm_t35_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* setup USB with proper PHY reset GPIOs */
 	ehci_pdata.reset_gpio_port[0] = gpio + 6;
@@ -443,8 +406,8 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.keypad		= &cm_t35_kp_data,
 	.usb		= &cm_t35_usb_data,
 	.gpio		= &cm_t35_gpio_data,
-	.vmmc1		= &cm_t35_vmmc1,
-	.vsim		= &cm_t35_vsim,
+	.vmmc1		= &twl4030_vmmc1_data,
+	.vsim		= &twl4030_vsim_data,
 };
 
 static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 117b8fd..ad3f225 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -31,6 +31,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -102,25 +103,6 @@ static inline void __init igep2_init_smsc911x(void) { }
 static struct omap_board_config_kernel igep2_config[] __initdata = {
 };
 
-static struct regulator_consumer_supply igep2_vmmc1_supply = {
-	.supply		= "vmmc",
-};
-
-/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data igep2_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vmmc1_supply,
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -147,7 +129,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	igep2_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 
 	return 0;
 };
@@ -180,7 +162,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &igep2_usb_data,
 	.gpio		= &igep2_gpio_data,
-	.vmmc1          = &igep2_vmmc1,
+	.vmmc1          = &twl4030_vmmc1_data,
 
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 995d4a2..ce358ef 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -45,6 +45,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
@@ -310,25 +311,6 @@ static struct twl4030_madc_platform_data ldp_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct regulator_consumer_supply ldp_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data ldp_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &ldp_vmmc1_supply,
-};
-
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -336,7 +318,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	/* platform_data for children goes here */
 	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
-	.vmmc1		= &ldp_vmmc1,
+	.vmmc1		= &twl4030_vmmc1_data,
 	.gpio		= &ldp_gpio_data,
 	.keypad		= &ldp_kp_twl4030_data,
 };
@@ -398,7 +380,7 @@ static void __init omap_ldp_init(void)
 
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
-	ldp_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 231cb4e..2dc4e57 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -46,6 +46,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
@@ -126,14 +127,6 @@ static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct regulator_consumer_supply beagle_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply beagle_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
 static struct gpio_led gpio_leds[];
 
 static int beagle_twl_gpio_setup(struct device *dev,
@@ -150,8 +143,8 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	beagle_vmmc1_supply.dev = mmc[0].dev;
-	beagle_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -191,36 +184,6 @@ static struct regulator_consumer_supply beagle_vdvi_supply = {
 	.dev		= &omap3_beagle_lcd_device.dev,
 };
 
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data beagle_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &beagle_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data beagle_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &beagle_vsim_supply,
-};
-
 /* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
 static struct regulator_init_data beagle_vdac = {
 	.constraints = {
@@ -271,8 +234,8 @@ static struct twl4030_platform_data beagle_twldata = {
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.codec		= &beagle_codec_data,
-	.vmmc1		= &beagle_vmmc1,
-	.vsim		= &beagle_vsim,
+	.vmmc1		= &twl4030_vmmc1_data,
+	.vsim		= &twl4030_vsim_data,
 	.vdac		= &beagle_vdac,
 	.vpll2		= &beagle_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 34de178..1461d70 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -45,6 +45,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
@@ -147,44 +148,6 @@ static inline void __init omap3evm_init_smsc911x(void)
 static inline void __init omap3evm_init_smsc911x(void) { return; }
 #endif
 
-static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply omap3evm_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data omap3evm_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3evm_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data omap3evm_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3evm_vsim_supply,
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -228,8 +191,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	omap3evm_vmmc1_supply.dev = mmc[0].dev;
-	omap3evm_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
@@ -327,8 +290,8 @@ static int __init omap3_evm_i2c_init(void)
 	 * REVISIT: These entries can be set in omap3evm_twl_data
 	 * after a merge with MFD tree
 	 */
-	omap3evm_twldata.vmmc1 = &omap3evm_vmmc1;
-	omap3evm_twldata.vsim = &omap3evm_vsim;
+	omap3evm_twldata.vmmc1 = &twl4030_vmmc1_data;
+	omap3evm_twldata.vsim = &twl4030_vsim_data;
 
 	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index fe3d22c..46bad04 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -51,6 +51,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #include <asm/setup.h>
 
@@ -140,14 +141,6 @@ static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct regulator_consumer_supply touchbook_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply touchbook_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
 static struct gpio_led gpio_leds[];
 
 static int touchbook_twl_gpio_setup(struct device *dev,
@@ -164,8 +157,8 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	touchbook_vmmc1_supply.dev = mmc[0].dev;
-	touchbook_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -205,36 +198,6 @@ static struct regulator_consumer_supply touchbook_vdvi_supply = {
 	.dev		= &omap3_touchbook_lcd_device.dev,
 };
 
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data touchbook_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &touchbook_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data touchbook_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &touchbook_vsim_supply,
-};
-
 /* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
 static struct regulator_init_data touchbook_vdac = {
 	.constraints = {
@@ -285,8 +248,8 @@ static struct twl4030_platform_data touchbook_twldata = {
 	.usb		= &touchbook_usb_data,
 	.gpio		= &touchbook_gpio_data,
 	.codec		= &touchbook_codec_data,
-	.vmmc1		= &touchbook_vmmc1,
-	.vsim		= &touchbook_vsim,
+	.vmmc1		= &twl4030_vmmc1_data,
+	.vsim		= &twl4030_vsim_data,
 	.vdac		= &touchbook_vdac,
 	.vpll2		= &touchbook_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d192dd9..ce60b79 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -49,6 +49,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
@@ -290,16 +291,12 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply overo_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	twl4030_mmc_init(mmc);
 
-	overo_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 
 	return 0;
 }
@@ -315,20 +312,6 @@ static struct twl4030_usb_data overo_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct regulator_init_data overo_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &overo_vmmc1_supply,
-};
-
 static struct twl4030_codec_audio_data overo_audio_data = {
 	.audio_mclk = 26000000,
 };
@@ -346,7 +329,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
-	.vmmc1		= &overo_vmmc1,
+	.vmmc1		= &twl4030_vmmc1_data,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
old mode 100755
new mode 100644
index 1e3dfb6..18b3e28
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -25,6 +25,7 @@
 #include <plat/usb.h>
 
 #include "mmc-twl4030.h"
+#include "twl4030-pmic.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -93,63 +94,6 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.rep		= 1,
 };
 
-static struct regulator_consumer_supply zoom_vmmc1_supply = {
-	.supply		= "vmmc",
-};
-
-static struct regulator_consumer_supply zoom_vsim_supply = {
-	.supply		= "vmmc_aux",
-};
-
-static struct regulator_consumer_supply zoom_vmmc2_supply = {
-	.supply		= "vmmc",
-};
-
-/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data zoom_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom_vmmc1_supply,
-};
-
-/* VMMC2 for MMC2 card */
-static struct regulator_init_data zoom_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 1850000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom_vmmc2_supply,
-};
-
-/* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data zoom_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom_vsim_supply,
-};
-
 static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -180,9 +124,9 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	zoom_vmmc1_supply.dev = mmc[0].dev;
-	zoom_vsim_supply.dev = mmc[0].dev;
-	zoom_vmmc2_supply.dev = mmc[1].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc2_supply.dev = mmc[1].dev;
 
 	return 0;
 }
@@ -239,10 +183,9 @@ static struct twl4030_platform_data zoom_twldata = {
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
 	.codec		= &zoom_codec_data,
-	.vmmc1          = &zoom_vmmc1,
-	.vmmc2          = &zoom_vmmc2,
-	.vsim           = &zoom_vsim,
-
+	.vmmc1		= &twl4030_vmmc1_data,
+	.vmmc2		= &twl4030_vmmc2_data,
+	.vsim		= &twl4030_vsim_data,
 };
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
-- 
1.6.2.4

