From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping
 from cpuidle
Date: Thu, 26 Jul 2012 17:13:51 +0530
Message-ID: <50112D77.2040302@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>	<1342764284-8143-3-git-send-email-rnayak@ti.com>	<CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>	<5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban> <87obn3798o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53678 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418Ab2GZLoA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 07:44:00 -0400
Received: by ggnk3 with SMTP id k3so1723152ggn.38
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 04:43:59 -0700 (PDT)
In-Reply-To: <87obn3798o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: t-kristo@ti.com, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com

On Thursday 26 July 2012 04:13 AM, Kevin Hilman wrote:
> Tero Kristo<t-kristo@ti.com>  writes:
>
>> >  On Fri, 2012-07-20 at 13:38 +0530, Rajendra Nayak wrote:
>>> >>  On Friday 20 July 2012 12:55 PM, Shilimkar, Santosh wrote:
>>>> >>  >  On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak<rnayak@ti.com>   wrote:
>>>>> >>  >>  pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
>>>>> >>  >>  operations done within cpuidle to do Powerdomain level book-keeping to know
>>>>> >>  >>  what state transitions for different Powerdomains have been triggered.
>>>>> >>  >>  This is also useful to do a restore-on-demand in some cases when we know
>>>>> >>  >>  the context for the given Powerdomain was lost etc.
>>>>> >>  >>
>>>>> >>  >>  Now that we have definitive entry/exit points (thanks to the Powerdomain
>>>>> >>  >>  level usecounting) for Powerdomain transitions, these book-keeping functions
>>>>> >>  >>  can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
>>>>> >>  >>  clkdm_disable() functions.
>>>>> >>  >>
>>>>> >>  >>  Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
>>>>> >>  >>  and get rid of the original ones which iterate over all powerdomains.
>>>>> >>  >>
>>>>> >>  >>  Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> This is excellent!   Thanks for working on this.
>
> However, it needs a rebase against mainline though because I merged a
> set of optimizations[1] to this code already that only calls pre/post
> per-pwrdm.

Sure Kevin, I'll repost this series once 3.6-rc1 is out.
