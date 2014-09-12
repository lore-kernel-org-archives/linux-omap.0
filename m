From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/3] mtd: nand: Force omap_elm to be built as a module
 if omap2_nand is a module
Date: Fri, 12 Sep 2014 12:01:35 +0300
Message-ID: <5412B66F.8050505@ti.com>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1410443224-18477-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37235 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbaILJCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2014 05:02:53 -0400
In-Reply-To: <1410443224-18477-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, pekon <pekon@pek-sem.com>

On 09/11/2014 04:47 PM, Ezequiel Garcia wrote:
> This commit adds a hidden option to build the omap_elm as a module, if
> omap2_nand is a module (and similarly in the built-in case).
> 
> This fixes the following build error when omap2_nand is chosen built-in,
> and omap_elm is chosen as a module:
> 
> drivers/built-in.o: In function `omap_nand_probe':
> /work/linux-2.6/drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
> drivers/built-in.o: In function `omap_elm_correct_data':
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/mtd/nand/Kconfig  | 8 +++++++-
>  drivers/mtd/nand/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f1cf503..12e8ee8 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -96,7 +96,7 @@ config MTD_NAND_OMAP2
>  
>  config MTD_NAND_OMAP_BCH
>  	depends on MTD_NAND_OMAP2
> -	tristate "Support hardware based BCH error correction"
> +	bool "Support hardware based BCH error correction"
>  	default n
>  	select BCH
>  	help
> @@ -106,6 +106,12 @@ config MTD_NAND_OMAP_BCH
>  	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
>  	  so they should not enable this config symbol.
>  
> +config MTD_NAND_OMAP_BCH_BUILD
> +	tristate
> +	depends on MTD_NAND_OMAP2
> +	default m if MTD_NAND_OMAP2=m && MTD_NAND_OMAP_BCH
> +	default y if MTD_NAND_OMAP2=y && MTD_NAND_OMAP_BCH
> +
>  config MTD_NAND_IDS
>  	tristate
>  
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 4bcdeb0..3580188 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
>  obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
>  obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
>  obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
> -obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
> +obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
>  obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
>  obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
>  obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
> 

The overall logic seems to work but I still see the following issue.

In menuconfig, the OMAP_BCH option is still visible as a boolean even though
the ELM module finally gets built as a module.
This can be confusing to the user and I'd avoid that behaviour.

cheers,
-roger
