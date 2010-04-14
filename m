From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 06/12] AM3517: Add nand platform data for am3517evm
Date: Wed, 14 Apr 2010 18:46:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304B3E658@dbde02.ent.ti.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
 <1271233822-27286-7-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52488 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab0DNNQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 09:16:26 -0400
In-Reply-To: <1271233822-27286-7-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Wednesday, April 14, 2010 2:00 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com
> Subject: [PATCH 06/12] AM3517: Add nand platform data for am3517evm
> 
> Add nand flash init code for am3517evm.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |   84
> +++++++++++++++++++++++++++++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index 879c13f..a76ff11 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -23,6 +23,9 @@
>  #include <linux/davinci_emac.h>
>  #include <linux/i2c/pca953x.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/am35xx.h>
> @@ -35,6 +38,8 @@
>  #include <plat/control.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/nand.h>
> +#include <plat/gpmc.h>
> 
>  #include "mux.h"
> 
> @@ -42,6 +47,84 @@
>  #define LCD_PANEL_BKLIGHT_PWR	182
>  #define LCD_PANEL_PWM		181
> 
> +#define GPMC_CS0_BASE  0x60
> +#define GPMC_CS_SIZE   0x30
> +
> +#define NAND_BLOCK_SIZE        SZ_128K
> +
> +static struct mtd_partition am3517evm_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "xloader",
> +		.offset         = 0,
> +		.size           = 4 * (SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "uboot",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 14 * (SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "uboot-params",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 2 * (SZ_128K)
> +	},
> +	{
> +		.name           = "linux-kernel",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 40 * (SZ_128K)
> +	},
> +	{
> +		.name           = "rootfs",
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,
> +	},
> +};
--- snip ---
[Sriram] Similar patch was posted earlier - pending re-work (see Tony's comments)
https://patchwork.kernel.org/patch/56485/

If you deriving your work from existing implementation, attribute the original author in your submissions 

Regards
Sriram
