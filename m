From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 2/2] ARM: dts: cm-t54: add WiFi/BT support
Date: Tue,  8 Apr 2014 16:08:51 +0300
Message-ID: <1396962531-27729-3-git-send-email-lifshitz@compulab.co.il>
References: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35463 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbaDHNKN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 09:10:13 -0400
In-Reply-To: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

Add support of AW-NH387 (mwifiex) WiFi/BT chip connected to MMC3.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c |   10 ++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index c87401f..27f5b7f 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -51,6 +51,7 @@
 	pinctrl-0 = <
 			&led_gpio_pins
 			&usbhost_pins
+			&wlan_reset_pins
 	>;
 
 	led_gpio_pins: pinmux_led_gpio_pins {
@@ -92,6 +93,24 @@
 		>;
 	};
 
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			0x164 (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_clk */
+			0x166 (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_cmd */
+			0x168 (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data0 */
+			0x16a (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data1 */
+			0x16c (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data2 */
+			0x16e (PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data3 */
+		>;
+	};
+
+	wlan_reset_pins: pinmux_wlan_reset_pins {
+		pinctrl-single,pins = <
+			0x15c (PIN_OUTPUT | MUX_MODE6) /* abemcpdm_ul_data.gpio4_109 - WLAN_nPD */
+			0x15e (PIN_OUTPUT | MUX_MODE6) /* abemcpdm_dl_data.gpio4_110 - WLAN_nRESET */
+		>;
+	};
+
 	usbhost_pins: pinmux_usbhost_pins {
 		pinctrl-single,pins = <
 			0x084 (PIN_INPUT | MUX_MODE0)  /* usbb2_hsic_strobe */
@@ -121,6 +140,14 @@
 	ti,non-removable;
 };
 
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+	vmmc-supply = <&ldo2_reg>;
+	bus-width = <4>;
+	ti,non-removable;
+};
+
 &mmc4 {
 	status = "disabled";
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index a114806..554ab37 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -205,6 +205,15 @@ static void __init omap5_uevm_legacy_init(void)
 {
 	legacy_init_ehci_clk("auxclk1_ck");
 }
+
+static void __init omap5_cm_t54_legacy_init(void)
+{
+	gpio_request_one(109, GPIOF_OUT_INIT_HIGH, "wlan_pdn");
+	gpio_export(109, 0);
+
+	gpio_request_one(110, GPIOF_OUT_INIT_HIGH, "wlan_rst");
+	gpio_export(110, 0);
+}
 #endif
 
 static struct pcs_pdata pcs_pdata;
@@ -286,6 +295,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 #endif
 #ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
+	{ "compulab,omap5-cm-t54", omap5_cm_t54_legacy_init, },
 #endif
 	{ /* sentinel */ },
 };
-- 
1.7.5.4

