From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 11:41:18 -0800
Message-ID: <877hg9ayox.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-9-git-send-email-nm@ti.com>
	<87eiahckba.fsf@deeprootsystems.com>
	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
	<4CE6B2D4.1030201@ti.com>
	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64686 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab0KSTlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 14:41:23 -0500
Received: by gwb20 with SMTP id 20so221401gwb.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 11:41:23 -0800 (PST)
In-Reply-To: <7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 19 Nov 2010 22:58:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

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
>> >> I guess we need some more details on which secure mode calls can
>> trigger
>> >> this problem.  If this is an isolated case, I'm OK with this fix.  If
>> >> it's more general, I'd like to see a more general fix.
>> >>
>> > On the related topic I posted a patch some time back.
>> > http://www.spinics.net/lists/linux-omap/msg37907.html
>> > I guess Kevin is referring to the above patch.

Yes.

>> I believe the fix we are attempting here is for a specific scenario
>> which IMHO is different from the issue solved in the link above.
>
> It will also solve the above issue indirectly.

Yes, it indirectly fixes the issue solved by $SUBJECT patch, but what
else does it fix?

This secure mode call is currently the only one I'm aware of that does a
WFI.  If there are others, then $SUBJECT patch is not enough. 

If TI cannot tell us definitively if other secure-mode calls may use
WFI, then we have to assume there are others, and $SUBJECT patch has to
be NAK'd in favor of a more generic fix like the one from Santosh.

Kevin

