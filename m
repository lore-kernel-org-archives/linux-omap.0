From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 14/15] ARM: dts: dra7: Use sdhci-omap programming model
Date: Tue, 6 Feb 2018 18:28:05 +0530
Message-ID: <20180206125806.19350-15-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the first 2 instances of eMMC/SD/SDIO
controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  3 +--
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  2 +-
 arch/arm/boot/dts/dra7-evm.dts                  |  1 +
 arch/arm/boot/dts/dra7.dtsi                     | 15 ++++++---------
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  2 +-
 arch/arm/boot/dts/dra76-evm.dts                 |  3 ++-
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 7539096fe4d8..1827b1e9a9f2 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -444,8 +444,7 @@
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
-	ti,non-removable;
-	cap-mmc-dual-data-rate;
+	non-removable;
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43cdf523a8a0..855c130afc69 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -423,7 +423,7 @@
 	vmmc-supply = <&v3_3d>;
 	vqmmc-supply = <&v3_3d>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <96000000>;
 };
 
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f1425b0f3a54..e9a1aa17cca5 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -325,6 +325,7 @@
 	vmmc-supply = <&evm_1v8_sw>;
 	vqmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b4ef814c556c..7bf33d522b14 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1066,17 +1066,15 @@
 		};
 
 		mmc1: mmc@4809c000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
-			ti,dual-volt;
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 61>, <&sdma_xbar 62>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
 			max-frequency = <192000000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 		};
 
 		hdqw1w: 1w@480b2000 {
@@ -1087,15 +1085,14 @@
 		};
 
 		mmc2: mmc@480b4000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			max-frequency = <192000000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 		};
 
 		mmc3: mmc@480ad000 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2e485a13dfd7..4f48f97c9c47 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -421,7 +421,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <192000000>;
 };
 
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb96405d06..f8c0c6b068fd 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -307,7 +307,7 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vio_3v3_sd>;
-	vmmc_aux-supply = <&ldo4_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
@@ -324,6 +324,7 @@
 	vmmc-supply = <&vio_1v8>;
 	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_default>;
-- 
2.11.0
