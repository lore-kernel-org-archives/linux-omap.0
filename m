From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH v2 2/5] ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,
 set}_voltage
Date: Fri, 4 Nov 2016 16:02:15 +0200
Message-ID: <1478268138-7044-3-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Last user of these functions was removed in commit
e92fc4 ("ARM: OMAP2+: Drop legacy board file for LDP") during
legacy board file removal.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/twl-common.c | 160 ---------------------------------------
 arch/arm/mach-omap2/twl-common.h |   3 -
 2 files changed, 163 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 06a7521..cf3d81b 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -39,20 +39,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.flags		= I2C_CLIENT_WAKE,
 };
 
-#if defined(CONFIG_ARCH_OMAP3)
-static int twl_set_voltage(void *data, int target_uV)
-{
-	struct voltagedomain *voltdm = (struct voltagedomain *)data;
-	return voltdm_scale(voltdm, target_uV);
-}
-
-static int twl_get_voltage(void *data)
-{
-	struct voltagedomain *voltdm = (struct voltagedomain *)data;
-	return voltdm_get_voltage(voltdm);
-}
-#endif
-
 void __init omap_pmic_init(int bus, u32 clkrate,
 			   const char *pmic_type, int pmic_irq,
 			   struct twl4030_platform_data *pmic_data)
@@ -76,152 +62,6 @@ void __init omap_pmic_late_init(void)
 	omap4_twl_init();
 }
 
-#if defined(CONFIG_ARCH_OMAP3)
-static struct twl4030_usb_data omap3_usb_pdata = {
-	.usb_mode = T2_USB_MODE_ULPI,
-};
-
-static int omap3_batt_table[] = {
-/* 0 C */
-30800, 29500, 28300, 27100,
-26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
-17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
-11600, 11200, 10800, 10400, 10000, 9630,  9280,  8950,  8620,  8310,
-8020,  7730,  7460,  7200,  6950,  6710,  6470,  6250,  6040,  5830,
-5640,  5450,  5260,  5090,  4920,  4760,  4600,  4450,  4310,  4170,
-4040,  3910,  3790,  3670,  3550
-};
-
-static struct twl4030_bci_platform_data omap3_bci_pdata = {
-	.battery_tmp_tbl	= omap3_batt_table,
-	.tblsize		= ARRAY_SIZE(omap3_batt_table),
-};
-
-static struct twl4030_madc_platform_data omap3_madc_pdata = {
-	.irq_line	= 1,
-};
-
-static struct twl4030_codec_data omap3_codec;
-
-static struct twl4030_audio_data omap3_audio_pdata = {
-	.audio_mclk = 26000000,
-	.codec = &omap3_codec,
-};
-
-static struct regulator_consumer_supply omap3_vdda_dac_supplies[] = {
-	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
-};
-
-static struct regulator_init_data omap3_vdac_idata = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap3_vdda_dac_supplies),
-	.consumer_supplies	= omap3_vdda_dac_supplies,
-};
-
-static struct regulator_consumer_supply omap3_vpll2_supplies[] = {
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
-};
-
-static struct regulator_init_data omap3_vpll2_idata = {
-	.constraints = {
-		.min_uV                 = 1800000,
-		.max_uV                 = 1800000,
-		.valid_modes_mask       = REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask         = REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap3_vpll2_supplies),
-	.consumer_supplies		= omap3_vpll2_supplies,
-};
-
-static struct regulator_consumer_supply omap3_vdd1_supply[] = {
-	REGULATOR_SUPPLY("vcc", "cpu0"),
-};
-
-static struct regulator_consumer_supply omap3_vdd2_supply[] = {
-	REGULATOR_SUPPLY("vcc", "l3_main.0"),
-};
-
-static struct regulator_init_data omap3_vdd1 = {
-	.constraints = {
-		.name			= "vdd_mpu_iva",
-		.min_uV			= 600000,
-		.max_uV			= 1450000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd1_supply),
-	.consumer_supplies		= omap3_vdd1_supply,
-};
-
-static struct regulator_init_data omap3_vdd2 = {
-	.constraints = {
-		.name			= "vdd_core",
-		.min_uV			= 600000,
-		.max_uV			= 1450000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd2_supply),
-	.consumer_supplies		= omap3_vdd2_supply,
-};
-
-static struct twl_regulator_driver_data omap3_vdd1_drvdata = {
-	.get_voltage = twl_get_voltage,
-	.set_voltage = twl_set_voltage,
-};
-
-static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
-	.get_voltage = twl_get_voltage,
-	.set_voltage = twl_set_voltage,
-};
-
-void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
-				  u32 pdata_flags, u32 regulators_flags)
-{
-	if (!pmic_data->vdd1) {
-		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
-		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
-		pmic_data->vdd1 = &omap3_vdd1;
-	}
-	if (!pmic_data->vdd2) {
-		omap3_vdd2.driver_data = &omap3_vdd2_drvdata;
-		omap3_vdd2_drvdata.data = voltdm_lookup("core");
-		pmic_data->vdd2 = &omap3_vdd2;
-	}
-
-	/* Common platform data configurations */
-	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-		pmic_data->usb = &omap3_usb_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_BCI && !pmic_data->bci)
-		pmic_data->bci = &omap3_bci_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_MADC && !pmic_data->madc)
-		pmic_data->madc = &omap3_madc_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
-		pmic_data->audio = &omap3_audio_pdata;
-
-	/* Common regulator configurations */
-	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
-		pmic_data->vdac = &omap3_vdac_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VPLL2 && !pmic_data->vpll2)
-		pmic_data->vpll2 = &omap3_vpll2_idata;
-}
-#endif /* CONFIG_ARCH_OMAP3 */
-
 #if IS_ENABLED(CONFIG_SND_OMAP_SOC_OMAP_TWL4030)
 #include <linux/platform_data/omap-twl4030.h>
 
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 8e46ca3..048f6b2 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -51,9 +51,6 @@ static inline void omap3_pmic_init(const char *pmic_type,
 	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
 }
 
-void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
-			   u32 pdata_flags, u32 regulators_flags);
-
 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
 
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
2.5.5
