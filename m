From: Tony Lindgren <tony@atomide.com>
Subject: Re: [rfc/rft/patch 7/9] arm: omap: innovator: kill compile warning
 on board-innovator.c
Date: Tue, 1 Dec 2009 07:52:29 -0800
Message-ID: <20091201155229.GD4348@atomide.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
 <1259672635-12306-8-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61852 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZLAPw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 10:52:28 -0500
Content-Disposition: inline
In-Reply-To: <1259672635-12306-8-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

* Felipe Balbi <felipe.balbi@nokia.com> [091201 05:03]:
> that address is used by struct map_desc, which expects
> an unsigned long instead of a void __iomem *. Fix it.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/plat-omap/include/plat/fpga.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
> index f1864a6..87a87d2 100644
> --- a/arch/arm/plat-omap/include/plat/fpga.h
> +++ b/arch/arm/plat-omap/include/plat/fpga.h
> @@ -85,7 +85,7 @@ struct h2p2_dbg_fpga {
>   *  OMAP-1510 FPGA
>   * ---------------------------------------------------------------------------
>   */
> -#define OMAP1510_FPGA_BASE		IOMEM(0xE8000000)	/* VA */
> +#define OMAP1510_FPGA_BASE		0xE8000000		/* VA */
>  #define OMAP1510_FPGA_SIZE		SZ_4K
>  #define OMAP1510_FPGA_START		0x08000000		/* PA */
>  

Instead of removing the IOMEM, can you please move it to the
OMAP1510_FPGA_START physical address where it should be?

Thanks,

Tony
