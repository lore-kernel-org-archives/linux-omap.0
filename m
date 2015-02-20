From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] ARM: DTS: omap5: Correct the dma controller's property names
Date: Fri, 20 Feb 2015 15:42:05 +0200
Message-ID: <1424439726-31994-5-git-send-email-peter.ujfalusi@ti.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vinod.koul@intel.com
List-Id: linux-omap@vger.kernel.org

According to the Documentation/devicetree/bindings/dma/dma.txt the
dma-channels and dma-requests property should not have '#'.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf42c9f..eb6653cbe3f8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -238,8 +238,8 @@
 				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <32>;
-			#dma-requests = <127>;
+			dma-channels = <32>;
+			dma-requests = <127>;
 		};
 
 		gpio1: gpio@4ae10000 {
-- 
2.3.0
