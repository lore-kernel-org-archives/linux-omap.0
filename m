From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/8] ARM: dts: am33xx: Add external clock provider
Date: Tue, 9 Sep 2014 10:57:51 +0300
Message-ID: <540EB2FF.7000105@ti.com>
References: <cover.1408397864.git.jsarha@ti.com> <9d4974b949b9b3bc1b08d73b1ec2d9cdd7a8e5da.1408397864.git.jsarha@ti.com> <20140908233037.GT3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140908233037.GT3238-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/09/2014 02:30 AM, Tony Lindgren wrote:
> * Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [140818 14:49]:
>> Add external clock provider for am33xx devices.
>
> Please send all the .dts and defconfig changes separately
> so I can pick them up and we don't get pointless merge
> conflicts.

Moreover, this patch is obsolete now, given I have posted this:

http://www.spinics.net/lists/arm-kernel/msg355992.html

There will be v2 of my patch coming in though this week, but the 
functionality will be the same.

-Tero

>
> Regards,
>
> TOny
>
>> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 3a0a161..d2cc397 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -92,6 +92,16 @@
>>   		pinctrl-single,function-mask = <0x7f>;
>>   	};
>>
>> +	ext_clocks {
>> +		compatible = "ti,external-clocks";
>> +
>> +		ext_clocks: clocks {
>> +		};
>> +
>> +		ext_clockdomains: clockdomains {
>> +		};
>> +	};
>> +
>>   	/*
>>   	 * XXX: Use a flat representation of the AM33XX interconnect.
>>   	 * The real AM33XX interconnect network is quite complex. Since
>> --
>> 1.7.9.5
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
