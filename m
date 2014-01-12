From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 10/12] ARM: dts: sbc-t3530: add support for sbc-t3530
Date: Sun, 12 Jan 2014 15:22:53 +0200
Message-ID: <1389532975-28281-11-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35354 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaALNXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:05 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for CM-T3530 CoM and SBC-T3530 board.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/Makefile            |    2 +
 arch/arm/boot/dts/omap3-cm-t3530.dts  |   12 +++++++++++
 arch/arm/boot/dts/omap3-sbc-t3530.dts |   36 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c    |    6 +++++
 4 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3530.dts
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3530.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b7af502..fb8c397 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -179,6 +179,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap2420-n810-wimax.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
+	omap3-cm-t3530.dtb \
+	omap3-sbc-t3530.dtb \
 	omap3-cm-t3730.dtb \
 	omap3-sbc-t3730.dtb \
 	omap3-devkit8000.dtb \
diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/omap3-cm-t3530.dts
new file mode 100644
index 0000000..9faf1cd
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
@@ -0,0 +1,12 @@
+/*
+ * Support for CompuLab CM-T3530
+ */
+/dts-v1/;
+
+#include "omap34xx.dtsi"
+#include "omap3-cm-t3x30.dtsi"
+
+/ {
+	model = "CompuLab CM-T3530";
+	compatible = "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+};
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
new file mode 100644
index 0000000..bbbeea6
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -0,0 +1,36 @@
+/*
+ * Suppport for CompuLab SBC-T3530 with CM-T3530
+ */
+
+#include "omap3-cm-t3530.dts"
+#include "omap3-sb-t35.dtsi"
+
+/ {
+	model = "CompuLab SBC-T3530 with CM-T3530";
+	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sb_t35_usb_hub_pins>;
+
+	sb_t35_usb_hub_pins: pinmux_sb_t35_usb_hub_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2130, PIN_OUTPUT | MUX_MODE4) /* ccdc_wen.gpio_167 - SB-T35 USB HUB RST */
+		>;
+	};
+};
+
+/*
+ * The following ranges correspond to SMSC9x eth chips on CM-T3530 CoM and
+ * SB-T35 baseboard respectively.
+ * This setting includes both chips in SBC-T3530 board device tree.
+ */
+&gpmc {
+	ranges = <5 0 0x2c000000 0x01000000>,
+		 <4 0 0x2d000000 0x01000000>;
+};
+
+&mmc1 {
+	cd-gpios =  <&twl_gpio 0 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 0748ade..4f2591e 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -119,6 +119,11 @@ static void __init omap3_sbc_t3730_legacy_init(void)
 	omap_ads7846_init(1, 57, 0, NULL);
 }
 
+static void __init omap3_sbc_t3530_legacy_init(void)
+{
+	omap_ads7846_init(1, 57, 0, NULL);
+}
+
 static void __init omap3_igep0020_legacy_init(void)
 {
 	omap3_igep2_display_init_of();
@@ -258,6 +263,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
  */
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
+	{ "compulab,omap3-sbc-t3530", omap3_sbc_t3530_legacy_init, },
 	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
 	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
-- 
1.7.5.4

