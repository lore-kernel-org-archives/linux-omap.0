From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 14 Jun 2012 22:13:41 +0200
Message-ID: <4FDA45F5.9090300@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59241 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502Ab2FNUNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 16:13:49 -0400
In-Reply-To: <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On 6/14/2012 8:04 PM, Paul Walmsley wrote:
> Hi
>
> On Thu, 14 Jun 2012, Cousson, Benoit wrote:
>
>> On 6/11/2012 2:45 AM, Paul Walmsley wrote:
>>> Kuvin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
>>
>> I guess you meant Kevin?
>
> ...
>
>>> The IP block itself pbobably does not have any native idle
>>
>> typo
>
> Thanks for noticing these, but they are not in what was sent out by the
> list server:
>
> http://www.spinics.net/lists/linux-omap/msg71503.html
>
> Some software/hardware issue on your end, maybe?

Hehe, funny, first time outlook server is editing email automatically... 
That's probably a new feature.

>
>>> handling at all, due to its simplicity.
>>
>> I don't think this description is really accurate, due to the usual confusing
>> definition of IDLE for the PRCM standpoint :-)
>> The counter_32k will follow PRCM requirement toward SIdleReq/SIdleAck.
>> It has to be "idle" for PRCM standpoint to allow the transition of the L4_WKUP
>> to inactive (SIdleAck=IDLE). And it will be functional as soon as the L4_WKUP
>> domain is active.
>>
>> The fact that the smartidle mode is missing does not change anything in the
>> way the PRCM handle the protocol. It is just an issue at IP level.
>>
>> In that case force-idle = smart-idle, just because this module does not have
>> anything to do to delay the SIdleAck upon SIdleReq request. The IP is probably
>> connecting the SIdleAck to the SIdleReq signal.
>> Please note that there are a bunch of IPs that are doing that even if they do
>> support the smartidle mode.
>
> Right, that's exactly my point -- perhaps made in an unclear way.
>
> My point was that the 32k counter IP block doesn't do anything with the
> incoming IdleReq signal to determine whether or not to assert IdleAck back
> to the PRCM.  But rather than implementing smart-idle mode to handle this,
> like the other IP blocks do, the only two modes implemented were the
> debugging modes, force-idle and no-idle.
>
> So depending on one's point of view, this patch is either:
>
> 1. a hardware bug workaround, because the hardware should have a
> smart-idle mode that acts the same way as the force-idle mode, just like
> the other IP blocks do; or

Well it is not even a real HW bug. That's more a recommendation that was 
not followed than a real HW bug. It is not the only one BTW, hence the 
number of flags we have in hwmod already :-)

A HW bug will be more for an IP that is supposed to have smart-idle but 
it does work properly and thus has to be disabled. In that case the mode 
is clearly not documented, so I'm not calling that an HW bug.

> 2. a software workaround, because we don't have a 32k counter device
> driver that implements runtime PM around counter reads.
>
> Of course #2 would be rather pointless and the patch description tries to
> convey this too.
>
>>> Furthermore, the PRCM will never request target idle for this IP block
>>> while the kernel is running, due to the sleep dependency that prevents
>>> the WKUP clockdomain from idling while the CORE_L3 clockdomain is
>>> active.  So we can safely leave the 32k sync timer in target-no-idle
>>> mode, even while we continue to access it.
>>
>> Do you mean force-idle? Because accessing a module in no-idle is always
>> possible.
>
> Thanks, that's indeed a description bug.

I'm not sure to follow you? My point was it should be: "So we can safely 
leave the 32k sync timer in force-idle mode, even while we continue to 
access it."
This is what the WA is doing.

>>> This workaround is implemented by defining a new hwmod flag,
>>> HWMOD_ALWAYS_FORCE_SIDLE, that places the IP block into target
>>> force-idle mode even when enabled.  The 32k sync timer hwmods are
>>> marked with this flag for OMAP3 and OMAP4 SoCs.  (On OMAP2xxx, no OCP
>>> header existed on the 32k sync timer.)
>>
>> I still don't see the need for this flag. It looks to me that we are adding a
>> redundant information and thus make things more complex than it should.
>>
>> 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
>>
>> It the real root cause of the problem. There is no need to re-encode that
>> using an extra flag. Especially at hwmod level where the issue is at sysconfig
>> level.
>>
>> I did not really get the reason why you changed your mind on that point.
>>
>> As soon as there is no SIDLE_SMART mode, what choice do we have but using the
>> SIDLE_FORCE?
>
> SIDLE_NO is the option that makes more sense to me.
>
> Consider an IP block with SIDLE_NO and SIDLE_FORCE but without
> SIDLE_SMART.  When an initiator will access it, the default setting should
> be SIDLE_NO, for the reason that you identified above: "because accessing
> a module in no-idle is always possible."  On the other hand, we don't know
> when it's safe to access a module in SIDLE_FORCE unless we have additional
> information as to how the IP block handles the SIdleReq signal internally,
> and the characteristics of the clock domain in which it's integrated.

