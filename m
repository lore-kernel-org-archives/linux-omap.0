From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix chain_a_transfer return value
Date: Tue, 11 Mar 2008 17:21:34 +0200
Message-ID: <20080311152133.GK7524@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A088057E3F70@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65254 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYCKPVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 11:21:38 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A088057E3F70@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [080311 08:41]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> This patch changes the return value of omap_dma_chain_a_transfer
> to 0 on success instead of the flag 'start_dma', which wasn't really useful
> for anything.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> This patch seems to have been accidentally reversed by commit
> 6d6baabf174b0543db0873282ec233b5ecc6c083 (ARM: OMAP: Fix DMA comments from RMK)
> 
>  arch/arm/plat-omap/dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/dma.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/dma.c	2008-02-19 11:15:51.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/dma.c	2008-03-11 12:04:07.142786661 +0530
> @@ -1248,7 +1248,7 @@ EXPORT_SYMBOL(omap_dma_chain_status);
>   * @param frame_count
>   * @param callbk_data - channel callback parameter data.
>   *
> - * @return  - Success : start_dma status
> + * @return  - Success : 0
>   * 	      Failure: -EINVAL/-EBUSY
>   */
>  int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
> @@ -1367,7 +1367,7 @@ int omap_dma_chain_a_transfer(int chain_
>  			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
>  		}
>  	}
> -	return start_dma;
> +	return 0;
>  }
>  EXPORT_SYMBOL(omap_dma_chain_a_transfer);

Pushing today.

Tony
