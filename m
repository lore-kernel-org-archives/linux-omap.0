From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] ARM: dts: am57xx: Disable voltage switching for SD card
Date: Wed, 19 Jun 2019 15:54:54 +0530
Message-ID: <20190619102454.5097-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, tony@atomide.com, faiz_abbas@ti.com, robertcnelson@gmail.com
List-Id: linux-omap@vger.kernel.org

If UHS speed modes are enabled, a compatible SD card switches down to
1.8V during enumeration. If after this a software reboot/crash takes
place and on-chip ROM tries to enumerate the SD card, the difference in
IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.

The fix for this is to have support for power cycling the card in
hardware (with a PORz/soft-reset line causing a power cycle of the
card). Because the beaglebone X15 (rev A,B and C), am57xx-idks and
am57xx-evms don't have this capability, disable voltage switching for
these boards.

The major effect of this is that the maximum supported speed
mode is now high speed(50 MHz) down from SDR104(200 MHz).

commit 88a748419b84 ("ARM: dts: am57xx-idk: Remove support for voltage
switching for SD card") did this only for idk boards. Do it for all
affected boards.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts                | 7 +------
 arch/arm/boot/dts/am572x-idk.dts                | 7 +------
 arch/arm/boot/dts/am574x-idk.dts                | 7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   | 7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts    | 7 +------
 6 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 66116ad3f9f4..0a043908215c 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -178,14 +178,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50_rev20 &mmc1_iodelay_ddr50_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 4f835222c266..8663a9416af6 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -19,14 +19,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index dc5141c35610..7935d70874ce 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -24,14 +24,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_default>;
-	pinctrl-3 = <&mmc1_pins_hs>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_conf>;
-	pinctrl-6 = <&mmc1_pins_ddr50 &mmc1_iodelay_sdr104_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 2341a56ebab9..0cdfd2853ba8 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -433,6 +433,7 @@
 
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
+	no-1-8-v;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 5a77b334923d..34c69965821b 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -19,14 +19,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev11_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev11_conf>;
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&ldo1_reg>;
 };
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
index 17c41da3b55f..ccd99160bbdf 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
@@ -19,14 +19,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&ldo1_reg>;
 };
-- 
2.19.2
