From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Thu, 31 Mar 2011 12:12:36 +0530
Message-ID: <4D94225C.7010000@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com> <1301489930.15095.51.camel@deskari> <4D932E62.2050903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39166 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab1CaGi2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 02:38:28 -0400
In-Reply-To: <4D932E62.2050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wednesday 30 March 2011 06:51 PM, Cousson, Benoit wrote:
> On 3/30/2011 2:58 PM, Valkeinen, Tomi wrote:
>> On Wed, 2011-03-30 at 14:12 +0200, Cousson, Benoit wrote:
>>> On 3/30/2011 1:03 PM, Valkeinen, Tomi wrote:
>>>> On Wed, 2011-03-30 at 11:32 +0200, Cousson, Benoit wrote:
>>>>> Hi Tomi,
>>>>>
>>>>> On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
>>>>>> Hi Benoit, Paul,
>>>>>>
>>>>>> I've been discussing with Sumit and Archit to understand how the DSS
>>>>>> clocks are set up on OMAP4. I think I now have some idea how things
>>>>>> work, but I'm still at loss why things are the way they are.
>>>>>>
>>>>>> So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
>>>>>> clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
>>>>>> and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
>>>>>> controllable, but it is affected by MODULEMODE bit.
>>>>>>
>>>>>> Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
>>>>>> and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
>>>>>> the TRM's DSS_FCLK.
>>>>>>
>>>>>> Was that correct?
>>>>>
>>>>> Yes. For the moment, but this is not the final state.
>>>>>
>>>>>> If so, from DSS driver's perspective, the dss_fck sounds very much like
>>>>>> an interface clock (it's always needed when DSS is used) and dss_dss_clk
>>>>>> sounds very much like functional clock (it's always needed, except if
>>>>>> DSI PLL is used for DSS functional clock).
>>>
>>> dss_dss_fck is one of the possible functional clocks, hence the optional
>>> attribute. You can run the DSS only for sys_clk is you want.
>>
>> We can? I remember this was possible on OMAP2, but I can't seem to find
>> it on OMAP4 TRM...
>>
>> Ah right, you mean sys_clk goes to DSI PLL, and the output from DSI PLL
>> can be used as functional clock?
>
> Yes, you're right, maybe we can still use the sys_clk directly with a
> parallel QVGA LCD like on OMAP2:-)
>
>> We _always_ need DSS_FCLK to get DSS up and running, and to configure
>> DSI PLL if we want to get the clocks from there. So it's not quite that
>> optional. But it's true that we can turn it off later.

Just wanted to clarify the issue for myself and summarise:

hwmod and pm runtime ensures that the MODULEMODE bits are set, and 
technically, that should be enough for a module to get up and running. 
But because of the strange design of DSS HW, we need an additional clock 
(DSS_CLK at bootup, could be something else later on) to access DSS 
registers. So we need to enable dss_dss_fclk in our driver in the 
beginning itself to access a register, hence Sumit's patch is needed.

The strange thing is that if dss_dss_fclk is 
off(OMAP4430_OPTFCLKEN_DSSCLK bit is 0) it doesn't mean that the clock 
is surely OFF. Its only OFF when the DPLL per m5x2 divider allows HW 
auto-gating of the clock.

So OPTCLKEN_DSSCLK is in a way a dummy bit which when set, ensures that 
the M5 divider doesn't auto gate. So it isn't exactly a enable/disable bit.

In our tree(2.6.38-rc series), HW auto gating bit was disabled for m5x2 
divider, and hence, it never mattered to us if OPTCLKEN_DSSCLK was 
enabled or disabled. We went on happily without bothering about this opt 
clock.

When things got merged in mainline, the HW auto gating for m5x2 came 
into picture(HSDIVIDER_CLKOUT2_GATE_CTRL in CM_DIV_M5_DPLL_PER), and 
then suddenly dss_dss_fclk became super crucial, and a register access 
depended on it. This was the main reason of the confusion I guess.

Archit

