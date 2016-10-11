From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] n900 device tree: cleanup, add camera flash
Date: Tue, 11 Oct 2016 10:01:39 +0200
Message-ID: <20161011080139.GK4467@pali>
References: <20161011075416.GA22453@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011075416.GA22453@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 11 October 2016 09:54:17 Pavel Machek wrote:
> @@ -669,6 +670,22 @@
>  
>  		ti,usb-charger-detection = <&isp1707>;
>  	};
> +
> +	adp1653: led-controller@30 {
> +		compatible = "adi,adp1653";
> +		reg = <0x30>;
> +		gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +		flash {
> +			flash-timeout-us = <500000>;
> +			flash-max-microamp = <320000>;
> +			max-microamp = <50000>;
> +		};
> +
> +		indicator {
> +			max-microamp = <17500>;
> +		};
> +	};
>  };
>  
>  &i2c3 {
> 

This part of patch is already in mainline kernel, isn't?

-- 
Pali Rohár
pali.rohar@gmail.com
