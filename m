From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
Date: Tue, 24 Jul 2012 11:48:54 +0530
Message-ID: <1343110735-10640-4-git-send-email-anilkumar@ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40715 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362Ab2GXGTT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 02:19:19 -0400
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

Add tps65910 regulator device tree data to AM335x-EVM by adding
regulator consumers with tightened constraints and regulator-name.
TPS65910 regulator handle can be obtained by using this regulator
name.

This patch also add I2C node with I2C frequency and tps65910 PMIC
I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d6a97d9..e4e1ccb 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -18,3 +18,31 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	tps: tps@2D {
+		reg = <0x2D>;
+	};
+};
+
+/include/ "tps65910.dtsi"
+
+&vdd1_reg {
+	/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+	regulator-name = "vdd_mpu";
+	regulator-min-microvolt = <912500>;
+	regulator-max-microvolt = <1312500>;
+	regulator-boot-on;
+	regulator-always-on;
+};
+
+&vdd2_reg {
+	/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+	regulator-name = "vdd_core";
+	regulator-min-microvolt = <912500>;
+	regulator-max-microvolt = <1150000>;
+	regulator-boot-on;
+	regulator-always-on;
+};
-- 
1.7.9.5

