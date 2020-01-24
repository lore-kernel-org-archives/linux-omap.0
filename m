From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [Patch v4 00/10] ARM: dts: dra7: add cal nodes
Date: Fri, 24 Jan 2020 09:25:22 +0200
Message-ID: <fde9ef6c-e214-7436-10c5-7996f19b5cfe@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com>
 <20200123171737.GB5885@atomide.com> <20200123172624.GE5885@atomide.com>
 <668be3a7-d9be-6a2e-71ba-5631bf99dfae@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <668be3a7-d9be-6a2e-71ba-5631bf99dfae@ti.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Parrot <bparrot@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 24/01/2020 09:21, Tero Kristo wrote:
> On 23/01/2020 19:26, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [200123 17:18]:
>>> * Benoit Parrot <bparrot@ti.com> [191211 06:03]:
>>>> This patch series adds the needed clkctrl and ty-sysc nodes for CAL 
>>>> module.
>>>> It also adds support for the module in related dtsi and dts for DRA72,
>>>> DRA76 and AM654 SoC.
>>>
>>> Applying these into omap-for-v5.6/ti-sysc-dt-cam on top of Tero's
>>> for-5.6-ti-clk branch. It might be too later for v5.6, but we'll
>>> see.
>>
>> Actually I'll leave out the k3-am65 dts changes as I don't see
>> acks for those. Tero can pick up those later.
>>
>> Regards,
>>
>> Tony
>>
> 
> Right, I think I also missed the cal clkctrl patch in this series. This 
> series is imho applying against too many different trees (three if I am 
> not mistaken) and should be split up to avoid confusion / not to get 
> lost in mailboxes.

Not cal clkctrl but the cal k3 patches. I just assumed all dts patches 
in this series were against omaps.

Anyways, I am planning to send k3 dts pull v2 today due to dma patches 
from Peter, so I think I can sneak these also in with that...

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
