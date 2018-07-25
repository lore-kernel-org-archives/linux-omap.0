From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 13/32] ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
Date: Wed, 25 Jul 2018 08:58:45 +0200
Message-ID: <967e50885329664596024974694f94efd80f4bd5.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

vaux2 should remain always on since a higher potential at vio
could potentially damage the itg3200 sensor.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 813d93c4c0d2..f6166b37405d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -553,7 +553,7 @@
 &vaux2 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-	regulator-always-on;
+	regulator-always-on;	/* we should never switch off while vio is on! */
 };
 
 /* camera */
-- 
2.12.2
