From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 11 Mar 2015 08:24:15 -0700
Message-ID: <20150311152414.GX5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36469 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbbCKP3V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 11:29:21 -0400
Content-Disposition: inline
In-Reply-To: <1426022847-30912-4-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com

Hi,

* Marek Belisko <marek@goldelico.com> [150310 14:28]:
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> new file mode 100644
> index 0000000..d3dd9d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> @@ -0,0 +1,43 @@
> +twl4030_madc_battery
> +
> +Required properties:
> + - compatible : "ti,twl4030-madc-battery"
> + - capacity-uah : battery capacity in uAh
> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +	for charging calibration (see example)
> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +	for discharging calibration (see example)
> + - io-channels: Should contain IIO channel specifiers
> +	for each element in io-channel-names.
> +- io-channel-names: Should contain the following values:
> + * "temp" - The ADC channel for temperature reading
> + * "ichg" - The ADC channel for battery charging status
> + * "vbat" - The ADC channel to measure the battery voltage
> +
> +Example:
> +	madc-battery {
> +		compatible = "ti,twl4030-madc-battery";
> +		capacity-uah = <1200000>;
> +		ti,volt-to-capacity-charging-map = <4200 100>,
> +					        <4100 75>,
> +					        <4000 55>,
> +					        <3900 25>,
> +					        <3800 5>,
> +					        <3700 2>,
> +					        <3600 1>,
> +					        <3300 0>;
> +
> +		ti,volt-to-capacity-discharging-map = <4200 100>
> +						   <4100 95>,
> +						   <4000 70>,
> +						   <3800 50>,
> +						   <3700 10>,
> +						   <3600 5>,
> +						   <3300 0>;
> +		io-channels = <&twl_madc 1>,
> +	                      <&twl_madc 10>,
> +			      <&twl_madc 12>;
> +		io-channel-names = "temp",
> +		                   "ichg",
> +		                   "vbat";
> +	};

Rather than just making platform_data into device tree properties..

Can't you hide the these custom properties behind the compatible flag?

You can initialize that data in the driver based on the compatible
flag and the match data.

This makes sense if you can group things to similar configurations.

Regards,

Tony

