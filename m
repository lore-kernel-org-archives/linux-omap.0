From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: hwmod: check for clkdomain pointer before accesing it to change the sleep dependencies.
Date: Thu, 10 Dec 2009 09:05:40 -0800
Message-ID: <87hbryrc7v.fsf@deeprootsystems.com>
References: <1260098323-26183-1-git-send-email-thara@ti.com>
	<873a3ju4ng.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030ACBFDFF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:44790 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760982AbZLJRFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 12:05:37 -0500
Received: by pzk1 with SMTP id 1so41861pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 09:05:43 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFDFF@dbde02.ent.ti.com> (Thara Gopinath's message of "Thu\, 10 Dec 2009 12\:04\:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, December 10, 2009 4:39 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; Paul Walmsley
>>>Subject: Re: [PATCH] OMAP3: hwmod: check for clkdomain pointer before accesing it to change the sleep
>>>dependencies.
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> Some clock nodes like wdt1_fck, sr1_fck, sr2_fck etc do not have a
>>>> clock domain associated . For such nodes accessing the clock domain pointers
>>>> in _add_initiator_dep and _del_initiator_dep, will lead to null pointer
>>>> defreferencing crash. Adding support in these functions to check for
>>>> existence of clkdm pointer before trying to acess it. Even if tomorrow
>>>> we correct all the clock nodes to have an associated clock domain, checking
>>>> for the existence of the pointer is a good programming practice.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>> ---
>>>> This patch depends on http://patchwork.kernel.org/patch/63383/
>>>
>>>I think clocks without associated clockdomains should be handled with
>>>a flag instead of a check for a NULL pointer.
>>>
>>>Your current approach will silently fail if someone forgets to add
>>>a clockdomain to a clock that should have one.
>
> Are you suggesting adding a flag to the clock node in case it does
> not have an associated clockdomain?  

Yes, or to the hwmod.

> I am using your tree origin/pm-wip/omap_device branch. On this I see
> a commit (e89a95db7095d998991c564a756a33ee0ec722c5) in which a
> warning is printed in omap2_init_clk_clkdm if there is no
> clockdomain associated with a clock node. 

This is to check for the case of a missing clkdm when there should be
one.  You're trying to solve the problem of when there is no
clockdomain for a given clock.

> My idea was this warning plus the check so as to avoid the system
> crash would suffice.

I still think this should be flagged explicitly in the clock/hwmod,
then check using the flag instead of of using NULL pointer check.

For readability, it makes it more clear that this is checking for some
exceptions and not simply doing error checking.

Kevin
