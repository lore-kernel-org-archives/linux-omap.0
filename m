From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/3] ARM: dts: am335x-evm: Enable NAND dma prefetch by default
Date: Tue, 25 Jul 2017 21:15:50 -0500
Message-ID: <20170726021552.19880-2-fcooper@ti.com>
References: <20170726021552.19880-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726021552.19880-1-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the default method of prefetch polled shows the highest
possible read and write speed when minimal non NAND background
activity is being done. But it is also very CPU intensive to reach
these high speeds (CPU load of 99% via mtd performance tests). While
DMA prefetch only uses 50% of the CPU to achieve around 23% less in
top read and write performance.

However, as the non NAND CPU load increases the read and write
performance takes a large hit when using polled prefetch. Therefore,
prefetch dma mode ends up outperforming prefetch polled in general
"system level" test. So switch to using dma prefetch by default since
it is likely what most users would prefer.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 1c37a7c..ddd8975 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -531,6 +531,7 @@
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-dma";
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
-- 
2.10.0
