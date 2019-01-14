From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Mon, 14 Jan 2019 10:25:49 +0200
Message-ID: <2cd42549-7209-ced7-fc95-bd837f6c0f68@ti.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info>
 <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux>
 <20181228200229.GY6707@atomide.com>
 <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com> <20181231092944.014fc1c0@aktux>
 <154655874528.15366.10423050138946294754@swboyd.mtv.corp.google.com>
 <33b3aecd-54dc-ae93-dabe-883275e1d7b0@ti.com>
 <154724694850.169631.6179537075340016611@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154724694850.169631.6179537075340016611@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On 12/01/2019 00:49, Stephen Boyd wrote:
> Quoting Tero Kristo (2019-01-03 23:28:58)
>> On 04/01/2019 01:39, Stephen Boyd wrote:
>>> Quoting Andreas Kemnade (2018-12-31 00:30:21)
>>>> On Mon, 31 Dec 2018 09:23:01 +0200
>>>> Tero Kristo <t-kristo@ti.com> wrote:
>>>>
>>>>> On 28/12/2018 22:02, Tony Lindgren wrote:
>>>>>> * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, 4 Dec 2018 08:45:57 -0800
>>>>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>>>>    
>>>>>>>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
>>>>>>>>> On Mon, 3 Dec 2018 07:39:10 -0800
>>>>>>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>>>>>>> The consumer device stays active just fine with PM runtime
>>>>>>>>>> calls. So yes, the problem is keeping a clock controller forced
>>>>>>>>>> active for the period of consumer device reset. Other than
>>>>>>>>>> that typically autoidle can be just kept enabled.
>>>>>>>>>>        
>>>>>>>>> Are we still talking about the same problem? Maybe I am losing track
>>>>>>>>> here. Just to make sure.
>>>>>>>>> The patch series was about disabling autoidle for devices which cannot
>>>>>>>>> work with it during normal operation. Not during reset or something
>>>>>>>>> like that.
>>>>>>>>> Or is the keep-clock-active-during-reset just a requirement for bigger
>>>>>>>>> restructuring ideas?
>>>>>>>>
>>>>>>>> Yeah there are two issues: The fix needed for the issue you brought up,
>>>>>>>> and also how to let a reset driver to block autoidle for reset.
>>>>>>>>    
>>>>>>> Hmm, is this set now waiting for the famous "somebody" fixing all
>>>>>>> the stuff?
>>>>>>
>>>>>> Well I think we're still waiting on Tero to comment on this.
>>>>>
>>>>> The only item requiring immediate fixing is the point Stephen made out,
>>>>> removing the usage of CLK_IS_BASIC from this patch.
>>>>>
>>>>> Afaics, the reset related concerns Tony has can be handled later.
>>>>>
>>>> hmm, and there we need Stephen's opinion about having the allow/deny
>>>> autoidle functions in the main clk_ops struct.
>>>>
>>>
>>> I have unanswered questions on the list for this thread[1].
>>
>> The reset portion we can't answer with the current knowledge I fear, we
>> need to prototype this a bit first and see which way to go.
>>
>>> I'm not sure
>>> what allow/deny autoidle functions mean to clk drivers. It looks like an
>>> OMAP specific addition to the clk_ops struct, which sounds wrong to put
>>> it plainly.
>>
>> Yeah, I don't think other SoCs implement the same functionality, at
>> least not in the same way. The autoidle bits are available in
>> omap2/omap3 only, where they control the HW autoidle functionality of
>> these clocks. If the bit is enabled, the HW can autonomously disable the
>> clock once it is not needed anymore by HW.
> 
> Some qcom chips have automatic clock gating (basically hw clk gating)
> but they don't really need to involve that with the reset asserting or
> deasserting anymore. It used to be that they had to turn off the
> automatic mode, assert the reset, deassert the reset, and then reenable
> the automatic mode. So there is some precedence for this. But again, I
> think that the reset controller and the clk controller are the same
> device in both vendor instances so in theory the driver can be one
> driver for both clk and reset and do the proper things on the backend.
> So just use reset controller framework and register that from the clk
> controller driver?
> 
>>
>>> Hopefully it can be done outside of the clk framework by
>>> having the provider driver know more things about all the frameworks
>>> it's hooking into.
>>
>> This is how it has been done so far, however Andreas wants to expand the
>> functionality a bit where it breaks... unless we can use the
>> CLK_IS_BASIC flag to detect if we accessing an OMAP specific clock or
>> not. If we are passing in a clk pointer from a consumer level API, I
>> don't know if there is any other way to go with this if we can't modify
>> the generic clk_ops struct.
>>
>> The same flag check is used across TI clock driver already btw.
>>
> 
> Sure, it's not like this is a new problem. I'd just like to see if we
> can solve it now and get rid of the CLK_IS_BASIC flag now. It would be
> great if some extra effort could be put into it vs. punting the problem
> until 2020 or something.

Ok, let me see if I can figure out something for this...

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
