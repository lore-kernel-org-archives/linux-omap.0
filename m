From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after DSP_MMUFAULT
Date: Tue, 13 Apr 2010 11:46:40 -0500
Message-ID: <1271177200-1054-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44341 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab0DMQqp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Apr 2010 12:46:45 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DGkjeh025010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 11:46:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>

kmalloc() does not guarantee page aligned memory always,hence
resulting in virtual addresses not getting aligned to page boundary.
This patch replaces kmalloc() with __get_free_pages() which
allocates kernel memory in terms of PAGES fixing the Kernel
memory corruption after DSP_MMUFAULT.

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 14dd8ae..7ed5f60 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -239,7 +239,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			       "bridge_deh_notify: DSP_MMUFAULT, fault "
 			       "address = 0x%x\n", (unsigned int)fault_addr);
 			dummy_va_addr =
-			    (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+			    (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
+						     0);
 			mem_physical =
 			    VIRT_TO_PHYS(PG_ALIGN_LOW
 					 ((u32) dummy_va_addr, PG_SIZE4K));
@@ -338,6 +339,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
  */
 void bridge_deh_release_dummy_mem(void)
 {
-	kfree((void *)dummy_va_addr);
+	free_pages((void *)dummy_va_addr, 0);
 	dummy_va_addr = 0;
 }
-- 
1.6.3.3

