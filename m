From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] NET: SMC911X: Add support for OMAP LDP platform
Date: Fri, 2 May 2008 16:19:51 -0700
Message-ID: <20080502231951.GZ8981@atomide.com>
References: <1209727441-4312-1-git-send-email-nskamat@ti.com> <1209727441-4312-2-git-send-email-nskamat@ti.com> <1209727441-4312-3-git-send-email-nskamat@ti.com> <1209727441-4312-4-git-send-email-nskamat@ti.com> <1209727441-4312-5-git-send-email-nskamat@ti.com> <1209727441-4312-6-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57354 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764749AbYEBXTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 19:19:52 -0400
Content-Disposition: inline
In-Reply-To: <1209727441-4312-6-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org

* Nishant Kamat <nskamat@ti.com> [080502 04:26]:
> This patch adds support for OMAP LDP platform to smc911x driver.

This too should go via smc911x maintainer.

Tony

> 
> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> ---
>  drivers/net/Kconfig   |    2 +-
>  drivers/net/smc911x.c |    9 ++++++---
>  drivers/net/smc911x.h |    5 +++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 015e163..49752d0 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -955,7 +955,7 @@ config SMC911X
>  	tristate "SMSC LAN911[5678] support"
>  	select CRC32
>  	select MII
> -	depends on ARCH_PXA || SH_MAGIC_PANEL_R2
> +	depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX
>  	help
>  	  This is a driver for SMSC's LAN911x series of Ethernet chipsets
>  	  including the new LAN9115, LAN9116, LAN9117, and LAN9118.
> diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> index 00b9b3e..14a0e3a 100644
> --- a/drivers/net/smc911x.c
> +++ b/drivers/net/smc911x.c
> @@ -2136,7 +2136,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
>  		ret = -ENODEV;
>  		goto out;
>  	}
> -
> +#ifndef SMC_MEM_RESERVED
>  	/*
>  	 * Request the regions.
>  	 */
> @@ -2144,7 +2144,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
>  		 ret = -EBUSY;
>  		 goto out;
>  	}
> -
> +#endif
>  	ndev = alloc_etherdev(sizeof(struct smc911x_local));
>  	if (!ndev) {
>  		printk("%s: could not allocate device.\n", CARDNAME);
> @@ -2172,7 +2172,9 @@ static int smc911x_drv_probe(struct platform_device *pdev)
>  release_both:
>  		free_netdev(ndev);
>  release_1:
> +#ifndef SMC_MEM_RESERVED
>  		release_mem_region(res->start, SMC911X_IO_EXTENT);
> +#endif
>  out:
>  		printk("%s: not found (%d).\n", CARDNAME, ret);
>  	}
> @@ -2211,8 +2213,9 @@ static int smc911x_drv_remove(struct platform_device *pdev)
>  #endif
>  	iounmap((void *)ndev->base_addr);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +#ifndef SMC_MEM_RESERVED
>  	release_mem_region(res->start, SMC911X_IO_EXTENT);
> -
> +#endif
>  	free_netdev(ndev);
>  	return 0;
>  }
> diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
> index a416c61..aed2121 100644
> --- a/drivers/net/smc911x.h
> +++ b/drivers/net/smc911x.h
> @@ -43,6 +43,11 @@
>    #define SMC_USE_16BIT		0
>    #define SMC_USE_32BIT		1
>    #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
> +#elif defined(CONFIG_MACH_OMAP_LDP)
> +  #define SMC_USE_16BIT		0
> +  #define SMC_USE_32BIT		1
> +  #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
> +  #define SMC_MEM_RESERVED	1
>  #endif
>  
>  
> -- 
> 1.5.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
