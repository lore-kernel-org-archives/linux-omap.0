From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH typo-resend] mtd: omap: fix mtd devices not showing up
Date: Mon, 27 Oct 2014 15:56:41 +0200
Message-ID: <544E4F19.8060205@ti.com>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbaJ0N5I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Oct 2014 09:57:08 -0400
In-Reply-To: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>, Brian Norris <computersforpeace@gmail.com>
Cc: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hi Frans,

On 10/27/2014 03:32 PM, Frans Klaver wrote:
> Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
> omap_elm"), I don't have any mtd devices present on my am335x. This
> appears to be related to the link order of the omap_elm and omap2
> objects. Fix it by swapping the two in the Makefile.

Alternatively we could fix either elm_config() or omap_nand_probe() to
return -EPROBE_DEFER in case the device is present but driver not yet probed.

cheers,
-roger

> 
> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> ---
> I hoped this wouldn't make a difference, but it very much did. I don't
> have a proper explanation for why this actually fixes it for me though.
> 
> Resend due to misspelling in ...infradead.org
> 
>  drivers/mtd/nand/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 9c847e4..24b81ec 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -26,8 +26,8 @@ obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
>  obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
>  obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
>  obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
> -obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
>  obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
> +obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
>  obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
>  obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
>  obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
> 

