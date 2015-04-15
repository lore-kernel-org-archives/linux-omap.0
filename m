From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 11/35] ARM: OMAP2+: pdata-quirks: move data out of __initdata section
Date: Wed, 15 Apr 2015 15:52:58 +0300
Message-ID: <1429102402-5276-12-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbbDOMwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:52:51 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

These need to move later in the boot with hwmod data being moved into a
module, thus remove the __init declarations to make them accessible at
module probe phase also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |   58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e642b07..6d5948a 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -37,11 +37,11 @@ static struct twl4030_gpio_platform_data twl_gpio_auxdata;
 
 #if IS_ENABLED(CONFIG_WL12XX)
 
-static struct wl12xx_platform_data wl12xx __initdata;
+static struct wl12xx_platform_data wl12xx;
 
-static void __init __used legacy_init_wl12xx(unsigned ref_clock,
-					     unsigned tcxo_clock,
-					     int gpio)
+static void __used legacy_init_wl12xx(unsigned ref_clock,
+				      unsigned tcxo_clock,
+				      int gpio)
 {
 	int res;
 
@@ -64,7 +64,7 @@ static inline void legacy_init_wl12xx(unsigned ref_clock,
 #endif
 
 #ifdef CONFIG_MACH_NOKIA_N8X0
-static void __init omap2420_n8x0_legacy_init(void)
+static void omap2420_n8x0_legacy_init(void)
 {
 	omap_auxdata_lookup[0].platform_data = n8x0_legacy_init();
 }
@@ -73,7 +73,7 @@ static void __init omap2420_n8x0_legacy_init(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static void __init hsmmc2_internal_input_clk(void)
+static void hsmmc2_internal_input_clk(void)
 {
 	u32 reg;
 
@@ -104,7 +104,7 @@ static int omap3_sbc_t3730_twl_callback(struct device *dev,
 	return 0;
 }
 
-static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
+static void omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
 {
 	int err = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, hub_name);
 
@@ -121,18 +121,18 @@ static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
 	msleep(1);
 }
 
-static void __init omap3_sbc_t3730_twl_init(void)
+static void omap3_sbc_t3730_twl_init(void)
 {
 	twl_gpio_auxdata.setup = omap3_sbc_t3730_twl_callback;
 }
 
-static void __init omap3_sbc_t3730_legacy_init(void)
+static void omap3_sbc_t3730_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 136);
 }
 
-static void __init omap3_sbc_t3530_legacy_init(void)
+static void omap3_sbc_t3530_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 }
@@ -157,27 +157,27 @@ static struct platform_device btwilink_device = {
 	.id	= -1,
 };
 
-static void __init omap3_igep0020_rev_f_legacy_init(void)
+static void omap3_igep0020_rev_f_legacy_init(void)
 {
 	legacy_init_wl12xx(0, 0, 177);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
 
-static void __init omap3_igep0030_rev_g_legacy_init(void)
+static void omap3_igep0030_rev_g_legacy_init(void)
 {
 	legacy_init_wl12xx(0, 0, 136);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
 
-static void __init omap3_evm_legacy_init(void)
+static void omap3_evm_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
 }
 
-static void __init omap3_zoom_legacy_init(void)
+static void omap3_zoom_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
 }
@@ -208,7 +208,7 @@ static struct emac_platform_data am35xx_emac_pdata = {
 	.interrupt_disable	= am35xx_disable_emac_int,
 };
 
-static void __init am35xx_emac_reset(void)
+static void am35xx_emac_reset(void)
 {
 	u32 v;
 
@@ -218,12 +218,12 @@ static void __init am35xx_emac_reset(void)
 	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
 }
 
-static struct gpio cm_t3517_wlan_gpios[] __initdata = {
+static struct gpio cm_t3517_wlan_gpios[] = {
 	{ 56,	GPIOF_OUT_INIT_HIGH,	"wlan pwr" },
 	{ 4,	GPIOF_OUT_INIT_HIGH,	"xcvr noe" },
 };
 
-static void __init omap3_sbc_t3517_wifi_init(void)
+static void omap3_sbc_t3517_wifi_init(void)
 {
 	int err = gpio_request_array(cm_t3517_wlan_gpios,
 				ARRAY_SIZE(cm_t3517_wlan_gpios));
@@ -239,7 +239,7 @@ static void __init omap3_sbc_t3517_wifi_init(void)
 	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
 }
 
-static void __init omap3_sbc_t3517_legacy_init(void)
+static void omap3_sbc_t3517_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(152, "cm-t3517 usb hub");
 	omap3_sbc_t3x_usb_hub_init(98, "sb-t35 usb hub");
@@ -249,7 +249,7 @@ static void __init omap3_sbc_t3517_legacy_init(void)
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 145);
 }
 
-static void __init am3517_evm_legacy_init(void)
+static void am3517_evm_legacy_init(void)
 {
 	am35xx_emac_reset();
 }
@@ -262,7 +262,7 @@ static struct platform_device omap3_rom_rng_device = {
 	},
 };
 
-static void __init nokia_n900_legacy_init(void)
+static void nokia_n900_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
 
@@ -282,25 +282,25 @@ static void __init nokia_n900_legacy_init(void)
 	}
 }
 
-static void __init omap3_tao3530_legacy_init(void)
+static void omap3_tao3530_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
-static void __init omap4_sdp_legacy_init(void)
+static void omap4_sdp_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26,
 			   WL12XX_TCXOCLOCK_26, 53);
 }
 
-static void __init omap4_panda_legacy_init(void)
+static void omap4_panda_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
 
-static void __init var_som_om44_legacy_init(void)
+static void var_som_om44_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 41);
 }
@@ -315,14 +315,14 @@ static struct iommu_platform_data omap4_iommu_pdata = {
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-static void __init am335x_evmsk_legacy_init(void)
+static void am335x_evmsk_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 31);
 }
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-static void __init omap5_uevm_legacy_init(void)
+static void omap5_uevm_legacy_init(void)
 {
 }
 #endif
@@ -354,7 +354,7 @@ void omap_auxdata_legacy_init(struct device *dev)
  * Few boards still need auxdata populated before we populate
  * the dev entries in of_platform_populate().
  */
-static struct pdata_init auxdata_quirks[] __initdata = {
+static struct pdata_init auxdata_quirks[] = {
 #ifdef CONFIG_SOC_OMAP2420
 	{ "nokia,n800", omap2420_n8x0_legacy_init, },
 	{ "nokia,n810", omap2420_n8x0_legacy_init, },
@@ -366,7 +366,7 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
-struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
 	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
@@ -410,7 +410,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
  * Few boards still need to initialize some legacy devices with
  * platform data until the drivers support device tree.
  */
-static struct pdata_init pdata_quirks[] __initdata = {
+static struct pdata_init pdata_quirks[] = {
 #ifdef CONFIG_ARCH_OMAP3
 	{ "compulab,omap3-sbc-t3517", omap3_sbc_t3517_legacy_init, },
 	{ "compulab,omap3-sbc-t3530", omap3_sbc_t3530_legacy_init, },
-- 
1.7.9.5