Nope, that's not really accurate. The SIDLE mode is just the local 
configuration for the IP behavior during clock domain transition to 
idle. It does not have any influence on the re-activation of the clock.
In that case, both force-idle and smart-idle will behave the same. Only 
the transition to *idle* is supposed to be different between these two 
modes, hence the name.
What is missing here is the modulemode and the clock domain control:

counter_32k modulemode description:
"Module is managed automatically by HW according to clock domain 
transition. A clock domain sleep transition put module into idle. A 
wakeup domain transition put it back into function.
If CLKTRCTRL=3, any OCP access to module is always granted. Module 
clocks may be gated according to the clock domain state."

This is the modulemode and clkdm static dependency / dynamic on OMAP3/4 
that will guaranty that the OCP clock will be enabled upon any access to 
this L4_WKUP clock domain IPs. This has nothing to do with the SIDLE mode.

So SIDLE_FORCE is the right solution to still allow the proper 
clockdomain transition. It will behave exactly like a SIDLE_SMART.
And that's probably why they did not implement the smart-idle for that IP.

> For
> example, as mentioned earlier in the discussion on this patch, the AM335x
> documentation states "By definition, initiator may generate read/write
> transaction as long as it is out of IDLE state."

I saw that sentence, but what is this supposed to mean?


Moreover if AM335X require some specific trick, we should add some flags 
for that, and not force the usage of a flag that is mostly irrelevant 
for OMAP3 and 4 just because AM might need it.

>> BTW, I even think the HWMOD_SWSUP_SIDLE hwmod flag is useless now. It
>> was needed before probably because the idlemodes were wrongly populated.
>>
>> In fact the hwmod flags is really there to *flag* some real HW bug we cannot
>> figure out otherwise, but in that case, the sysc.idlemodes already contains
>> all the information we need to set the proper mode during enable/disable.
>>
>> Duplicating the information is always a source of confusion and might lead to
>> nasty bugs due to the increase of complexity.
>
> You may be misunderstanding the meaning of the HWMOD_SWSUP_SIDLE flag.  It
> was added to work around IP blocks that had broken smart-idle.  These
> modules definitely do exist; see for example the OMAP3 wdt2, usbhsotg, and
> usb_host_hs hwmods as some examples.

I know, I was mostly referring to the HWMOD_ALWAYS_FORCE_SIDLE. My point 
about HWMOD_SWSUP_SIDLE is: it is useless for that IP, not in general.

> It might be reasonable to remove the HWMOD_SWSUP_SIDLE flag from the 32k
> counter and just test again for HWMOD_ALWAYS_FORCE_SIDLE in the module
> disable.  I'll take a look at this.

Both should be removed as explained before. There is clearly no need for 
HWMOD_ALWAYS_FORCE_SIDLE.

We are already explicitly listing the limitation through the idlemodes 
attribute. Only SIDLE_FORCE and SIDLE_NO are supported, so we already 
know that SIDLE_FORCE is the proper way to fix that limitation for the 
current OMAPs.
Since there is no other IP with such limitation, we know as well that 
there will be no side effect.
If, in the future, some more IPs will have that limitation and will not 
work as expected, it will mean that some other HW bugs will be there, 
and only these ones will have to be flagged.

But my point is let's keep it simple and not try to anticipate future 
bugs. This flag is not require today, let's not add it.

>>> Another theoretically clean fix for this problem would be to implement
>>> PM runtime-based control for 32k sync timer accesses.  These PM
>>> runtime calls would need to located in a custom clocksource, since the
>>> 32k sync timer is currently used as an MMIO clocksource.  But in
>>> practice, there would be little benefit to doing so; and there would
>>> be some cost, due to the addition of unnecessary lines of code and the
>>> additional CPU overhead of the PM runtime and hwmod code - unnecessary
>>> in this case.
>>
>> I don't think that part is really relevant anymore.
>
> Why?

I'm not sure anymore now :-)
I guess it was because I thought this is mostly a HW issue, and it was 
detected because HWMOD_SWSUP_SIDLE was set previously. Without that, 
this IP will behave like a GPTIMER.

>>> Another possible fix would have been to modify the pm34xx.c code to
>>> force the IP block idle before entering WFI.  But this would not have
>>> been an acceptable approach: we are trying to remove this type of
>>> centralized IP block idle control from the PM code.
>>
>> Neither that one I guess. As soon as we consider force-idle to be equivalent
>> to smart-idle, nothing more is needed.
>
> But they are definitely not equivalent.

Indeed, but in that case, yes, and this is what really matter.

Regards,
Benoit
