From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: davinci-nand: disable subpage write for
 davinci-nand
Date: Tue, 3 Jan 2017 09:59:18 +0100
Message-ID: <20170103095918.7da43be3@bbrezillon>
References: <1457428095-2801-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457428095-2801-1-git-send-email-sushaanth.s@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sushaanth,

Sorry for the late reply, I'm dequeing old NAND related patches and
found this one.

Is this patch still needed?

On Tue, 8 Mar 2016 14:38:15 +0530
Sushaanth Srirangapathi <sushaanth.s@ti.com> wrote:

> Commit 28c015a9daabe4e ("mtd: davinci-nand: disable subpage write for
> keystone-nand") disables subpage write for Keystone SOCs due to hw
> issues.
> 
> But subpage writes doesn't work even for DaVinci SOCs due to hw issues.
> So set NAND_NO_SUBPAGE_WRITE option for all devices compatible to
> this driver.
> 
> I tested this patch using DA850 board.
> 
> Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
> ---
>  drivers/mtd/nand/davinci_nand.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index 8cb821b..466439c 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -601,11 +601,7 @@ static struct davinci_nand_pdata
>  		    of_property_read_bool(pdev->dev.of_node,
>  			"ti,davinci-nand-use-bbt"))
>  			pdata->bbt_options = NAND_BBT_USE_FLASH;
> -
> -		if (of_device_is_compatible(pdev->dev.of_node,
> -					    "ti,keystone-nand")) {
> -			pdata->options |= NAND_NO_SUBPAGE_WRITE;
> -		}
> +		pdata->options |= NAND_NO_SUBPAGE_WRITE;
>  	}
>  
>  	return dev_get_platdata(&pdev->dev);
