From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] dmaengine: omap-dma: Add memory barrier to dma_resume path
Date: Tue, 16 Sep 2014 16:53:48 +0300
Message-ID: <1410875629-1540-2-git-send-email-peter.ujfalusi@ti.com>
References: <1410875629-1540-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410875629-1540-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add mb() call to resume path to ensure the necessary barrier.
Resume can happen after waking up from suspend for example.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 4cf7d9a950d7..c01ea505ee7c 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1017,6 +1017,8 @@ static int omap_dma_resume(struct omap_chan *c)
 		return -EINVAL;
 
 	if (c->paused) {
+		mb();
+
 		omap_dma_start(c, c->desc);
 		c->paused = false;
 	}
-- 
2.1.0
