From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Wed, 15 Jun 2011 14:37:03 +0530
Message-ID: <4DF87637.7020200@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>	 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>	 <1307958710.1847.56.camel@deskari>	 <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com> <1308036257.1899.8.camel@deskari> <4DF76830.8070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34002 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745Ab1FOJHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 05:07:12 -0400
In-Reply-To: <4DF76830.8070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On 6/14/2011 7:24 PM, Rajendra Nayak wrote:
> On 6/14/2011 12:54 PM, Tomi Valkeinen wrote:
>> On Tue, 2011-06-14 at 01:13 -0600, Paul Walmsley wrote:
>>> Hi Tomi
>>>
>>> On Mon, 13 Jun 2011, Tomi Valkeinen wrote:
>>>
>>>> Paul, can you take this patch and queue it for an rc?
>>>
>>> Generally I only queue regressions or fixes for major problems (crashes,
>>> corruption, etc.) for -rc series. So probably this one should go in via
>>> the normal merge window, unless it's been causing major disruptions?
>>
>> No, only disruptions for me as the DSS pm_runtime patches depend on this
>> one to function correctly. So merge window is ok, I'll handle the DSS
>> side somehow.
>
> Hi Paul/Kevin,
>
> I had a query, not directly related to this patch, but to the way
> the omap_pm_get_dev_context_loss_count() api is implemented, which
> this patch is trying to fix in some ways.
> I see that the api relies on the pwrdm level state counters, which
> in-turn seem to be getting updated only in the cpuidle/suspend path.
> How are domains like DSS which can independently transition outside
> of the cpuidle path handled?

Thinking some more on this, maybe I now understand how this worked
on OMAP3. We always had the 'autodeps' on OMAP3 which made sure no
clkdm idle's while MPU is not in standby, and hence all transitions
would always happen between the pwrdm_pre_transition() and
pwrdm_post_transition() (where the pwrdm level state counters get
cleared/updated) callbacks. So there were really no domain
transitions outside of this on OMAP3.

My questions were popping out from the work I was trying to do to
support this on OMAP4, and with no 'autodeps' on OMAP4 there will
be transitions outside of cpuidle/suspend where counters need
to be updated/cleared which at this point I have no clue how to
handle :(
I will start a separate discussion/thread on this since
this is probably not the right place to discuss on how to do
this on OMAP4.

Thanks,
Rajendra


> What I mean is, if DSS on disabling its clocks transitions to OFF
> state (it being an independent powerdomain) and tries to use this api
> to know if it lost context the next time it is re-enabling clocks and
> all this happens while there was no cpuidle being scheduled, where do
> the pwrdm level state counters get updated, which tell DSS it did lose
> context?
>
> On another note, i was wondering if it even made any sense to drivers
> like DSS, which have an independent power domain of its own on OMAP to
> try and do a restore-only-if-needed kind of an implementation.
> Would'nt it always lose context the moment it run-time idle's?
>
> regards,
> Rajendra
>
>>
>> Tomi
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

