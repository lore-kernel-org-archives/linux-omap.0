From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ARM: dts: am33xx: Remove obsolete properties from edma node
Date: Tue, 13 May 2014 10:43:47 +0300
Message-ID: <1399967028-24757-4-git-send-email-peter.ujfalusi@ti.com>
References: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, joelf@ti.com
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
the the same information is available in the IP's CCCFG register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index baf56cc92040..5e8f647ee4ec 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -147,9 +147,6 @@
 				<0x44e10f90 0x10>;
 			interrupts = <12 13 14>;
 			#dma-cells = <1>;
-			dma-channels = <64>;
-			ti,edma-regions = <4>;
-			ti,edma-slots = <256>;
 		};
 
 		gpio0: gpio@44e07000 {
-- 
1.9.3
