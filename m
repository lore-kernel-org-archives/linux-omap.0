From: Fernando Guzman Lugo <fernando.lugo@ti.com>
Subject: [PATCH] rpmsg: use right device paramter when calling
 dma_free_coherent function
Date: Wed, 29 Aug 2012 19:24:52 -0500
Message-ID: <1346286292-21773-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

dma_alloc/free_coherent APIs requires the platform specific remoteproc
device as the device parameter. We are passing vdev->dev.parent to the
dma_free_coherent function which is the generic rproc device and it is
wrong, it has to be vdev->dev.parent->parent instead, same as when we
call dma_alloc_coherent function.

Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 590cfaf..1859f71 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -1008,8 +1008,8 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	return 0;
 
 free_coherent:
-	dma_free_coherent(vdev->dev.parent, RPMSG_TOTAL_BUF_SPACE, bufs_va,
-					vrp->bufs_dma);
+	dma_free_coherent(vdev->dev.parent->parent, RPMSG_TOTAL_BUF_SPACE,
+					bufs_va, vrp->bufs_dma);
 vqs_del:
 	vdev->config->del_vqs(vrp->vdev);
 free_vrp:
@@ -1043,7 +1043,7 @@ static void __devexit rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vrp->vdev);
 
-	dma_free_coherent(vdev->dev.parent, RPMSG_TOTAL_BUF_SPACE,
+	dma_free_coherent(vdev->dev.parent->parent, RPMSG_TOTAL_BUF_SPACE,
 					vrp->rbufs, vrp->bufs_dma);
 
 	kfree(vrp);
-- 
1.7.1
