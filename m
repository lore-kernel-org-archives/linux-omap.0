From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 2/3] gpio-twl4030: new dt properties for BeagleBoard and
 omap3-EVM
Date: Tue, 4 Sep 2012 12:57:27 +0530
Message-ID: <5045AD5F.2030503@ti.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch> <1346680491-4211-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006Ab2IDH1g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Sep 2012 03:27:36 -0400
In-Reply-To: <1346680491-4211-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org



On 9/3/2012 7:24 PM, Florian Vaussard wrote:
> Add device tree properties for twl4030/gpio, according to the
> platform data of corresponding boards. This enables the led
> connected to LEDB output for both boards, as well as
> pullups/pulldowns on GPIO for the BeagleBoard.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap3-evm.dts    |   13 +++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index cdcb98c..16bff8b 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -17,6 +17,14 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x20000000>; /* 512 MB */
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pmu_stat {
> +			label = "beagleboard::pmu_stat";
> +			gpios = <&twl_gpio 19 0>; /* LEDB */
> +		};
> +	};
>  };
>  
>  &i2c1 {
> @@ -67,3 +75,15 @@
>  &mmc3 {
>  	status = "disabled";
>  };
> +
> +&twl_gpio {
> +	ti,use-leds = "true";
> +	/* pullups: BIT(1) */
> +	ti,pullups = <2>;
> +	/*
> +	 * pulldowns:
> +	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
> +	 * BIT(15), BIT(16), BIT(17)
> +	 */
> +	ti,pulldowns = <238020>;

Consider changing above value to hex presentation.
Otherwise looks ok to me, also I have tested it on OMAP3EVM.

Tested-&-Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> +};
> diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
> index f349ee9..f1e18fe 100644
> --- a/arch/arm/boot/dts/omap3-evm.dts
> +++ b/arch/arm/boot/dts/omap3-evm.dts
> @@ -17,6 +17,15 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		ledb {
> +			label = "omap3evm::ledb";
> +			gpios = <&twl_gpio 19 0>; /* LEDB */
> +			linux,default-trigger = "default-on";
> +		};
> +	};
>  };
>  
>  &i2c1 {
> @@ -46,3 +55,7 @@
>  		reg = <0x5c>;
>  	};
>  };
> +
> +&twl_gpio {
> +	ti,use-leds = "true";
> +};
> 
