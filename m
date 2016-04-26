From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH 3/3] ARM: dts: add DTS for Baltos IR2110
Date: Tue, 26 Apr 2016 15:00:26 +0200
Message-ID: <1461675626-5818-4-git-send-email-yegorslists@googlemail.com>
References: <1461675626-5818-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461675626-5818-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts | 71 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir2110.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2c19cd9..64a2bc6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -485,6 +485,7 @@ dtb-$(CONFIG_SOC_TI81XX) += \
 	dm8168-evm.dtb \
 	dra62x-j5eco-evm.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
+	am335x-baltos-ir2110.dtb \
 	am335x-baltos-ir3220.dtb \
 	am335x-baltos-ir5221.dtb \
 	am335x-base0033.dtb \
diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
new file mode 100644
index 0000000..a9a9730
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * VScom OnRISC
+ * http://www.vscom.de
+ */
+
+/dts-v1/;
+
+#include "am335x-baltos.dtsi"
+
+/ {
+	model = "OnRISC Baltos iR 2110";
+};
+
+&am33xx_pinmux {
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+	rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <7>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <2>;
+};
+
+&phy_sel {
+	rmii-clock-ext = <1>;
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
