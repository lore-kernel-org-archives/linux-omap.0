From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 01/23] ARM: dts: n9/n950: regulator configuration
Date: Tue,  8 Mar 2016 17:39:33 +0100
Message-ID: <1457455195-1938-2-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add regulator configuration as found in the
board files of Nokia's kernel.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index a2c2b8d8dd2c..3c7f1d2deb2f 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -72,6 +72,30 @@
 	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
 };
 
+&vdac {
+	regulator-name = "vdac";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&vpll1 {
+	regulator-name = "vpll1";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&vpll2 {
+	regulator-name = "vpll2";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&vaux1 {
+	regulator-name = "vaux1";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
 /* CSI-2 receiver */
 &vaux2 {
 	regulator-name = "vaux2";
@@ -86,6 +110,54 @@
 	regulator-max-microvolt = <2800000>;
 };
 
+&vaux4 {
+	regulator-name = "vaux4";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
+&vmmc1 {
+	regulator-name = "vmmc1";
+	regulator-min-microvolt = <1850000>;
+	regulator-max-microvolt = <3150000>;
+};
+
+&vmmc2 {
+	regulator-name = "vmmc2";
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+&vintana1 {
+	regulator-name = "vintana1";
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+};
+
+&vintana2 {
+	regulator-name = "vintana2";
+	regulator-min-microvolt = <2750000>;
+	regulator-max-microvolt = <2750000>;
+};
+
+&vintdig {
+	regulator-name = "vintdig";
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+};
+
+&vsim {
+	regulator-name = "vsim";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&vio {
+	regulator-name = "vio";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 };
-- 
2.7.0
