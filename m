From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: dra72-evm: Add tps65917 PMIC node
Date: Mon, 28 Jul 2014 11:48:54 +0530
Message-ID: <1406528334-4415-3-git-send-email-j-keerthy@ti.com>
References: <1406528334-4415-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406528334-4415-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-patch-review-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>

DRA72x-evm uses TPS65917 PMIC. Add the node.

NOTE: LDO2 is actually unused, but the usage if any is expected to be
between 1.8 to 3.3v IO voltage. So define the node.

NOTE: Interrupt used is crossbar number based.

Tested-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> 
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm.dts |  104 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 1e12862..4107428 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -33,6 +33,110 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
+
+	tps65917: tps65917@58 {
+		compatible = "ti,tps65917";
+		reg = <0x58>;
+
+		interrupts = <GIC_SPI 2 IRQ_TYPE_NONE>;  /* IRQ_SYS_1N */
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		ti,system-power-controller;
+
+		tps65917_pmic {
+			compatible = "ti,tps65917-pmic";
+
+			regulators {
+				smps1_reg: smps1 {
+					/* VDD_MPU */
+					regulator-name = "smps1";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps2_reg: smps2 {
+					/* VDD_CORE */
+					regulator-name = "smps2";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1030000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				smps3_reg: smps3 {
+					/* VDD_GPU IVA DSPEVE */
+					regulator-name = "smps3";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				smps4_reg: smps4 {
+					/* VDDS1V8 */
+					regulator-name = "smps4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps5_reg: smps5 {
+					/* VDD_DDR */
+					regulator-name = "smps5";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo1_reg: ldo1 {
+					/* LDO1_OUT --> SDIO  */
+					regulator-name = "ldo1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+				};
+
+				ldo2_reg: ldo2 {
+					/* LDO2_OUT --> TP1017 (UNUSED)  */
+					regulator-name = "ldo2";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo3_reg: ldo3 {
+					/* VDDA_1V8_PHY */
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo5_reg: ldo5 {
+					/* VDDA_1V8_PLL */
+					regulator-name = "ldo5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo4_reg: ldo4 {
+					/* VDDA_3V_USB: VDDA_USBHS33 */
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+				};
+			};
+		};
+	};
 };
 
 &uart1 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
