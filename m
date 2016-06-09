From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4/6] mtd: nand: Add OMAP_GPMC as a dependency to
 MTD_NAND_OMAP2
Date: Thu, 9 Jun 2016 20:47:50 +0200
Message-ID: <20160609204750.23e587dc@bbrezillon>
References: <1465491777-20033-1-git-send-email-fcooper@ti.com>
	<1465491777-20033-5-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465491777-20033-5-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: tony@atomide.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu,  9 Jun 2016 12:02:55 -0500
Franklin S Cooper Jr <fcooper@ti.com> wrote:

> OMAP 2 NAND depends on the GPMC driver. Therefore, insure that the OMAP
> GPMC config is selected before enabling the OMAP 2 NAND driver.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f05e0e9..e24404f 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -89,7 +89,7 @@ config MTD_NAND_AMS_DELTA
>  
>  config MTD_NAND_OMAP2
>  	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
> -	depends on ARCH_OMAP2PLUS
> +	depends on ARCH_OMAP2PLUS && OMAP_GPMC

If you add

	depends on ARCH_OMAP2PLUS

in the OMAP_GPMC driver, you can just drop the ARCH_OMAP2PLUS
dependency here.

>  	help
>            Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
>  	  platforms.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
