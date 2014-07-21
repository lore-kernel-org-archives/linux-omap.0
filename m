From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 7/7] arm: dts: omap3-gta04: Add twl4030 regulators parameters
Date: Mon, 21 Jul 2014 23:05:27 +0200
Message-ID: <1405976727-15166-8-git-send-email-marek@goldelico.com>
References: <1405976727-15166-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405976727-15166-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 05fd4d2..e39ede2 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -346,11 +346,37 @@
 	bb_uamp = <150>;
 };
 
+/* spare */
+&vaux1 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+/* sensors */
+&vaux2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-always-on;
+};
+
+/* camera */
+&vaux3 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+};
+
+/* WLAN/BT */
 &vaux4 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <3150000>;
 };
 
+/* GPS LNA */
+&vsim {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <3150000>;
+};
+
 /* Needed to power the DPI pins */
 &vpll2 {
 	regulator-always-on;
-- 
1.9.1
