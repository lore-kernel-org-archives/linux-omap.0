From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ PATCH 2/3 ] net:smc911x Modify driver to also work with
	omap24xx
Date: Thu, 26 Jun 2008 15:22:02 +0300
Message-ID: <20080626122202.GE12992@atomide.com>
References: <dfeb90390806240514w62490fb9kdc1c189f3fd946f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:62989 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYFZMWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 08:22:07 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390806240514w62490fb9kdc1c189f3fd946f5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Arun KS <getarunks@gmail.com> [080624 15:14]:
> net:smc911x Modify driver to also work with omap24xx

Few comments below.

Also, can you please send this to the Linux netdev mailing list?
Also Cc linux-omap list too.

> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  drivers/net/Kconfig   |    2 +-
>  drivers/net/smc911x.h |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 61ecee7..17d0a9c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -955,7 +955,7 @@ config SMC911X
>     tristate "SMSC LAN911[5678] support"
>     select CRC32
>     select MII
> -   depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX
> +   depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX || ARCH_OMAP24XX
>     help
>       This is a driver for SMSC's LAN911x series of Ethernet chipsets
>       including the new LAN9115, LAN9116, LAN9117, and LAN9118.

Maybe have ARCH_OMAP24XX before ARCH_OMAP34XX to be consistent
how it's done elsewhere.


> diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
> index dad93a8..0f406a0 100644
> --- a/drivers/net/smc911x.h
> +++ b/drivers/net/smc911x.h
> @@ -47,6 +47,11 @@
>    #define SMC_USE_32BIT        1
>    #define SMC_IRQ_SENSE        IRQF_TRIGGER_LOW
>    #define SMC_MEM_RESERVED 1
> +#elif defined(CONFIG_ARCH_OMAP24XX)
> +  #define SMC_USE_16BIT        0
> +  #define SMC_USE_32BIT        1
> +  #define SMC_IRQ_SENSE        IRQF_TRIGGER_LOW
> +  #define SMC_MEM_RESERVED 1
>  #endif

You should probably use tabs here in the new code even if old code
does not.

Regards,

Tony

> 
> 
> --
> 1.5.3.4

> From 8b45bfd40aca7d5f89195f95d668bae78e2dbba9 Mon Sep 17 00:00:00 2001
> From: Arun KS <arunks@mistralsolutions.com>
> Date: Tue, 24 Jun 2008 17:33:08 +0530
> Subject: [PATCH] net:smc911x Modify driver to also work with omap24xx
> 
> net:smc911x Modify driver to also work with omap24xx
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  drivers/net/Kconfig   |    2 +-
>  drivers/net/smc911x.h |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 61ecee7..17d0a9c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -955,7 +955,7 @@ config SMC911X
>  	tristate "SMSC LAN911[5678] support"
>  	select CRC32
>  	select MII
> -	depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX
> +	depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX || ARCH_OMAP24XX
>  	help
>  	  This is a driver for SMSC's LAN911x series of Ethernet chipsets
>  	  including the new LAN9115, LAN9116, LAN9117, and LAN9118.
> diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
> index dad93a8..0f406a0 100644
> --- a/drivers/net/smc911x.h
> +++ b/drivers/net/smc911x.h
> @@ -47,6 +47,11 @@
>    #define SMC_USE_32BIT		1
>    #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
>    #define SMC_MEM_RESERVED	1
> +#elif defined(CONFIG_ARCH_OMAP24XX)
> +  #define SMC_USE_16BIT		0
> +  #define SMC_USE_32BIT		1
> +  #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
> +  #define SMC_MEM_RESERVED	1
>  #endif
>  
>  
> -- 
> 1.5.3.4
> 

