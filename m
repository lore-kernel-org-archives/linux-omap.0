From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage supply mapping accurately
Date: Wed, 4 May 2016 14:20:18 -0500
Message-ID: <1462389618-28860-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP5uEVM[1] based platforms share a similar voltage rail map. This
should be properly described in device tree, without this regulator core
will be unable to determine the source voltage of LDOs such as LDO9 and
SMPS10 which could be configured for bypass depending on the voltage
requested of them. This results in conditions such as

[    4.207853] ldo9: bypassed regulator has no supply!
[    4.212982] ldo9: failed to get the current voltage(-517)
[    4.218662] palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register 48070000.i2c:palmas@48:palmas_pmic regulator

NOTE: I do not have access to omap5-igep0050 schematics, but based on
test behavior for LDO9 by Tony, I am assuming to be the same map as
OMAP5uEVM.

Reference schematics document: 750-2628-103-SCH
rev D (Access to schematics requires NDA as per
https://e2e.ti.com/support/omap/f/885/t/282560)

[1] https://svtronics.com/5432

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on next-20160504

This should fix regression reported for mmcsd such as that seen in:
https://storage.kernelci.org/next/next-20160504/arm-omap2plus_defconfig/lab-baylibre-seattle/boot-omap5-uevm_rootfs:mmc.txt

http://pastebin.ubuntu.com/16223856/
NFS data transfer test however failed on linux-next
next-20160504 - this could be a second order issue to be identified.

 arch/arm/boot/dts/omap5-board-common.dtsi | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index dc759a3028b7..56eb4f1a6bf0 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -14,6 +14,29 @@
 		display0 = &hdmi0;
 	};
 
+	vmain: fixedregulator-vmain {
+		compatible = "regulator-fixed";
+		regulator-name = "vmain";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vsys_cobra: fixedregulator-vsys_cobra {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_cobra";
+		vin-supply = <&vmain>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdds_1v8_main: fixedregulator-vdds_1v8_main {
+		compatible = "regulator-fixed";
+		regulator-name = "vdds_1v8_main";
+		vin-supply = <&smps7_reg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vmmcsd_fixed: fixedregulator-mmcsd {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -413,6 +436,7 @@
 				smps123_reg: smps123 {
 					/* VDD_OPP_MPU */
 					regulator-name = "smps123";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = < 600000>;
 					regulator-max-microvolt = <1500000>;
 					regulator-always-on;
@@ -422,6 +446,7 @@
 				smps45_reg: smps45 {
 					/* VDD_OPP_MM */
 					regulator-name = "smps45";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = < 600000>;
 					regulator-max-microvolt = <1310000>;
 					regulator-always-on;
@@ -431,6 +456,7 @@
 				smps6_reg: smps6 {
 					/* VDD_DDR3 - over VDD_SMPS6 */
 					regulator-name = "smps6";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
@@ -440,6 +466,7 @@
 				smps7_reg: smps7 {
 					/* VDDS_1v8_OMAP over VDDS_1v8_MAIN */
 					regulator-name = "smps7";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -449,6 +476,7 @@
 				smps8_reg: smps8 {
 					/* VDD_OPP_CORE */
 					regulator-name = "smps8";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = < 600000>;
 					regulator-max-microvolt = <1310000>;
 					regulator-always-on;
@@ -458,6 +486,7 @@
 				smps9_reg: smps9 {
 					/* VDDA_2v1_AUD over VDD_2v1 */
 					regulator-name = "smps9";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <2100000>;
 					regulator-max-microvolt = <2100000>;
 					ti,smps-range = <0x80>;
@@ -466,6 +495,7 @@
 				smps10_out2_reg: smps10_out2 {
 					/* VBUS_5V_OTG */
 					regulator-name = "smps10_out2";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <5000000>;
 					regulator-max-microvolt = <5000000>;
 					regulator-always-on;
@@ -475,6 +505,7 @@
 				smps10_out1_reg: smps10_out1 {
 					/* VBUS_5V_OTG */
 					regulator-name = "smps10_out1";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <5000000>;
 					regulator-max-microvolt = <5000000>;
 				};
@@ -482,6 +513,7 @@
 				ldo1_reg: ldo1 {
 					/* VDDAPHY_CAM: vdda_csiport */
 					regulator-name = "ldo1";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
@@ -489,6 +521,7 @@
 				ldo2_reg: ldo2 {
 					/* VCC_2V8_DISP: Does not go anywhere */
 					regulator-name = "ldo2";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
 					/* Unused */
@@ -498,6 +531,7 @@
 				ldo3_reg: ldo3 {
 					/* VDDAPHY_MDM: vdda_lli */
 					regulator-name = "ldo3";
+					vin-supply = <&vdds_1v8_main>;
 					regulator-min-microvolt = <1500000>;
 					regulator-max-microvolt = <1500000>;
 					regulator-boot-on;
@@ -508,6 +542,7 @@
 				ldo4_reg: ldo4 {
 					/* VDDAPHY_DISP: vdda_dsiport/hdmi */
 					regulator-name = "ldo4";
+					vin-supply = <&vdds_1v8_main>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
@@ -515,6 +550,7 @@
 				ldo5_reg: ldo5 {
 					/* VDDA_1V8_PHY: usb/sata/hdmi.. */
 					regulator-name = "ldo5";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -524,6 +560,7 @@
 				ldo6_reg: ldo6 {
 					/* VDDS_1V2_WKUP: hsic/ldo_emu_wkup */
 					regulator-name = "ldo6";
+					vin-supply = <&vdds_1v8_main>;
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
@@ -533,6 +570,7 @@
 				ldo7_reg: ldo7 {
 					/* VDD_VPP: vpp1 */
 					regulator-name = "ldo7";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <2000000>;
 					regulator-max-microvolt = <2000000>;
 					/* Only for efuse reprograming! */
@@ -542,6 +580,7 @@
 				ldo8_reg: ldo8 {
 					/* VDD_3v0: Does not go anywhere */
 					regulator-name = "ldo8";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
 					regulator-boot-on;
@@ -551,6 +590,8 @@
 
 				ldo9_reg: ldo9 {
 					/* VCC_DV_SDIO: vdds_sdcard */
+					vin-supply = <&vmmcsdio_fixed>;
+
 					regulator-name = "ldo9";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3000000>;
@@ -569,6 +610,7 @@
 				ldousb_reg: ldousb {
 					/* VDDA_3V_USB: VDDA_USBHS33 */
 					regulator-name = "ldousb";
+					vin-supply = <&vsys_cobra>;
 					regulator-min-microvolt = <3250000>;
 					regulator-max-microvolt = <3250000>;
 					regulator-always-on;
-- 
2.8.0
