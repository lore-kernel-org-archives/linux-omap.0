From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/2] arm: dts: gta04: add ldo 3v3 regulator
Date: Fri, 1 Feb 2019 11:02:44 +0100
Message-ID: <20190201100244.GC3691@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-2-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131180640.14480-2-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 31, 2019 at 07:06:39PM +0100, Andreas Kemnade wrote:
> Required for completeness sake to be able to specify
> a regulator for devices having a non-optional regulator
> property. It corresponds to the "3V3" net in the
> schematics.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> new in v3
> 
>  arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e53d32691308..02d8274a2f47 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -32,6 +32,14 @@
>  		display1 = &tv0;
>  	};
>  
> +	ldo_3v3: fixedregulator {

A suffix, even if its just to rename as "fixedregulator0", would allow
further fixed regulators to be added later, but I guess that can be
handled then.

> +		compatible = "regulator-fixed";
> +		regulator-name = "ldo_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
>  	/* fixed 26MHz oscillator */
>  	hfclk_26m: oscillator {
>  		#clock-cells = <0>;

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
