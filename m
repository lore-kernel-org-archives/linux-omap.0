From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a
 regression that unhides a broken legacy handler, which makes the gta04
 display inoperable
Date: Mon, 1 Apr 2019 09:46:17 -0700
Message-ID: <20190401164617.GH49658@atomide.com>
References: <cover.1554026842.git.hns@goldelico.com>
 <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [190331 10:08]:
> This is an ugly workaround for a regression introduced into v5.1-rc1 by
> 
> <c1c04cea13dc234ce9a4504879ddd36ea524d880>

You should standardized commit references like this instead:

c1c04cea13dc ("gpio: of: Fix logic inversion")

Then please also include a proper Fixes tag.

You can configure an alias for it to make things easier:

git log --abbrev=12 --pretty=format:"%h (\"%s\")"

> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -114,6 +114,7 @@
>  		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>  		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
>  		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
>  		num-chipselects = <1>;
>  
>  		/* lcd panel */
> @@ -123,6 +124,7 @@
>  			spi-max-frequency = <100000>;
>  			spi-cpol;
>  			spi-cpha;
> +			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
>  
>  			backlight= <&backlight>;
>  			label = "lcd";

So what's the plan with this fix? Add this for v5.2-rc cycle,
then revert it later? I'd probably go directly for the proper
fix if possible.

Regards,

Tony
