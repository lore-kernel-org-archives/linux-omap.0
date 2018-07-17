From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Mon, 16 Jul 2018 23:36:31 -0700
Message-ID: <20180717063631.GZ99251@atomide.com>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180717 06:28]:
> +&i2c0 {
> +	lps331ap: barometer@5c {
> +		compatible = "st,lps331ap-press";
> +		st,drdy-int-pin = <1>;
> +		reg = <0x5c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	mpu6050: accelerometer@68 {
> +		compatible = "invensense,mpu6050";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +		orientation = <0xff 0 0 0 1 0 0 0 0xff>;
> +	};
> +
> +	usb2512b@2c {
> +		compatible = "microchip,usb2512b";
> +		reg = <0x2c>;
> +		reset-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +		/* wifi on port 4 */
> +	};
> +};

Thanks for updating it, should the last one be usb-hub@2c?

Regards,

Tony
