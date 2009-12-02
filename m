From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/9] arm: omap: innovator: kill compile warning on
 board-innovator.c
Date: Tue, 1 Dec 2009 16:09:34 -0800
Message-ID: <20091202000934.GG4348@atomide.com>
References: <1259692132-17445-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53010 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZLBAJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 19:09:31 -0500
Content-Disposition: inline
In-Reply-To: <1259692132-17445-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [091201 10:28]:
> that address is used by struct map_desc, which expects
> an unsigned long instead of a void __iomem *. Fix it.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> Is this what you mean ??

Yeah, thanks!

Tony
 
>  arch/arm/plat-omap/include/plat/fpga.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
> index f1864a6..db2af50 100644
> --- a/arch/arm/plat-omap/include/plat/fpga.h
> +++ b/arch/arm/plat-omap/include/plat/fpga.h
> @@ -85,9 +85,9 @@ struct h2p2_dbg_fpga {
>   *  OMAP-1510 FPGA
>   * ---------------------------------------------------------------------------
>   */
> -#define OMAP1510_FPGA_BASE		IOMEM(0xE8000000)	/* VA */
> +#define OMAP1510_FPGA_BASE		0xE8000000		/* VA */
>  #define OMAP1510_FPGA_SIZE		SZ_4K
> -#define OMAP1510_FPGA_START		0x08000000		/* PA */
> +#define OMAP1510_FPGA_START		IOMEM(0x08000000)	/* PA */
>  
>  /* Revision */
>  #define OMAP1510_FPGA_REV_LOW			(OMAP1510_FPGA_BASE + 0x0)
> -- 
> 1.6.6.rc0
> 
