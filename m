From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 bis 12/25] mtd: nand: use the mtd instance embedded in
 struct nand_chip
Date: Tue, 8 Dec 2015 16:17:41 -0800
Message-ID: <20151209001741.GT120110@google.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449046201-22921-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449046201-22921-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Wed, Dec 02, 2015 at 09:50:01AM +0100, Boris Brezillon wrote:
> struct nand_chip now embeds an mtd device. Patch all drivers to make use
> of this mtd instance instead of using the instance embedded in their
> private struct or dynamically allocated.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> ---
> Most of those changes were generated with the coccinelle script added
> in commit c671312 "coccinelle: nand: detect and correct drivers embedding
> an mtd_info object"
> ---
> Changes since v2:
> - fix several compilation errors/warnings
> 
>  drivers/mtd/nand/ams-delta.c                   | 13 ++--
>  drivers/mtd/nand/atmel_nand.c                  | 13 ++--
>  drivers/mtd/nand/au1550nd.c                    | 19 ++---
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |  1 -
>  drivers/mtd/nand/bcm47xxnflash/main.c          |  8 ++-
>  drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  2 +-
>  drivers/mtd/nand/bf5xx_nand.c                  | 12 ++--
>  drivers/mtd/nand/brcmnand/brcmnand.c           | 13 ++--
>  drivers/mtd/nand/cafe_nand.c                   |  8 +--
>  drivers/mtd/nand/cmx270_nand.c                 | 11 ++-

There's another error here, I think ^^^

>  drivers/mtd/nand/cs553x_nand.c                 | 13 ++--
>  drivers/mtd/nand/davinci_nand.c                | 30 ++++----
>  drivers/mtd/nand/denali.c                      | 68 ++++++++++--------
>  drivers/mtd/nand/denali.h                      |  1 -
>  drivers/mtd/nand/diskonchip.c                  | 11 ++-
>  drivers/mtd/nand/docg4.c                       | 23 +++---
>  drivers/mtd/nand/fsl_elbc_nand.c               | 26 ++++---
>  drivers/mtd/nand/fsl_ifc_nand.c                | 28 ++++----
>  drivers/mtd/nand/fsl_upm.c                     | 28 ++++----
>  drivers/mtd/nand/fsmc_nand.c                   | 56 ++++++++-------
>  drivers/mtd/nand/gpio.c                        | 20 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |  2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c         | 23 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |  1 -
>  drivers/mtd/nand/hisi504_nand.c                | 13 ++--
>  drivers/mtd/nand/jz4740_nand.c                 |  9 ++-
>  drivers/mtd/nand/lpc32xx_mlc.c                 |  7 +-
>  drivers/mtd/nand/lpc32xx_slc.c                 |  7 +-
>  drivers/mtd/nand/mpc5121_nfc.c                 |  3 +-
>  drivers/mtd/nand/mxc_nand.c                    |  5 +-
>  drivers/mtd/nand/nandsim.c                     | 12 ++--
>  drivers/mtd/nand/ndfc.c                        | 24 ++++---
>  drivers/mtd/nand/nuc900_nand.c                 | 24 +++----
>  drivers/mtd/nand/omap2.c                       | 98 +++++++++++++++-----------
>  drivers/mtd/nand/orion_nand.c                  |  4 +-
>  drivers/mtd/nand/pasemi_nand.c                 | 12 ++--
>  drivers/mtd/nand/plat_nand.c                   | 15 ++--
>  drivers/mtd/nand/pxa3xx_nand.c                 | 33 ++++-----
>  drivers/mtd/nand/r852.c                        | 34 ++++-----
>  drivers/mtd/nand/r852.h                        |  1 -
>  drivers/mtd/nand/s3c2410.c                     | 23 +++---
>  drivers/mtd/nand/sh_flctl.c                    |  8 +--
>  drivers/mtd/nand/sharpsl.c                     | 22 +++---
>  drivers/mtd/nand/socrates_nand.c               |  5 +-
>  drivers/mtd/nand/sunxi_nand.c                  | 13 ++--
>  drivers/mtd/nand/tmio_nand.c                   | 10 +--
>  drivers/mtd/nand/txx9ndfmc.c                   |  3 +-
>  drivers/mtd/nand/vf610_nfc.c                   |  8 ++-
>  include/linux/mtd/sh_flctl.h                   |  3 +-
>  49 files changed, 432 insertions(+), 394 deletions(-)
> 

...

> diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
> index 43bded6..84d027e 100644
> --- a/drivers/mtd/nand/cmx270_nand.c
> +++ b/drivers/mtd/nand/cmx270_nand.c
> @@ -160,10 +160,8 @@ static int __init cmx270_init(void)
>  	gpio_direction_input(GPIO_NAND_RB);
>  
>  	/* Allocate memory for MTD device structure and private data */
> -	cmx270_nand_mtd = kzalloc(sizeof(struct mtd_info) +
> -				  sizeof(struct nand_chip),
> -				  GFP_KERNEL);
> -	if (!cmx270_nand_mtd) {
> +	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
> +	if (!this) {
>  		ret = -ENOMEM;
>  		goto err_kzalloc;
>  	}
> @@ -175,8 +173,7 @@ static int __init cmx270_init(void)
>  		goto err_ioremap;
>  	}
>  
> -	/* Get pointer to private data */
> -	this = (struct nand_chip *)(&cmx270_nand_mtd[1]);
> +	cmx270_nand_mtd = nand_to_mtd(this);

So, you make cmx270_nand_mtd no longer kzalloc()'d, but I still see the
cmx270_init() function end with:

err_scan:
        iounmap(cmx270_nand_io);
err_ioremap:
        kfree(cmx270_nand_mtd);  <----- *** this! ***
err_kzalloc:
        gpio_free(GPIO_NAND_RB);
err_gpio_request:
	gpio_free(GPIO_NAND_CS);

	return ret;

}

I have a feeling there's a failing in your coccinelle script somewhere.

Given that I was only through 10 of 49 files changes, I think you might
need to take a comb over your patch better.

>  
>  	/* Link the private data with the MTD structure */
>  	cmx270_nand_mtd->owner = THIS_MODULE;
> @@ -241,7 +238,7 @@ static void __exit cmx270_cleanup(void)
>  	iounmap(cmx270_nand_io);
>  
>  	/* Free the MTD device structure */
> -	kfree (cmx270_nand_mtd);
> +	kfree(mtd_to_nand(cmx270_nand_mtd));
>  }
>  module_exit(cmx270_cleanup);
>  

...

Brian
