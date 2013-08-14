From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
Date: Wed, 14 Aug 2013 19:35:25 +0530
Message-ID: <520B8EA5.5090400@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com> <1374560679-14666-3-git-send-email-rnayak@ti.com> <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com> <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com> <20130814134904.GC13141@e106331-lin.cambridge.arm.com> <520B8D01.1040205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab3HNOGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 10:06:07 -0400
In-Reply-To: <520B8D01.1040205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, pawel.moll@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, grant.likely@linaro.org, tomasz.figa@gmail.com, rob.herring@calxeda.com, galak@codeaurora.org, mturquette@linaro.org

On Wednesday 14 August 2013 07:28 PM, Nishanth Menon wrote:
> On 08/14/2013 08:49 AM, Mark Rutland wrote:
>> [Adding Mike Turquette and dt maintainers]
>>
>> On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
>>> On 08/14/2013 08:20 AM, Rajendra Nayak wrote:
>>>> On Wednesday 14 August 2013 06:18 PM, Nishanth Menon wrote:
>>>>> Hi Rajendra,
>>>>>
>>>>> On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>>>>> [..]
>>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>> index 12fa589..e5c804b 100644
>>>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>>>>>>           return ret;
>>>>>>    }
>>>>>>
>>>>>> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
>>>>>> +                                      struct device_node *np,
>>>>>> +                                      int *opt_clks_cnt)
>>>>>> +{
>>>>>> +       int i, clks_cnt;
>>>>>> +       const char *clk_name;
>>>>>> +       const char **opt_clk_names;
>>>>>> +
>>>>>> +       clks_cnt = of_property_count_strings(np, "clock-names");
>>>>>> +       if (!clks_cnt)
>>>>>> +               return NULL;
>>>>>> +
>>>>>> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
>>>>>> +       if (!opt_clk_names)
>>>>>> +               return NULL;
>>>>>> +
>>>>>> +       for (i = 0; i < clks_cnt; i++) {
>>>>>> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
>>>>>> +               if (!strcmp(clk_name, "fck"))
>>>>>
>>>>> Could we instead parse for names that are "optional,role_name" instead
>>>>> of assuming anything other than fck is optional clocks?
>>>>
>>>> you mean look for anything with optional,*? because the role names would change.
>>>>
>>>
>>> yes. the idea being, we now have a meaning to the clock name - there are
>>> two types of clocks here.. functional and optional, we *might* have
>>> facility to add interface clock(we dont know interface clock handling
>>> yet, but something in the future).. we might increase the support for
>>> number of functional clocks.. it might help to keep the format such that
>>> it is a "bit extendable".
>>
>> I completely disagree. The only things that should appear in clock-names
>> are the names of the clock inputs that appear in the manual for the
>> device. The driver should know which ones are optional, as that's a
>> fixed property of the IP and the way the driver uses it.
>>
>> You should not be embedding additional semantics in name properties.
> 
> we use an level of abstraction called omap_device and hwmod to allow devices to use a generic pm_runtime. drivers for specific blocks dont normally need to know about the clocks to deal with. This allows maximum reuse consider concept is generic enough.

They do know about the optional clocks though and request and release them when needed. The need for hwmod to know about optional clocks
(and enable all) arises from the fact that some of these devices need *some* optional clocks for a successful reset.
And given hmwod has no knowledge about which optional ones (if at all) will be needed, it goes ahead and enables all before doing a reset.
This is something done only at init time and *not* something thats done every time the device is enabled by the driver using pm_runtime.

> 
> The traditional way of dealing with this has been to encode the *names* *inside* hwmod!!! which is obviously the wrong way to deal with with clock nodes in dts.
> 
> This series moves away from that approach - which is good. Now, the question is:
> 
> clocks-names = "....."  is not sufficient to indicate a list of clocks of different functions
> 
> 3 types of clocks may exist for OMAP h/w blocks:
> a) functional clock (1 usually, but we are starting to see multiple fclks). this drives the actual functionality
> b) optional clocks - additional clocks such as debounce clock etc. - there can be n such clocks
> c) interface clocks - this drives the register interface on the bus.  - there can be n such clocks and additional headaches for interface - currently embedded inside hwmod.
> 
> you could do:
> A) embedd in the sematics of the name
> clock-names="fck", "optional,role1",  "optional,role2";
> clocks= <&clk_a>, <&clk_x>, <&clk_y>;
> OR:
> B) embedd in the property name
> optional-clock-names="optional,role1",  "optional,role2";
> optional-clocks=<&clk_x>, <&clk_y>;
> functional-clock-names="fck";
> functional-clocks=<&clk_a>;
> 
> are you suggesting (b) here?
> 

