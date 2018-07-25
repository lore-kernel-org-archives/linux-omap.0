From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 02/32] ARM: dts: omap3-gta04: fix some whitespace and tab style errors
Date: Wed, 25 Jul 2018 08:58:34 +0200
Message-ID: <cc8eb04a449629d162d3234957d054ef540a3640.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

tab+space -> tab only	 for /* GSM audio */
spaces -> tab for dss_dpi_pins

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 9ad9cc62128e..27fc9e54dcda 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -55,7 +55,7 @@
 		ti,mcbsp = <&mcbsp2>;
 	};
 
-	 /* GSM audio */
+	/* GSM audio */
 	sound_telephony {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "GTA04 voice";
@@ -227,7 +227,7 @@
 	};
 
 	dss_dpi_pins: pinmux_dss_dpi_pins {
-               pinctrl-single,pins = <
+		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
 			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
 			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
-- 
2.12.2
