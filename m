From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 9/9] dmaengine: ti-dma-crossbar: enable COMPILE_TEST
Date: Fri, 16 Sep 2016 11:33:24 +0300
Message-ID: <20160916083324.29133-10-peter.ujfalusi@ti.com>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916083324.29133-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

To get more coverage, enable COMPILE_TEST for this driver.
When compile testing eDMA or omap-dma, select also the ti-dma-crossbar so
it is also covered by the compile testing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 84647d6cb2f4..1c11628062ad 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -133,7 +133,7 @@ config DMA_OMAP
 	depends on ARCH_OMAP || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-	select TI_DMA_CROSSBAR if SOC_DRA7XX
+	select TI_DMA_CROSSBAR if (SOC_DRA7XX || COMPILE_TEST)
 
 config DMA_SA11X0
 	tristate "SA-11x0 DMA support"
@@ -518,7 +518,7 @@ config TI_EDMA
 	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-	select TI_DMA_CROSSBAR if ARCH_OMAP
+	select TI_DMA_CROSSBAR if (ARCH_OMAP || COMPILE_TEST)
 	default n
 	help
 	  Enable support for the TI EDMA controller. This DMA
-- 
2.10.0
