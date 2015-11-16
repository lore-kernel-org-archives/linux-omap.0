From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 8/8] DT:omap3+ads7846: use new common touchscreen bindings
Date: Mon, 16 Nov 2015 16:31:24 +0100
Message-ID: <28AFB27C-1D97-49E1-80B2-79000AD426D2@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com> <df5bd5fdcc2284a7d8e2d5132bc865701a8ca38f.1447446957.git.hns@goldelico.com> <CANOLnOO=J=se7K7GnJZPrkXJpm-_+vshsRUCeWo1GVsum8jyeg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnOO=J=se7K7GnJZPrkXJpm-_+vshsRUCeWo1GVsum8jyeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, gta04-owner@goldelico.comlinux
List-Id: linux-omap@vger.kernel.org

HI,

Am 16.11.2015 um 15:37 schrieb Grazvydas Ignotas <notasas@gmail.com>:

> Hi,
> 
> On Fri, Nov 13, 2015 at 10:35 PM, H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
>> The standard touch screen bindings [1] replace the private ti,swap-xy
>> with touchscreen-swaped-x-y. And for the Openpandora we use
>> touchscreen-size etc. to match the LCD screen size.
>> 
>> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-lilly-a83x.dtsi              |  2 +-
>> arch/arm/boot/dts/omap3-pandora-common.dtsi          | 17 +++++++++++++----
>> arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |  2 +-
>> 3 files changed, 15 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>> index d0dd036..01dae66 100644
>> --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>> @@ -325,7 +325,7 @@
>>                ti,y-max = /bits/ 16 <3600>;
>>                ti,x-plate-ohms = /bits/ 16 <80>;
>>                ti,pressure-max = /bits/ 16 <255>;
>> -               ti,swap-xy;
>> +               touchscreen-swapped-x-y;
>> 
>>                linux,wakeup;
>>        };
>> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> index f672a04..9497cc6 100644
>> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> @@ -696,10 +696,19 @@
>>                pendown-gpio = <&gpio3 30 0>;
>>                vcc-supply = <&vaux4>;
>> 
>> -               ti,x-min = /bits/ 16 <0>;
>> -               ti,x-max = /bits/ 16 <8000>;
>> -               ti,y-min = /bits/ 16 <0>;
>> -               ti,y-max = /bits/ 16 <4800>;
>> +               touchscreen-size-x = <800>;
>> +               touchscreen-size-y = <480>;
>> +               touchscreen-max-pressure = <1000>;
>> +               touchscreen-fuzz-x = <16>;
>> +               touchscreen-fuzz-y = <16>;
>> +               touchscreen-fuzz-pressure = <10>;
>> +               touchscreen-inverted-x;
>> +               touchscreen-inverted-y;
>> +
>> +               ti,x-min = /bits/ 16 <160>;
>> +               ti,x-max = /bits/ 16 <3900>;
>> +               ti,y-min = /bits/ 16 <220>;
>> +               ti,y-max = /bits/ 16 <3750>;
> 
> I'm not sure this is a good idea, there have been at least 3 different
> batches of LCDs which slightly different touchscreens attached, with
> such thresholds we might end up with unreachable touchscreen points on
> some units. If I understand right, calibration won't help if for some
> screen locations ADC reading goes below/above these min/max thresholds
> on some specific units? If so there should probably be at least 10%
> margin in either case to make calibration useful.

Ok, then someone owning all variants should test and we should use the
min/max values we find. I.e. the touch with the biggest ADC value range.
All others have smaller screens which can be calibrated in user space.
But 10% is good enough to boot and start manual calibration.

Alternatively, we can set them to 0 and 4095 (or remove them to use defaults).

BR and thanks,
Nikolaus
