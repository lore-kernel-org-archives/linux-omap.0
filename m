From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [Patch 1/3] ARM: dts: am43xx: add support for clkout1 clock
Date: Tue, 22 Oct 2019 19:47:39 +0300
Message-ID: <586dcabb-0400-50d6-5488-16bddc059286@ti.com>
References: <20191016184954.14048-1-bparrot@ti.com>
 <20191016184954.14048-2-bparrot@ti.com> <20191022154816.GO5610@atomide.com>
 <20191022162134.fpawonjdjvd5kxza@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022162134.fpawonjdjvd5kxza@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 22/10/2019 19:21, Benoit Parrot wrote:
> Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 08:48:16 -0700]:
>> * Benoit Parrot <bparrot@ti.com> [191016 18:47]:
>>> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
>>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>>> @@ -704,6 +704,60 @@
>>>   		ti,bit-shift = <8>;
>>>   		reg = <0x2a48>;
>>>   	};
>>> +
>>> +	clkout1_osc_div_ck: clkout1_osc_div_ck {
>>> +		#clock-cells = <0>;
>>> +		compatible = "ti,divider-clock";
>>> +		clocks = <&sys_clkin_ck>;
>>> +		ti,bit-shift = <20>;
>>> +		ti,max-div = <4>;
>>> +		reg = <0x4100>;
>>> +	};
>>
>> Here too please describe why the clock names are not generic.
> 
> Tero originally had this patch in the kernel so this is somewhat of a
> revert. Since these "clock" were removed. If the name syntax is no longer
> valid for some reason, then I will need a little more informations to
> proceed.
> 
> Tero, can you assist here?

This one is just following the naming convention of the rest of the 
clocks atm.

If we need to fix all the underscore name clocks, that requires pretty 
much complete revamp of both the dts data + clock data under the clock 
driver, and it is not backwards compatible either. How should we tackle 
that one?

We could maybe add support code in kernel to do s/-/_/g for the "new" 
clocks so that their parent-child relationships would be retained, and 
then convert the clocks in phases.

-Tero

> 
> Benoit
> 
>>
>> Regards,
>>
>> Tony

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
