From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option dependency
Date: Fri, 25 Oct 2013 11:26:06 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2AE93@DBDE04.ent.ti.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58562 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3JYL0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:26:37 -0400
In-Reply-To: <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Brian Norris <computersforpeace@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option
> dependency
> 
> This option does not need to depend in MTD_NAND, for it's enclosed
> under it. Also, it's wrong to make it depend in ARCH_OMAP3 only
> since the controller is used in a wider range of SoCs.
> 
> Instead, just leave the dependency on the OMAP2 driver option.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index d885298..8187466 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
>  	  platforms.
> 
>  config MTD_NAND_OMAP_BCH
> -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> +	depends on MTD_NAND_OMAP2
>  	tristate "Enable support for hardware BCH error correction"
>  	default n
>  	select BCH
> --
> 1.8.1.5

Acked-by: Pekon Gupta <pekon@ti.com>
Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

with regards, pekon
