From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/2] ARM: OMAP2: Camera: Update camera driver for correct
	use of API's
Date: Wed, 21 Nov 2007 12:43:50 -0400
Message-ID: <1195663431-20390-2-git-send-email-edubezval@gmail.com>
References: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
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
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

V4l2:
- Updates this camera driver to use correctly the new videobuf API.
Currently, changed to use videobuf_gen and videobuf_dma_sg.
- Removed VIDEO_BUF reference from Kconfig.

S/G:
- Update this code to sg_* helper functions.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/Kconfig       |    3 +-
 drivers/media/video/omap24xxcam.c |   68 +++++++++++++++++++-----------------
 drivers/media/video/omap24xxcam.h |    2 +-
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 7285f08..3fd1d98 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -712,7 +712,8 @@ config VIDEO_CAFE_CCIC
 
 config VIDEO_OMAP2
 	tristate "OMAP 2 Camera support (EXPERIMENTAL)"
-	select VIDEO_BUF
+	select VIDEOBUF_GEN
+	select VIDEOBUF_DMA_SG
 	depends on VIDEO_V4L2 && ARCH_OMAP24XX
 	---help---
 	  Driver for an OMAP 2 camera controller.
diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 8fda9e1..b61a903 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -226,27 +226,28 @@ static void omap24xxcam_core_isr(struct omap24xxcam_device *cam)
  */
 static void omap24xxcam_vbq_free_mmap_buffer(struct videobuf_buffer *vb)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	int i;
 	size_t alloc_size;
 	struct page *page;
 
-	if (vb->dma.sglist == NULL)
+	if (dma->sglist == NULL)
 		return;
 
-	i = vb->dma.sglen;
+	i = dma->sglen;
 	while (i) {
 		i--;
-		alloc_size = vb->dma.sglist[i].length;
-		page = vb->dma.sglist[i].page;
+		alloc_size = sg_dma_len(&dma->sglist[i]);
+		page = sg_page(&dma->sglist[i]);
 		do {
 			ClearPageReserved(page++);
 		} while (alloc_size -= PAGE_SIZE);
-		__free_pages(vb->dma.sglist[i].page,
-			     get_order(vb->dma.sglist[i].length));
+		__free_pages(sg_page(&dma->sglist[i]),
+			     get_order(sg_dma_len(&dma->sglist[i])));
 	}
 
-	kfree(vb->dma.sglist);
-	vb->dma.sglist = NULL;
+	kfree(dma->sglist);
+	dma->sglist = NULL;
 }
 
 /* Release all memory related to the videobuf_queue. */
@@ -278,6 +279,7 @@ static void omap24xxcam_vbq_free_mmap_buffers(struct videobuf_queue *vbq)
  */
 static int omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	unsigned int order;
 	size_t alloc_size, size = vb->bsize; /* vb->bsize is page aligned */
 	struct page *page;
@@ -288,9 +290,8 @@ static int omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
 	 * overhead. We may not use as many entries as we allocate
 	 */
 	max_pages = vb->bsize >> PAGE_SHIFT;
