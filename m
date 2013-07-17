From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/9] ARM: dts: omap5-uevm: document regulator signals used on the actual board
Date: Wed, 17 Jul 2013 11:45:30 -0500
Message-ID: <1374079538-19548-2-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, currently we use the Palmas regulator names which is used for
different purposes on uEVM. Document the same based on 750-2628-XXX
boards - which is meant to be supported by this dts.

Reported-by: Marc J=C3=BCttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5=
-uevm.dts
index 08b7267..b430b8f 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -282,6 +282,7 @@
=20
 			regulators {
 				smps123_reg: smps123 {
+					/* VDD_OPP_MPU */
 					regulator-name =3D "smps123";
 					regulator-min-microvolt =3D < 600000>;
 					regulator-max-microvolt =3D <1500000>;
@@ -290,6 +291,7 @@
 				};
=20
 				smps45_reg: smps45 {
+					/* VDD_OPP_MM */
 					regulator-name =3D "smps45";
 					regulator-min-microvolt =3D < 600000>;
 					regulator-max-microvolt =3D <1310000>;
@@ -298,6 +300,7 @@
 				};
=20
 				smps6_reg: smps6 {
+					/* VDD_DDR3 - over VDD_SMPS6 */
 					regulator-name =3D "smps6";
 					regulator-min-microvolt =3D <1200000>;
 					regulator-max-microvolt =3D <1200000>;
@@ -306,6 +309,7 @@
 				};
=20
 				smps7_reg: smps7 {
+					/* VDDS_1v8_OMAP over VDDS_1v8_MAIN */
 					regulator-name =3D "smps7";
 					regulator-min-microvolt =3D <1800000>;
 					regulator-max-microvolt =3D <1800000>;
@@ -314,6 +318,7 @@
 				};
=20
 				smps8_reg: smps8 {
+					/* VDD_OPP_CORE */
 					regulator-name =3D "smps8";
 					regulator-min-microvolt =3D < 600000>;
 					regulator-max-microvolt =3D <1310000>;
@@ -322,6 +327,7 @@
 				};
=20
 				smps9_reg: smps9 {
+					/* VDDA_2v1_AUD over VDD_2v1 */
 					regulator-name =3D "smps9";
 					regulator-min-microvolt =3D <2100000>;
 					regulator-max-microvolt =3D <2100000>;
@@ -331,6 +337,7 @@
 				};
=20
 				smps10_reg: smps10 {
+					/* VBUS_5V_OTG */
 					regulator-name =3D "smps10";
 					regulator-min-microvolt =3D <5000000>;
 					regulator-max-microvolt =3D <5000000>;
@@ -339,6 +346,7 @@
 				};
=20
 				ldo1_reg: ldo1 {
+					/* VDDAPHY_CAM: vdda_csiport */
 					regulator-name =3D "ldo1";
 					regulator-min-microvolt =3D <2800000>;
 					regulator-max-microvolt =3D <2800000>;
@@ -347,6 +355,7 @@
 				};
=20
 				ldo2_reg: ldo2 {
+					/* VCC_2V8_DISP: Does not go anywhere */
 					regulator-name =3D "ldo2";
 					regulator-min-microvolt =3D <2900000>;
 					regulator-max-microvolt =3D <2900000>;
@@ -355,6 +364,7 @@
 				};
=20
 				ldo3_reg: ldo3 {
+					/* VDDAPHY_MDM: vdda_lli */
 					regulator-name =3D "ldo3";
 					regulator-min-microvolt =3D <3000000>;
 					regulator-max-microvolt =3D <3000000>;
@@ -363,6 +373,7 @@
 				};
=20
 				ldo4_reg: ldo4 {
+					/* VDDAPHY_DISP: vdda_dsiport/hdmi */
 					regulator-name =3D "ldo4";
 					regulator-min-microvolt =3D <2200000>;
 					regulator-max-microvolt =3D <2200000>;
@@ -371,6 +382,7 @@
 				};
=20
 				ldo5_reg: ldo5 {
+					/* VDDA_1V8_PHY: usb/sata/hdmi.. */
 					regulator-name =3D "ldo5";
 					regulator-min-microvolt =3D <1800000>;
 					regulator-max-microvolt =3D <1800000>;
@@ -379,6 +391,7 @@
 				};
=20
 				ldo6_reg: ldo6 {
+					/* VDDS_1V2_WKUP: hsic/ldo_emu_wkup */
 					regulator-name =3D "ldo6";
 					regulator-min-microvolt =3D <1500000>;
 					regulator-max-microvolt =3D <1500000>;
@@ -387,6 +400,7 @@
 				};
=20
 				ldo7_reg: ldo7 {
+					/* VDD_VPP: vpp1 */
 					regulator-name =3D "ldo7";
 					regulator-min-microvolt =3D <1500000>;
 					regulator-max-microvolt =3D <1500000>;
@@ -395,6 +409,7 @@
 				};
=20
 				ldo8_reg: ldo8 {
+					/* VDD_3v0: Does not go anywhere */
 					regulator-name =3D "ldo8";
 					regulator-min-microvolt =3D <1500000>;
 					regulator-max-microvolt =3D <1500000>;
@@ -403,6 +418,7 @@
 				};
=20
 				ldo9_reg: ldo9 {
+					/* VCC_DV_SDIO: vdds_sdcard */
 					regulator-name =3D "ldo9";
 					regulator-min-microvolt =3D <1800000>;
 					regulator-max-microvolt =3D <3300000>;
@@ -411,6 +427,7 @@
 				};
=20
 				ldoln_reg: ldoln {
+					/* VDDA_1v8_REF: vdds_osc/mm_l4per.. */
 					regulator-name =3D "ldoln";
 					regulator-min-microvolt =3D <1800000>;
 					regulator-max-microvolt =3D <1800000>;
@@ -419,6 +436,7 @@
 				};
=20
 				ldousb_reg: ldousb {
+					/* VDDA_3V_USB: VDDA_USBHS33 */
 					regulator-name =3D "ldousb";
 					regulator-min-microvolt =3D <3250000>;
 					regulator-max-microvolt =3D <3250000>;
--=20
1.7.9.5
