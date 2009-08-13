From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: OMAP PM status?
Date: Thu, 13 Aug 2009 19:41:33 +0300
Message-ID: <877hx7k6o2.fsf@litku.valot.fi>
References: <87bpmkkegw.fsf@litku.valot.fi>
	<873a7wsjm9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:57272 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZHMQlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 12:41:35 -0400
Received: by bwz22 with SMTP id 22so697793bwz.18
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 09:41:36 -0700 (PDT)
In-Reply-To: <873a7wsjm9.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 12 Aug 2009 16\:22\:22 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Hi Kalle,

Hello,

> Kalle Valo <kalle.valo@iki.fi> writes:
>
>> as you might guess, I'm eagerly waiting for OMAP PM support to hit
>> mainline :) I'm just curious, what's the current status? Are we
>> going to get PM support in 2.6.32?
>
> Hmmm, good question.  To avoid giving an answer that can be archived
> and used against me, I updated the PM branch wiki page[1] with a
> 'mainline plans' section[2] which I can edit as plans slip^Wchange. :)

Excellent, the page was very helpful for me and I'm sure also for
others.

>> Especially I'm interested about 2420 support for n8x0.
>
> Well, I'm afraid I've done basically no testing for OMAP2, and have
> been focusing solely on OMAP3.  I'm pretty sure things at least should
> compile for OMAP2, as care has been taken to keep OMAP2 up to speed
> with OMAP3 for the base features, but I haven't done any boot testing
> on OMAP2 for some time.

I'm sorry to hear that, but I understand that you don't have time for
everything.

> That being said, all the infrastructure for OMAP2 that was in
> linux-omap is already in mainline so will work as good as it did in
> linux-omap.  The last time I actually tried PM on OMAP2, I found/fixed
> a bug[3] in the asm sleep code for OMAP2 that was causing fault.  At
> least it no longer faults when suspended
>
> Of course, I'll be glad to take any OMAP2 patches/fixes and get them
> upstream with the rest of my changes, but I'm afraid with my current
> plans, I do not have the cycles to spend on OMAP2.

As soon as I find some spare time (which usually means three to four
months from now :) I'll start experimenting with N800 PM. If I have any
problems, I'll send email to the list as usual.

Thanks.

-- 
Kalle Valo
