From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Mon, 5 Nov 2012 15:20:50 -0600
Message-ID: <50982DB2.4000104@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com> <50950AC7.1030707@deeprootsystems.com> <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40590 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2KEVU4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 16:20:56 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


On 11/03/2012 08:17 AM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 17:45:03, Kevin Hilman wrote:
>> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>
>>> The current OMAP timer code registers two timers -
>>> one as clocksource and one as clockevent.
>>> AM33XX has only one usable timer in the WKUP domain
>>> so one of the timers needs suspend-resume support
>>> to restore the configuration to pre-suspend state.
>>
>> The changelog describes "what", but doesn't answer "why?"
>>
> 
> Sorry I'll try to take of this in the future.
> 
>>> commit adc78e6 (timekeeping: Add suspend and resume
>>> of clock event devices) introduced .suspend and .resume
>>> callbacks for clock event devices. Leverages these
>>> callbacks to have AM33XX clockevent timer which is
>>> in not in WKUP domain to behave properly across system
>>> suspend.
>>
>> You say it behaves properly without describing what improper
>> behavior is happening.
>>
> 
> There are two issues. One is that the clockevent timer doesn't
> get idled which blocks PER domain transition. 

Why is this? How is the dmtimer TIOCP_CFG register configured on AM33xx?
Is it using smart-idle?

> The next one is that
> the clockevent doesn't generate any further interrupts once the
> system resumes. We need to restore the pre-suspend configuration.
> I haven't tried but I guess we could have used the save and restore
> of timer registers here.

It would be interesting to try using an non-wakeup domain timer on
OMAP3/4 for clock events and seeing if suspend/resume works.

Do you know what the exact problem here is? I understand that the timer
context could get lost, but exactly what is not getting restarted by the
kernel? For example, the only place we set the interrupt enable is
during the clock event init and so if the context is lost, then I could
see no more interrupts occurring. So is it enough to just restore the
interrupt enable register, do you really need to program the timer again?

Cheers
Jon
