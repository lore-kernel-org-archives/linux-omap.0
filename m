From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] ARM: omap1: add nand_chip declaration
Date: Wed, 26 Sep 2018 15:23:40 +0200
Message-ID: <20180926152340.332b36e4@xps13>
References: <20180926130458.2406549-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926130458.2406549-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

Thanks for the fix, sorry for breaking the build.

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 15:04:38 +0200:

> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/common.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 11b87a4c84d4..82f2c065040a 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -82,6 +82,7 @@ void omap1_restart(enum reboot_mode, const char *);
>  
>  extern void __init omap_check_revision(void);
>  
> +struct nand_chip;
>  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
>  			       unsigned int ctrl);
>  

Currently I see "#include <linux/mtd/mtd.h>" at the top of this file.
That's where the "struct mtd_info" that has been replaced by a "struct
nand_chip" was declared. The nand_chip object is declared in
<linux/mtd/rawnand.h>.

I think you can remove this include (unneeded anymore for what I see).
Then, either you keep the nand_chip forward declaration, or replace the
mtd.h include into the rawnand.h one?


Thanks,
Miquèl
