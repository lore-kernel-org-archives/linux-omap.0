From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [RFC PATCH 1/1] OMAP: V4L: Update videobuf-dma-sg usage on omap camera drivers
Date: Tue, 29 Apr 2008 12:02:52 +0300
Message-ID: <1209459772-12659-2-git-send-email-francisco.alecrim@indt.org.br>
References: <"Francisco Alecrim <francisco.alecrim@indt.org.br>">
 <1209459772-12659-1-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbYD2JC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 05:02:58 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3T94Tsv004899
	for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 04:05:31 -0500
In-Reply-To: <1209459772-12659-1-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

Update videobuf-dma-sg usage on omap camera drivers

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |    2 +-
 drivers/media/video/omap24xxcam.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index dce47fc..eeedb36 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -916,7 +916,7 @@ static int camera_core_open(struct inode *inode, struct file *file)
 	vidioc_int_g_fmt_cap(cam->sdev, &format);
 	spin_unlock(&cam->img_lock);
 
-	videobuf_queue_pci_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
+	videobuf_queue_sg_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
 			    fh->type, V4L2_FIELD_NONE,
 			    sizeof(struct videobuf_buffer), fh);
 
diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 4308fec..dfd3479 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -1493,7 +1493,7 @@ static int omap24xxcam_open(struct inode *inode, struct file *file)
 
 	spin_lock_init(&fh->vbq_lock);
 
-	videobuf_queue_pci_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
+	videobuf_queue_sg_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
 				&fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
 				V4L2_FIELD_NONE,
 				sizeof(struct videobuf_buffer), fh);
-- 
1.5.4.4

