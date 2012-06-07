From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 2/3] dmaengine: virt-dma: vchan_find_desc()
Date: Thu, 07 Jun 2012 11:41:02 +0100
Message-ID: <E1Sca9G-0003at-Mj@rmk-PC.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54121 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab2FGKlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:41:07 -0400
In-Reply-To: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Add a function to find a descriptor within the depths of the
virtualized DMA channel support.  Needed for tx_status functionality.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/virt-dma.c |   13 +++++++++++++
 drivers/dma/virt-dma.h |    2 +-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index bd85b05..a8054fc 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -39,6 +39,19 @@ dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(vchan_tx_submit);
 
+struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
+	dma_cookie_t cookie)
+{
+	struct virt_dma_desc *vd;
+
+	list_for_each_entry(vd, &vc->desc_issued, node)
+		if (vd->tx.cookie == cookie)
+			return vd;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_find_desc);
+
 /*
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 825bb96..44ec57e 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -40,8 +40,8 @@ static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
 }
 
 void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head);
-
 void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev);
+struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *, dma_cookie_t);
 
 /**
  * vchan_tx_prep - prepare a descriptor
-- 
1.7.4.4

