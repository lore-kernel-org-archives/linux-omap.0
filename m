From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 08/10] arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4
 devices
Date: Wed, 4 Jan 2012 11:14:55 -0700
Message-ID: <20120104181455.GO15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-9-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40998 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2ADTLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 14:11:35 -0500
Received: by vcbfk14 with SMTP id fk14so13449682vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 11:11:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323439361-1647-9-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:39PM +0100, Benoit Cousson wrote:
> Update DTS file with required clock frequencies
> for the i2c client devices existing on sdp4430.
> 
> Add the twl6030 node inside the i2c1 controller node.
> This is the minimal support needed to boot OMAP4 boards
> without any crash.
> The support for all the features included in this MFD will be
> added later.
> 
> Add the RTC submodule inside the twl node.
> 
> Add tmp105 temperature sensor in i2c3
> Add bh1780 Ambient Light Sensor in i2c3
> Add hmc5843 3-Axis Digital Compass in i2c4
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/boot/dts/omap4-sdp.dts |   63 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 63c6b2b..0ab14cb 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -18,3 +18,66 @@
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
>  	};
>  };
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	/*
> +	 * Integrated Power Management Chip
> +	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
> +	 */
> +	twl@48 {
> +		compatible = "ti,twl6030";
> +		reg = <0x48>;
> +		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
> +		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupt-parent = <&gic>;
> +
> +		/* twl is a MFD, so it will contain a bunch of sub-ips */
> +		rtc {
> +			compatible = "ti,twl4030-rtc";
> +			interrupts = <11>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +
> +	/*
> +	 * Temperature Sensor
> +	 * http://www.ti.com/lit/ds/symlink/tmp105.pdf
> +	 */
> +	tmp105@48 {
> +		compatible = "ti,tmp105";
> +		reg = <0x48>;
> +	};
> +
> +	/*
> +	 * Ambient Light Sensor
> +	 * http://www.rohm.com/products/databook/sensor/pdf/bh1780gli-e.pdf
> +	 */
> +	bh1780@29 {
> +		compatible = "rohm,bh1780";
> +		reg = <0x29>;
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +
> +	/*
> +	 * 3-Axis Digital Compass
> +	 * http://www.sparkfun.com/datasheets/Sensors/Magneto/HMC5843.pdf
> +	 */
> +	hmc5843@1e {
> +		compatible = "honeywell,hmc5843";
> +		reg = <0x1e>;
> +	};
> +};
> -- 
> 1.7.0.4
> 
