From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request line >
 63
Date: Mon, 10 Nov 2008 16:38:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYKJLI2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:08:28 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>

From: Anand Gadiyar <gadiyar@ti.com>

Bug in existing code causes synchro control to be set +32 if request
line greater than 63 is used.

Reported by Wenbiao Wang

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Patch generated against OMAPZOOM tree. Will apply against
linux-omap as well with an offset of 8 lines.

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 562089e..b38a362 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -287,10 +287,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 
 		val = dma_read(CCR(lch));
 		val &= ~(3 << 19);
-		if (dma_trigger > 63)
-			val |= 1 << 20;
-		if (dma_trigger > 31)
-			val |= 1 << 19;
+		val |= ((dma_trigger & ~(0x1f)) << 14);
 
 		val &= ~(0x1f);
 		val |= (dma_trigger & 0x1f);