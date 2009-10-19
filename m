From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: SDMA: Fix omap_stop_dma() API for
	channel linking
Date: Mon, 19 Oct 2009 10:23:40 -0700
Message-ID: <20091019172339.GR12576@atomide.com>
References: <1255590416-11550-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56052 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZJSRXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 13:23:38 -0400
Content-Disposition: inline
In-Reply-To: <1255590416-11550-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [091015 00:07]:
> OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
> in linking scenario. This patch fixes the same.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Reviewed-By: Tony Lindgren <tony@atomide.com>
> CC: Hari n <hari.zoom@gmail.com>
> CC: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/dma.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index fd3154a..1c933b4 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -987,6 +987,11 @@ void omap_stop_dma(int lch)
>  			/* Mark the current channel */
>  			dma_chan_link_map[cur_lch] = 1;
>  
> +			/* Disable the DMA channel */
> +			l = dma_read(CCR(lch));
> +			l &= ~OMAP_DMA_CCR_EN;
> +			dma_write(l, CCR(lch));
> +
>  			disable_lnk(cur_lch);
>  
>  			next_lch = dma_chan[cur_lch].next_lch;

Hmm, I'm thinking it should be like this instead to also clear
the dma_chan[lch].flags instead of returning before that.

Can you try this with your testcase?

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 0eb676d..b53125f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -978,6 +978,14 @@ void omap_stop_dma(int lch)
 {
 	u32 l;
 
+	/* Disable all interrupts on the channel */
+	if (cpu_class_is_omap1())
+		dma_write(0, CICR(lch));
+
+	l = dma_read(CCR(lch));
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -995,18 +1003,8 @@ void omap_stop_dma(int lch)
 			next_lch = dma_chan[cur_lch].next_lch;
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-
-		return;
 	}
 
-	/* Disable all interrupts on the channel */
-	if (cpu_class_is_omap1())
-		dma_write(0, CICR(lch));
-
-	l = dma_read(CCR(lch));
-	l &= ~OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
-
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_stop_dma);
