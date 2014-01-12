From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 11/12] ARM: dts: sbc-t3517: add support for sbc-t3517
Date: Sun, 12 Jan 2014 15:22:54 +0200
Message-ID: <1389532975-28281-12-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36513 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbaALNXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:05 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for CM-T3517 CoM and SBC-T3517 board.

reused common support for sbc-t3x boards
(omap3-cm-t3x.dtsi, omap3-sb-t35.dtsi):

* SB-T35 baseboard eth
* MMC1, UART3
* HS USB Port 1/2
* I2C1/3
* Heartbit led

Added basic support for:

* MMC1 wp/cd signals
* CM-T3517 Usb Hub
* WL12xx WiFi chip
* Davinci EMAC
* AM35X OTG

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/Makefile            |    2 +
 arch/arm/boot/dts/omap3-cm-t3517.dts  |  136 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-sbc-t3517.dts |   43 ++++++++++
 arch/arm/mach-omap2/pdata-quirks.c    |   38 +++++++++-
 4 files changed, 218 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3517.dts
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3517.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fb8c397..afa9698 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -179,6 +179,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap2420-n810-wimax.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
+	omap3-cm-t3517.dtb \
+	omap3-sbc-t3517.dtb \
 	omap3-cm-t3530.dtb \
 	omap3-sbc-t3530.dtb \
 	omap3-cm-t3730.dtb \
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
new file mode 100644
index 0000000..d00502f
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -0,0 +1,136 @@
+/*
+ * Support for CompuLab CM-T3517
+ */
+/dts-v1/;
+
+#include "am3517.dtsi"
+#include "omap3-cm-t3x.dtsi"
+
+/ {
+	model = "CompuLab CM-T3517";
+	compatible = "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
+
+	vmmc:  regulator-vmmc {
+                compatible = "regulator-fixed";
+                regulator-name = "vmmc";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+        };
+
+	wl12xx_vmmc2: wl12xx_vmmc2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vw1271";
+		pinctrl-names = "default";
+		pinctrl-0 = <
+				&wl12xx_wkup_pins
+				&wl12xx_core_pins
+			    >;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH >; /* gpio6 */
+		startup-delay-us = <20000>;
+		enable-active-high;
+	};
+
+	wl12xx_vaux2: wl12xx_vaux2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271_vaux2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&omap3_pmx_wkup {
+
+	wl12xx_wkup_pins: pinmux_wl12xx_wkup_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a0e, PIN_OUTPUT | MUX_MODE4)	/* sys_boot2.gpio_4 */
+			OMAP3_WKUP_IOPAD(0x2a12, PIN_OUTPUT | MUX_MODE4)	/* sys_boot4.gpio_6 */
+		>;
+	};
+};
+
+&omap3_pmx_core {
+
+	phy1_reset_pins: pinmux_hsusb1_phy_reset_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE4)	/* uart2_tx.gpio_146 */
+		>;
+	};
+
+	phy2_reset_pins: pinmux_hsusb2_phy_reset_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x217a, PIN_OUTPUT | MUX_MODE4)	/* uart2_rx.gpio_147 */
+		>;
+	};
+
+	otg_drv_vbus: pinmux_otg_drv_vbus {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50Mhz_clk.usb0_drvvbus */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+		>;
+	};
+
+	wl12xx_core_pins: pinmux_wl12xx_core_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b8, PIN_OUTPUT | MUX_MODE4)	/* gpmc_ncs5.gpio_56 */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart2_rts.gpio_145 */
+		>;
+	};
+
+	usb_hub_pins: pinmux_usb_hub_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2184, PIN_OUTPUT | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 - USB HUB RST */
+		>;
+	};
+};
+
+&hsusb1_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&phy1_reset_pins>;
+	reset-gpios = <&gpio5 18 GPIO_ACTIVE_LOW>;
+};
+
+&hsusb2_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&phy2_reset_pins>;
+	reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>;
+};
+
+&davinci_emac {
+	status = "okay";
+};
+
+&davinci_mdio {
+	status = "okay";
+};
+
+&am35x_otg_hs {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&otg_drv_vbus>;
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&wl12xx_vmmc2>;
+	vmmc_aux-supply = <&wl12xx_vaux2>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+};
diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
new file mode 100644
index 0000000..024c9c6
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -0,0 +1,43 @@
+/*
+ * Suppport for CompuLab SBC-T3517 with CM-T3517
+ */
+
+#include "omap3-cm-t3517.dts"
+#include "omap3-sb-t35.dtsi"
+
+/ {
+	model = "CompuLab SBC-T3517 with CM-T3517";
+	compatible = "compulab,omap3-sbc-t3517", "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&sb_t35_usb_hub_pins
+			&usb_hub_pins
+		    >;
+
+	mmc1_aux_pins: pinmux_mmc1_aux_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20c0, PIN_INPUT_PULLUP | MUX_MODE4) /* gpmc_clk.gpio_59   */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE4) /* uart2_cts.gpio_144 */
+		>;
+	};
+
+	sb_t35_usb_hub_pins: pinmux_sb_t35_usb_hub_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ec, PIN_OUTPUT | MUX_MODE4) /* ccdc_wen.gpio_98 - SB-T35 USB HUB RST */
+		>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&mmc1_pins
+		&mmc1_aux_pins
+	>;
+
+	wp-gpios =  <&gpio2 27 GPIO_ACTIVE_HIGH>; /* gpio_59  */
+	cd-gpios =  <&gpio5 16 GPIO_ACTIVE_HIGH>; /* gpio_144 */
+};
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 4f2591e..1ee831f 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -165,7 +165,7 @@ static struct emac_platform_data am35xx_emac_pdata = {
 	.interrupt_disable	= am35xx_disable_emac_int,
 };
 
-static void __init am3517_evm_legacy_init(void)
+static void __init am35xx_emac_reset(void)
 {
 	u32 v;
 
@@ -174,6 +174,41 @@ static void __init am3517_evm_legacy_init(void)
 	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
 	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
 }
+
+static struct gpio cm_t3517_wlan_gpios[] __initdata = {
+	{ 56,	GPIOF_OUT_INIT_HIGH,	"wlan pwr" },
+	{ 4,	GPIOF_OUT_INIT_HIGH,	"xcvr noe" },
+};
+
+static void __init omap3_sbc_t3517_wifi_init(void)
+{
+	int err = gpio_request_array(cm_t3517_wlan_gpios,
+				ARRAY_SIZE(cm_t3517_wlan_gpios));
+	if (err) {
+		pr_err("SBC-T3517: wl12xx gpios request failed: %d\n", err);
+		return;
+	}
+
+	gpio_export(cm_t3517_wlan_gpios[0].gpio, 0);
+	gpio_export(cm_t3517_wlan_gpios[1].gpio, 0);
+
+	msleep(100);
+	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
+}
+
+static void __init omap3_sbc_t3517_legacy_init(void)
+{
+	am35xx_emac_reset();
+	hsmmc2_internal_input_clk();
+	omap3_sbc_t3517_wifi_init();
+	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 145);
+	omap_ads7846_init(1, 57, 0, NULL);
+}
+
+static void __init am3517_evm_legacy_init(void)
+{
+	am35xx_emac_reset();
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -263,6 +298,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
  */
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
+	{ "compulab,omap3-sbc-t3517", omap3_sbc_t3517_legacy_init, },
 	{ "compulab,omap3-sbc-t3530", omap3_sbc_t3530_legacy_init, },
 	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
 	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
-- 
1.7.5.4

