From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC v2 13/18] ARM: OMAP2+: AM33XX: timer: Interchance clkevt
 and clksrc timers
Date: Wed, 30 Jan 2013 11:48:10 -0600
Message-ID: <51095CDA.9090701@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com> <5101B622.7050901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222Ab3A3RsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 12:48:15 -0500
In-Reply-To: <5101B622.7050901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>


On 01/24/2013 04:30 PM, Jon Hunter wrote:
> Hi Vaibhav,
> 
> On 12/31/2012 07:07 AM, Vaibhav Bedia wrote:
>> AM33XX has two timers (DTIMER0/1) in the WKUP domain.
>> On GP devices the source of DMTIMER0 is fixed to an
>> inaccurate internal 32k RC oscillator and this makes
>> the DMTIMER0 practically either as a clocksource or
>> as clockevent.
>>
>> Currently the timer instance in WKUP domain is used
>> as the clockevent and the timer in non-WKUP domain
>> as the clocksource. DMTIMER1 in WKUP domain can keep
>> running in suspend from a 32K clock fed from external
>> OSC and can serve as the persistent clock for the kernel.
>> To enable this, interchange the timers used as clocksource
>> and clockevent for AM33XX.
> 
> I have been thinking about this some more. In the case where we are
> using gptimers for both clock-events and clock-source (on both AM33xx
> and OMAP) and I am wondering if it makes sense to switch the timers so
> that we use the always-on timer for clock-source and a different one
> from clock-events.
> 
> For OMAP, if we are not using the 32k-sync for clock-source, then we are
> never going to achieve low power states during idle as we will always
> have one gptimer running. And in this case, to your point below, it
> would be better to use the always-on for clock-source so that in suspend
> we can at least hit low power states and maintain time.

I have posted a patch today [1] that I hope will address this issue for
you. Can you give that a try?

Cheers
Jon

[1] http://www.spinics.net/lists/arm-kernel/msg221265.html
