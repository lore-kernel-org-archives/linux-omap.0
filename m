From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/3] ARM: OMAP1: Camera: Update videobuf utilization
Date: Wed, 21 Nov 2007 18:23:03 -0400
Message-ID: <1195683785-32132-2-git-send-email-edubezval@gmail.com>
References: <1195683785-32132-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195683785-32132-1-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch updates the camera_core.[c,h] to use corretly the new
v4l2 videobuf API.

Also removes VIDEO_BUF reference from Kconfig and adds the correct
dependencies.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/Kconfig       |    3 ++-
 drivers/media/video/omap/camera_core.c |   11 ++++++-----
 drivers/media/video/omap/camera_core.h |    2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 0fb0686..c8d1f4c 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -1,6 +1,7 @@
 config VIDEO_OMAP_CAMERA
 	tristate "OMAP Camera support (EXPERIMENTAL)"
-	select VIDEO_BUF
+	select VIDEOBUF_GEN
+	select VIDEOBUF_DMA_SG
 	depends on VIDEO_DEV && (ARCH_OMAP16XX || ARCH_OMAP24XX)
 	help
 	  V4L2 camera driver support for OMAP1/2 based boards.
diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 1d47212..6e5d8bd 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -393,9 +393,10 @@ static void camera_core_vbq_complete(void *arg1, void *arg)
 static void camera_core_vbq_release(struct videobuf_queue *q,
 				    struct videobuf_buffer *vb)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	videobuf_waiton(vb, 0, 0);
-	videobuf_dma_unmap(q, &vb->dma);
-	videobuf_dma_free(&vb->dma);
+	videobuf_dma_unmap(q, dma);
+	videobuf_dma_free(dma);
 
 	vb->state = STATE_NEEDS_INIT;
 }
@@ -459,13 +460,14 @@ static int camera_core_vbq_prepare(struct videobuf_queue *q,
 static void camera_core_vbq_queue(struct videobuf_queue *q,
 				  struct videobuf_buffer *vb)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	struct camera_fh *fh = q->priv_data;
 	struct camera_device *cam = fh->cam;
 	enum videobuf_state state = vb->state;
 	int err;
 
 	vb->state = STATE_QUEUED;
-	err = camera_core_sgdma_queue(cam, vb->dma.sglist, vb->dma.sglen,
+	err = camera_core_sgdma_queue(cam, dma->sglist, dma->sglen,
 				      camera_core_vbq_complete, vb);
 	if (err) {
 		/* Oops.  We're not supposed to get any errors here.  The only
@@ -915,7 +917,7 @@ static int camera_core_open(struct inode *inode, struct file *file)
 	vidioc_int_g_fmt_cap(cam->sdev, &format);
 	spin_unlock(&cam->img_lock);
 
-	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
+	videobuf_queue_pci_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
 			    fh->type, V4L2_FIELD_NONE,
 			    sizeof(struct videobuf_buffer), fh);
 
@@ -1045,7 +1047,6 @@ static int camera_device_register(struct v4l2_int_device *ctl,
 	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
 
 	/* Need to register for a VID_HARDWARE_* ID in videodev.h */
-	vfd->hardware = 0;
 	vfd->fops = &camera_core_fops;
 	video_set_drvdata(vfd, cam);
 	vfd->minor = -1;
diff --git a/drivers/media/video/omap/camera_core.h b/drivers/media/video/omap/camera_core.h
index e156cc3..02ed5be 100644
--- a/drivers/media/video/omap/camera_core.h
+++ b/drivers/media/video/omap/camera_core.h
@@ -17,8 +17,8 @@
 
 struct camera_fh;
 
-#include <media/video-buf.h>
 #include <asm/scatterlist.h>
+#include <media/videobuf-dma-sg.h>
 #include <media/v4l2-int-device.h>
 
 struct camera_device;
-- 
1.5.3.4.206.g58ba4
