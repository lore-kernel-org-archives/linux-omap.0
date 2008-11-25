From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] [OMAPZOOM]  OMAP : DMA: added helper APIs in dma.c
Date: Tue, 25 Nov 2008 17:30:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02936BE46E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbYKYMBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 07:01:05 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>

By mistake I sent to 'linux-omap-owner@vger.kernel.org'

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Added helper APIs in the arch/arm/plat-omap/dma.c.Declaration was already
present in arch/arm/plat-omap/include/mach/dma.h. 
APIs are 1) omap_set_dma_src_endian_type
	   2) omap_set_dma_dst_endian_type
	   3) omap_get_dma_index
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2008-10-24 12:27:56.000000000 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2008-11-25 12:28:04.721536991 +0530
@@ -597,6 +597,18 @@ void omap_set_dma_dest_burst_mode(int lc
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
+void omap_set_dma_src_endian_type(int lch, enum end_type etype)
+{
+	OMAP_DMA_CSDP_REG(lch) |= ((etype & 0x1) << 21);
+}
+EXPORT_SYMBOL(omap_set_dma_src_endian_type);
+
+void omap_set_dma_dst_endian_type(int lch, enum end_type etype)
+{
+	OMAP_DMA_CSDP_REG(lch) |= ((etype & 0x1) << 19);
+}
+EXPORT_SYMBOL(omap_set_dma_dst_endian_type);
+
 static inline void omap_enable_channel_irq(int lch)
 {
 	u32 status;
@@ -1020,6 +1032,26 @@ int omap_set_dma_callback(int lch,
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
+
+	*ei = OMAP2_DMA_CCEN_REG(lch);
+	*fi = OMAP2_DMA_CCFN_REG(lch);
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_index);
 /*
  * Returns current physical source address for the given DMA channel.
  * If the channel is running the caller must disable interrupts prior calling


_______________________________

	From: Pandita, Vikram 
	Sent: Tuesday, November 25, 2008 11:44 AM
	To: Shilimkar, Santosh; Diaz Prado, Gustavo
	Cc: Arce, Abraham; Olivares, Ricardo Perez; Zavala Trujillo, Diego; Torres Martinez, Cristopherson; Kamat, Nishant
	Subject: RE: DMA unresolved symbol on OmapZoom kernel
	
	

	Santosh

	 

	Can you send a patch for this.

	 

	________________________________

		From: Shilimkar, Santosh 
	Sent: Monday, November 24, 2008 11:27 PM
	To: Diaz Prado, Gustavo
	Cc: Arce, Abraham; Olivares, Ricardo Perez; Zavala Trujillo, Diego; Torres Martinez, Cristopherson; Kamat, Nishant; Pandita, Vikram
	Subject: RE: DMA unresolved symbol on OmapZoom kernel

	 

	Hi Gus,

	 

	I just checked the OMAPZoom codebase and saw that function 'omap_set_dma_src_endian_type' is missing from dma.c

	 

	Test suite compiled because dma.h has the declaration of the function. This function should be added to dma.c in order to use it.

	 

	Hope this clarifies.

	 

	Regards,

	Santosh Shilimkar

	 

		 

		________________________________

				From: Diaz Prado, Gustavo 
		Sent: Tuesday, November 25, 2008 6:42 AM
		To: Shilimkar, Santosh
		Cc: Arce, Abraham; Olivares, Ricardo Perez; Zavala Trujillo, Diego; Torres Martinez, Cristopherson
		Subject: DMA unresolved symbol on OmapZoom kernel

		Good day Santosh,

		 

		We are having an issue when running the DMA testcases:

		 

		Unknown symbol omap_set_dma_src_endian_type

		 

		This message doesn't show up when we run the tests on a different kernel than Android or OmapZoom (on 12x and 23x is ok). The testsuite compiles fine but the test module fails due to the previous error when it is inserted into the kernel. Could you give us some advice?

		 

		Regards,

		Gus

