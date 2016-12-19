From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Mon, 19 Dec 2016 08:22:07 +0200
Message-ID: <88baee5e-48c3-f0d3-de5e-8e578fab0aa4@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org> <20161213013133.GR4920@atomide.com>
 <148160402543.37646.6019420188689675769@resonance>
 <4b016883-e7c9-94d8-d964-3c8dfee6ee13@ti.com>
 <20161217014626.GX5423@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161217014626.GX5423@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 17/12/16 03:46, Stephen Boyd wrote:
> On 12/13, Tero Kristo wrote:
>> On 13/12/16 06:40, Michael Turquette wrote:
>>>>> On 12/12, Michael Turquette wrote:
>>>
>>> Is the goal to describe this hardware topology in DT? Is that right
>>> thing to do? I think it's cool to have this modeled *somehow* in Linux,
>>> but I'm not sure DT is the right place to model the interconnect and
>>> every device hanging off of it.
>>>
>>> I don't want to put words in Stephen's mouth, but I think the issue over
>>> whether clockdomains are CCF clock providers or some genpd thing is
>>> probably less important to him than the fact that the DT bindings are
>>> super detailed to inner workings of the SoC.
>>
>> Ok, so your preference would be to reduce the data under DT, and the
>> ideal approach would be a single prcm node. I think we still need to
>> keep the prm / cm1 / cm2 as separate nodes, as they are pretty
>> individual from hardware point of view, provide quite different
>> features, and they reside in some cases in quite different address
>> spaces also. Anyway, here's what I gather we should probably have in
>> DT:
>>
>> - reset provider
>>   * example: resets = <&prm OMAP4_IVA2_RESET>;
>>   * only from 'prm' node
>>
>> - genpd provider (for the hwmods, clockdomains, powerdomains,
>> voltage domains)
>>   * examples: power-domains = <&cm2 OMAP4_DSS_CORE_MOD>;
>> 		power-domains = <&cm2 OMAP4_DSS_CLKDM>;
>> 		power-domains = <&prm OMAP4_DSS_PWRDM>;
>> 		power-domains = <&prm OMAP4_CORE_VOLTDM>;
>>   * from all 'prm', 'cm1' and 'cm2' nodes, though 'prm' would be the
>> only one providing _CLKDM, _PWRDM, _VOLTDM genpds.
>>
>> - clock provider (for anything that requires clocks)
>>   * example: clocks = <&cm1 OMAP4_DPLL_MPU_CK>;
>>   * from all 'prm', 'cm1' and 'cm2' nodes
>>
>> This would eventually cause an ABI breakage for the clock handles,
>> if we transfer the existing clocks to this format, and remove the
>> existing clock handles from DT. Otherwise, I think we could just
>> transition the existing hwmod data to this new format only, and add
>> the clockdomain / powerdomain / voltagedomain support a bit later.
>>
>
> This sounds about right. Is the ABI break because we get rid of
> clock nodes and just have a few big nodes?

In the above plan, the ABI breakage is because we get rid of the 
existing clock nodes and replace everything with a single (or few) clock 
provider nodes.

> I thought we had
> already broken DT ABI here but if we didn't then that isn't
> great. Perhaps to make things keep working we can detect the old
> style one node per clock design and register a bunch of providers
> individually from the single driver probe?  It would have to match
> up the registers with a clk_hw pointer somewhere, but it should
> be possible. Alternatively, we keep both designs around for some
> time and have different compatibles and different driver entry
> points.

Keeping both around for a while should be okay, the design for this 
series was done with that in mind. I didn't address the scrapping of old 
clock data yet though, but that would be a step taken in the future.

First thing to do here would be to implement the hwmod genpds, rest can 
follow later, but we need an agreement if this is the way we want to go.

-Tero