-	vb->dma.sglist =
-		kcalloc(max_pages, sizeof(*vb->dma.sglist), GFP_KERNEL);
-	if (vb->dma.sglist == NULL) {
+	dma->sglist = kcalloc(max_pages, sizeof(*dma->sglist), GFP_KERNEL);
+	if (dma->sglist == NULL) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -318,9 +319,8 @@ static int omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
 		size -= (PAGE_SIZE << order);
 
 		/* append allocated chunk of pages into scatter-gather list */
-		vb->dma.sglist[i].page = page;
-		vb->dma.sglist[i].length = (PAGE_SIZE << order);
-		vb->dma.sglen++;
+		sg_set_buf(&dma->sglist[i], page, (PAGE_SIZE << order));
+		dma->sglen++;
 		i++;
 
 		alloc_size = (PAGE_SIZE << order);
@@ -337,8 +337,8 @@ static int omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
 	 * REVISIT: not fully correct to assign nr_pages == sglen but
 	 * video-buf is passing nr_pages for e.g. unmap_sg calls
 	 */
-	vb->dma.nr_pages = vb->dma.sglen;
-	vb->dma.direction = PCI_DMA_FROMDEVICE;
+	dma->nr_pages = dma->sglen;
+	dma->direction = PCI_DMA_FROMDEVICE;
 
 	return 0;
 
@@ -357,11 +357,12 @@ static int omap24xxcam_vbq_alloc_mmap_buffers(struct videobuf_queue *vbq,
 	mutex_lock(&vbq->lock);
 
 	for (i = 0; i < count; i++) {
+		struct videobuf_dmabuf *dma = videobuf_to_dma(vbq->bufs[i]);
 		err = omap24xxcam_vbq_alloc_mmap_buffer(vbq->bufs[i]);
 		if (err)
 			goto out;
 		dev_dbg(fh->cam->dev, "sglen is %d for buffer %d\n",
-			vbq->bufs[i]->dma.sglen, i);
+			dma->sglen, i);
 	}
 
 	mutex_unlock(&vbq->lock);
@@ -415,7 +416,7 @@ static void omap24xxcam_vbq_complete(struct omap24xxcam_sgdma *sgdma,
 static void omap24xxcam_vbq_release(struct videobuf_queue *vbq,
 				    struct videobuf_buffer *vb)
 {
-	struct videobuf_dmabuf *dma = &vb->dma;
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 
 	/* wait for buffer, especially to get out of the sgdma queue */
 	videobuf_waiton(vb, 0, 0);
@@ -424,8 +425,8 @@ static void omap24xxcam_vbq_release(struct videobuf_queue *vbq,
 			     dma->direction);
 		dma->direction = DMA_NONE;
 	} else {
-		videobuf_dma_unmap(vbq, &vb->dma);
-		videobuf_dma_free(&vb->dma);
+		videobuf_dma_unmap(vbq, dma);
+		videobuf_dma_free(dma);
 	}
 
 	vb->state = STATE_NEEDS_INIT;
@@ -476,6 +477,7 @@ static int omap24xxcam_vbq_prepare(struct videobuf_queue *vbq,
 				   struct videobuf_buffer *vb,
 				   enum v4l2_field field)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	struct omap24xxcam_fh *fh = vbq->priv_data;
 	int err = 0;
 
@@ -525,7 +527,7 @@ static int omap24xxcam_vbq_prepare(struct videobuf_queue *vbq,
 			 * we have built the scatter-gather list by ourself so
 			 * do the scatter-gather mapping as well
 			 */
-			err = omap24xxcam_dma_iolock(vbq, &vb->dma);
+			err = omap24xxcam_dma_iolock(vbq, dma);
 		else
 			err = videobuf_iolock(vbq, vb, NULL);
 	}
@@ -541,6 +543,7 @@ static int omap24xxcam_vbq_prepare(struct videobuf_queue *vbq,
 static void omap24xxcam_vbq_queue(struct videobuf_queue *vbq,
 				  struct videobuf_buffer *vb)
 {
+	struct videobuf_dmabuf *dma = videobuf_to_dma(vb);
 	struct omap24xxcam_fh *fh = vbq->priv_data;
 	struct omap24xxcam_device *cam = fh->cam;
 	enum videobuf_state state = vb->state;
@@ -554,8 +557,8 @@ static void omap24xxcam_vbq_queue(struct videobuf_queue *vbq,
 	 */
 	vb->state = STATE_ACTIVE;
 
-	err = omap24xxcam_sgdma_queue(&fh->cam->sgdma, vb->dma.sglist,
-				      vb->dma.sglen, vb->size,
+	err = omap24xxcam_sgdma_queue(&fh->cam->sgdma, dma->sglist,
+				      dma->sglen, vb->size,
 				      omap24xxcam_vbq_complete, vb);
 
 	if (!err) {
@@ -1401,15 +1404,17 @@ static int omap24xxcam_mmap_buffers(struct file *file,
 
 	size = 0;
 	for (i = first; i <= last; i++) {
+		struct videobuf_dmabuf *dma;
 		vb = vbq->bufs[i];
-		for (j = 0; j < vb->dma.sglen; j++) {
+		dma = videobuf_to_dma(vb);
+		for (j = 0; j < dma->sglen; j++) {
 			err = remap_pfn_range(
 				vma, vma->vm_start + size,
-				page_to_pfn(vb->dma.sglist[j].page),
-				vb->dma.sglist[j].length, vma->vm_page_prot);
+				page_to_pfn(sg_page(&dma->sglist[j])),
+				sg_dma_len(&dma->sglist[j]), vma->vm_page_prot);
 			if (err)
 				goto out;
-			size += vb->dma.sglist[j].length;
+			size += sg_dma_len(&dma->sglist[j]);
 		}
 	}
 
@@ -1483,10 +1488,10 @@ static int omap24xxcam_open(struct inode *inode, struct file *file)
 
 	spin_lock_init(&fh->vbq_lock);
 
-	videobuf_queue_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
-			    &fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
-			    V4L2_FIELD_NONE,
-			    sizeof(struct videobuf_buffer), fh);
+	videobuf_queue_pci_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
+				&fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
+				V4L2_FIELD_NONE,
+				sizeof(struct videobuf_buffer), fh);
 
 	return 0;
 
@@ -1635,7 +1640,6 @@ static int omap24xxcam_device_register(struct v4l2_int_device *s)
 	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
 	vfd->type		 = VID_TYPE_CAPTURE | VID_TYPE_CHROMAKEY;
 	/* need to register for a VID_HARDWARE_* ID in videodev.h */
-	vfd->hardware		 = 0;
 	vfd->fops		 = &omap24xxcam_fops;
 	vfd->priv		 = cam;
 	vfd->minor		 = -1;
diff --git a/drivers/media/video/omap24xxcam.h b/drivers/media/video/omap24xxcam.h
index 7799733..00d0e31 100644
--- a/drivers/media/video/omap24xxcam.h
+++ b/drivers/media/video/omap24xxcam.h
@@ -27,7 +27,7 @@
 #ifndef OMAP24XXCAM_H
 #define OMAP24XXCAM_H
 
-#include <media/video-buf.h>
+#include <media/videobuf-dma-sg.h>
 #include <media/v4l2-int-device.h>
 
 /*
-- 
1.5.3.4.206.g58ba4
