From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: dmtimer: Enable autoidle
Date: Tue, 15 Feb 2011 08:14:17 -0800
Message-ID: <87ipwluvfq.fsf@ti.com>
References: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com>
	<87oc6exkjr.fsf@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B037E9BDD@008-AM1MPN1-014.mgdnok.nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03745CA4C6@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03745CA4D8@dbde02.ent.ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B037E9D2C@008-AM1MPN1-014.mgdnok.nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03745CA4F7@dbde02.ent.ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B037E9EA3@008-AM1MPN1-014.mgdnok.nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03745CA5D1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57086 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994Ab1BOQOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:14:21 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so252672qwi.20
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 08:14:20 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03745CA5D1@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Tue, 15 Feb 2011 18:11:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>> >> >> >
>> >> >> > Should this be changed to apply only on that one? I don't know
>> >about
>> >> >> > OMAP4, but I think this should work on OMAP2 at least based on
>> >spec.
>> >> >> It works on OMAP2 and OMAP4.
>> >> >Ok, on OMAP4 I should have clarified further.
>> >> >AUTOIDLE is present only for millisecond timers: 1,2,10.
>> >> >The reset of the timers do not have this bit.
>> >>
>> >> Does it matter if the bit is set on the timers that don't have it or
>> >does
>> >> the HW just ignore it? Or should we enumerate the timers that support
>> >it
>> >> on omap4?
>> >For other timers it happens to be SOFTRESET bit. So HW would not ignore.
>> 
>> Ok, so this one should only be implemented for omap2/3 or added logic is
>> needed for omap4.
> YES.
>

Tarun is autoidle feature handled in your hwmod conversion series?

If not, this should be implemented as a patch on top of your series
since we will know which timers have this capability.

Kevin

