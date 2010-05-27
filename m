From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 6/7] DSPBRIDGE: add dspbridge API to mark end of DMA
Date: Thu, 27 May 2010 19:02:13 +0300
Message-ID: <1274976134-22769-7-git-send-email-ohad@wizery.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0E0QCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:46 -0400
Received: by fg-out-1718.google.com with SMTP id d23so83476fga.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:45 -0700 (PDT)
In-Reply-To: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add new dspbridge API that ends DMA transfers.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 drivers/dsp/bridge/rmgr/proc.c |   68 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 2710a11..e952d2e 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -653,6 +653,36 @@ out:
 	return ret;
 }
 
+static int memory_regain_ownership(struct dmm_map_object *map_obj,
+		unsigned long start, ssize_t len, enum dma_data_direction dir)
+{
+	int ret = 0;
+	unsigned long first_data_page = start >> PAGE_SHIFT;
+	unsigned long last_data_page = ((u32)(start + len - 1) >> PAGE_SHIFT);
+	/* calculating the number of pages this area spans */
+	unsigned long num_pages = last_data_page - first_data_page + 1;
+	struct bridge_dma_map_info *dma_info = &map_obj->dma_info;
+
+	if (!dma_info->sg)
+		goto out;
+
+	if (dma_info->dir != dir || dma_info->num_pages != num_pages) {
+		pr_err("%s: dma info doesn't match given params\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_unmap_sg(bridge, dma_info->sg, num_pages, dma_info->dir);
+
+	pr_debug("%s: dma_map_sg unmapped\n", __func__);
+
+	kfree(dma_info->sg);
+
+	map_obj->dma_info.sg = NULL;
+
+out:
+	return ret;
+}
+
 /* Cache operation against kernel address instead of users */
 static int memory_give_ownership(struct dmm_map_object *map_obj,
 		unsigned long start, ssize_t len, enum dma_data_direction dir)
@@ -749,6 +779,44 @@ err_out:
 	return status;
 }
 
+static int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
+			enum dma_data_direction dir)
+{
+	/* Keep STATUS here for future additions to this function */
+	int status = 0;
+	struct process_context *pr_ctxt = (struct process_context *) hprocessor;
+	struct dmm_map_object *map_obj;
+
+	DBC_REQUIRE(refs > 0);
+
+	if (!pr_ctxt) {
+		status = -EFAULT;
+		goto err_out;
+	}
+
+	pr_debug("%s: addr 0x%x, size 0x%x, type %d\n", __func__,
+							(u32)pmpu_addr,
+							ul_size, dir);
+
+	/* find requested memory are in cached mapping information */
+	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
+	if (!map_obj) {
+		pr_err("%s: find_containing_mapping failed\n", __func__);
+		status = -EFAULT;
+		goto err_out;
+	}
+
+	if (memory_regain_ownership(map_obj, (u32) pmpu_addr, ul_size, dir)) {
+		pr_err("%s: InValid address parameters %p %x\n",
+		       __func__, pmpu_addr, ul_size);
+		status = -EFAULT;
+		goto err_out;
+	}
+
+err_out:
+	return status;
+}
+
 /*
  *  ======== proc_flush_memory ========
  *  Purpose:
-- 
1.7.0.4

