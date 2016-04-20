From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: AM57xx/DRA7: Update SoC voltage rail limits to match data sheet
Date: Wed, 20 Apr 2016 03:18:39 -0500
Message-ID: <1461140319-32026-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

As per the data sheet starting from SPRUHQ0H (Nov 2015 - Latest[1]),
VDD_CORE can vary from 0.85v to 1.15v for AVS class0. VDD GPU/DSP
et.al. can range from 0.85v to 1.25V with AVS class0

Since dynamic voltage scaling is disabled for DRA7/AM57xx SoCs for
all SoC rails other than MPU, the bootloader is responsible for
setting up the AVS class0 voltage, however, with wrong voltage machine
constraints in dtb, regulator framework will lower the voltage below
the required voltage levels for certain samples in production flow.
This can cause catastrophic failures which can be pretty hard to
identify.

Update board files which don't match required specification.

[1] http://www.ti.com/product/AM5728/datasheet/specifications#SPRT637-7340

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
omap-for-v4.7/dt     a4240d3af677 ARM: dts: Add support for dra72-evm rev C (SR2.0)

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++--
 arch/arm/boot/dts/dra7-evm.dts          | 4 ++--
 arch/arm/boot/dts/dra72-evm-common.dtsi | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 75d04b1bbd1b..779466e18d34 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -438,7 +438,7 @@
 					/* VDD_DSPEVE, VDD_IVA, VDD_GPU */
 					regulator-name = "smps45";
 					regulator-min-microvolt = < 850000>;
-					regulator-max-microvolt = <1150000>;
+					regulator-max-microvolt = <1250000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
@@ -447,7 +447,7 @@
 					/* VDD_CORE */
 					regulator-name = "smps6";
 					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1030000>;
+					regulator-max-microvolt = <1150000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d272cf140197..e94cbb7dd3c5 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -431,7 +431,7 @@
 					/* VDD_DSPEVE */
 					regulator-name = "smps45";
 					regulator-min-microvolt = < 850000>;
-					regulator-max-microvolt = <1150000>;
+					regulator-max-microvolt = <1250000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
@@ -449,7 +449,7 @@
 					/* CORE_VDD */
 					regulator-name = "smps7";
 					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1060000>;
+					regulator-max-microvolt = <1150000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2c880501ba2e..874bdf1db306 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -328,7 +328,7 @@
 					/* VDD_CORE */
 					regulator-name = "smps2";
 					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1060000>;
+					regulator-max-microvolt = <1150000>;
 					regulator-boot-on;
 					regulator-always-on;
 				};
-- 
2.8.0
