From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Fix MMC1 card for detect GPIO and regulator
Date: Mon, 27 Mar 2017 17:40:20 -0700
Message-ID: <20170328004020.15781-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

There's a typo, it should be GPIO176 and not GPIO106.

And it seems I messed up the regulators at some point while trying
to figure out what devices the regulators are used. The correct
regulator for MMC1 is vwlan2.

Fixes: 0d4cb3ccee58 ("ARM: dts: Configure regulators for droid 4")
Reported-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -204,6 +204,7 @@
 		regulator-enable-ramp-delay = <1000>;
 	};
 
+	/* Used by micro-SDIO at mmc1 */
 	vwlan2: VWLAN2 {
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
@@ -216,7 +217,6 @@
 		regulator-enable-ramp-delay = <1000>;
 	};
 
-	/* Used by micro-SDIO at mmc1 */
 	vsimcard: VSIMCARD {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2900000>;
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -278,9 +278,9 @@
 };
 
 &mmc1 {
-	vmmc-supply = <&vsimcard>;
+	vmmc-supply = <&vwlan2>;
 	bus-width = <4>;
-	cd-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;	/* gpio106 */
+	cd-gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;	/* gpio176 */
 };
 
 &mmc2 {
-- 
2.12.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
