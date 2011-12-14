From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 07/10] arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
Date: Tue, 13 Dec 2011 21:06:16 -0800
Message-ID: <87obvbpws7.fsf@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
	<1323439361-1647-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58072 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722Ab1LNFGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 00:06:19 -0500
Received: by mail-iy0-f171.google.com with SMTP id n33so813675iae.2
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 21:06:19 -0800 (PST)
In-Reply-To: <1323439361-1647-8-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 9 Dec 2011 15:02:38 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

Benoit Cousson <b-cousson@ti.com> writes:

> Update pandaboard dts file with required clock frequencies
> for the i2c client devices existing on pandaboard.
>
> Add the twl6030 node in i2c1 controller.
>
> This is the minimal support needed to boot OMAP4 boards
> without any crash.
> The support for all the features included in this MFD will be
> added later.
>
> Add a generic i2c EEPROM entry.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/boot/dts/omap4-panda.dts |   45 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 9755ad5..b66bcd6 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -18,3 +18,48 @@
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

After seeing the mostly cut & paste in Rajendra's regulator series, I'm
wondering if it wouldn't be better to just have a twl4030.dtsi here
which has the RTC and all the regulators with the default voltage ranges
from the TWL data sheet.   

Not knowing much about how includes work in DT, would it then be
possible for board files to override things like default voltage ranges
for regulators?

Kevin
