From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 4/6] ARM: dts: AM335x: Make charge delay a DT parameter
 for TSC
Date: Wed, 7 Jan 2015 11:17:20 +0530
Message-ID: <54ACC868.7040801@ti.com>
References: <1419404619-10744-1-git-send-email-vigneshr@ti.com> <1419404619-10744-5-git-send-email-vigneshr@ti.com> <20150102170933.GB3298@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150102170933.GB3298-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap@
List-Id: linux-omap@vger.kernel.org



On Friday 02 January 2015 10:39 PM, Tony Lindgren wrote:
> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [141223 23:07]:
>> The charge delay value is by default 0x400. But it can be set to lower
>> values on some boards, as long as false pen-ups are avoided. Lowering the
>> value increases the sampling rate (though current sampling rate is
>> sufficient for TSC operation). In some boards, the value has to be
>> increased to avoid false pen-up events. Hence, charge delay has been
>> made a DT parameter.
>>
>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> 
> Assuming this binding makes sense for the input people, there should
> be no conflicts merging this patch along with the rest of the series
> via the input tree.
> 

I will post new version moving documentation to driver code and keeping
DT changes as a separate patch.

> Sounds like this value probably depends on the size of the touchscreen
> for the capacitance, so a numeric value is really needed here. 

Its not just dependent on the size of the touchscreen. It varies based
on the individual setups.

> I would personally prefer generic bindings in general, but in any case

There isn't any generic binding that corresponds to charge-delay.
Nothing as been pointed out by input maintainer either.

Regards
Vignesh

> please feel free to merge along with the other input patches:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> 
>> ---
>> v4:
>>  - Set charge delay to 0x400 as default. Most devices function normally
>>    at this value
>>
>>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 15 +++++++++++++++
>>  arch/arm/boot/dts/am335x-evm.dts                          |  1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> index 878549ba814d..6df5028a4ad3 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> @@ -28,6 +28,20 @@ Required properties:
>>  	ti,adc-channels: List of analog inputs available for ADC.
>>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>>  
>> +Optional properties:
>> +- child "tsc"
>> +	ti,charge-delay: Length of touch screen charge delay step in terms of
>> +			 ADC clock cycles. Charge delay value should be large
>> +			 in order to avoid false pen-up events. This value
>> +			 affects the overall sampling speed, hence need to be
>> +			 kept as low as possible, while avoiding false pen-up
>> +			 event. Start from a lower value, say 0x400, and
>> +			 increase value until false pen-up events are avoided.
>> +			 The pen-up detection happens immediately after the
>> +			 charge step, so this does in fact function as a
>> +			 hardware knob for adjusting the amount of "settling
>> +			 time".
>> +
>>  Example:
>>  	tscadc: tscadc@44e0d000 {
>>  		compatible = "ti,am3359-tscadc";
>> @@ -36,6 +50,7 @@ Example:
>>  			ti,x-plate-resistance = <200>;
>>  			ti,coordiante-readouts = <5>;
>>  			ti,wire-config = <0x00 0x11 0x22 0x33>;
>> +			ti,charge-delay = <0x400>;
>>  		};
>>  
>>  		adc {
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
>> index 54f118c08db8..66342515df20 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -648,6 +648,7 @@
>>  		ti,x-plate-resistance = <200>;
>>  		ti,coordinate-readouts = <5>;
>>  		ti,wire-config = <0x00 0x11 0x22 0x33>;
>> +		ti,charge-delay = <0x400>;
>>  	};
>>  
>>  	adc {
>> -- 
>> 1.9.1
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
