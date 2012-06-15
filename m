From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Fri, 15 Jun 2012 15:28:28 +0200
Message-ID: <4FDB387C.7030003@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48389 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756294Ab2FON2f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 09:28:35 -0400
In-Reply-To: <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Paul,

On 6/15/2012 2:18 AM, Paul Walmsley wrote:
> On Thu, 14 Jun 2012, Cousson, Benoit wrote:
>
>> On 6/14/2012 8:04 PM, Paul Walmsley wrote:
>>> On Thu, 14 Jun 2012, Cousson, Benoit wrote:
>
> (attribution lost)
>
>>>>> Furthermore, the PRCM will never request target idle for this IP block
>>>>> while the kernel is running, due to the sleep dependency that prevents
>>>>> the WKUP clockdomain from idling while the CORE_L3 clockdomain is
>>>>> active.  So we can safely leave the 32k sync timer in target-no-idle
>>>>> mode, even while we continue to access it.
>>>>
>>>> Do you mean force-idle? Because accessing a module in no-idle is always
>>>> possible.
>>>
>>> Thanks, that's indeed a description bug.
>>
>> I'm not sure to follow you? My point was it should be: "So we can safely leave
>> the 32k sync timer in force-idle mode, even while we continue to access it."
>> This is what the WA is doing.
>
> I am expressing appreciation to you for pointing out something incorrect
> in the patch description, which has been fixed in the current version of
> the patch.

OK, thanks for the clarification, I was confused by the sentence :-(.

>>> SIDLE_NO is the option that makes more sense to me.>>>
>>> Consider an IP block with SIDLE_NO and SIDLE_FORCE but without
>>> SIDLE_SMART.  When an initiator will access it, the default setting should
>>> be SIDLE_NO, for the reason that you identified above: "because accessing
>>> a module in no-idle is always possible."  On the other hand, we don't know
>>> when it's safe to access a module in SIDLE_FORCE unless we have additional
>>> information as to how the IP block handles the SIdleReq signal internally,
>>> and the characteristics of the clock domain in which it's integrated.
>
> ...
>
>> This is the modulemode and clkdm static dependency / dynamic on OMAP3/4 that
>> will guaranty that the OCP clock will be enabled upon any access to this
>> L4_WKUP clock domain IPs. This has nothing to do with the SIDLE mode.
>
> I want to implement a behavior that does not implicitly assume that an IP
> block without smart-idle will only exist inside clockdomains which are
> guaranteed to be active when the kernel is running.  That might be true
> for current WBU chips, but it seems unwise to make that assumption in
> general.

1- The fact that the IP does not support smart-idle does not change 
anything regarding the clock domain behavior.
2- So far the assumption is true for all the existing OMAP devices. 
Let's not anticipate something that will potentially never ever happen.

>>> It might be reasonable to remove the HWMOD_SWSUP_SIDLE flag from the 32k
>>> counter and just test again for HWMOD_ALWAYS_FORCE_SIDLE in the module
>>> disable.  I'll take a look at this.
>>
>> Both should be removed as explained before. There is clearly no need for
>> HWMOD_ALWAYS_FORCE_SIDLE.
>>
>> We are already explicitly listing the limitation through the idlemodes
>> attribute. Only SIDLE_FORCE and SIDLE_NO are supported, so we already
>> know that SIDLE_FORCE is the proper way to fix that limitation for the
>> current OMAPs. Since there is no other IP with such limitation, we know
>> as well that there will be no side effect. If, in the future, some more
>> IPs will have that limitation and will not work as expected, it will
>> mean that some other HW bugs will be there, and only these ones will
>> have to be flagged.
>>
>> But my point is let's keep it simple and not try to anticipate future
>> bugs. This flag is not require today, let's not add it.
>
> Which of these two behaviors do you feel is more "future-proof," in
> general:
>
> 1. Implementing a target idle policy that could break if a hardware
>     designer were to skip adding a target smart-idle mode to a module in
>     a clockdomain that might go idle while the kernel was active?

That's not fully accurate. Even with smart-idle implemented in this 
module, it will still go to idle automatically without any clock domain 
dependency properly handled.

The goal of this fix is to adapt the SIDLE management for such module, 
it will not solve the overall idle management that is anyway handled at 
clock domain level whatever the SIDLE implementation.

> 2. Implementing a target idle policy that is guaranteed to allow
>     initiator accesses to succeed by definition?

It will not, as explained before. This is the clock domain settings that 
will make the whole thing working properly.

> considering that the implementation cost of either approach is identical?

My point is simple, we should not add any new custom flag when all the 
information to detect such exception are already there in the current 
data and represent accurately what the HW is doing.

So far every IPs that do not support SIDLE_SMART can/should use 
SIDLE_FORCE instead.

Regards,
Benoit
