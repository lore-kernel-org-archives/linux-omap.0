From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/30] ARM: omap2: export functions used by nand driver
Date: Mon, 3 Oct 2011 10:56:45 -0700
Message-ID: <20111003175645.GT6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-10-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37001 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728Ab1JCR4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 13:56:48 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-10-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111002 07:13]:
> The omap nand driver uses the gpmc_enable_hwecc and
> gpmc_calculate_ecc functions from the platform code,
> but can be built as a module.
> 
> This only works if the functions are exported.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/gpmc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 130034b..4ed6880 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -882,6 +882,7 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
>  	gpmc_write_reg(GPMC_ECC_CONFIG, val);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(gpmc_enable_hwecc);
>  
>  /**
>   * gpmc_calculate_ecc - generate non-inverted ecc bytes
> @@ -912,3 +913,4 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
>  	gpmc_ecc_used = -EINVAL;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
> -- 
> 1.7.5.4
> 
