From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Linux-fbdev-devel] [REVIEW PATCH 8/9] DSS: support for Beagle
	Board
Date: Tue, 4 Nov 2008 10:24:29 -0800
Message-ID: <20081104182427.GZ28924@atomide.com>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51218 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKDSYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 13:24:38 -0500
Content-Disposition: inline
In-Reply-To: <20081104161038.19071.98198.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

Hi,

One comment below.

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [081104 08:32]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> 
>  arch/arm/mach-omap2/board-omap3beagle.c |  121 ++++++++++++++++++++++++++++---
>  1 files changed, 108 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index ce6c7b4..a6fe63d 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c

<snip>

> +static struct omap_fbmem_config beagle_fbmem0_config = {
> +	.size = 1024*768*4,
> +	.start = OMAPFB_MEMTYPE_SDRAM,
> +};
> +
> +static struct omap_fbmem_config beagle_fbmem1_config = {
> +	.size = 1024*768*4,
> +	.start = OMAPFB_MEMTYPE_SDRAM,
> +};
> +
> +static struct omap_fbmem_config beagle_fbmem2_config = {
> +	.size = 1024*768*4,
> +	.start = OMAPFB_MEMTYPE_SDRAM,
> +};
> +
> +
>  static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
>  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
> -	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
> +	{ OMAP_TAG_FBMEM,       &beagle_fbmem0_config },
> +	{ OMAP_TAG_FBMEM,       &beagle_fbmem1_config },
> +	{ OMAP_TAG_FBMEM,       &beagle_fbmem2_config },
>  };
>  

NAK for adding new OMAP_TAGs. We are in process of removing those.
You should be able to use just board specific platform_data.

If there are ATAGs that are needed, they must be ARM generic. They
also need to be acked by Russell King on the linux-arm-kernel mailing
list. I doubt that you'll need those though.

Regards,

Tony
