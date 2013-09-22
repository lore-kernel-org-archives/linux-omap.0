From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 4/5] dma: cppi41: only allocate descriptor memory once
Date: Sun, 22 Sep 2013 13:57:47 +0200
Message-ID: <1379851068-18675-5-git-send-email-zonque@gmail.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58123 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab3IVL6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:58:09 -0400
In-Reply-To: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

cdd->cd and cdd->descs_phys are allocated DESCS_AREAS times from
init_descs() and freed as often from purge_descs(). This leads to both
memory leaks and double-frees.

Fix this by pulling the calls to dma_{alloc,free}_coherent() out of the
loops.

While at it, remove the intermediate variable mem_decs (I guess it was
only there to make the code comply to the 80-chars CodingSytle rule).

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/cppi41.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d689706..3347321 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -727,13 +727,12 @@ static void purge_descs(struct device *dev, struct cppi41_dd *cdd)
 	mem_decs = ALLOC_DECS_NUM * sizeof(struct cppi41_desc);
 
 	for (i = 0; i < DESCS_AREAS; i++) {
-
 		cppi_writel(0, cdd->qmgr_mem + QMGR_MEMBASE(i));
 		cppi_writel(0, cdd->qmgr_mem + QMGR_MEMCTRL(i));
-
-		dma_free_coherent(dev, mem_decs, cdd->cd,
-				cdd->descs_phys);
 	}
+
+	dma_free_coherent(dev, ALLOC_DECS_NUM * sizeof(struct cppi41_desc),
+			  cdd->cd, cdd->descs_phys);
 }
 
 static void disable_sched(struct cppi41_dd *cdd)
@@ -755,8 +754,7 @@ static void deinit_cppi41(struct device *dev, struct cppi41_dd *cdd)
 
 static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 {
-	unsigned int desc_size;
-	unsigned int mem_decs;
+	unsigned int desc_size = sizeof(struct cppi41_desc);
 	int i;
 	u32 reg;
 	u32 idx;
@@ -765,28 +763,25 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 			(sizeof(struct cppi41_desc) - 1));
 	BUILD_BUG_ON(sizeof(struct cppi41_desc) < 32);
 	BUILD_BUG_ON(ALLOC_DECS_NUM < 32);
+	BUILD_BUG_ON(DESCS_AREAS != 1);
 
-	desc_size = sizeof(struct cppi41_desc);
-	mem_decs = ALLOC_DECS_NUM * desc_size;
+	cdd->cd = dma_alloc_coherent(dev, ALLOC_DECS_NUM * desc_size,
+				     &cdd->descs_phys, GFP_KERNEL);
+	if (!cdd->cd)
+		return -ENOMEM;
 
 	idx = 0;
 	for (i = 0; i < DESCS_AREAS; i++) {
-
 		reg = idx << QMGR_MEMCTRL_IDX_SH;
 		reg |= (ilog2(desc_size) - 5) << QMGR_MEMCTRL_DESC_SH;
 		reg |= ilog2(ALLOC_DECS_NUM) - 5;
 
-		BUILD_BUG_ON(DESCS_AREAS != 1);
-		cdd->cd = dma_alloc_coherent(dev, mem_decs,
-				&cdd->descs_phys, GFP_KERNEL);
-		if (!cdd->cd)
-			return -ENOMEM;
-
 		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
 		cppi_writel(reg, cdd->qmgr_mem + QMGR_MEMCTRL(i));
 
 		idx += ALLOC_DECS_NUM;
 	}
+
 	return 0;
 }
 
-- 
1.8.3.1

