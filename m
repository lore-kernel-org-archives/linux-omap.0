From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH][OMAP3][sDMA] : Fixing the DMA chain transfer callback.
Date: Tue, 16 Dec 2008 17:35:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB0297DA1826@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbYLPMF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 07:05:26 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

Tony,
Here is the patch for DMA to ease the chaining usage. OMAP mcbsp drivers makes use of this chaining feature but it's not pushed on mainline yet. It's available on zoom tree. Link for the same driver. http://git.omapzoom.org/?p=omapkernel.git;a=blob;f=arch/arm/mach-omap2/mcbsp.c;h=ce726c5d27eedb678ad3f981e2f5e08134e44e27;hb=2af15d1d7931a7c928d84057ed4494b77769de12


From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch reverts back the change done on OMAP dma library. It corrects the chaining callback and reduces the complexity for the DMA users in chaining. So with this patch, drivers making use of OMAP DMA chaining feature need not built any intelligence for chain related transfers in their callback using private data. 

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked By : Nishant kamat <nskamat@ti.com>
---
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2008-12-04 11:11:07.000000000 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2008-12-16 16:59:42.066118383 +0530
@@ -1936,7 +1936,11 @@ static int omap2_dma_handle_ch(int ch)
 	}
 
 	if (likely(dma_chan[ch].callback != NULL))
-		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+		if (dma_chan[ch].chain_id != -1)
+			dma_chan[ch].callback(dma_chan[ch].chain_id, status,
+					      dma_chan[ch].data);
+		else
+			dma_chan[ch].callback(ch, status, dma_chan[ch].data);
 
 	dma_write(status, CSR(ch));