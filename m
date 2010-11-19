From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 12:51:00 -0600
Message-ID: <4CE6C714.50209@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com><1290131698-6194-9-git-send-email-nm@ti.com> <87eiahckba.fsf@deeprootsystems.com> <9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com> <4CE6B2D4.1030201@ti.com> <7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46823 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756516Ab0KSSvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 13:51:07 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so353052vws.12
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 10:51:04 -0800 (PST)
In-Reply-To: <7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Santosh Shilimkar had written, on 11/19/2010 11:28 AM, the following:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Friday, November 19, 2010 10:55 PM
>> To: Santosh Shilimkar
>> Cc: Kevin Hilman; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
>> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
>> RAM
>>
>> Santosh Shilimkar had written, on 11/19/2010 11:18 AM, the following:
>> [..]
>>>> I guess we need some more details on which secure mode calls can
>> trigger
>>>> this problem.  If this is an isolated case, I'm OK with this fix.  If
>>>> it's more general, I'd like to see a more general fix.
>>>>
>>> On the related topic I posted a patch some time back.
>>> http://www.spinics.net/lists/linux-omap/msg37907.html
>>> I guess Kevin is referring to the above patch.
>> I believe the fix we are attempting here is for a specific scenario
>> which IMHO is different from the issue solved in the link above.
> 
> It will also solve the above issue indirectly.
just my dumb brains :) agreed, good one that takes care of the power 
domain, agreed that pwrdm_set_next_pwrst(which is currently present in 
the omap3_save_secure_ram_context) would no longer be necessary - so [1] 
should also have removed that - This specific patch controls the clock 
domain from auto idling around the secure ram save. Apologies on the 
confusion - but if the [1] patch is fixing it, you can help me 
understand how it does it.

[1]http://www.spinics.net/lists/linux-omap/msg37907.html

-- 
Regards,
Nishanth Menon
