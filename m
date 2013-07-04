From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 14/22] arm/am33xx: add TSC/ADC mfd device support
Date: Thu, 04 Jul 2013 15:51:54 +0200
Message-ID: <51D57DFA.9060809@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-15-git-send-email-bigeasy@linutronix.de> <51D57D4F.30905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51D57D4F.30905-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 07/04/2013 03:49 PM, Sekhar Nori wrote:
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 1460d9b..4ad7797 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -404,6 +404,24 @@
>>  			ti,hwmods = "wkup_m3";
>>  		};
>>  
>> +		tscadc: tscadc@44e0d000 {
>> +			compatible = "ti,am3359-tscadc";
>> +			reg = <0x44e0d000 0x1000>;
>> +			interrupt-parent = <&intc>;
> 
> interrupt-parent can be dropped since it will be inherited from parent.

That is true. I prepare a patch for that after the merge window.

> 
> Thanks,
> Sekhar

Sebastian
