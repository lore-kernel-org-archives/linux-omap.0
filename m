From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Fri, 11 Nov 2016 11:47:19 +0530
Message-ID: <e83fb53b-94ab-4273-a7d0-410013bc0dc4@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
 <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
 <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
 <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
 <b7232421-10f7-2bac-0ad8-847804126bf2@ti.com>
 <30CF3CC1-A4F1-4C31-B51F-A1AB1D352AF5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <30CF3CC1-A4F1-4C31-B51F-A1AB1D352AF5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "N, Mugunthan V" <mugunthanvnm-l0cyMroinI0@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Friday 11 November 2016 09:00 AM, John Syne wrote:
> 
>> On Nov 9, 2016, at 9:07 PM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>>
>> Hi,
>>
>> On Thursday 10 November 2016 05:23 AM, John Syne wrote:
>>> OK, then back to my original question. Given that these DT properties are supported in the driver
>>>
>>
>> Below properties are supported by only by ti_am3335x_adc driver and not
>> ti_am335x_tsc driver. As author of this patch pointed out in another
>> reply, there is no need to change step-opendelay for tsc. AFAIK, I don't
>> see a use case where these values needs to be tweaked for tsc channels,
>> therefore it does not make sense to be DT properties.
> Yeah, the confusion was mine because the author of this patch series was proposing to hard code these settings while DT properties already existed in the ti_am335x_adc driver. I use the ADC for sensor measurement and do not use the touchscreen features. I already pointed out where these DT parameters should be added by referencing how this was done in one of the BBB DT overlay files [1]. I am just proposing the same is done as a default in the AM33xx.dtsi and AM4372.dtsi files. Here is what I was proposing. 

> Granted, the adc-channels should be restricted to the subset of channels not used by tsc, but you get the idea.

There are 4 wire, 5 wire and 8 wire touchscreens. Therefore there is no
way to know in advance, how many channels are available for adc. IMO,
this is not a SoC specific configuration but board dependent. Hence, all
channel related configurations need to be in board specific dts files
and not in top level dtsi files.

> 
> tscadc: tscadc@44e0d000 {
> 			compatible = "ti,am3359-tscadc";
> 			reg = <0x44e0d000 0x1000>;
> 			interrupt-parent = <&intc>;
> 			interrupts = <16>;
> 			ti,hwmods = "adc_tsc";
> 			status = "disabled";
> 			dmas = <&edma 53 0>, <&edma 57 0>;
> 			dma-names = "fifo0", "fifo1”;
> 
> 			tsc {
> 				compatible = "ti,am3359-tsc";
> 			};
> 			am335x_adc: adc {
> 				#io-channel-cells = <1>;
> 				ti,adc-channels = <0 1 2 3 4 5 6>;
> 				ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
> 				ti,chan-step-opendelay = <0x98 0x98 0x98 0x98 0x98 0x98 0x98>;
> 				ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
> 				compatible = "ti,am3359-adc";
> 			};
> };
> 
> [1]https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-ADC-00A0.dts
> 

-- 
Regards
Vignesh
