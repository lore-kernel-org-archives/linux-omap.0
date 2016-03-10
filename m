From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 7/7] ARM: OMAP2+: Update GPMC and NAND DT binding documentation
Date: Thu, 10 Mar 2016 17:56:43 -0600
Message-ID: <1457654203-20856-8-git-send-email-fcooper@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Add additional details to the GPMC NAND documentation to clarify
what is needed to enable NAND DMA prefetch.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt   | 7 ++++++-
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index 704be93..ae6388a 100644
--- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -33,6 +33,10 @@ Required properties:
 			As this will change in the future, filling correct
 			values here is a requirement.
 
+Required properties when using NAND prefetch dma:
+ - dmas			GPMC NAND prefetch dma channel
+ - dma-names		Must be set to "rxtx"
+
 Timing properties for child nodes. All are optional and default to 0.
 
  - gpmc,sync-clk-ps:	Minimum clock period for synchronous mode, in picoseconds
@@ -119,7 +123,8 @@ Example for an AM33xx board:
 		ti,hwmods = "gpmc";
 		reg = <0x50000000 0x2000>;
 		interrupts = <100>;
-
+		dmas = <&edma 52 0>;
+		dma-names = "rxtx";
 		gpmc,num-cs = <8>;
 		gpmc,num-waitpins = <2>;
 		#address-cells = <2>;
diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index fb733c4..7cb9dc56 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -35,7 +35,7 @@ Optional properties:
 
 		"prefetch-polled"	Prefetch polled mode (default)
 		"polled"		Polled mode, without prefetch
-		"prefetch-dma"		Prefetch enabled sDMA mode
+		"prefetch-dma"		Prefetch enabled DMA mode
 		"prefetch-irq"		Prefetch enabled irq mode
 
  - elm_id:	<deprecated> use "ti,elm-id" instead
-- 
2.7.0
