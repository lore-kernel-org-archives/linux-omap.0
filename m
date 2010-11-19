From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 12:39:46 -0800
Message-ID: <877hg96oa5.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-9-git-send-email-nm@ti.com>
	<87eiahckba.fsf@deeprootsystems.com>
	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
	<4CE6B2D4.1030201@ti.com>
	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
	<4CE6C714.50209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33591 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab0KSUjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 15:39:49 -0500
Received: by iwn7 with SMTP id 7so206022iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 12:39:49 -0800 (PST)
In-Reply-To: <4CE6C714.50209@ti.com> (Nishanth Menon's message of "Fri, 19 Nov
	2010 12:51:00 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Santosh Shilimkar had written, on 11/19/2010 11:28 AM, the following:
>>> -----Original Message-----
>>> From: Nishanth Menon [mailto:nm@ti.com]
>>> Sent: Friday, November 19, 2010 10:55 PM
>>> To: Santosh Shilimkar
>>> Cc: Kevin Hilman; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
>>> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
>>> RAM
>>>
>>> Santosh Shilimkar had written, on 11/19/2010 11:18 AM, the following:
>>> [..]
>>>>> I guess we need some more details on which secure mode calls can
>>> trigger
>>>>> this problem.  If this is an isolated case, I'm OK with this fix.  If
>>>>> it's more general, I'd like to see a more general fix.
>>>>>
>>>> On the related topic I posted a patch some time back.
>>>> http://www.spinics.net/lists/linux-omap/msg37907.html
>>>> I guess Kevin is referring to the above patch.
>>> I believe the fix we are attempting here is for a specific scenario
>>> which IMHO is different from the issue solved in the link above.
>>
>> It will also solve the above issue indirectly.
> just my dumb brains :) agreed, good one that takes care of the power
> domain, agreed that pwrdm_set_next_pwrst(which is currently present in
> the omap3_save_secure_ram_context) would no longer be necessary

Ah, you're right.  I hadn't noticed that the current code is already
setting he MPU powerdomain to on.

> - so [1] should also have removed that - 

Agreed.

In addtion, the patch from Santosh needs to better describe what other
problems it is solving, since it is clearly not fixing this particular
secure mode entry.  Therefore, there must be others that are also doing
WFI.   That being said, instead of such a generic fix as is done by
Santosh's patch, maybe we need a common secure-mode entry point which
does the necessary ROM code prep.

> This specific patch controls the clock domain from auto idling around
> the secure ram save. Apologies on the confusion - but if the [1] patch
> is fixing it, you can help me understand how it does it.

Now that I understand the clockdomain part, I'm seeing the problem
differently.  (side note: A better written changelog could have avoided
this confusion by being clear that it was *clockdomain* idle that was
being added here and that it was in addition to the existing powerdomain
settings.)

Technically, $SUBJECT patch could have replaced the set_next_pwrst with
the clkdm_deny_idle.  IOW, setting the pwrdm next state to is redundant
if you clkdm_deny_idle.

I think this is the key to the confusion:

1) clkdm_deny_idle() implies the powerdomain stays on
2) setting powerdomain to on, does NOT imply clkdm_deny_idle()

Another way of saying it is that setting a powerdomain to on does not
prevent it from going inactive.  It only prevents retention or off-mode.

Tero had a series a while back[1] that addressed this in a more general
way.  IIRC, with his series, he generalized the powerdomain states so
you could set a powerdomain to on, denying clkdm idle, or you could set
the powerdomain to inactive, allowing clkdm idle.

ISTR that I quite liked the inactive support from Tero in that series,
but Paul and myself had some issues with how the IDLEST bits were
managed in that series, which could probably be addressed with hwmod
today.

I think it's time to revisit this series from Tero.

Kevin

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg25268.html
