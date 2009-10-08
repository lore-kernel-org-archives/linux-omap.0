From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] board-rx51-peripherals: split vaux3 and vmmc2
 supplies
Date: Thu, 8 Oct 2009 14:21:10 +0100
Message-ID: <20091008132109.GD29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34431 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757974AbZJHNVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:21:47 -0400
Content-Disposition: inline
In-Reply-To: <1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 02:58:54PM +0300, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

> Use separated supplies for vaux3 and vmmc2.

> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>

> +static struct regulator_consumer_supply rx51_vaux3_supply = {
> +	.supply			= "vmmc",
> +};
> +

I'd expect all these supplies to have devices associated with them (see
below)...

>  static struct regulator_consumer_supply rx51_vmmc2_supply = {
>  	.supply			= "vmmc",
>  };
> @@ -184,7 +188,7 @@ static struct regulator_init_data rx51_vaux3_mmc = {
>  					| REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &rx51_vmmc2_supply,
> +	.consumer_supplies	= &rx51_vaux3_supply,
>  };

I may have missed it but I don't see rx51_vmmc2_supply added back
anywhere in the patch?

>  static struct regulator_init_data rx51_vaux4 = {
> @@ -266,7 +270,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
>  	/* set up MMC adapters, linking their regulators to them */
>  	twl4030_mmc_init(mmc);
>  	rx51_vmmc1_supply.dev = mmc[0].dev;
> -	rx51_vmmc2_supply.dev = mmc[1].dev;
> +	rx51_vaux3_supply.dev = mmc[1].dev;

...using dev_name rather than dev should avoid the need to do this at
runtime.
