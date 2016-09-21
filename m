From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/9] dmaengine: edma: Use correct type for of_find_property() third parameter
Date: Wed, 21 Sep 2016 15:41:29 +0300
Message-ID: <20160921124135.11849-4-peter.ujfalusi@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The correct type is int and not for the third parameter of
of_find_property().
Fixes compilation for 64bit architectures (x86_64, aarch64).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 87c58710ae31..0241f39ba64c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2026,8 +2026,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 {
 	struct edma_soc_info *info;
 	struct property *prop;
-	size_t sz;
-	int ret;
+	int sz, ret;
 
 	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
 	if (!info)
-- 
2.10.0
