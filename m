From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/9] dmaengine: edma: enable COMPILE_TEST
Date: Wed, 21 Sep 2016 15:41:33 +0300
Message-ID: <20160921124135.11849-8-peter.ujfalusi@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

To get more coverage, enable COMPILE_TEST for this driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fe2dbb811e19..4348249b943a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -515,7 +515,7 @@ config TI_DMA_CROSSBAR
 
 config TI_EDMA
 	bool "TI EDMA support"
-	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select TI_DMA_CROSSBAR if ARCH_OMAP
-- 
2.10.0
