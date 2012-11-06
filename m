From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Tue, 6 Nov 2012 10:00:48 -0600
Message-ID: <50993430.2090907@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com> <509829C5.100@ti.com> <B5906170F1614E41A8A28DE3B8D121433EC045C5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46076 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab2KFQAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 11:00:54 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC045C5@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


On 11/06/2012 01:32 AM, Bedia, Vaibhav wrote:
> Hi Jon,
> 
> On Tue, Nov 06, 2012 at 02:34:05, Hunter, Jon wrote:
> [...]
>>>  static struct clock_event_device clockevent_gpt = {
>>>  	.name		= "gp_timer",
>>>  	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>>> @@ -142,6 +171,8 @@ static struct clock_event_device clockevent_gpt = {
>>>  	.rating		= 300,
>>>  	.set_next_event	= omap2_gp_timer_set_next_event,
>>>  	.set_mode	= omap2_gp_timer_set_mode,
>>> +	.suspend	= omap_clkevt_suspend,
>>> +	.resume		= omap_clkevt_resume,
>>
>> So these suspend/resume callbacks are going to be called for all OMAP2+
>> and AMxxxx devices? I don't think we want that. AFAIK OMAP timers will
>> idle on their own when stopped and don't require this.
>>
> 
> IMO instead of skipping the callback registration we could have checks in the
> suspend/resume callbacks to decide what to do. 
> 
> I'll check if the idling part is AM33xx specific. If not, based on the recent timer
> changes that you did, perhaps checking if the clockevent selected doesn't have the
> "ti,timer-alwon" capability will be good enough. What do you think?

Yes, I was thinking along the same lines. If I get chance I will try and
test your scenario on an OMAP3 too.

Cheers
Jon
