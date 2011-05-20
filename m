From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Fix generic irq chip
Date: Fri, 20 May 2011 18:20:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105201820180.14430@xanadu.home>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:55856 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1ETWUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 18:20:55 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LLI001XJM1OBB71@vl-mo-mrz23.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 20 May 2011 18:20:12 -0400 (EDT)
In-reply-to: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

On Fri, 20 May 2011, Russell King - ARM Linux wrote:

> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Nicolas Pitre <nico@fluxnic.net>




> 
>  arch/arm/Kconfig           |    2 ++
>  arch/arm/plat-omap/Kconfig |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44c16f0..9b63bab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -854,6 +854,7 @@ config ARCH_DAVINCI
>  	select HAVE_IDE
>  	select CLKDEV_LOOKUP
>  	select GENERIC_ALLOCATOR
> +	select GENERIC_IRQ_CHIP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	help
>  	  Support for TI's DaVinci platform.
> @@ -1033,6 +1034,7 @@ config PLAT_IOP
>  
>  config PLAT_ORION
>  	bool
> +	select GENERIC_IRQ_CHIP
>  	select HAVE_SCHED_CLOCK
>  
>  config PLAT_PXA
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index cd5f993..29b4c35 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_OMAP1
>  config ARCH_OMAP2PLUS
>  	bool "TI OMAP2/3/4"
>  	select CLKDEV_LOOKUP
> +	select GENERIC_IRQ_CHIP
>  	select OMAP_DM_TIMER
>  	help
>  	  "Systems based on OMAP2, OMAP3 or OMAP4"
> 
