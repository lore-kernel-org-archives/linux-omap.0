From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] Nokia N9/N900/N950 -- mention product names
Date: Wed, 17 Oct 2012 22:25:25 +0300
Message-ID: <20121017192525.GD1613@blackmetal.musicnaut.iki.fi>
References: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
 <20120501104801.GA23559@elf.ucw.cz>
 <20120504181105.GL5613@atomide.com>
 <20121017183307.GA12560@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:40421 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab2JQTZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 15:25:28 -0400
Content-Disposition: inline
In-Reply-To: <20121017183307.GA12560@elf.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, arnd@arndb.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Some minor comments:

On Wed, Oct 17, 2012 at 08:33:08PM +0200, Pavel Machek wrote:
> This adds product names (that most users know) to Kconfig and board
> comments.

Good idea. :-)

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 346fd26..da08226 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -263,14 +263,14 @@ config MACH_NOKIA_N8X0
>  	select MACH_NOKIA_N810_WIMAX
>  
>  config MACH_NOKIA_RM680
> -	bool "Nokia RM-680/696 board"
> +	bool "Nokia N9/N950 (RM-680/696) phones"

This should be "N950/N9 (RM-680/RM-696)" or perhaps for clarity
"N950 (RM-680) / N9 (RM-696)".

>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
>  	select MACH_NOKIA_RM696
>  
>  config MACH_NOKIA_RX51
> -	bool "Nokia RX-51 board"
> +	bool "Nokia N900 phone (RX-51)"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
> diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
> index 0ad1bb3b..26965f3 100644
> --- a/arch/arm/mach-omap2/board-rm680.c
> +++ b/arch/arm/mach-omap2/board-rm680.c
> @@ -1,5 +1,5 @@
>  /*
> - * Board support file for Nokia RM-680/696.
> + * Board support file for Nokia N9/N950 (aka RM-680/696).

Same here.

Thanks,

A.
