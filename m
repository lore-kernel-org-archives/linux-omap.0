From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 26/32] ARM: dts: omap3-gta04a5: fix whitepsace and tab style
Date: Tue, 31 Jul 2018 09:11:29 +0200
Message-ID: <647a18b436d76e738f8103e0a00c9bc22ae6c863.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

in node sound / property ti,jack-det-gpio.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index c01b4715fb83..d408eb05cdfa 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -12,6 +12,6 @@
 	model = "Goldelico GTA04A5/Letux 2804";
 
 	sound {
-		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;    /* GTA04A5 only */
+		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;	/* GTA04A5 only */
 	};
 };
-- 
2.12.2
