From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Mon, 16 Jul 2012 13:27:35 -0500
Message-ID: <50045D17.9050704@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35815 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2GPS15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 14:27:57 -0400
In-Reply-To: <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 07/13/2012 04:00 PM, Paul Walmsley wrote:

[...]

>> Unfortunately, although this works it does make the flags a bit less 
>> clearer. The upside is the solution is simpler.
> 
> Yeah, the problem is the clockdomain CLKDM_CAN_* flags are just intended 
> to represent the available bits from the register bitfield, rather than a 
> higher-level concept.  Among other things, it allows the maintainers and 
> users of this code to verify it by comparing it to the TRM.  Changing the 
> CLKDM_CAN_* flags in the kernel is not actually that simple since it 
> involves overriding the hardware data for the EMU clockdomain for every 
> applicable chip.  In other words, it just moves the complexity 
> elsewhere.

Yes I see that makes sense. However, patch #7 has already changed the
mapping of the flags. I had intended that patch #7 and #8 would be
applied together. However, I could see that patch #7 can be taken just
to eliminate using the SW_SLEEP state. So basically, what I am saying is
does patch #7 have any value without #8?

>> I am not sure if it is really a matter of the clock domain missing the
>> idle reporting, but more of a problem that the EMU power domain power
>> state is programmed in HW to OFF and cannot be changed by software. (see
>> POWER_STATE field of PM_EMU_PWRSTCTRL register description in the TRM).
>>
>> This means that when the EMU clock domain does idle, the EMU power
>> domain can transition to OFF and hence we loss the EMU logic context. So
>> we need to keep the EMU CLKDM on to keep the EMU PWRDM on, but it is
>> really the lack of control we have over the PWRDM that is the problem. I
>> would not say this is a HW bug but more of a design choice probably to
>> keep the design simpler at the expense of power.
> 
> I really wonder how much more difficult it would have been to add the 
> ON state to the EMU powerdomain next-power-state control bitfields...

True, probably a good area for us to provide some feedback to the
designers.

>> I believe that this problem would happen to all power domains if they
>> were programmed for the OFF power state when the clock domain idled. For
>> other power domains we avoid this by programming them to the ON state
>> when we are using them.
> 
> Hmm.  In the case of most other clockdomains, we have some way to indicate 
> to the PRCM whether the IP block/clock is in use or not: functional clock 
> control bits or modulemode control bits or CLKACTIVITY bits or (in the 
> worst case) SIDLEMODE bits.  We don't really have any of these control 
> mechanisms for most of the EMU clockdomain IP blocks/clocks.
> 
> From a theoretical perspective, assigning the problem solely to the 
> powerdomain next-power-state bits might also ignore the impact on 
> clockdomain dependencies.  These take effect based on the clockdomain 
> activity state, rather than powerdomain next-power-states.  Although, for 
> the specific case of the EMU clockdomains on OMAP3/4, it looks like this 
> is not a practical problem according to the TRM.

Ok, yes I understand your point of view.

>> Thanks for the detailed suggestion! Adding a flag to prevent programming
>> the HW_AUTO while the CLKDM is active could definitely work (although I
>> may change the name/description of the flag a little).
> 
> Sure, let me know what you think of the above reasoning.

I would say it is fair (with limited knowledge of the h/w design
decisions made here).

>> Another proposal I also thought of is re-working the flags to describe
>> the HW mode to be used when turning on the CLKDM, when the CLKDM is
>> active and when the CLKDM is shut down. So instead of saying what modes
>> the CLKDM supports, specify what modes should be used for pre-ON (i.e.
>> turn ON), ON and OFF. Right now software is trying to decide for us by
>> what is available (which is ideal) but makes working around such nuances
>> a little more painful.
> 
> With the hardware data, it would be good to keep it something that can be 
> generated with as little human intervention as possible, except in the 
> case of bug workarounds or departures from standard practice.  The idea is 
> to reduce the amount of human interaction needed to generate data to 
> support new chips, when everything works as it should.  It also allows us 
> software forks to explicitly mark unusual quirks or bugs that we'd like 
> the hardware people to change for future revisions :-)

That's fine with me. We can always workaround such issues by adding flags.

I can give this a try this week and let you know how it goes.

I think that Benoit is out until the end of the month. I am not sure if
he will have any inputs.

Cheers
Jon
