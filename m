From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 01/32] ARM: dts: omap3-gta04: fix typo in backlight pins node name
Date: Wed, 25 Jul 2018 08:58:33 +0200
Message-ID: <6d8ebc5340047cc40013fbe4d614c9aca30a434f.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

mn -> nm for backlight_pins

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ac830b917776..9ad9cc62128e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -220,7 +220,7 @@
 		>;
 	};
 
-	backlight_pins: backlight_pins_pimnux {
+	backlight_pins: backlight_pins_pinmux {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20ba, MUX_MODE3)		/* gpt11/gpio57 */
 		>;
-- 
2.12.2
