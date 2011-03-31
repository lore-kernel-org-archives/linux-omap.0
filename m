From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Thu, 31 Mar 2011 11:36:52 +0200
Message-ID: <4D944B34.3090002@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com> <1301489930.15095.51.camel@deskari> <4D932E62.2050903@ti.com> <4D94225C.7010000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab1CaJkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 05:40:22 -0400
In-Reply-To: <4D94225C.7010000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Archit,

On 3/31/2011 8:42 AM, Taneja, Archit wrote:
> On Wednesday 30 March 2011 06:51 PM, Cousson, Benoit wrote:
>> On 3/30/2011 2:58 PM, Valkeinen, Tomi wrote:
>>> On Wed, 2011-03-30 at 14:12 +0200, Cousson, Benoit wrote:
>>>> On 3/30/2011 1:03 PM, Valkeinen, Tomi wrote:
>>>>> On Wed, 2011-03-30 at 11:32 +0200, Cousson, Benoit wrote:
>>>>>> Hi Tomi,
>>>>>>
>>>>>> On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
>>>>>>> Hi Benoit, Paul,
>>>>>>>
>>>>>>> I've been discussing with Sumit and Archit to understand how the DSS
>>>>>>> clocks are set up on OMAP4. I think I now have some idea how things
>>>>>>> work, but I'm still at loss why things are the way they are.
>>>>>>>
>>>>>>> So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
>>>>>>> clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
>>>>>>> and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
>>>>>>> controllable, but it is affected by MODULEMODE bit.
>>>>>>>
>>>>>>> Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
>>>>>>> and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
>>>>>>> the TRM's DSS_FCLK.
>>>>>>>
>>>>>>> Was that correct?
>>>>>>
>>>>>> Yes. For the moment, but this is not the final state.
>>>>>>
>>>>>>> If so, from DSS driver's perspective, the dss_fck sounds very much like
>>>>>>> an interface clock (it's always needed when DSS is used) and dss_dss_clk
>>>>>>> sounds very much like functional clock (it's always needed, except if
>>>>>>> DSI PLL is used for DSS functional clock).
>>>>
>>>> dss_dss_fck is one of the possible functional clocks, hence the optional
>>>> attribute. You can run the DSS only for sys_clk is you want.
>>>
>>> We can? I remember this was possible on OMAP2, but I can't seem to find
>>> it on OMAP4 TRM...
>>>
>>> Ah right, you mean sys_clk goes to DSI PLL, and the output from DSI PLL
>>> can be used as functional clock?
>>
>> Yes, you're right, maybe we can still use the sys_clk directly with a
>> parallel QVGA LCD like on OMAP2:-)
>>
>>> We _always_ need DSS_FCLK to get DSS up and running, and to configure
>>> DSI PLL if we want to get the clocks from there. So it's not quite that
>>> optional. But it's true that we can turn it off later.
>
> Just wanted to clarify the issue for myself and summarise:
>
> hwmod and pm runtime ensures that the MODULEMODE bits are set, and
> technically, that should be enough for a module to get up and running.
> But because of the strange design of DSS HW, we need an additional clock
> (DSS_CLK at bootup, could be something else later on) to access DSS
> registers. So we need to enable dss_dss_fclk in our driver in the
> beginning itself to access a register, hence Sumit's patch is needed.
>
> The strange thing is that if dss_dss_fclk is
> off(OMAP4430_OPTFCLKEN_DSSCLK bit is 0) it doesn't mean that the clock
> is surely OFF. Its only OFF when the DPLL per m5x2 divider allows HW
> auto-gating of the clock.

Hehe, welcome to the PRCM world :-)

> So OPTCLKEN_DSSCLK is in a way a dummy bit which when set, ensures that
> the M5 divider doesn't auto gate. So it isn't exactly a enable/disable bit.

It is the case for most clocks in the system. You know when it is 
enabled, but it will be disabled only when the clock domain or in that 
case the parent clock will do HW auto gating.
In this case there is no intermediate gating because the DSS_CLK is the 
only user of the M5 HW divider output, so gating only the parent is enough.

> In our tree(2.6.38-rc series), HW auto gating bit was disabled for m5x2
> divider, and hence, it never mattered to us if OPTCLKEN_DSSCLK was
> enabled or disabled. We went on happily without bothering about this opt
> clock.
>
> When things got merged in mainline, the HW auto gating for m5x2 came
> into picture(HSDIVIDER_CLKOUT2_GATE_CTRL in CM_DIV_M5_DPLL_PER), and
> then suddenly dss_dss_fclk became super crucial, and a register access
> depended on it. This was the main reason of the confusion I guess.

That make sense now, in theory, all these HS divider should be autogated 
by default, it was not the case previously because we were still in a 
non-PM optimize mode. That's why you have to control the clock at your 
level to ensure that the HW will not gate the parent clock.

Benoit
