From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
Date: Wed, 14 Aug 2013 09:41:42 -0500
Message-ID: <520B9726.4030505@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
 <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com>
 <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
 <520B8D01.1040205@ti.com> <520B8EA5.5090400@ti.com>
 <20130814141319.GF13141@e106331-lin.cambridge.arm.com>
 <520B9236.2090205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520B9236.2090205@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Tero Kristo <t-kristo@ti.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/14/2013 09:20 AM, Rajendra Nayak wrote:
> On Wednesday 14 August 2013 07:43 PM, Mark Rutland wrote:
>> On Wed, Aug 14, 2013 at 03:05:25PM +0100, Rajendra Nayak wrote:
>>> On Wednesday 14 August 2013 07:28 PM, Nishanth Menon wrote:
>>>> On 08/14/2013 08:49 AM, Mark Rutland wrote:
>>>>> [Adding Mike Turquette and dt maintainers]
>>>>>
>>>>> On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
>>>>>> On 08/14/2013 08:20 AM, Rajendra Nayak wrote:
>>>>>>> On Wednesday 14 August 2013 06:18 PM, Nishanth Menon wrote:
>>>>>>>> Hi Rajendra,
>>>>>>>>
>>>>>>>> On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>>>>>>>> [..]
>>>>>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>>>> index 12fa589..e5c804b 100644
>>>>>>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>>>> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>>>>>>>>>           return ret;
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
>>>>>>>>> +                                      struct device_node *np,
>>>>>>>>> +                                      int *opt_clks_cnt)
>>>>>>>>> +{
>>>>>>>>> +       int i, clks_cnt;
>>>>>>>>> +       const char *clk_name;
>>>>>>>>> +       const char **opt_clk_names;
>>>>>>>>> +
>>>>>>>>> +       clks_cnt = of_property_count_strings(np, "clock-names");
>>>>>>>>> +       if (!clks_cnt)
>>>>>>>>> +               return NULL;
>>>>>>>>> +
>>>>>>>>> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
>>>>>>>>> +       if (!opt_clk_names)
>>>>>>>>> +               return NULL;
>>>>>>>>> +
>>>>>>>>> +       for (i = 0; i < clks_cnt; i++) {
>>>>>>>>> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
>>>>>>>>> +               if (!strcmp(clk_name, "fck"))
>>>>>>>>
>>>>>>>> Could we instead parse for names that are "optional,role_name" instead
>>>>>>>> of assuming anything other than fck is optional clocks?
>>>>>>>
>>>>>>> you mean look for anything with optional,*? because the role names would change.
>>>>>>>
>>>>>>
>>>>>> yes. the idea being, we now have a meaning to the clock name - there are
>>>>>> two types of clocks here.. functional and optional, we *might* have
>>>>>> facility to add interface clock(we dont know interface clock handling
>>>>>> yet, but something in the future).. we might increase the support for
>>>>>> number of functional clocks.. it might help to keep the format such that
>>>>>> it is a "bit extendable".
>>>>>
>>>>> I completely disagree. The only things that should appear in clock-names
>>>>> are the names of the clock inputs that appear in the manual for the
>>>>> device. The driver should know which ones are optional, as that's a
>>>>> fixed property of the IP and the way the driver uses it.
>>>>>
>>>>> You should not be embedding additional semantics in name properties.
>>>>
>>>> we use an level of abstraction called omap_device and hwmod to allow devices to use a generic pm_runtime. drivers for specific blocks dont normally need to know about the clocks to deal with. This allows maximum reuse consider concept is generic enough.
>>>
>>> They do know about the optional clocks though and request and release them when needed. The need for hwmod to know about optional clocks
>>> (and enable all) arises from the fact that some of these devices need *some* optional clocks for a successful reset.
>>> And given hmwod has no knowledge about which optional ones (if at all) will be needed, it goes ahead and enables all before doing a reset.
>>> This is something done only at init time and *not* something thats done every time the device is enabled by the driver using pm_runtime.
>>
>> To clarify:
>>
>> I was initially confused as to the purpose of the code. I'm not against
>> a one-off clock initialisation to put everything into a sane state. If
>> we can't trust the bootloaders, that seems like a necessary evil. I'll
>> leave Mike to comment on whether and how that should be done.
>>
>> I do not think we should be embedding clock semantics in clock-names.
>> That's not the way the property is intended to be used, it breaks
>> uniformity, and it's an abuse of the system that may come back to bite
>> us later.
> 
> Mark, that makes sense.
> 
> Nishanth, thinking some more of this, the 'optional,role-name' also won't work
> for the simple reason that drivers who do clk_get(node, 'role-name') would
> then simply fail.
> 
> So I guess we need to figure out a better way to handle this.

you are right :( we do have types of clock inputs to a device and
therein lies our problem :(


-- 
Regards,
Nishanth Menon
