From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [OMAP3] ALSA driver 'suspend/resume' handlers
Date: Sat, 3 Oct 2009 03:56:51 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE9215@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45944 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZJBW0z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 18:26:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Tony,
Can you check below patch? If it is OK, please add this to omap-fixes
-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
Sent: Wednesday, September 30, 2009 11:38 AM
To: Jarkko Nikula
Cc: hari n; Pandita, Vikram; linux-omap@vger.kernel.org
Subject: RE: [OMAP3] ALSA driver 'suspend/resume' handlers


> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Wednesday, September 30, 2009 11:10 AM
> To: Shilimkar, Santosh
> Cc: hari n; Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: Re: [OMAP3] ALSA driver 'suspend/resume' handlers
> 
> On Tue, 29 Sep 2009 21:28:45 +0530
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:
> 
> > > Having said that, there is also bug in the DMA driver which doesn't
> > > disable the channel in linking cases. Since we use always hardware
> > > synchronized method, hardware will take care of draining the buffer so
> no
> > > loss of data.
> > >
> > > So option B should be ok and USB case also would work as mentioned
> above.
> >
> > Which option finally we converged on this issue? Shall we fix in the DMA
> driver or you want to do this in ALSA?
> >
> For me it looks that at least the omap_stop_dma should be fixed to stop
> ongoing transfer always when it's called. As the name suggest :-)
Agree !!
Have a look at below patch and let me know if it's ok.

>From 6042ce380c36907b0740e208f243f00ca370d09e Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 30 Sep 2009 11:26:24 +0530
Subject: [PATCH] ARM: OMAP: SDMA: Stop channel in omap_stop_dma() API for linking as well.

OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
in linking scenario. This patch fixes the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC: Hari n <hari.zoom@gmail.com>
CC: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/dma.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fd3154a..633c123 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -975,6 +975,11 @@ void omap_stop_dma(int lch)
 {
 	u32 l;
 
+	/* Disable the DMA channel */
+	l = dma_read(CCR(lch));
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -1000,10 +1005,6 @@ void omap_stop_dma(int lch)
 	if (cpu_class_is_omap1())
 		dma_write(0, CICR(lch));
 
-	l = dma_read(CCR(lch));
-	l &= ~OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
-
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_stop_dma);
-- 
1.5.4.7

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

