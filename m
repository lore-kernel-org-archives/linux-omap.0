From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 5/5] mtd: nand: Constrain omap_elm to built-in
Date: Mon, 22 Sep 2014 11:17:13 +0300
Message-ID: <541FDB09.1080209@ti.com>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34773 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaIVIRl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2014 04:17:41 -0400
In-Reply-To: <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 09/20/2014 07:53 PM, Ezequiel Garcia wrote:
> This fixes the following build error when omap2_nand is chosen built-in,
> and omap_elm is chosen as a module:
> 
>   drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'
> 
> Fix this by making omap_elm a 'bool' driver.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Acked-by: <rogerq@ti.com>

--
cheers,
-roger

> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f1cf503..549c0cb 100644
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
> 

