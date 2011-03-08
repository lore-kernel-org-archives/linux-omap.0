From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Problem with DSS clocks & accessing registers
Date: Tue, 8 Mar 2011 11:22:42 +0100
Message-ID: <4D760372.3020005@ti.com>
References: <1299486149.2281.77.camel@deskari>  <4D74E2D5.2000705@ti.com> <1299510200.2281.199.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1CHKWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 05:22:46 -0500
In-Reply-To: <1299510200.2281.199.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>

On 3/7/2011 4:03 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-03-07 at 07:51 -0600, Cousson, Benoit wrote:
>> + Rajendra
>>
>> Hi Tomi,
>>
>> On 3/7/2011 9:22 AM, Valkeinen, Tomi wrote:
>>> Hi Kevin, Paul,
>>>
>>> We currently have a small problem with OMAP4 DSS. When we enable the DSS
>>> clocks, it seems that the DSS registers are not always accessible right
>>> after the clock enable.
>>
>> What clocks are you talking about? As you know, the DSS has a bunch of
>> functional clocks available depending of the use case.
>
> In this case the clocks for DISPC, iclk and fclk. On OMAP4 fclk is
> DSS_FCLK and iclk is not used, I believe. The problem is probably also
> in all the other DSS modules.
>
>>> I understood that on OMAP4 the clock framework doesn't guarantee that
>>> the registers are accessible after enabling clocks, and pm_runtime will
>>> handle this. Is this correct?
>>
>> The point is that there is no status at clock level but only one status
>> at module level. That's why this check does not have anything to do at
>> clock level.
>> So hwmod with handle that status (OMAP4430_CM_DSS_DSS_CLKCTRL) during
>> the hwmod_enable that is indirectly called by pm_runtime, through
>> omap_device API.
>
> Ah. Ok. How does CM_DSS_DSS_CLKCTRL show that the DSS module is ready?
> IDLEST is 0?

Yep, or 2 if only the interface clock is idle and a separate functional 
clock is running, which is the case of the DSS. You can check the 
function used in hwmod: omap4_cm_wait_module_ready in cminst44xx.c.

- 0x0 func: Module is fully functional, including OCP
- 0x2 idle: Module is in Idle mode (only OCP part). It is functional if 
using separate functional clock

>>> I have made a small hack fix for this. I added udelay(10) in the DSS
>>> code which enables the clocks and this seem to remove the problem. The
>>> delay is only called when DSS thinks the clocks have been off, so in
>>> practice the delay shouldn't be visible. Is this fix acceptable for now,
>>> until we get pm_runtime support to DSS?
>>
>> Cannot you use omap_device for the moment? Relying on a udelay is not a
>> very safe method, even temporally.
>
> Yes, udelay is not very good option even as a hack, except if we can
> wait some amount of time which we know will always be enough. Can we?

You should really avoid that, because we really don't have any good way 
to get a good number.

> I have to say I'm not very familiar with omap_device, as I haven't been
> really working with them (nor hwmods). Sumit or Archit can perhaps fill
> in, but my understanding is that work on that area is going on, but it's
> not ready yet. So I'm looking for some temporary quick solution for this
> so that DSS driver doesn't randomly crash on OMAP4.

Adding the check in the clock framework for DSS clock nodes only might 
be the cleanest way to do that right now.

You can map clock nodes to clkops_omap2_dflt_wait clkops instead of the 
clkops_omap2_dflt currently used. But then you will have to add the 
support for OMAP4, since for the moment the function seems to work only 
for OMAP2 & 3 (omap2_clk_dflt_find_idlest).

It is a little bit more complex than the current WA but should not be 
that hard either to do.
This is a much cleaner WA before having the full hwmod support for the 
DSS for my point of view.

Paul,
Any thoughts?

Regards,
Benoit
