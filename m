From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Tue, 14 Jun 2011 19:24:56 +0530
Message-ID: <4DF76830.8070108@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>	 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>	 <1307958710.1847.56.camel@deskari>	 <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com> <1308036257.1899.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53138 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751569Ab1FNNzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 09:55:05 -0400
In-Reply-To: <1308036257.1899.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On 6/14/2011 12:54 PM, Tomi Valkeinen wrote:
> On Tue, 2011-06-14 at 01:13 -0600, Paul Walmsley wrote:
>> Hi Tomi
>>
>> On Mon, 13 Jun 2011, Tomi Valkeinen wrote:
>>
>>> Paul, can you take this patch and queue it for an rc?
>>
>> Generally I only queue regressions or fixes for major problems (crashes,
>> corruption, etc.) for -rc series.  So probably this one should go in via
>> the normal merge window, unless it's been causing major disruptions?
>
> No, only disruptions for me as the DSS pm_runtime patches depend on this
> one to function correctly. So merge window is ok, I'll handle the DSS
> side somehow.

Hi Paul/Kevin,

I had a query, not directly related to this patch, but to the way
the omap_pm_get_dev_context_loss_count() api is implemented, which
this patch is trying to fix in some ways.
I see that the api relies on the pwrdm level state counters, which
in-turn seem to be getting updated only in the cpuidle/suspend path.
How are domains like DSS which can independently transition outside
of the cpuidle path handled?
What I mean is, if DSS on disabling its clocks transitions to OFF
state (it being an independent powerdomain) and tries to use this api
to know if it lost context the next time it is re-enabling clocks and
all this happens while there was no cpuidle being scheduled, where do
the pwrdm level state counters get updated, which tell DSS it did lose
context?

On another note, i was wondering if it even made any sense to drivers
like DSS, which have an independent power domain of its own on OMAP to 
try and do a restore-only-if-needed kind of an implementation.
Would'nt it always lose context the moment it run-time idle's?

regards,
Rajendra

>
>   Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

