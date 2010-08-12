From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 12 Aug 2010 15:00:41 +0300
Message-ID: <20100812120040.GD6629@atomide.com>
References: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab0HLMAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 08:00:45 -0400
Content-Disposition: inline
In-Reply-To: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson@gmail.com> [100812 02:30]:
> Due to the omap3530 ES3.0 Silicon being used on both the
> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
> routines to differentiate the Beagle Boards.
> 
> However gpio pins 171,172,173 where setup for this prupose, so 
> lets use them.

<snip>

> --- a/arch/arm/plat-omap/include/plat/board.h
> +++ b/arch/arm/plat-omap/include/plat/board.h
> @@ -26,6 +26,22 @@ enum {
>  	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
>  };
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
>  /* Different peripheral ids */
>  #define OMAP_TAG_CLOCK		0x4f01
>  #define OMAP_TAG_LCD		0x4f05
> @@ -173,4 +189,11 @@ u8 get_omap3_evm_rev(void);
>  #else
>  #define get_omap3_evm_rev() (-EINVAL)
>  #endif
> +
> +/* Beagle revision */
> +#if defined(CONFIG_MACH_OMAP3_BEAGLE)
> +u8 get_omap3_beagle_rev(void);
> +#else
> +#define get_omap3_beagle_rev() (-EINVAL)
> +#endif
>  #endif

You should be able to keep this all in board-omap3beagle.c,
no need for the header. If this header is needed somewhere
else, chances are that something is wrong.

For the drivers, you should be able to pass the necessary
flags via platform_data if needed.

Regards,

Tony
