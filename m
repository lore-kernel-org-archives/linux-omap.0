From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP3: hsmmc: fix MMC 2 setup for AM35x
Date: Thu, 08 Dec 2011 21:25:20 +0200
Message-ID: <4EE10F20.5080806@compulab.co.il>
References: <1322559468-5883-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:48608
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751280Ab1LHTZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:25:31 -0500
In-Reply-To: <1322559468-5883-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

ping

Tony,
I'd like this to go into 3.3, can it?

On 11/29/11 11:37, Igor Grinberg wrote:
> AM35x MMC 2 controller has internal clock loopback setting which cannot
> be utilized without this patch and thus SDIO devices connected to this
> controller and depend on this setting will fail to initialize.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/hsmmc.c |   42 ++++++++++++++++++++++++++++++------------
>  1 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index ecde558..c80859e 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -171,6 +171,17 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>  	}
>  }
>  
> +static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
> +{
> +	u32 reg;
> +
> +	if (mmc->slots[0].internal_clock) {
> +		reg = omap_ctrl_readl(control_devconf1_offset);
> +		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> +		omap_ctrl_writel(reg, control_devconf1_offset);
> +	}
> +}
> +
>  static void hsmmc23_before_set_reg(struct device *dev, int slot,
>  				   int power_on, int vdd)
>  {
> @@ -179,16 +190,19 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
>  	if (mmc->slots[0].remux)
>  		mmc->slots[0].remux(dev, slot, power_on);
>  
> -	if (power_on) {
> -		/* Only MMC2 supports a CLKIN */
> -		if (mmc->slots[0].internal_clock) {
> -			u32 reg;
> +	if (power_on)
> +		hsmmc2_select_input_clk_src(mmc);
> +}
>  
> -			reg = omap_ctrl_readl(control_devconf1_offset);
> -			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> -			omap_ctrl_writel(reg, control_devconf1_offset);
> -		}
> -	}
> +static int am35x_hsmmc2_set_power(struct device *dev, int slot,
> +				  int power_on, int vdd)
> +{
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +
> +	if (power_on)
> +		hsmmc2_select_input_clk_src(mmc);
> +
> +	return 0;
>  }
>  
>  static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
> @@ -346,9 +360,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>  	else
>  		mmc->slots[0].ocr_mask = c->ocr_mask;
>  
> -	if (cpu_is_omap3517() || cpu_is_omap3505())
> -		mmc->slots[0].set_power = nop_mmc_set_power;
> -	else
> +	if (!cpu_is_omap3517() && !cpu_is_omap3505())
>  		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
>  
>  	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
> @@ -371,6 +383,9 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>  			}
>  		}
>  
> +		if (cpu_is_omap3517() || cpu_is_omap3505())
> +			mmc->slots[0].set_power = nop_mmc_set_power;
> +
>  		/* OMAP3630 HSMMC1 supports only 4-bit */
>  		if (cpu_is_omap3630() &&
>  				(c->caps & MMC_CAP_8_BIT_DATA)) {
> @@ -380,6 +395,9 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>  		}
>  		break;
>  	case 2:
> +		if (cpu_is_omap3517() || cpu_is_omap3505())
> +			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
> +
>  		if (c->ext_clock)
>  			c->transceiver = 1;
>  		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {

-- 
Regards,
Igor.
