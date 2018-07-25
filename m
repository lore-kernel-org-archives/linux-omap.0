From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 25/32] ARM: dts: omap3-gta04a5: fix model name
Date: Wed, 25 Jul 2018 08:58:57 +0200
Message-ID: <4010fdcb8d513673613560aa2c62babdb8a62a24.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 is the project name and Letux 2804 the product name.
Report both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index b691e70773f9..c01b4715fb83 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -9,7 +9,7 @@
 #include "omap3-gta04.dtsi"
 
 / {
-	model = "Goldelico GTA04A5";
+	model = "Goldelico GTA04A5/Letux 2804";
 
 	sound {
 		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;    /* GTA04A5 only */
-- 
2.12.2
