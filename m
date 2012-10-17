From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] Nokia N9/N900/N950 -- mention product names
Date: Thu, 18 Oct 2012 00:21:12 +0300
Message-ID: <20121017212112.GG1613@blackmetal.musicnaut.iki.fi>
References: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
 <20120501104801.GA23559@elf.ucw.cz>
 <20120504181105.GL5613@atomide.com>
 <20121017183307.GA12560@elf.ucw.cz>
 <20121017192525.GD1613@blackmetal.musicnaut.iki.fi>
 <20121017210300.GB12560@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:52897 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab2JQVVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 17:21:16 -0400
Content-Disposition: inline
In-Reply-To: <20121017210300.GB12560@elf.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de

On Wed, Oct 17, 2012 at 11:03:00PM +0200, Pavel Machek wrote:
> 
> This adds product names (that most users know) to Kconfig and board
> comments.
>  
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 346fd26..f03f19a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -263,14 +263,14 @@ config MACH_NOKIA_N8X0
>  	select MACH_NOKIA_N810_WIMAX
>  
>  config MACH_NOKIA_RM680
> -	bool "Nokia RM-680/696 board"
> +	bool "Nokia N950 (RM-680) / N9 (RM-696) phones"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
>  	select MACH_NOKIA_RM696
>  
>  config MACH_NOKIA_RX51
> -	bool "Nokia RX-51 board"
> +	bool "Nokia N900 (RX-51) phone"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
> diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
> index 0ad1bb3b..96f8757 100644
> --- a/arch/arm/mach-omap2/board-rm680.c
> +++ b/arch/arm/mach-omap2/board-rm680.c
> @@ -1,5 +1,5 @@
>  /*
> - * Board support file for Nokia RM-680/696.
> + * Board support file for Nokia N950 (RM-680) / N9 (RM-696).
>   *
>   * Copyright (C) 2010 Nokia
>   *
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 345dd93..b60ca9d 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/arch/arm/mach-omap2/board-rx51.c
> + * Board support file for Nokia N900 (aka RX-51).
>   *
>   * Copyright (C) 2007, 2008 Nokia
>   *
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
