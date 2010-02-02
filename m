From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] omap: 3630: Disable internal pull-ups
Date: Mon, 1 Feb 2010 20:45:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002012038170.19652@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55694 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0BBDpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 22:45:50 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, m-sonasath@ti.com, vikram.pandita@ti.com, rnayak@ti.com, tony@atomide.com

Hello Allen,

a few comments:

On Thu, 21 Jan 2010, Pais, Allen wrote:

> >From 9a6b34dca3ff8ce4a200df4b65037978e4325452 Mon Sep 17 00:00:00 2001
> From: Allen Pais <allen.pais@ti.com>
> Date: Thu, 21 Jan 2010 21:23:41 +0530
> Subject: [PATCH 2/2] omap: 3630: Disable internal pull-ups

Please don't repeat the headers in the message - this will force the 
maintainer to edit the commit message.  The only header that should be 
repeated is 'From:', in the event that you are forwarding along a patch 
written by someone else.

Speaking of which, regarding Vikram's message, if these two patches were 
written by Moiz, then they should say: "From: Moiz Sonasath 
<m-sonasath@ti.com>" at the beginning of the message.

Also:

> This patch disables the newly introduced internal pull-up feature in
> OMAP3630, to use only the external HW resistor >=470 Ohm for the
> assured functionality in HS mode.
> 
> While testing the I2C in High Speed mode, it was discovered that
> without a proper pull-up resistor, there is data corruption during
> multi-byte transfers. RTC(time_set) test case was used for testing.
> 
> >From the analysis done, it was concluded that ideally we need a
> pull-up of 1.6K Ohm (recomended) or atleast 470 Ohm or greater for
> assured performance in HS mode.
> 
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   20 ++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/control.h    |   13 +++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 5c8474c..3ddd51a 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -257,6 +257,26 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
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
> +		prog_io |= OMAP_3630_PRG_SR_PULLUPRESX;
> +		omap_ctrl_writel(prog_io, OMAP36XX_CONTROL_PROG_IO_WKUP1);
> +	}
>  	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
>  			ARRAY_SIZE(zoom_i2c_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index a745d62..2213d4b 100644
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
> +#define OMAP_36XX_CONTROL_PROG_IO_WKUP1	(OMAP343X_CONTROL_GENERAL_WKUP + 0x020)

Please remove the extra underscore after "OMAP" in the line above to 
conform to the style of the rest of the file.


- Paul
