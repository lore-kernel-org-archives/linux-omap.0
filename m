From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] ARM: dts: omap3-pandora: miscellaneous corrections
Date: Tue, 21 Jul 2015 04:11:58 +0300
Message-ID: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

- add pandora specific compatible name
- fix mmc2 card detect polarity
- fix mmc1 and mmc2 write protect polarity
- disable write protect pins because of production issue and add an
  explanation why they are disabled
- fix NAND partition name to reflect the correct address

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-pandora-1ghz.dts    |  2 +-
 arch/arm/boot/dts/omap3-pandora-600mhz.dts  |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 13 +++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
index 9619a28..25498f7 100644
--- a/arch/arm/boot/dts/omap3-pandora-1ghz.dts
+++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
@@ -19,7 +19,7 @@
 / {
 	model = "Pandora Handheld Console 1GHz";
 
-	compatible = "ti,omap36xx", "ti,omap3";
+	compatible = "openpandora,omap3-pandora-1ghz", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-pandora-600mhz.dts b/arch/arm/boot/dts/omap3-pandora-600mhz.dts
index fb803a7..8775897 100644
--- a/arch/arm/boot/dts/omap3-pandora-600mhz.dts
+++ b/arch/arm/boot/dts/omap3-pandora-600mhz.dts
@@ -19,7 +19,7 @@
 / {
 	model = "Pandora Handheld Console";
 
-	compatible = "ti,omap3";
+	compatible = "openpandora,omap3-pandora-600mhz", "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 782ab1f..f6363bc 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -459,13 +459,18 @@
 	power = <50>;
 };
 
+/*
+ * Many pandora boards have been produced with defective write-protect switches
+ * on either slot, so it was decided not to use this feature. If you know
+ * your board has good switches, feel free to uncomment wp-gpios below.
+ */
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
 	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio4 30 GPIO_ACTIVE_LOW>;	/* GPIO_126 */
+	/*wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;*/	/* GPIO_126 */
 };
 
 &mmc2 {
@@ -473,8 +478,8 @@
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&vmmc2>;
 	bus-width = <4>;
-	cd-gpios = <&twl_gpio 1 GPIO_ACTIVE_HIGH>;
-	wp-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>;	/* GPIO_127 */
+	cd-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
+	/*wp-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;*/	/* GPIO_127 */
 };
 
 /* bluetooth*/
@@ -545,7 +550,7 @@
 			reg = <0x280000 0xa00000>;
 		};
 
-		filesystem@680000 {
+		filesystem@c80000 {
 			label = "rootfs";
 			reg = <0xc80000 0>;	/* 0 = MTDPART_SIZ_FULL */
 		};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
