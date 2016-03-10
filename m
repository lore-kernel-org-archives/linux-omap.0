From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 2/6] ARM: dts: am437x/am33xx: Fix GPMC dma properties
Date: Wed,  9 Mar 2016 22:07:37 -0600
Message-ID: <1457582861-20619-3-git-send-email-fcooper@ti.com>
References: <1457582861-20619-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457582861-20619-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Recent patch series that updated the eDMA driver also updated the eDMA
bindings.

The following patches forgot to update the DMA bindings for the GPMC node.
ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
ARM: DTS: am437x: Use the new DT bindings for the eDMA3

This patch corrects this so NAND with DMA prefetch can work.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1fafaad..97471d6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -860,7 +860,7 @@
 			ti,no-idle-on-init;
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
-			dmas = <&edma 52>;
+			dmas = <&edma 52 0>;
 			dma-names = "rxtx";
 			gpmc,num-cs = <7>;
 			gpmc,num-waitpins = <2>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 92068fb..2878b04 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -884,7 +884,7 @@
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
-			dmas = <&edma 52>;
+			dmas = <&edma 52 0>;
 			dma-names = "rxtx";
 			clocks = <&l3s_gclk>;
 			clock-names = "fck";
-- 
2.7.0
