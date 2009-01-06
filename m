From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 2/7] OMAP3ISP: Check asignment on vbq before
 unmapping
Date: Tue, 6 Jan 2009 14:41:54 -0600
Message-ID: <A24693684029E5489D1D202277BE89441632805F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39137 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZAFUmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:04 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06KfvEr007991
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:02 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06KfvMe007656
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:41:57 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 3303ee708f205b5441ca92f4628c195877fbc074 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:17:35 -0600
Subject: [PATCH] OMAP3ISP: Check asignment on vbq before unmapping

This avoids the possible failure when a vbq_release is called when no buffer
has been mapped.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/media/video/isp/isp.c

diff --git a/drivers/media/video/isp/isp.c b/drivers/media/video/isp/isp.c
old mode 100644
new mode 100755
index c841bb4..e75e879
--- a/drivers/media/video/isp/isp.c
+++ b/drivers/media/video/isp/isp.c
@@ -1712,8 +1712,10 @@ EXPORT_SYMBOL(isp_vbq_prepare);
  **/
 void isp_vbq_release(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
 {
-	ispmmu_unmap(ispsg.isp_addr_capture[vb->i]);
-	ispsg.isp_addr_capture[vb->i] = (dma_addr_t) NULL;
+	if (ispsg.isp_addr_capture[vb->i]) {
+		ispmmu_unmap(ispsg.isp_addr_capture[vb->i]);
+		ispsg.isp_addr_capture[vb->i] = (dma_addr_t) NULL;
+	}
 	return;
 }
 EXPORT_SYMBOL(isp_vbq_release);
-- 
1.5.6.5

