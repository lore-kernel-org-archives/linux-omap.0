From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date: Mon, 21 Jan 2019 09:11:01 -0800
Message-ID: <20190121171101.GD5544@atomide.com>
References: <20190121032109.10220-1-spinal.by@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121032109.10220-1-spinal.by@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arthur Demchenkov <spinal.by@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Arthur Demchenkov <spinal.by@gmail.com> [190121 03:22]:
> Wrong polarity of card detect GPIO pin leads to the system not
> booting from external mmc, if the back cover of N900 is closed.
> When the cover is open the system boots fine.
> 
> This wasn't noticed before, because of a bug, which was fixed
> by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> CD and WP).

Aaro, does this work for your test case too?

> Kernels up to 4.19 ignored the card detect GPIO from DT.

Hmm so should this have a Fixes tag or not?

Regards,

Tony

>  arch/arm/boot/dts/omap3-n900.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 182a53991c90..826920e6b878 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -814,7 +814,7 @@
>  	/* For debugging, it is often good idea to remove this GPIO.
>  	   It means you can remove back cover (to reboot by removing
>  	   battery) and still use the MMC card. */
> -	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
> +	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
>  };
>  
>  /* most boards use vaux3, only some old versions use vmmc2 instead */
> -- 
> 2.11.0
> 
