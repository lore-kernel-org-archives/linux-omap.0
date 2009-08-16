From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: PM: Upgrade the makefile for power domain
 initialisations
Date: Sun, 16 Aug 2009 13:15:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908161313510.1930@utopia.booyaka.com>
References: <1250247553-22525-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38579 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbZHPTP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 15:15:28 -0400
In-Reply-To: <1250247553-22525-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Abhijit,

On Fri, 14 Aug 2009, abhijitpagare@ti.com wrote:

> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> This Patch upgrades the Makefile for Power Domain Framework
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3322292..1a18026 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o clock.o prcm.o
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o clock.o prcm.o powerdomain.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  prcm-common				= powerdomain.o

NACK, please use the same mechanism that is present a few lines down in 
the Makefile:

obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)

then add an OMAP4 line, etc.

Also, this patch can be rolled into one of your other patches, there's no 
need for it to be separate.


- Paul
