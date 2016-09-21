From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 5/9] dmaengine: ti-dma-crossbar: Correct type for of_find_property() third parameter
Date: Wed, 21 Sep 2016 15:41:31 +0300
Message-ID: <20160921124135.11849-6-peter.ujfalusi@ti.com>
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
 drivers/dma/ti-dma-crossbar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 5ae294b256a7..e4f3bd1ae264 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -311,7 +311,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	struct property *prop;
 	struct resource *res;
 	u32 safe_val;
-	size_t sz;
+	int sz;
 	void __iomem *iomem;
 	int i, ret;
 
-- 
2.10.0
