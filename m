From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm, am335x: add support for the bosch shc board
Date: Mon, 30 Nov 2015 13:41:30 -0800
Message-ID: <20151130214130.GA23396@atomide.com>
References: <1447748655-2088-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447748655-2088-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Georg.Soffel-k21M0aUVSxZWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org> [151117 00:25]:
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-shc.dts
> +&tps {
> +	compatible = "ti,tps65217";
> +	ti,pmic-shutdown-controller;
> +
> +	regulators {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dcdc1_reg: regulator@0 {
> +			reg = <0>;
> +			regulator-name = "vdds_dpr";
> +			regulator-compatible = "dcdc1";
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		dcdc2_reg: regulator@1 {
> +			reg = <1>;
> +			/*
> +			 * VDD_MPU voltage limits 0.95V - 1.26V with
> +			 * +/-4% tolerance
> +			 */
> +			regulator-compatible = "dcdc2";
> +			regulator-name = "vdd_mpu";
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <1375000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +			regulator-ramp-delay = <70000>;
> +		};
> +
> +		dcdc3_reg: regulator@2 {
> +			reg = <2>;
> +			/*
> +			 * VDD_CORE voltage limits 0.95V - 1.1V with
> +			 * +/-4% tolerance
> +			 */
> +			regulator-name = "vdd_core";
> +			regulator-compatible = "dcdc3";
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <1125000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		ldo1_reg: regulator@3 {
> +			reg = <3>;
> +			regulator-name = "vio,vrtc,vdds";
> +			regulator-compatible = "ldo1";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo2_reg: regulator@4 {
> +			reg = <4>;
> +			regulator-name = "vdd_3v3aux";
> +			regulator-compatible = "ldo2";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo3_reg: regulator@5 {
> +			reg = <5>;
> +			regulator-name = "vdd_1v8";
> +			regulator-compatible = "ldo3";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo4_reg: regulator@6 {
> +			reg = <6>;
> +			regulator-name = "vdd_3v3a";
> +			regulator-compatible = "ldo4";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +};

Applying this into omap-for-v4.5/dt.. But I'm getting concerned about this
"regulator-always-on" stuff and having multiple copies of the same thing.

I think we should have a common am33xx-tps65217.dtsi file that has the
regulators defined at one place and other then include it. And they are
controllable AFAIK..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
