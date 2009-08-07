From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] Add support for Nokia N800
Date: Fri, 7 Aug 2009 16:32:40 +0300
Message-ID: <20090807133240.GB8525@nokia.com>
References: <20090807130416.4978.96828.stgit@tikku>
 <20090807130611.4978.96154.stgit@tikku>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35288 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbZHGNbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 09:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20090807130611.4978.96154.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Valo <kalle.valo@iki.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Aug 07, 2009 at 03:06:11PM +0200, ext Kalle Valo wrote:
> Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
> ---
> 
>  arch/arm/mach-omap2/Kconfig      |    4 
>  arch/arm/mach-omap2/Makefile     |    2 
>  arch/arm/mach-omap2/board-n8x0.c |  307 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-n8x0.c
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index bf54686..75b1c7e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -73,6 +73,10 @@ config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  
> +config MACH_NOKIA_N8X0
> +	bool "Nokia N800/N810"
> +	depends on ARCH_OMAP2420
> +
>  config MACH_NOKIA_RX51
>  	bool "Nokia RX-51 board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 757c84b..8850a24 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -62,7 +62,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  					   mmc-twl4030.o
> -
> +obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
>  					   board-rx51-peripherals.o \
>  					   mmc-twl4030.o
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> new file mode 100644
> index 0000000..08d1c11
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -0,0 +1,307 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-n8x0.c
> + *
> + * Copyright (C) 2005-2007 Nokia Corporation

2005-2009

-- 
balbi
