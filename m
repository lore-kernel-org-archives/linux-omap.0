From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 09/14] v4l: ti-vpe: report correct capabilities in querycap
Date: Tue, 11 Mar 2014 14:03:48 +0530
Message-ID: <1394526833-24805-10-git-send-email-archit@ti.com>
References: <1393922965-15967-1-git-send-email-archit@ti.com>
 <1394526833-24805-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1394526833-24805-1-git-send-email-archit@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: k.debski@samsung.com, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

querycap currently returns V4L2_CAP_VIDEO_M2M as a capability, this should be
V4L2_CAP_VIDEO_M2M_MPLANE instead, as the driver supports multiplanar formats.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 4abb85c..46b9d44 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1347,7 +1347,7 @@ static int vpe_querycap(struct file *file, void *priv,
 	strncpy(cap->driver, VPE_MODULE_NAME, sizeof(cap->driver) - 1);
 	strncpy(cap->card, VPE_MODULE_NAME, sizeof(cap->card) - 1);
 	strlcpy(cap->bus_info, VPE_MODULE_NAME, sizeof(cap->bus_info));
-	cap->device_caps  = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
+	cap->device_caps  = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
 }
-- 
1.8.3.2
