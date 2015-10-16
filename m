From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 11/14] dmaengine: Kconfig: edma: Select TI_DMA_CROSSBAR in case of ARCH_OMAP
Date: Fri, 16 Oct 2015 10:18:09 +0300
Message-ID: <1444979892-31626-12-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Since the crossbar is needed for eDMA when it is used on OMAP like
platforms (am335x/am437x and later DRA7xx), select the crossbar to be built
if ARCH_OMAP is set.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index af81a7a1b597..e6cd1a32025a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -486,6 +486,7 @@ config TI_EDMA
 	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select TI_DMA_CROSSBAR if ARCH_OMAP
 	default n
 	help
 	  Enable support for the TI EDMA controller. This DMA
-- 
2.6.1
