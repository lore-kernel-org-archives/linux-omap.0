From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 03/14] v4l: ti-vpe: Use video_device_release_empty
Date: Tue, 11 Mar 2014 14:03:42 +0530
Message-ID: <1394526833-24805-4-git-send-email-archit@ti.com>
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

The video_device struct is currently embedded in the driver data struct vpe_dev.
A vpe_dev instance is allocated by the driver, and the memory for the vfd is a
part of this struct.

The v4l2 core, however, manages the removal of the vfd region, through the
video_device's .release() op, which currently is the helper
video_device_release. This causes memory corruption, and leads to issues when
we try to re-insert the vpe module.

Use the video_device_release_empty helper function instead

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index f1eae67..0363df6 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -2000,7 +2000,7 @@ static struct video_device vpe_videodev = {
 	.fops		= &vpe_fops,
 	.ioctl_ops	= &vpe_ioctl_ops,
 	.minor		= -1,
-	.release	= video_device_release,
+	.release	= video_device_release_empty,
 	.vfl_dir	= VFL_DIR_M2M,
 };
 
-- 
1.8.3.2
