From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] omap_vout: Fix "DMA transaction error" issue when rotation is enabled
Date: Fri, 9 Mar 2012 17:41:57 +0530
Message-ID: <1331295117-489-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: mchehab@infradead.org, archit@ti.com, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

When rotation is enabled and driver is configured in USERPTR
buffer exchange mechanism, in specific use-case driver reports
an error,
   "DMA transaction error with device 0".

In driver _buffer_prepare funtion, we were using
"vout->buf_phy_addr[vb->i]" for buffer physical address to
configure SDMA channel, but this variable does get updated
only during init.
And the issue will occur when driver allocates less number
of buffers during init and application requests more buffers
through REQBUF ioctl; this variable will lead to invalid
configuration of SDMA channel leading to DMA transaction error.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Archit/Laurent,
Can you help me to validate this patch on your platform/usecase?

 drivers/media/video/omap/omap_vout_vrfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout_vrfb.c b/drivers/media/video/omap/omap_vout_vrfb.c
index 4be26ab..240d36d 100644
--- a/drivers/media/video/omap/omap_vout_vrfb.c
+++ b/drivers/media/video/omap/omap_vout_vrfb.c
@@ -225,7 +225,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 	if (!is_rotation_enabled(vout))
 		return 0;

-	dmabuf = vout->buf_phy_addr[vb->i];
+	dmabuf = (dma_addr_t) vout->queued_buf_addr[vb->i];
 	/* If rotation is enabled, copy input buffer into VRFB
 	 * memory space using DMA. We are copying input buffer
 	 * into VRFB memory space of desired angle and DSS will
--
1.7.0.4
