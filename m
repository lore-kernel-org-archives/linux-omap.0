From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: nand: Constrain omap_elm to built-in
Date: Mon, 22 Sep 2014 11:58:49 -0700
Message-ID: <20140922185849.GT1193@ld-irv-0074>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38732 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaIVS6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 14:58:52 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so5033337pab.8
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 11:58:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 20, 2014 at 05:53:16PM +0100, Ezequiel Garcia wrote:
> This fixes the following build error when omap2_nand is chosen built-in,
> and omap_elm is chosen as a module:
> 
>   drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
>   drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'
> 
> Fix this by making omap_elm a 'bool' driver.

Hmm, so we're sacrificing a "feature" (that omap2 + omap_elm can both be
built as modules) because we haven't solved one particular developer UI
inconsistency (that we don't prevent the config combination of
MTD_NAND_OMAP2=y and MTD_NAND_OMAP_BCH=m)? I wouldn't tend to sacrifice
the feature for the sake of a bad config.

Do you have any guesstimate as to whether the linker failure affects
many people? Are people just hitting this with randconfig?

Do you know if anyone ships loadable modules for this driver? e.g., any
embedded distros?

I could go either way on this, but I just wasn't sure if these sorts of
questions had been asked/answered.

> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
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

Brian
