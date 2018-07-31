From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 12/32] ARM: dts: omap3-gta04: add a comment how to reference the tca6507 gpio
Date: Tue, 31 Jul 2018 09:11:15 +0200
Message-ID: <4a81d383aa957081c987d411c66f6ac206ccfc07.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Make clear how to use the wifi_reset since it is not obvious.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 45d4b080341b..1145cfaa06d6 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -436,7 +436,7 @@
 			reg = <0x4>;
 		};
 
-		wifi_reset: wifi_reset@6 {
+		wifi_reset: wifi_reset@6 { /* reference as <&tca_gpios 0 0> since it is currently the only GPIO */
 			reg = <0x6>;
 			compatible = "gpio";
 		};
-- 
2.12.2
