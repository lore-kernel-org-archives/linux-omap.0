From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 17/17] ARM: dts: am335x-*: Enable PRU-ICSS nodes
Date: Thu, 22 Nov 2018 13:39:13 +0200
Message-ID: <1542886753-17625-18-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU-ICSS processor bus node and subsystem nodes were left in
disabled state in the base am33xx.dtsi file. PRU-ICSS is supported
on these AM335x boards so enable the PRUSS node.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/am335x-evm.dts          | 8 ++++++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 8 ++++++++
 arch/arm/boot/dts/am335x-icev2.dts        | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 9e5e75e..ea0e869 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -422,3 +422,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 98ec9c3..0e07160 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -800,3 +800,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 245868f..f152c15 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -741,3 +741,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ec..7d2fff2e 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -504,3 +504,11 @@
 		reg = <3>;
 	};
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
