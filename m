From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: Beagle: revision detection
Date: Tue, 17 Aug 2010 09:10:23 +0300
Message-ID: <20100817061022.GC12184@atomide.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52646 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0HQGKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 02:10:20 -0400
Content-Disposition: inline
In-Reply-To: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

* Robert Nelson <robertcnelson@gmail.com> [100816 17:29]:
> Due to the omap3530 ES3.0 Silicon being used on both the
> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
> routines to differentiate the Beagle Boards.
> 
> However gpio pins 171,172,173 where setup for this prupose, so 
> lets use them.
> 
> Changes:
> for older U-Boot's, use omap_mux_init_gpio()
> keep Beagle Rev in board-omap3beagle.c
> 
> Tested on Beagle Revisions: B5, C2, C4, and xMA

Looks good, just one minor comment below.
 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   79 +++++++++++++++++++++++++++++++
>  1 files changed, 79 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 87969c7..01a288f 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -50,6 +50,84 @@
>  
>  #define NAND_BLOCK_SIZE		SZ_128K
>  
> +/*
> + * OMAP3 Beagle revision
> + * Run time detection of Beagle revision is done by reading GPIO.
> + * GPIO ID -
> + *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
> + *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
> + *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
> + *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
> + */
> +enum {
> +	OMAP3BEAGLE_BOARD_AXBX = 0,
> +	OMAP3BEAGLE_BOARD_C1_3,
> +	OMAP3BEAGLE_BOARD_C4,
> +	OMAP3BEAGLE_BOARD_XM,
> +};
> +
> +static u8 omap3_beagle_version;
> +
> +u8 get_omap3_beagle_rev(void)
> +{
> +	return omap3_beagle_version;
> +}

Please make this static u8 get_omap3_beagle_rev().

Regards,

Tony
