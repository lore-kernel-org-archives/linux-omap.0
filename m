From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3] dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3) voltage
Date: Mon, 14 Nov 2016 12:55:15 +0100
Message-ID: <9718ff02c1c863e97bf1247009db8292fcff7d8d.1479124514.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

DDR3L is usually specified as

	JEDEC standard 1.35V(1.28V~1.45V) & 1.5V(1.425V~1.575V)

Therefore setting smps6 regulator to 1.2V is definitively below
minimum. It appears that real world chips are more forgiving than
data sheets indicate, but let's set the regulator right.

Note: a board that uses other voltages (DDR with 1.5V) can
overwrite by referencing &smps6_reg.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index ab60a8e..e4a14d5 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -476,8 +476,8 @@
 				smps6_reg: smps6 {
 					/* VDD_DDR3 - over VDD_SMPS6 */
 					regulator-name = "smps6";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
-- 
2.7.3
