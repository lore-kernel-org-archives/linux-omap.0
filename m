From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 5/8] ARM: dts: Drop bogus ahclkr clocks for dra7 mcasp 3
 to 8
Date: Tue, 17 Sep 2019 10:21:25 +0300
Message-ID: <931eb0e1-8024-3003-1fb3-6f6ad8b74bf9@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-6-tony@atomide.com>
 <2c750847-700e-c835-ee53-a656b363c36c@ti.com>
 <20190724064758.GU5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724064758.GU5447@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 24/07/2019 09:47, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [190723 21:02]:
>> Hi Tony,
>>
>> On 7/23/19 6:28 AM, Tony Lindgren wrote:
>>> The ahclkr clkctrl clock bit 28 only exists for mcasp 1 and 2 on dra7.
>>> Otherwise we get the following warning on beagle-x15:
> ...
>>> @@ -2962,9 +2958,8 @@
>>>   					<SYSC_IDLE_SMART>;
>>>   			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
>>>   			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>,
>>> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>,
>>> -				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 28>;
>>> -			clock-names = "fck", "ahclkx", "ahclkr";
>>> +				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>;
>>> +			clock-names = "fck", "ahclkx";
>>
>> The equivalent change to MCASP8 is missing.
> 
> Thanks for spotting it, probably should be set up the same way as
> MCASP4 too looking at the TRM.
> 
> Tero, care to check the dra7 mcasp clocks we have defined?

Sorry, missed this earlier.

> 
> $ grep MCASP drivers/clk/ti/clk-7xx.c
>          { DRA7_IPU_MCASP1_CLKCTRL, dra7_mcasp1_bit_data, CLKF_SW_SUP, "ipu-clkctrl:0000:22" },
>          { DRA7_L4PER2_MCASP2_CLKCTRL, dra7_mcasp2_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:0154:22" },
>          { DRA7_L4PER2_MCASP3_CLKCTRL, dra7_mcasp3_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:015c:22" },
>          { DRA7_L4PER2_MCASP5_CLKCTRL, dra7_mcasp5_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:016c:22" },
>          { DRA7_L4PER2_MCASP8_CLKCTRL, dra7_mcasp8_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:0184:24" },
>          { DRA7_L4PER2_MCASP4_CLKCTRL, dra7_mcasp4_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:018c:22" },
>          { DRA7_L4PER2_MCASP6_CLKCTRL, dra7_mcasp6_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:01f8:22" },
>          { DRA7_L4PER2_MCASP7_CLKCTRL, dra7_mcasp7_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:01fc:22" },
> 
> Is bit 24 above correct for MCASP8 or should it too be 22 like
> adjacent MCASP4 in the TRM?

So yeah, mcasp8 is wrong here, should be 22 as rest of them. I did fix 
mcasp8 clocks partially when doing the conversion but missed the 
parenting here; it was completely broken before.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
