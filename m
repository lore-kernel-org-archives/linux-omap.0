From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti-dma-crossbar: Correct am335x/am43xx mux value type
Date: Fri, 19 May 2017 12:17:27 +0300
Message-ID: <20170519091727.3239-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The used 0x1f mask is only valid for am335x family of SoC, different family
using this type of crossbar might have different number of electable
events. In case of am43xx family 0x3f mask should have been used for
example.
Instead of trying to handle each family's mask, just use u8 type to store
the mux value since the event offsets are aligned to byte offset.

Fixes: 42dbdcc6bf965 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 2403475a37cf..aaff35292c7d 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -49,12 +49,12 @@ struct ti_am335x_xbar_data {
 
 struct ti_am335x_xbar_map {
 	u16 dma_line;
-	u16 mux_val;
+	u8 mux_val;
 };
 
-static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u16 val)
+static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8 val)
 {
-	writeb_relaxed(val & 0x1f, iomem + event);
+	writeb_relaxed(val, iomem + event);
 }
 
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
@@ -105,7 +105,7 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	}
 
 	map->dma_line = (u16)dma_spec->args[0];
-	map->mux_val = (u16)dma_spec->args[2];
+	map->mux_val = (u8)dma_spec->args[2];
 
 	dma_spec->args[2] = 0;
 	dma_spec->args_count = 2;
-- 
2.13.0
