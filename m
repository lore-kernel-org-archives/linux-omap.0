From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request
	line > 63
Date: Thu, 8 Jan 2009 15:31:20 +0200
Message-ID: <20090108133119.GH27566@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53430 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZAHNbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 08:31:21 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [081111 15:34]:
> Pushed to zoom tree.

Sorry for the long delay with this. Pushing to l-o tree and
added to omap-fixes queue.

Tony


> >-----Original Message-----
> >From: Gadiyar, Anand
> >Sent: Monday, November 10, 2008 5:08 AM
> >To: linux-omap@vger.kernel.org
> >Cc: Pandita, Vikram; tony@atomide.com
> >Subject: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request line > 63
> >
> >From: Anand Gadiyar <gadiyar@ti.com>
> >
> >Bug in existing code causes synchro control to be set +32 if request
> >line greater than 63 is used.
> >
> >Reported by Wenbiao Wang
> >
> >Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> >---
> >Patch generated against OMAPZOOM tree. Will apply against
> >linux-omap as well with an offset of 8 lines.
> >
> >diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> >index 562089e..b38a362 100644
> >--- a/arch/arm/plat-omap/dma.c
> >+++ b/arch/arm/plat-omap/dma.c
> >@@ -287,10 +287,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
> >
> > 		val = dma_read(CCR(lch));
> > 		val &= ~(3 << 19);
> >-		if (dma_trigger > 63)
> >-			val |= 1 << 20;
> >-		if (dma_trigger > 31)
> >-			val |= 1 << 19;
> >+		val |= ((dma_trigger & ~(0x1f)) << 14);
> >
> > 		val &= ~(0x1f);
> > 		val |= (dma_trigger & 0x1f);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
