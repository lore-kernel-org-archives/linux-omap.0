From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Mon, 16 Jul 2018 23:16:40 -0700
Message-ID: <20180717061640.GX99251@atomide.com>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
 <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Koen,

Just noticed there should be generic node names here too, see below.

* Koen Kooi <koen@dominion.thruhere.net> [180713 06:28]:
> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
> but with the following differences:
> 
>  * Gigabit capable PHY
>  * Extra USB hub, optional i2c control
>  * lps3331ap barometer connected over i2c
>  * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>  * 1GiB DDR3 RAM
>  * RTL8723 Wifi/Bluetooth connected over USB

> +&i2c0 {
> +	lps331ap: lps331ap@5C {
> +		compatible = "st,lps331ap-press";
> +		st,drdy-int-pin = <1>;
> +		reg = <0x5C>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
> +	};

lps33lap: barometer@5c

> +	mpu6050: mpu6050@68 {
> +		compatible = "invensense,mpu6050";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +		orientation = <0xff 0 0 0 1 0 0 0 0xff>;
> +	};

mpu6050: accelerometer@2c

And so on. Please check the lower case hex numbers too as
that's what Linux typically uses.

Thanks,

Tony
