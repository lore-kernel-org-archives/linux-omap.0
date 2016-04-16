From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 06/12] mtd: nand: gpmi: rely on generic DT
 parsing done in nand_scan_ident()
Date: Sat, 16 Apr 2016 11:07:20 +0200
Message-ID: <20160416110720.462822e6@bbrezillon>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459515272-31011-7-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBS4BZC4AKGQEICNWQSA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459515272-31011-7-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Han,

On Fri,  1 Apr 2016 14:54:26 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.

Can you review/test this patch? I'd like to have the whole series
merged in this release.

Thanks,

Boris

> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 8122c69..c6e8a1c 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -25,7 +25,6 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_mtd.h>
>  #include "gpmi-nand.h"
>  #include "bch-regs.h"
>  
> @@ -1914,16 +1913,6 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
>  	/* Set up swap_block_mark, must be set before the gpmi_set_geometry() */
>  	this->swap_block_mark = !GPMI_IS_MX23(this);
>  
> -	if (of_get_nand_on_flash_bbt(this->dev->of_node)) {
> -		chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> -
> -		if (of_property_read_bool(this->dev->of_node,
> -						"fsl,no-blockmark-swap"))
> -			this->swap_block_mark = false;
> -	}
> -	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> -		this->swap_block_mark ? "en" : "dis");
> -
>  	/*
>  	 * Allocate a temporary DMA buffer for reading ID in the
>  	 * nand_scan_ident().
> @@ -1938,6 +1927,16 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
>  	if (ret)
>  		goto err_out;
>  
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +		if (of_property_read_bool(this->dev->of_node,
> +						"fsl,no-blockmark-swap"))
> +			this->swap_block_mark = false;
> +	}
> +	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> +		this->swap_block_mark ? "en" : "dis");
> +
>  	ret = gpmi_init_last(this);
>  	if (ret)
>  		goto err_out;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
