From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] [v2] ARM: omap1: add nand_chip declaration
Date: Wed, 26 Sep 2018 16:52:40 +0200
Message-ID: <20180926165240.77a78fc4@xps13>
References: <20180926142029.619397-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Paul Burton <paul.burton@mips.com>, Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:

> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion
> ---
>  arch/arm/mach-omap1/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 11b87a4c84d4..504b959ba5cf 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -26,7 +26,6 @@
>  #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
>  #define __ARCH_ARM_MACH_OMAP1_COMMON_H
>  
> -#include <linux/mtd/mtd.h>
>  #include <linux/platform_data/i2c-omap.h>
>  #include <linux/reboot.h>
>  
> @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
>  
>  extern void __init omap_check_revision(void);
>  
> +struct nand_chip;
>  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
>  			       unsigned int ctrl);
>  

Boris pointed me that the commit introducing the regression is still
in nand/next, so do you mind if I squash both patches with it?

Regards,
Miquèl
