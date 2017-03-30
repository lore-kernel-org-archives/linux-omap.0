From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 0/8] thermal: ti-soc-thermal: Migrate slope/offset data
 to device tree
Date: Thu, 30 Mar 2017 08:59:31 +0530
Message-ID: <5380b1bc-f3c6-a0ef-e458-7509d95d631e@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <64ab8413-6cf1-864f-0550-9c8db59523f7@ti.com>
 <20170323205256.GO10760@atomide.com>
 <a410d37f-92e5-39b4-ac6c-158673163cb0@ti.com>
 <20170324142610.GX10760@atomide.com>
 <20170329043753.GB1596@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170329043753.GB1596@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 29 March 2017 10:07 AM, Eduardo Valentin wrote:
> Keerthy,
> 
> On Fri, Mar 24, 2017 at 07:26:10AM -0700, Tony Lindgren wrote:
>> * Keerthy <j-keerthy@ti.com> [170323 20:29]:
>>>
>>>
>>> On Friday 24 March 2017 02:22 AM, Tony Lindgren wrote:
>>>> * Keerthy <j-keerthy@ti.com> [170321 20:45]:
>>>>>
>>>>>
>>>>> On Thursday 09 March 2017 01:35 PM, Keerthy wrote:
>>>>>> Currently the slope and offset values for calculating the
>>>>>> hot spot temperature of a particular thermal zone is part
>>>>>> of driver data. Pass them here instead and obtain the values
>>>>>> while of node parsing.
>>>>>>
>>>>>> Tested for the slope and constant values on DRA7-EVM, OMAP3-BEAGLE. 
> 
> Have you tried on boards that need negative coefficients?
> 
> https://patchwork.kernel.org/patch/9619577/

Yes. I retrieved the negative values nicely in the driver passed via
Device Tree.

> 
>>>>>
>>>>> Hi Eduardo,
>>>>>
>>>>> If the series looks okay could you please pull this?
>>>>
>>>> Also.. Are the dts changes safe for me to pick separately?
>>>
>>> Yes Tony they are safe to pulled separately.
>>
>> OK applying patches 1 - 5 of this series into omap-for-v4.12/dt-v2.
> 
> Keerthy,
> 
> The only thing I want you to confirm is if you are really getting the
> negative coefficients, because currently of-thermal reads the array
> using an OF helper that understands only unsigned. For this reason, I
> will be queueing your patches only for next merge window, not as a fix,
> not for rc's.

I am getting negative co-efficients.

> 
> 
>>
>> Thanks,
>>
>> Tony
