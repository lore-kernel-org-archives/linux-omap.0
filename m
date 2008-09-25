From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Add debobs Kconfig item
Date: Thu, 25 Sep 2008 11:58:07 +0300
Message-ID: <878wtgob4w.fsf@deeprootsystems.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-4-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:8602 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYIYI6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 04:58:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so121251nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 01:58:15 -0700 (PDT)
In-Reply-To: <1221663749-26121-4-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Wed\, 17 Sep 2008 18\:02\:29 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |   10 +++++++++-
>  arch/arm/mach-omap2/Makefile |    3 +++
>  2 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index d0bbbf8..639af08 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -151,4 +151,12 @@ config OMAP3_OFF_MODE
>  	depends on ARCH_OMAP3
>  	default n
>  	help
> -	  Use off mode for powerdomains.
> \ No newline at end of file
> +	  Use off mode for powerdomains.
> +
> +config OMAP3_DEBOBS	
> +	bool "OMAP 3430 Debug observability support"
> +	depends on ARCH_OMAP3 && DEBUG_FS
> +	default n
> +	help
> +	  Use ETK pads for debug observability
> +

This should go into arch/arm/plat-omap/Kconfig, under the 'OMAP
Feature Selections' list.

Kevin

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 23fc127..88d3af0 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -40,6 +40,9 @@ obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
>  mailbox_mach-objs		:= mailbox.o
>  mmu_mach-objs			:= mmu.o
>  
> +# Debobs
> +obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
> +
>  # Specific board support
>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
>  obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
