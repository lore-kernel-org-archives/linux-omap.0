From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: nand: Allow MTD_NAND_OMAP2 to be usable on
 Keystone devices
Date: Fri, 26 Aug 2016 09:47:59 +0200
Message-ID: <20160826094759.0130d6dd@bbrezillon>
References: <1472030700-16051-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472030700-16051-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: computersforpeace@gmail.com, fcooper@ti.com, tony@atomide.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 24 Aug 2016 12:25:00 +0300
Roger Quadros <rogerq@ti.com> wrote:

> Some Keystone devices (e.g. K2G) include a OMAP NAND IP.
> Allow the NAND driver to be usable for both
> Keystone and OMAP devices.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/nand/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 21ff580..e6260df 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -88,11 +88,11 @@ config MTD_NAND_AMS_DELTA
>  	  Support for NAND flash on Amstrad E3 (Delta).
>  
>  config MTD_NAND_OMAP2
> -	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
> -	depends on ARCH_OMAP2PLUS
> +	tristate "NAND Flash device on OMAP2, OMAP3, OMAP4 and Keystone"
> +	depends on (ARCH_OMAP2PLUS || ARCH_KEYSTONE)
>  	help
> -          Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
> -	  platforms.
> +          Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
> +	  and Keystone platforms.
>  
>  config MTD_NAND_OMAP_BCH
>  	depends on MTD_NAND_OMAP2
