From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Fix printk's error messages.
Date: Mon, 2 Feb 2009 11:32:49 -0600
Message-ID: <200902021132.50290.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbZBBRdB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Feb 2009 12:33:01 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: klimov.linux@gmail.com

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Fix printk's error messages.

This patch adds CRLF characters to some printk's.
Added 'ISP_ERR' at beginning of message a thats how other printks are formated in 
this module.
Reported-by: Alexey Klimov <klimov.linux@gmail.com>

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 drivers/media/video/isp/isp.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -1175,13 +1175,14 @@ u32 isp_buf_allocation(void)
 	buff_addr = (void *) vmalloc(ISP_BUFFER_MAX_SIZE);
 
 	if (!buff_addr) {
-		printk(KERN_ERR "Cannot allocate memory ");
+		printk(KERN_ERR "ISP_ERR: Cannot allocate "
+			"ISP_WORKAROUND memory\n");
 		return -ENOMEM;
 	}
 
 	sglist_alloc = videobuf_vmalloc_to_sg(buff_addr, ISP_BUFFER_MAX_PAGES);
 	if (!sglist_alloc) {
-		printk(KERN_ERR "videobuf_vmalloc_to_sg error");
+		printk(KERN_ERR "ISP_ERR: videobuf_vmalloc_to_sg failed\n");
 		return -ENOMEM;
 	}
 	num_sc = dma_map_sg(NULL, sglist_alloc, ISP_BUFFER_MAX_PAGES, 1);
@@ -1196,7 +1197,7 @@ u32 isp_buf_mmap(void)
 {
 	buff_addr_mapped = ispmmu_map_sg(sglist_alloc, ISP_BUFFER_MAX_PAGES);
 	if (!buff_addr_mapped) {
-		printk(KERN_ERR "ispmmu_map_sg mapping failed ");
+		printk(KERN_ERR "ISP_ERR: ispmmu_map_sg mapping failed\n");
 		return -ENOMEM;
 	}
 	isppreview_set_outaddr(buff_addr_mapped);
