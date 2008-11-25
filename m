From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] [OMAPZOOM]  OMAP : DMA: added helper APIs in dma.c
Date: Tue, 25 Nov 2008 20:26:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02936BE5B8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46780 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbYKYO4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 09:56:52 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>

Here is the updated patch.

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Added helper APIs in the arch/arm/plat-omap/dma.c.Declaration was already
present in arch/arm/plat-omap/include/mach/dma.h. 
APIs are 1) omap_set_dma_src_endian_type
	   2) omap_set_dma_dst_endian_type
	   3) omap_get_dma_index
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2008-11-25 20:02:37.000000000 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2008-11-25 20:10:07.505112358 +0530
@@ -594,6 +594,24 @@ void omap_set_dma_dest_burst_mode(int lc
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
+void omap_set_dma_src_endian_type(int lch, enum end_type etype)
+{
+	u32 csdp;
+	csdp = dma_read(CSDP(lch));
+	csdp |= ((etype & 0x1) << 21);
+	dma_write(csdp, CSDP(lch));
+}
+EXPORT_SYMBOL(omap_set_dma_src_endian_type);
+
+void omap_set_dma_dst_endian_type(int lch, enum end_type etype)
+{
+	u32 csdp;
+        csdp = dma_read(CSDP(lch));
+        csdp |= ((etype & 0x1) << 19);
+        dma_write(csdp, CSDP(lch));
+}
+EXPORT_SYMBOL(omap_set_dma_dst_endian_type);
+
 static inline void omap_enable_channel_irq(int lch)
 {
 	u32 status;
@@ -1017,6 +1035,26 @@ int omap_set_dma_callback(int lch,
 }
 EXPORT_SYMBOL(omap_set_dma_callback);
 
+/**
+ * @brief omap_get_dma_index : Get the element and frame number
+ * of the current logical channel
+ *
+ * @param lch : Logical channel number
+ * @param ei : Element index
+ * @param fi : Frame index
+ *
+ * @return  : Success
+ */
+int omap_get_dma_index(int lch, int *ei, int *fi)
+{
+	if ((!ei) || (!fi))
+		return -EPERM;
+	*ei = dma_read(CCEN(lch));
+	*fi = dma_read(CCFN(lch));
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_index);
+
 /*
  * Returns current physical source address for the given DMA channel.
  * If the channel is running the caller must disable interrupts prior calling


Regards
Santosh Shilimkar