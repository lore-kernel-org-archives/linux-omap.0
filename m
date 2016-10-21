From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 7/9] ARM: dts: Add support for dra718-evm
Date: Fri, 21 Oct 2016 16:08:39 +0530
Message-ID: <20161021103841.8044-8-lokeshvutla@ti.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161021103841.8044-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

The DRA718-evm is a board based on TI's DRA718 processor targeting
BOM-optimized entry infotainment systems and is a reduced pin and
software compatible derivative of the DRA72 ES2.0 processor.
This platform features:
- 2GB of DDR3L
- Dual 1Gbps Ethernet
- HDMI,
- uSD
- 8GB eMMC
- CAN
- PCIe
- USB3.0
- Video Input Port
- LP873x PMIC

More information can be found here[1].

Adding support for this board while reusing the data available in
dra72-evm-common.dtsi.

[1] http://www.ti.com/product/dra718

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/Makefile              |   3 +-
 arch/arm/boot/dts/dra71-evm.dts         | 230 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi |   6 +-
 3 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra71-evm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..b92d501 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -590,7 +590,8 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	am572x-idk.dtb \
 	dra7-evm.dtb \
 	dra72-evm.dtb \
-	dra72-evm-revc.dtb
+	dra72-evm-revc.dtb \
+	dra71-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-kuroboxpro.dtb \
 	orion5x-lacie-d2-network.dtb \
diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
new file mode 100644
index 0000000..2b9a5a8
--- /dev/null
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "dra72-evm-common.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	compatible = "ti,dra718-evm", "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7";
+	model = "TI DRA718 EVM";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>; /* 2GB */
+	};
+
+	vpo_sd_1v8_3v3: gpio-regulator-TPS74801 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vddshv8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		vin-supply = <&evm_5v0>;
+
+		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0
+			  3000000 0x1>;
+	};
+
+	poweroff: gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio7 30 GPIO_ACTIVE_HIGH>;
+		input;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	lp8733: lp8733@60 {
+		compatible = "ti,lp8733";
+		reg = <0x60>;
+
+		buck0-in-supply =<&vsys_3v3>;
+		buck1-in-supply =<&vsys_3v3>;
+		ldo0-in-supply =<&evm_5v0>;
+		ldo1-in-supply =<&evm_5v0>;
+
+		lp8733_regulators: regulators {
+			lp8733_buck0_reg: buck0 {
+				/* FB_B0 -> LP8733-BUCK1 - VPO_S1_AVS - VDD_CORE_AVS (core, mpu, gpu) */
+				regulator-name = "lp8733-buck0";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			lp8733_buck1_reg: buck1 {
+				/* FB_B1 -> LP8733-BUCK2 - VPO_S2_AVS - VDD_DSP_AVS (DSP/eve/iva) */
+				regulator-name = "lp8733-buck1";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lp8733_ldo0_reg: ldo0 {
+				/* LDO0 -> LP8733-LDO1 - VPO_L1_3V3 - VDDSHV8 (optional) */
+				regulator-name = "lp8733-ldo0";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			lp8733_ldo1_reg: ldo1 {
+				/* LDO1 -> LP8733-LDO2 - VPO_L2_3V3 - VDDA_USB3V3 */
+				regulator-name = "lp8733-ldo1";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+
+	lp8732: lp8732@61 {
+		compatible = "ti,lp8732";
+		reg = <0x61>;
+
+		buck0-in-supply =<&vsys_3v3>;
+		buck1-in-supply =<&vsys_3v3>;
+		ldo0-in-supply =<&vsys_3v3>;
+		ldo1-in-supply =<&vsys_3v3>;
+
+		lp8732_regulators: regulators {
+			lp8732_buck0_reg: buck0 {
+				/* FB_B0 -> LP8732-BUCK1 - VPO_S3_1V8 - VDDS_1V8 */
+				regulator-name = "lp8732-buck0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			lp8732_buck1_reg: buck1 {
+				/* FB_B1 -> LP8732-BUCK2 - VPO_S4_DDR - VDD_DDR_1V35 */
+				regulator-name = "lp8732-buck1";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lp8732_ldo0_reg: ldo0 {
+				/* LDO0 -> LP8732-LDO1 - VPO_L3_1V8 - VDA_1V8_PLL */
+				regulator-name = "lp8732-ldo0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lp8732_ldo1_reg: ldo1 {
+				/* LDO1 -> LP8732-LDO2 - VPO_L4_1V8 - VDA_1V8_PHY */
+				regulator-name = "lp8732-ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&pcf_gpio_21 {
+	interrupt-parent = <&gpio7>;
+	interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&pcf_hdmi {
+	p0 {
+		/*
+		 * PM_OEn to High: Disable routing I2C3 to PM_I2C
+		 * With this PM_SEL(p3) should not matter
+		 */
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "pm_oe_n";
+	};
+};
+
+&mmc1 {
+	vmmc_aux-supply = <&vpo_sd_1v8_3v3>;
+};
+
+&mac {
+	mode-gpios = <&pcf_gpio_21 4 GPIO_ACTIVE_LOW>,
+		     <&pcf_hdmi 9 GPIO_ACTIVE_LOW>,	/* P11 */
+		     <&pcf_hdmi 10 GPIO_ACTIVE_LOW>;	/* P12 */
+	dual_emac;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <2>;
+	phy-mode = "rgmii-id";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <3>;
+	phy-mode = "rgmii-id";
+	dual_emac_res_vlan = <2>;
+};
+
+&davinci_mdio {
+	dp83867_0: ethernet-phy@2 {
+		reg = <2>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,impedance-control = <0x1f>;
+	};
+
+	dp83867_1: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,impedance-control = <0x1f>;
+	};
+};
+
+/* No Sata on this device */
+&sata_phy {
+	status = "disabled";
+};
+
+&sata {
+	status = "disabled";
+};
+
+/* No RTC on this device */
+&rtc {
+	status = "disabled";
+};
+
+&usb2_phy1 {
+	phy-supply = <&lp8733_ldo1_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&lp8733_ldo1_reg>;
+};
+
+&dss {
+	/* Supplied by VDA_1V8_PLL */
+	vdda_video-supply = <&lp8732_ldo0_reg>;
+};
+
+&hdmi {
+	/* Supplied by VDA_1V8_PHY */
+	vdda_video-supply = <&lp8732_ldo1_reg>;
+};
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 9903ac7..e50fbee 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -29,7 +29,8 @@
 	};
 
 	evm_5v0: fixedregulator-evm5v0 {
-		/* Output 1 of TPS43351QDAPRQ1 */
+		/* Output 1 of TPS43351QDAPRQ1 on dra72-evm */
+		/* Output 1 of LM5140QRWGTQ1 on dra71-evm */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -40,7 +41,8 @@
 	};
 
 	vsys_3v3: fixedregulator-vsys3v3 {
-		/* Output 2 of TPS43351QDAPRQ1 */
+		/* Output 2 of TPS43351QDAPRQ1 on dra72-evm */
+		/* Output 2 of LM5140QRWGTQ1 on dra71-evm */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
 		regulator-min-microvolt = <3300000>;
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