>
> Yes, that was confirmed by HW folks, as soon as you have one functional
> clock active, you can disable the other one.
>
>>> That's why the hwmod fmwk cannot choose for you which one you will need
>>> depending of your panel. It is up to the driver to select the correct one.
>>
>> But isn't that DSS internal thing? (I'm looking again at the DSS clock
>> tree figure). DSS_FCLK from the PRCM should always be the same from
>> DSS's point of view, it doesn't change. If we use the clock from DSI
>> PLL, we'll get clock for LCD2_CLK, LCD1_CLK and DISPC_FCLK. But
>> DSS_FCLK/DSS_CLK is always the same.
>
> Yes, but there is no other need for the DSS_CLK beside these internal
> nodes and the DSI engines. So you can shut it down as soon as an
> alternate clock is available (PLL1_CLK1 or PLL2_CLK1 in your case).
>
>>>>>> If "dss_fck" would control DSS_FCLK and "dss_ick" would control
>>>>>> MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
>>>>>> and we wouldn't need any omap4 spesific trickery in the DSS driver.
>>>>>> ("dss_dss_clk" wouldn't be needed).
>>>>>
>>>>> You cannot play with iclk, because this clock is supposed to be handled
>>>>> automatically by the HW. This was the case on OMAP2&    3 as well BTW.
>>>>
>>>> Right.
>>>>
>>>> But now we have 1) dss_fck, which isn't the DSS_FCLK in TRM, and in fact
>>>> not fck at all, or even clock at all 2) dss_dss_clk, a new clock whose
>>>> name doesn't match to anything in TRM, and is in fact the DSS_FCLK.
>>>>
>>>> So they both sound like they are confusingly named.
>>>
>>> The naming convention is simple: opt clock are using the module name +
>>> the original clock name: "dss_XXX", whereas the modulemode is using the
>>> module name + fck, because it is for the moment similar to the fclk we
>>> have on simpler module. iclk_en is not exposed at all on OMAP4.
>>>
>>> optional clocks:
>>>
>>> static struct clk dss_sys_clk = {
>>> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
>>> 	.enable_bit	= OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
>>>
>>> static struct clk dss_tv_clk = {
>>> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
>>> 	.enable_bit	= OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
>>>
>>> static struct clk dss_dss_clk = {
>>> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
>>> 	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
>>>
>>> static struct clk dss_48mhz_clk = {
>>> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
>>> 	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
>>>
>>>
>>> MODULEMODE:
>>>
>>> static struct clk dss_fck = {
>>> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
>>> 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
>>
>> Okay, the naming makes sense now that you explained the convention.
>>
>> I think I'm finally starting to get this =).
>>
>>>> If we had dss_fck matching to DSS_FCLK and dss_ick for MODULEMODE, they
>>>> would, in my opinion, be much more understandable and in many ways
>>>> relate to the way things are in the HW. Additionally this would match
>>>> the way clocks are on OMAP2/3 and things would just work.
>>>
>>> No, because you should not have to play with iclk at all.
>>> BTW, for my point of view you have such issue because your are still not
>>> using the pm_runtime API.
>>> As soon as you will switch to pm_runtime, iclk_en and fclk_en (OMAP2&3
>>> name) or MODULEMODE will be handle by the fmwk. The driver will just
>>> have to handle the optional clock.
>>>
>>>> So while I understand that neither the current way and my suggestion
>>>> exactly match the HW, and also that things are not ready yet and the
>>>> clocks will change, I don't understand why such a strange method to name
>>>> the clocks was used, when there's a simpler and backward compatible way.
>>>
>>> The point is that this automated method works for every IPs in the OMAP
>>> except the DSS that is not managing its clocks like other modules.
>>
>> With this do you mean that the SW does not manage clocks like other
>> modules (should use pm_runtime?), or the HW is somehow different?
>>
>>> Moreover, since the clock fmwk is creating aliases for these clock
>>> nodes, you should never see at all that dss_dss_clk node that seems to
>>> bother you.
>>
>> Oh, that doesn't bother me =). What bothers me is that DSS did not
>> suddenly work because the clocks were set up in this manner.
>>
>> Perhaps the aliases should have been setup differently, at least
>> temporarily, to get things working more easily.
>>
>> Currently we have these aliases for OMAP4:
>>
>> "dss_clk" ->   dss_dss_clk
>> "fck" ->   dss_fck
>> "ick" ->   dummy_ck
>>
>> If that would be changed to:
>>
>> "fck" ->   dss_dss_clk
>> "ick ->   dss_fck
>>
>> The driver would work the same way for all OMAPs.
>>
>>>> And if this current way to handle OMAP4 DSS clocks is for some reason
>>>> better and can't be changed, could the OMAP2/3 clocks also be changed to
>>>> keep things consistent between OMAPs? Because the inconsistency between
>>>> platforms is the biggest problem for me.
>>>
>>> As I said previsously, pm_runtime should fix these issues.
>>
>> Ok. I really need to find time to look at that. Sumit has been working
>> on it, I hope it'll be ready soon =).
>>
>> Anyway. To get things working for rc2 (DSS currently crashes due to not
>> enabling dss_clk) we need to either:
>> 1) Change the clock aliases as above
>
> Changing the clock alias for my point of view is like hacking the HW
> definition to fit your need. Even if this is temporary, I do not like
> that approach.
>
>> 2) Add something like Sumit's patch (attached) to handle dss_clk. While
>> the patch is not that complex, it feels rather hacky.
>
> Yes, I'd rather hack that issue internally, because this is something
> you should fix as soon as you switch to PM runtime.
>
>> What's your opinion?
>
> Definitively #2.
>
> Benoit
>
>

