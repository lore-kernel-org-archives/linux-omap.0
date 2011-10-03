From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/30] ARM: omap4: always build omap_phy_internal
Date: Mon, 3 Oct 2011 11:04:39 -0700
Message-ID: <20111003180438.GW6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-13-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36816 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932263Ab1JCSEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:04:40 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-13-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111002 07:13]:
> The functions defined in omap_phy_internal.c are requrired on
> omap4-only configurations, not just for specific boards.
> 
> twl-common.c:(.init.text+0x6b40): undefined reference to `omap4430_phy_init'
> twl-common.c:(.init.text+0x6c68): undefined reference to `omap4430_phy_init'
> mach-omap2/built-in.o:(.data+0x154e0): undefined reference to `omap4430_phy_init'
> mach-omap2/built-in.o:(.data+0x154e4): undefined reference to `omap4430_phy_exit'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This should be OK for now:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/Makefile |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index f343365..dc36bd4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -242,12 +242,9 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
>  obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
> -					   hsmmc.o \
> -					   omap_phy_internal.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
> -					   hsmmc.o \
> -					   omap_phy_internal.o
> -
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
>  					   omap_phy_internal.o \
>  
> @@ -275,6 +272,7 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
>  smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
>  obj-y					+= $(smsc911x-m) $(smsc911x-y)
>  obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= omap_phy_internal.o
>  
>  disp-$(CONFIG_OMAP2_DSS)		:= display.o
>  obj-y					+= $(disp-m) $(disp-y)
> -- 
> 1.7.5.4
> 
