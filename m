From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 4/5] ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma channel
Date: Thu, 15 Oct 2015 12:37:27 -0500
Message-ID: <1444930648-19313-5-git-send-email-fcooper@ti.com>
References: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Add dma channel information to the gpmc. Although not enabled by
default this will allow prefetch-dma to be used.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
V2 Changes:
Added DMA entry for OMAP4 and OMAP5

 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 arch/arm/boot/dts/dm816x.dtsi | 2 ++
 arch/arm/boot/dts/omap3.dtsi  | 2 ++
 arch/arm/boot/dts/omap4.dtsi  | 2 ++
 arch/arm/boot/dts/omap5.dtsi  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index e065f21..f2d8eed 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -819,6 +819,8 @@
 			ti,no-idle-on-init;
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
+			dmas = <&edma 52>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <7>;
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ec8b7a3..c02061b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -841,6 +841,8 @@
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
+			dmas = <&edma 52>;
+			dma-names = "rxtx";
 			clocks = <&l3s_gclk>;
 			clock-names = "fck";
 			reg = <0x50000000 0x2000>;
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 68fb444..d2e5d31 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -180,6 +180,8 @@
 			#address-cells = <2>;
 			#size-cells = <1>;
 			interrupts = <100>;
+			dmas = <&edma 52>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <6>;
 			gpmc,num-waitpins = <2>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7f212b6..9dbbcf6 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -717,6 +717,8 @@
 			ti,hwmods = "gpmc";
 			reg = <0x6e000000 0x02d0>;
 			interrupts = <20>;
+			dmas = <&sdma 4>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5a206c1..32b65be 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -354,6 +354,8 @@
 			#address-cells = <2>;
 			#size-cells = <1>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 4>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4c04389..ca3c17f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -391,6 +391,8 @@
 			#address-cells = <2>;
 			#size-cells = <1>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 4>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
-- 
2.6.1
