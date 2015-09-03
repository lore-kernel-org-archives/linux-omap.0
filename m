From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 1/2] ARM: dts: am335x-phycore-som: Fix mpu voltage
Date: Thu, 3 Sep 2015 14:00:06 +0200
Message-ID: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Fix the mpu voltage as it is set to low for the silicon
revision 2.1.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 4d28fc3..5dd084f 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -252,10 +252,10 @@
 		};
 
 		vdd1_reg: regulator@2 {
-			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			/* VDD_MPU voltage limits 0.95V - 1.325V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1312500>;
+			regulator-max-microvolt = <1378000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
1.9.1
