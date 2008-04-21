From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: HSMMC: Use macros instead of some magic
	constants.
Date: Mon, 21 Apr 2008 11:05:59 -0700
Message-ID: <20080421180559.GX12099@atomide.com>
References: <48061C1E.1030007@indt.org.br> <20080418183945.GF12099@atomide.com> <48090497.6080800@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64411 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbYDUSGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 14:06:00 -0400
Content-Disposition: inline
In-Reply-To: <48090497.6080800@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [080418 13:33]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This patch makes arch/arm/mach-omap2/board-sdp-hsmmc.c file to use macros
> instead of some magic constants.

Pushing.

Tony


> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> Acked-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
> Acked-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  arch/arm/mach-omap2/board-sdp-hsmmc.c |   55 +++++++++++++++++++++++---------
>  1 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/board-sdp-hsmmc.c
> index 355c1c0..d21af87 100644
> --- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
> +++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
> @@ -35,6 +35,16 @@
>  #define MMC1_CD_IRQ		0
>  #define MMC2_CD_IRQ		1
>  
> +#define OMAP2_CONTROL_DEVCONF0	0x48002274
> +#define OMAP2_CONTROL_DEVCONF1	0x490022E8
> +
> +#define OMAP2_CONTROL_DEVCONF0_LBCLK	(1 << 24)
> +#define OMAP2_CONTROL_DEVCONF1_ACTOV	(1 << 31)
> +
> +#define OMAP2_CONTROL_PBIAS_VMODE	(1 << 0)
> +#define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
> +#define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
> +
>  static int sdp_mmc_card_detect(int irq)
>  {
>  	return twl4030_get_gpio_datain(irq - IH_TWL4030_GPIO_BASE);
> @@ -158,32 +168,36 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
>  
>  	if (power_on) {
>  		if (cpu_is_omap24xx())
> -			devconf = omap_readl(0x490022E8);
> +			devconf = omap_readl(OMAP2_CONTROL_DEVCONF1);
>  		else
> -			devconf = omap_readl(0x48002274);
> +			devconf = omap_readl(OMAP2_CONTROL_DEVCONF0);
>  
>  		switch (1 << vdd) {
>  		case MMC_VDD_33_34:
>  		case MMC_VDD_32_33:
>  			vdd_sel = VSEL_3V;
>  			if (cpu_is_omap24xx())
> -				devconf = (devconf | (1 << 31));
> +				devconf |= OMAP2_CONTROL_DEVCONF1_ACTOV;
>  			break;
>  		case MMC_VDD_165_195:
>  			vdd_sel = VSEL_18V;
>  			if (cpu_is_omap24xx())
> -				devconf = (devconf & ~(1 << 31));
> +				devconf &= ~OMAP2_CONTROL_DEVCONF1_ACTOV;
>  		}
>  
>  		if (cpu_is_omap24xx())
> -			omap_writel(devconf, 0x490022E8);
> +			omap_writel(devconf, OMAP2_CONTROL_DEVCONF1);
>  		else
> -			omap_writel(devconf | 1 << 24, 0x48002274);
> +			omap_writel(devconf | OMAP2_CONTROL_DEVCONF0_LBCLK,
> +				    OMAP2_CONTROL_DEVCONF0);
>  
> -		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 1 << 2,
> -			OMAP2_CONTROL_PBIAS);
> -		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) & ~(1 << 1),
> -			OMAP2_CONTROL_PBIAS);
> +		reg = omap_readl(OMAP2_CONTROL_PBIAS);
> +		reg |= OMAP2_CONTROL_PBIAS_SCTRL;
> +		omap_writel(reg, OMAP2_CONTROL_PBIAS);
> +
> +		reg = omap_readl(OMAP2_CONTROL_PBIAS);
> +		reg &= ~OMAP2_CONTROL_PBIAS_PWRDNZ;
> +		omap_writel(reg, OMAP2_CONTROL_PBIAS);
>  
>  		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>  						P1_DEV_GRP, VMMC1_DEV_GRP);
> @@ -197,8 +211,12 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
>  
>  		msleep(100);
>  		reg = omap_readl(OMAP2_CONTROL_PBIAS);
> -		reg = (vdd_sel == VSEL_18V) ? ((reg | 0x6) & ~0x1)
> -						: (reg | 0x7);
> +		reg |= (OMAP2_CONTROL_PBIAS_SCTRL |
> +			OMAP2_CONTROL_PBIAS_PWRDNZ);
> +		if (vdd_sel == VSEL_18V)
> +			reg &= ~OMAP2_CONTROL_PBIAS_VMODE;
> +		else
> +			reg |= OMAP2_CONTROL_PBIAS_VMODE;
>  		omap_writel(reg, OMAP2_CONTROL_PBIAS);
>  
>  		return ret;
> @@ -207,8 +225,10 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
>  		/* Power OFF */
>  
>  		/* For MMC1, Toggle PBIAS before every power up sequence */
> -		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) & ~(1 << 1),
> -					OMAP2_CONTROL_PBIAS);
> +		reg = omap_readl(OMAP2_CONTROL_PBIAS);
> +		reg &= ~OMAP2_CONTROL_PBIAS_PWRDNZ;
> +		omap_writel(reg, OMAP2_CONTROL_PBIAS);
> +
>  		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>  						LDO_CLR, VMMC1_DEV_GRP);
>  		if (ret)
> @@ -221,8 +241,11 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
>  
>  		/* 100ms delay required for PBIAS configuration */
>  		msleep(100);
> -		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 0x7,
> -			OMAP2_CONTROL_PBIAS);
> +		reg = omap_readl(OMAP2_CONTROL_PBIAS);
> +		reg |= (OMAP2_CONTROL_PBIAS_VMODE |
> +			OMAP2_CONTROL_PBIAS_PWRDNZ |
> +			OMAP2_CONTROL_PBIAS_SCTRL);
> +		omap_writel(reg, OMAP2_CONTROL_PBIAS);
>  	}
>  
>  	return 0;
> -- 1.5.3.GIT
> 
