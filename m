From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 07/12] arm: omap3: am35x: Set proper powerdomain states
Date: Wed, 11 Apr 2012 19:24:29 -0500
Message-ID: <4F8620BD.5000800@ti.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-8-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1204111546110.29473@utopia.booyaka.com> <20120411224031.GD31197@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40811 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761291Ab2DLAYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 20:24:32 -0400
In-Reply-To: <20120411224031.GD31197@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 04/11/2012 05:40 PM, Mark A. Greer wrote:
> On Wed, Apr 11, 2012 at 03:53:30PM -0600, Paul Walmsley wrote:
>> Hi
>>
>> On Wed, 11 Apr 2012, Mark A. Greer wrote:
>>
>>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>>
>>> The am35x family of SoCs only support PWRSTS_ON
>>> and PWRSTS_INACTIVE states so create a new set
>>> of powerdomain structures that ensure that only
>>> the ON and INACTIVE states are entered.
>>
>> I'm still unsure what we should do about this INACTIVE state.  As far as I 
>> can tell, it does not actually represent a distinct powerdomain state on 
>> OMAP3.  We can't write it to the PM_PWSTCTRL_*.POWERSTATE bits, since that 
>> value is marked as "reserved".  And SPRUGR0B, the AM3517/3505 TRM, 
>> explicitly states "This register should not be programmed with reserved 
>> values of bit fields for proper functioning of power state control."
>> Of course SPRUGR0B also claims that AM3517/3505 supports RETENTION, so 
>> that is relatively confusing.
> 
> Yep.  You read one section which tells you the device doesn't support
> such-and-such then it goes on for pages describing how it works.  I play
> with the hardware and the registers are there so it seems like it should
> work.  Its been an "adventure". :)
> 
>> OMAP4 PRCM actually does seem to support powerdomain INACTIVE state, 
>> although it does not actually seem to represent a separate state.  As I 
>> understand it, it simply allows the clockdomains in the powerdomain to 
>> transitioning from the ACTIVE state into the INACTIVE state.  In other 
>> words, it doesn't affect the powerdomain power state at all.  And on OMAP4 
>> it's referred to as the ON-INACTIVE state, to clarify that it is simply a 
>> variant of the ON state.  I wish they had just added a separate bit for 
>> this; it would have avoided some frustration...
>>
>> Anyway, my question is this: is there any point at all to defining the 
>> INACTIVE state for 3517/3505, given that it apparently cannot be read 
>> from, nor written to the PRCM hardware?
> 
> Great question and I really don't know the answer--its too hard to know
> what's for real and what isn't in the TRM.  Maybe it is best to get rid
> of INACTIVE and just leave everything ON.

FWIW, for omap3 class device inactive is defined as ...

"Inactive: The same as power on but all clocks are cut. Logic is not
working, because no clock is running."

There is nothing explicit to program as far as the power domain goes.
For OMAP4 you can program the power domain to enter inactive and when
all power domains in a voltage domain are inactive the voltage domain
can enter the sleep state.

Cheers
Jon
