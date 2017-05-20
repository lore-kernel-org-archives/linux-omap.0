From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: Add a battery driver
Date: Sat, 20 May 2017 10:05:33 -0700
Message-ID: <20170520170533.GN10472@atomide.com>
References: <20170519055146.2038-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519055146.2038-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170518 22:55]:
> Note that I left out the battery interrupt handling for now as I need
> to spend more time on it for the battery empty interrupts. The driver
> works just fine without the interrupts too.
...
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> @@ -0,0 +1,27 @@
> +Motorola CPCAP PMIC battery driver binding
> +
> +Required properties:
> +- compatible: Shall be "motorola,cpcap-battery"
> +- interrupts: Interrupt specifier for each name in interrupt-names
> +- interrupt-names: Should contain the following entries:
> +		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
> +- io-channels: IIO ADC channel specifier for each name in io-channel-names
> +- io-channel-names: Should contain the following entries:
> +		    "battdetb", "battp"
> +
> +Example:
> +
> +cpcap_battery: battery {
> +	compatible = "motorola,cpcap-battery";
> +	interrupts-extended = <
> +		&cpcap 5 0 &cpcap 3 0
> +		&cpcap 20 0 &cpcap 54 0
> +	>;
> +	interrupt-names =
> +		"lowbph", "lowbpl",
> +		"chrgcurr1", "battdetb";
> +	io-channels = <&cpcap_adc 0 &cpcap_adc 1
> +		       &cpcap_adc 5 &cpcap_adc 6>;
> +	io-channel-names = "battdetb", "battp",
> +			   "chg_isense", "batti";
> +};

I guess we should leave out the interrupts in the binding for now
too. Or at least move them to optional properties.

Anyways, below is the related dts patch I've been using.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 19 May 2017 14:23:25 -0700
Subject: [PATCH] ARM: dts: omap4-droid4: Configure CPCAP battery driver

Configure CPCAP battery driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -26,6 +26,21 @@
 			#io-channel-cells = <1>;
 		};
 
+		cpcap_battery: battery {
+			compatible = "motorola,cpcap-battery";
+			interrupts-extended = <
+				&cpcap 5 0 &cpcap 3 0
+				&cpcap 20 0 &cpcap 54 0
+			>;
+			interrupt-names =
+				"lowbph", "lowbpl",
+				"chrgcurr1", "battdetb";
+			io-channels = <&cpcap_adc 0 &cpcap_adc 1
+				       &cpcap_adc 5 &cpcap_adc 6>;
+			io-channel-names = "battdetb", "battp",
+					   "chg_isense", "batti";
+		};
+
 		cpcap_charger: charger {
 			compatible = "motorola,mapphone-cpcap-charger";
 			interrupts-extended = <
-- 
2.13.0
