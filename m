From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: Fix chain_a_transfer return value
Date: Tue, 11 Mar 2008 12:10:35 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088057E3F70@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40552 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbYCKGk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 02:40:59 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m2B6ecQl024028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 Mar 2008 01:40:48 -0500
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m2B6eIIv011143
	for <linux-omap@vger.kernel.org>; Tue, 11 Mar 2008 01:40:38 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

This patch changes the return value of omap_dma_chain_a_transfer
to 0 on success instead of the flag 'start_dma', which wasn't really useful
for anything.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
This patch seems to have been accidentally reversed by commit
6d6baabf174b0543db0873282ec233b5ecc6c083 (ARM: OMAP: Fix DMA comments from RMK)

 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/dma.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/dma.c	2008-02-19 11:15:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/dma.c	2008-03-11 12:04:07.142786661 +0530
@@ -1248,7 +1248,7 @@ EXPORT_SYMBOL(omap_dma_chain_status);
  * @param frame_count
  * @param callbk_data - channel callback parameter data.
  *
- * @return  - Success : start_dma status
+ * @return  - Success : 0
  * 	      Failure: -EINVAL/-EBUSY
  */
 int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
@@ -1367,7 +1367,7 @@ int omap_dma_chain_a_transfer(int chain_
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
 	}
-	return start_dma;
+	return 0;
 }
 EXPORT_SYMBOL(omap_dma_chain_a_transfer);
 
