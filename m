From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [Patch v3 0/3] ARM: dts: am43x-vpfe/ov2659.patch
Date: Fri, 13 Dec 2019 09:42:32 +0200
Message-ID: <c4ae58dc-3c81-f493-a665-6926baa0f04c@ti.com>
References: <20191211140720.10539-1-bparrot@ti.com>
 <20191212174123.GF35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212174123.GF35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Parrot <bparrot@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/12/2019 19:41, Tony Lindgren wrote:
> * Benoit Parrot <bparrot@ti.com> [191211 06:04]:
>> This patch series adds the missing camera endpoint (ov2659) as well as
>> the required source clocks nodes for the sensor.
>>
>> On the am437x-sk-evm the camera sensor is sourced from clkout1 but that
>> clock nodes/tree was removed as it was unsed at the time, we are
>> re-adding the needed clock nodes here.
> 
> Tero, it seems I can already pick this series?

I believe it is ready if you approve the clkout1 clock patch.

> Or ou want to queue the changes to am43xx-clocks.dtsi along with all
> your other clock patches?

Well, I have actually never queued any omap2+ dts patches myself, and I 
don't think there would be too many of those coming for next merge either.

-Tero

> 
> Regards,
> 
> Tony
> 
>   
>> Changes since v2:
>> - Fixed/added Tony's ack
>>
>> Changes since v1:
>> - Fix clock name to make it generic
>> - Add non-standard clock node naming to commit message as per Tony's
>>    comment
>> - Rename all clock nodes to use '-' instead of '_'
>>
>> Benoit Parrot (2):
>>    ARM: dts: am437x-sk-evm: Add VPFE and OV2659 entries
>>    ARM: dts: am43x-epos-evm: Add VPFE and OV2659 entries
>>
>> Tero Kristo (1):
>>    ARM: dts: am43xx: add support for clkout1 clock
>>
>>   arch/arm/boot/dts/am437x-sk-evm.dts  | 27 +++++++++++++-
>>   arch/arm/boot/dts/am43x-epos-evm.dts | 23 +++++++++++-
>>   arch/arm/boot/dts/am43xx-clocks.dtsi | 54 ++++++++++++++++++++++++++++
>>   3 files changed, 102 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.17.1
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
