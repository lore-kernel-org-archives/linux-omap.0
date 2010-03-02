From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: DMA: Add API for setting channel dest addr
Date: Tue,  2 Mar 2010 15:45:41 +0530
Message-ID: <1267524941-15526-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47466 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0CBJ5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 04:57:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, "S, Venkatraman" <svenkatr@ti.com>, Govindraj R <govindraj.raja@ti.com>

The new API - omap_set_dma_dst_pos(int lch, int value) is added
for setting channel destination address in CPC/CDAC register

Cc: Tony Lindgren <tony@atomide.com>
Cc: S, Venkatraman <svenkatr@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/dma.c              |   17 +++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..9a2a5c4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1109,6 +1109,23 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 }
 EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
+/**
+ * omap_set_dma_dst_pos() - Set DMA channel destination address
+ * @arg1:  lch      DMA logical channel number
+ * @arg2:  value    Value to write into CDAC register
+ *
+ * Writes "value" into the register CPC/CDAC
+ */
+void omap_set_dma_dst_pos(int lch, int value)
+{
+	if (cpu_is_omap15xx())
+		dma_write(CPC(lch), value);
+	else
+		dma_write(CDAC(lcd), value);
+
+}
+EXPORT_SYMBOL(omap_set_dma_dst_pos);
+
 int omap_get_dma_active_status(int lch)
 {
 	return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) != 0;
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..3b6e43e 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -509,6 +509,7 @@ extern int omap_set_dma_callback(int lch,
 			void *data);
 extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
+extern void omap_set_dma_dst_pos(int lch, int value);
 extern void omap_clear_dma(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
-- 
1.6.0.4

