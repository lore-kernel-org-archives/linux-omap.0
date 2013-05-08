From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Wed, 8 May 2013 15:12:22 -0700
Message-ID: <20130508221221.GJ32546@atomide.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366024808-4691-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [130415 04:25]:
> On Beagle xM Rev. Ax/Bx, the USB power enable GPIO logic is
> reversed when compared to other revisions i.e. it is
> active high instead of active low.
> 
> Use the beagle_config.usb_pwr_level flag correctly so that
> the power regulator can be configured at runtime.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks applying into omap-for-v3.10/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 5382215..21136b2 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -112,13 +112,13 @@ static u8 omap3_beagle_version;
>   */
>  static struct {
>  	int mmc1_gpio_wp;
> -	int usb_pwr_level;
> +	bool usb_pwr_level;	/* 0 - Active Low, 1 - Active High */
>  	int dvi_pd_gpio;
>  	int usr_button_gpio;
>  	int mmc_caps;
>  } beagle_config = {
>  	.mmc1_gpio_wp = -EINVAL,
> -	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
> +	.usb_pwr_level = 0,
>  	.dvi_pd_gpio = -EINVAL,
>  	.usr_button_gpio = 4,
>  	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> @@ -178,7 +178,7 @@ static void __init omap3_beagle_init_rev(void)
>  	case 0:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: xM Ax/Bx\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> -		beagle_config.usb_pwr_level = GPIOF_OUT_INIT_HIGH;
> +		beagle_config.usb_pwr_level = 1;
>  		beagle_config.mmc_caps &= ~MMC_CAP_8_BIT_DATA;
>  		break;
>  	case 2:
> -- 
> 1.7.4.1
> 
