From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Update Phy supplies
Date: Thu, 3 Sep 2015 14:23:45 -0500
Message-ID: <1441308226-26690-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Originally, all the SoC PHY rails were supplied by LDO3. However, as a
result of characterization, it was determined that this posed a risk in
extreme load  conditions. Hence the PHY rails are split between two
different LDOs. Update the related node as a result

LDO3/VDDA_1V8_PHYA supplies vdda_usb1, vdda_usb2, vdda_sata, vdda_usb3
LDO4/VDDA_1V8_PHYB supplies vdda_pcie1, vdda_pcie0, vdda_hdmi, vdda_pcie

NOTE: We break compatibility with pre-production boards with this change
since, the PMIC LDO4 is disabled at OTP level.

The new configuration is the plan of record and all pre-production
boards are supposed to be replaced with the latest boards matching the
mentioned configuration.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 3a05b94f59ed..ede7fb73c717 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -432,7 +432,7 @@
 				};
 
 				ldo3_reg: ldo3 {
-					/* VDDA_1V8_PHY */
+					/* VDDA_1V8_PHYA */
 					regulator-name = "ldo3";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -440,6 +440,15 @@
 					regulator-boot-on;
 				};
 
+				ldo4_reg: ldo4 {
+					/* VDDA_1V8_PHYB */
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				ldo9_reg: ldo9 {
 					/* VDD_RTC */
 					regulator-name = "ldo9";
@@ -681,7 +690,7 @@
 
 &hdmi {
 	status = "ok";
-	vdda-supply = <&ldo3_reg>;
+	vdda-supply = <&ldo4_reg>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_pins>;
-- 
1.7.9.5
