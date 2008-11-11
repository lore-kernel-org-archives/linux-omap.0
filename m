From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request
 line > 63
Date: Tue, 11 Nov 2008 19:03:49 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52954 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbYKKNeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 08:34:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mABDXtpO022248
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 07:34:01 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mABDXrnq004021
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 19:03:54 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pushed to zoom tree.

>-----Original Message-----
>From: Gadiyar, Anand
>Sent: Monday, November 10, 2008 5:08 AM
>To: linux-omap@vger.kernel.org
>Cc: Pandita, Vikram; tony@atomide.com
>Subject: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request line > 63
>
>From: Anand Gadiyar <gadiyar@ti.com>
>
>Bug in existing code causes synchro control to be set +32 if request
>line greater than 63 is used.
>
>Reported by Wenbiao Wang
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>---
>Patch generated against OMAPZOOM tree. Will apply against
>linux-omap as well with an offset of 8 lines.
>
>diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>index 562089e..b38a362 100644
>--- a/arch/arm/plat-omap/dma.c
>+++ b/arch/arm/plat-omap/dma.c
>@@ -287,10 +287,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
>
> 		val = dma_read(CCR(lch));
> 		val &= ~(3 << 19);
>-		if (dma_trigger > 63)
>-			val |= 1 << 20;
>-		if (dma_trigger > 31)
>-			val |= 1 << 19;
>+		val |= ((dma_trigger & ~(0x1f)) << 14);
>
> 		val &= ~(0x1f);
> 		val |= (dma_trigger & 0x1f);
