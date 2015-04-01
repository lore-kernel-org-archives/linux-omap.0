From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Wed, 1 Apr 2015 11:30:37 -0500
Message-ID: <CAL_JsqL1hMmp-cj56xDKJtdnySgLyCMJtmKVaLLtn=ALKUE8=g@mail.gmail.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com> <1426022847-30912-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426022847-30912-4-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 10, 2015 at 4:27 PM, Marek Belisko <marek@goldelico.com> wrote:
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

Is this a sub-node of the twl4030 or something? Please define where
this fits (hint: I would expect to be a sub node of a charging
controller or battery monitor).

> + - capacity-uah : battery capacity in uAh
> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +       for charging calibration (see example)
> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +       for discharging calibration (see example)

These seem like properties of the battery independent of the
battery/charging controller which is the twl4030. Ideally we would
define battery nodes generically and independent of the charge
controllers. Then there are smart batteries to consider too.

Rob

> + - io-channels: Should contain IIO channel specifiers
> +       for each element in io-channel-names.
> +- io-channel-names: Should contain the following values:
> + * "temp" - The ADC channel for temperature reading
> + * "ichg" - The ADC channel for battery charging status
> + * "vbat" - The ADC channel to measure the battery voltage
> +
> +Example:
> +       madc-battery {
> +               compatible = "ti,twl4030-madc-battery";
> +               capacity-uah = <1200000>;
> +               ti,volt-to-capacity-charging-map = <4200 100>,
> +                                               <4100 75>,
> +                                               <4000 55>,
> +                                               <3900 25>,
> +                                               <3800 5>,
> +                                               <3700 2>,
> +                                               <3600 1>,
> +                                               <3300 0>;
> +
> +               ti,volt-to-capacity-discharging-map = <4200 100>
> +                                                  <4100 95>,
> +                                                  <4000 70>,
> +                                                  <3800 50>,
> +                                                  <3700 10>,
> +                                                  <3600 5>,
> +                                                  <3300 0>;
> +               io-channels = <&twl_madc 1>,
> +                             <&twl_madc 10>,
> +                             <&twl_madc 12>;
> +               io-channel-names = "temp",
> +                                  "ichg",
> +                                  "vbat";
> +       };
> --
> 1.9.1
>
