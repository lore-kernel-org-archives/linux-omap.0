From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Update pinmux name to ddr_3_3v
Date: Mon, 18 Nov 2019 16:46:54 +0530
Message-ID: <20191118111654.9843-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, tony@atomide.com, bcousson@baylibre.com, faiz_abbas@ti.com, robertcnelson@gmail.com
List-Id: linux-omap@vger.kernel.org

am57xx-beagle-x15 revb1 and revc have 3.3V connected to the eMMC I/O
lines. Update the pinmux name to reflect this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 7b113b52c3fb..39d1c4ff5749 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -24,7 +24,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
index 30c500b15b21..4187a9729f96 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
@@ -24,7 +24,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20>;
-- 
2.19.2
