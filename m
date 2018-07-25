From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 21/32] ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
Date: Wed, 25 Jul 2018 08:58:53 +0200
Message-ID: <00f1f37a27ef6803c4e595eeef1d82d0b69aa8e7.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 audio system makes use of all four McBSP ports, so enable and
connect them with pinmux.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index f6abdef556c1..d53bb9bbbb70 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -770,8 +770,31 @@
 	};
 };
 
-&mcbsp2 {
-	status = "okay";
+&mcbsp1 { /* FM Transceiver PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+};
+
+&mcbsp2 { /* TPS65950 I2S */
+	status = "ok";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+};
+
+&mcbsp3 { /* Bluetooth PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp3_pins>;
+};
+
+&mcbsp4 { /* GSM voice PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp4_pins>;
 };
 
 &hdqw1w {
@@ -779,10 +802,6 @@
         pinctrl-0 = <&hdq_pins>;
 };
 
-&mcbsp4 {
-	status = "okay";
-};
-
 /* image signal processor within OMAP3 SoC */
 &isp {
 	ports {
-- 
2.12.2
