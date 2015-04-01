From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Wed, 1 Apr 2015 18:46:59 +0200
Message-ID: <034B4896-E7D1-4860-ADBE-78C4DB7C4B11@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com> <1426022847-30912-4-git-send-email-marek@goldelico.com> <CAL_JsqL1hMmp-cj56xDKJtdnySgLyCMJtmKVaLLtn=ALKUE8=g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:13088 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbDAQrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 12:47:35 -0400
In-Reply-To: <CAL_JsqL1hMmp-cj56xDKJtdnySgLyCMJtmKVaLLtn=ALKUE8=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

Am 01.04.2015 um 18:30 schrieb Rob Herring <robherring2@gmail.com>:

> On Tue, Mar 10, 2015 at 4:27 PM, Marek Belisko <marek@goldelico.com> wrote:
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>> 1 file changed, 43 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>> new file mode 100644
>> index 0000000..d3dd9d8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>> @@ -0,0 +1,43 @@
>> +twl4030_madc_battery
>> +
>> +Required properties:
>> + - compatible : "ti,twl4030-madc-battery"
> 
> Is this a sub-node of the twl4030 or something? Please define where
> this fits (hint: I would expect to be a sub node of a charging
> controller or battery monitor).

It is a driver connecting some battery parameters with measurements provided
by the twl4030-madc to present a /sys/class/power_supply node for the battery
with a coarse estimate for the charging level.

So maybe the best wording is that it is a battery-driver assuming a twl4030-madc
providing raw measurements (voltage, charging).

Therefore it could as well be battery-twl4030-madc.

> 
>> + - capacity-uah : battery capacity in uAh
>> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%) values
>> +       for charging calibration (see example)
>> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
>> +       for discharging calibration (see example)
> 
> These seem like properties of the battery independent of the
> battery/charging controller which is the twl4030. Ideally we would
> define battery nodes generically and independent of the charge
> controllers. Then there are smart batteries to consider too.

For smart batteries there are completely independent mechanisms
like I2C and HDQ/1-wire communication with fuel gauge chips (e.g. b27xxx).

Those do not need such battery properties because they are stored
in EEPROMs within these chips.

So all this is a quite special solution just for those handful of board that
have no smart battery and use exactly this twl4030 chip.

It is not intended to become a generic charging/fuel solution. Just
make it work with DT (it worked with platform_data since ~3.12).

BR,
Nikolaus



> 
> Rob
> 
>> + - io-channels: Should contain IIO channel specifiers
>> +       for each element in io-channel-names.
>> +- io-channel-names: Should contain the following values:
>> + * "temp" - The ADC channel for temperature reading
>> + * "ichg" - The ADC channel for battery charging status
>> + * "vbat" - The ADC channel to measure the battery voltage
>> +
>> +Example:
>> +       madc-battery {
>> +               compatible = "ti,twl4030-madc-battery";
>> +               capacity-uah = <1200000>;
>> +               ti,volt-to-capacity-charging-map = <4200 100>,
>> +                                               <4100 75>,
>> +                                               <4000 55>,
>> +                                               <3900 25>,
>> +                                               <3800 5>,
>> +                                               <3700 2>,
>> +                                               <3600 1>,
>> +                                               <3300 0>;
>> +
>> +               ti,volt-to-capacity-discharging-map = <4200 100>
>> +                                                  <4100 95>,
>> +                                                  <4000 70>,
>> +                                                  <3800 50>,
>> +                                                  <3700 10>,
>> +                                                  <3600 5>,
>> +                                                  <3300 0>;
>> +               io-channels = <&twl_madc 1>,
>> +                             <&twl_madc 10>,
>> +                             <&twl_madc 12>;
>> +               io-channel-names = "temp",
>> +                                  "ichg",
>> +                                  "vbat";
>> +       };
>> --
>> 1.9.1
>> 

