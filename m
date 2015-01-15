From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP4: Remove legacy PMIC platform code
Date: Wed, 14 Jan 2015 16:58:33 -0800
Message-ID: <20150115005833.GA18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32253 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbAOBCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 20:02:16 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

We've had omap4 booting in DT only mode for quite some time
now, let's remove the legacy PMIC code that's no longer
needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -39,7 +39,7 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.flags		= I2C_CLIENT_WAKE,
 };
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP3)
 static int twl_set_voltage(void *data, int target_uV)
 {
 	struct voltagedomain *voltdm = (struct voltagedomain *)data;
@@ -66,20 +66,6 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
-void __init omap4_pmic_init(const char *pmic_type,
-		    struct twl4030_platform_data *pmic_data,
-		    struct i2c_board_info *devices, int nr_devices)
-{
-	/* PMIC part*/
-	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
-	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
-	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
-
-	/* Register additional devices on i2c1 bus if needed */
-	if (devices)
-		i2c_register_board_info(1, devices, nr_devices);
-}
-
 void __init omap_pmic_late_init(void)
 {
 	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
@@ -236,297 +222,6 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#if defined(CONFIG_ARCH_OMAP4)
-static struct twl4030_usb_data omap4_usb_pdata = {
-};
-
-static struct regulator_consumer_supply omap4_vdda_hdmi_dac_supplies[] = {
-	REGULATOR_SUPPLY("vdda_hdmi_dac", "omapdss_hdmi"),
-};
-
-static struct regulator_init_data omap4_vdac_idata = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap4_vdda_hdmi_dac_supplies),
-	.consumer_supplies	= omap4_vdda_hdmi_dac_supplies,
-	.supply_regulator	= "V2V1",
-};
-
-static struct regulator_init_data omap4_vaux2_idata = {
-	.constraints = {
-		.min_uV			= 1200000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_init_data omap4_vaux3_idata = {
-	.constraints = {
-		.min_uV			= 1000000,
-		.max_uV			= 3000000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_consumer_supply omap4_vmmc_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-/* VMMC1 for MMC1 card */
-static struct regulator_init_data omap4_vmmc_idata = {
-	.constraints = {
-		.min_uV			= 1200000,
-		.max_uV			= 3000000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(omap4_vmmc_supply),
-	.consumer_supplies      = omap4_vmmc_supply,
-};
-
-static struct regulator_init_data omap4_vpp_idata = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 2500000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_init_data omap4_vana_idata = {
-	.constraints = {
-		.min_uV			= 2100000,
-		.max_uV			= 2100000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_consumer_supply omap4_vcxio_supply[] = {
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
-};
-
-static struct regulator_init_data omap4_vcxio_idata = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-		.always_on		= true,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap4_vcxio_supply),
-	.consumer_supplies	= omap4_vcxio_supply,
-	.supply_regulator	= "V2V1",
-};
-
-static struct regulator_init_data omap4_vusb_idata = {
-	.constraints = {
-		.min_uV			= 3300000,
-		.max_uV			= 3300000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_init_data omap4_clk32kg_idata = {
-	.constraints = {
-		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct regulator_consumer_supply omap4_vdd1_supply[] = {
-	REGULATOR_SUPPLY("vcc", "cpu0"),
-};
-
-static struct regulator_consumer_supply omap4_vdd2_supply[] = {
-	REGULATOR_SUPPLY("vcc", "iva.0"),
-};
-
-static struct regulator_consumer_supply omap4_vdd3_supply[] = {
-	REGULATOR_SUPPLY("vcc", "l3_main.0"),
-};
-
-static struct regulator_init_data omap4_vdd1 = {
-	.constraints = {
-		.name			= "vdd_mpu",
-		.min_uV			= 500000,
-		.max_uV			= 1500000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd1_supply),
-	.consumer_supplies		= omap4_vdd1_supply,
-};
-
-static struct regulator_init_data omap4_vdd2 = {
-	.constraints = {
-		.name			= "vdd_iva",
-		.min_uV			= 500000,
-		.max_uV			= 1500000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd2_supply),
-	.consumer_supplies		= omap4_vdd2_supply,
-};
-
-static struct regulator_init_data omap4_vdd3 = {
-	.constraints = {
-		.name			= "vdd_core",
-		.min_uV			= 500000,
-		.max_uV			= 1500000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd3_supply),
-	.consumer_supplies		= omap4_vdd3_supply,
-};
-
-
-static struct twl_regulator_driver_data omap4_vdd1_drvdata = {
-	.get_voltage = twl_get_voltage,
-	.set_voltage = twl_set_voltage,
-};
-
-static struct twl_regulator_driver_data omap4_vdd2_drvdata = {
-	.get_voltage = twl_get_voltage,
-	.set_voltage = twl_set_voltage,
-};
-
-static struct twl_regulator_driver_data omap4_vdd3_drvdata = {
-	.get_voltage = twl_get_voltage,
-	.set_voltage = twl_set_voltage,
-};
-
-static struct regulator_consumer_supply omap4_v1v8_supply[] = {
-	REGULATOR_SUPPLY("vio", "1-004b"),
-};
-
-static struct regulator_init_data omap4_v1v8_idata = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-		.always_on		= true,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap4_v1v8_supply),
-	.consumer_supplies	= omap4_v1v8_supply,
-};
-
-static struct regulator_consumer_supply omap4_v2v1_supply[] = {
-	REGULATOR_SUPPLY("v2v1", "1-004b"),
-};
-
-static struct regulator_init_data omap4_v2v1_idata = {
-	.constraints = {
-		.min_uV			= 2100000,
-		.max_uV			= 2100000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap4_v2v1_supply),
-	.consumer_supplies	= omap4_v2v1_supply,
-};
-
-void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
-				  u32 pdata_flags, u32 regulators_flags)
-{
-	if (!pmic_data->vdd1) {
-		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
-		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
-		pmic_data->vdd1 = &omap4_vdd1;
-	}
-
-	if (!pmic_data->vdd2) {
-		omap4_vdd2.driver_data = &omap4_vdd2_drvdata;
-		omap4_vdd2_drvdata.data = voltdm_lookup("iva");
-		pmic_data->vdd2 = &omap4_vdd2;
-	}
-
-	if (!pmic_data->vdd3) {
-		omap4_vdd3.driver_data = &omap4_vdd3_drvdata;
-		omap4_vdd3_drvdata.data = voltdm_lookup("core");
-		pmic_data->vdd3 = &omap4_vdd3;
-	}
-
-	/* Common platform data configurations */
-	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-		pmic_data->usb = &omap4_usb_pdata;
-
-	/* Common regulator configurations */
-	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
-		pmic_data->vdac = &omap4_vdac_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VAUX2 && !pmic_data->vaux2)
-		pmic_data->vaux2 = &omap4_vaux2_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VAUX3 && !pmic_data->vaux3)
-		pmic_data->vaux3 = &omap4_vaux3_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VMMC && !pmic_data->vmmc)
-		pmic_data->vmmc = &omap4_vmmc_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VPP && !pmic_data->vpp)
-		pmic_data->vpp = &omap4_vpp_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VANA && !pmic_data->vana)
-		pmic_data->vana = &omap4_vana_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VCXIO && !pmic_data->vcxio)
-		pmic_data->vcxio = &omap4_vcxio_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VUSB && !pmic_data->vusb)
-		pmic_data->vusb = &omap4_vusb_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_CLK32KG &&
-	    !pmic_data->clk32kg)
-		pmic_data->clk32kg = &omap4_clk32kg_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_V1V8 && !pmic_data->v1v8)
-		pmic_data->v1v8 = &omap4_v1v8_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_V2V1 && !pmic_data->v2v1)
-		pmic_data->v2v1 = &omap4_v2v1_idata;
-}
-#endif /* CONFIG_ARCH_OMAP4 */
-
 #if defined(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP_TWL4030_MODULE)
 #include <linux/platform_data/omap-twl4030.h>
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -31,7 +31,6 @@
 
 
 struct twl4030_platform_data;
-struct twl6040_platform_data;
 struct omap_tw4030_pdata;
 struct i2c_board_info;
 
@@ -51,16 +50,9 @@ static inline void omap3_pmic_init(const char *pmic_type,
 	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
 }
 
-void omap4_pmic_init(const char *pmic_type,
-		    struct twl4030_platform_data *pmic_data,
-		    struct i2c_board_info *devices, int nr_devices);
-
 void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
 
-void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
-			   u32 pdata_flags, u32 regulators_flags);
-
 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
 
 #endif /* __OMAP_PMIC_COMMON__ */
