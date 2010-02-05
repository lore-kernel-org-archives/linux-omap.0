From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2 V2] omap: 3630: Disable internal pull-ups
Date: Thu, 4 Feb 2010 17:22:42 -0800
Message-ID: <20100205012242.GE22747@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBE03@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52638 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0BEBWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 20:22:12 -0500
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBE03@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pais, Allen <allen.pais@ti.com> [100121 02:50]:
> From 4aa00e5dd0bdf06b7eb421cef9e066670669691e Mon Sep 17 00:00:00 2001
> From: Allen Pais <allen.pais@ti.com>
> Date: Thu, 21 Jan 2010 21:54:04 +0530
> Subject: [PATCH 2/2] omap: 3630: Disable internal pull-ups
> 
> This patch disables the newly introduced internal pull-up feature in
> OMAP3630, to use only the external HW resistor >=470 Ohm for the
> assured functionality in HS mode.
> 
> While testing the I2C in High Speed mode, it was discovered that
> without a proper pull-up resistor, there is data corruption during
> multi-byte transfers. RTC(time_set) test case was used for testing.
> 
> From the analysis done, it was concluded that ideally we need a
> pull-up of 1.6K Ohm (recomended) or atleast 470 Ohm or greater for
> assured performance in HS mode.
> 
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   21 +++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/control.h    |   13 +++++++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 5c8474c..804e8f5 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -23,6 +23,7 @@
>  
>  #include <plat/common.h>
>  #include <plat/usb.h>
> +#include <plat/control.h>
>  
>  #include "mux.h"
>  #include "mmc-twl4030.h"
> @@ -257,6 +258,26 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
>  
>  static int __init omap_i2c_init(void)
>  {
> +	/* Disable OMAP 3630 internal pull-ups for I2Ci */
> +	if (cpu_is_omap3630()) {
> +		u32 prog_io;
> +		prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> +		/* Program (bit 19)=1 to disable internal pull-up on I2C1 */
> +		prog_io |= OMAP3630_PRG_I2C1_PULLUPRESX;
> +		/* Program (bit 0)=1 to disable internal pull-up on I2C2 */
> +		prog_io |= OMAP3630_PRG_I2C2_PULLUPRESX;
> +		omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
> +
> +		prog_io = omap_ctrl_readl(OMAP36XX_CONTROL_PROG_IO2);
> +		/* Program (bit 7)=1 to disable internal pull-up on I2C3 */
> +		prog_io |= OMAP3630_PRG_I2C3_PULLUPRESX;
> +		omap_ctrl_writel(prog_io, OMAP36XX_CONTROL_PROG_IO2);
> +
> +		prog_io = omap_ctrl_readl(OMAP36XX_CONTROL_PROG_IO_WKUP1);
> +		/* Program (bit 5)=1 to disable internall pull-up on I2C4(SR) */
> +		prog_io |= OMAP3630_PRG_SR_PULLUPRESX;
> +		omap_ctrl_writel(prog_io, OMAP36XX_CONTROL_PROG_IO_WKUP1);
> +	}
>  	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
>  			ARRAY_SIZE(zoom_i2c_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);

To me it looks like both of these two patches should be done in a generic
way in the so every board that has this issue can specify it in the
platform data. No point adding the same code to each board-*.c file that
may have this issue. Maybe add it to arch/arm/mach-omap2/i2c.c instead?

Regards,

Tony


> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index a745d62..4fb487a 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -160,6 +160,8 @@
>  #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
>  #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
>  
> +/* 36xx-only CONTROL_GENERAL registor offsets */
> +#define OMAP36XX_CONTROL_PROG_IO2	(OMAP2_CONTROL_GENERAL + 0x0198)
>  
>  /* 34xx PADCONF register offsets */
>  #define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
> @@ -192,6 +194,9 @@
>  #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
>  #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
>  
> +/* 36xx-only GENERAL_WKUP register offsets */
> +#define OMAP36XX_CONTROL_PROG_IO_WKUP1	(OMAP343X_CONTROL_GENERAL_WKUP + 0x020)
> +
>  /* 34xx D2D idle-related pins, handled by PM core */
>  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
>  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
> @@ -242,6 +247,8 @@
>  #define OMAP2_PBIASLITEVMODE0		(1 << 0)
>  
>  /* CONTROL_PROG_IO1 bits */
> +#define OMAP3630_PRG_I2C2_PULLUPRESX	(1 << 0)
> +#define OMAP3630_PRG_I2C1_PULLUPRESX	(1 << 19)
>  #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
>  
>  /* CONTROL_IVA2_BOOTMOD bits */
> @@ -249,6 +256,12 @@
>  #define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
>  #define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
>  
> +/* CONTROL_PROG_IO2 bits on omap3630 */
> +#define OMAP3630_PRG_I2C3_PULLUPRESX	(1 << 7)
> +
> +/* CONTROL_PROG_IO_WKUP1 bits on omap3630 */
> +#define OMAP3630_PRG_SR_PULLUPRESX	(1 << 5)
> +
>  /* CONTROL_PADCONF_X bits */
>  #define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
>  #define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
> -- 
> 1.6.3.3
> 
> 
> - Allen --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
