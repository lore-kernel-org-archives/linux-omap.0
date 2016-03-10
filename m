From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 3/7] ARM: dts: am437x: Fix GPMC dma properties
Date: Thu, 10 Mar 2016 17:56:39 -0600
Message-ID: <1457654203-20856-4-git-send-email-fcooper@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch updates the GPMC's DT DMA property to reflect the updated eDMA
bindings.

Fixes: cce1ee000187 ("ARM: DTS: am437x: Use the new DT bindings for the eDMA3")

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 4 changes:
Split into its own commit. Use proper Fixes syntax.

 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
