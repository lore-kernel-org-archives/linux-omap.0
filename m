From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ioremap bug?
Date: Thu, 12 Mar 2009 15:27:57 -0700
Message-ID: <871vt24brm.fsf@deeprootsystems.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
	<87zlfq6497.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51E2CB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.249]:13174 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZCLW2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 18:28:04 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1254094agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 15:28:01 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51E2CB@dlee02.ent.ti.com> (Nishanth Menon's message of "Thu\, 12 Mar 2009 16\:49\:41 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

"Menon, Nishanth" <nm@ti.com> writes:

> Kevin, Richard,
>> -----Original Message-----
>> From: Menon, Nishanth
> <snip>
>> 
>> > -----Original Message-----
>> > From: Woodruff, Richard
>> > Sent: Thursday, March 12, 2009 9:33 PM
> <snip>
>> >
>> > This rings a bell from a couple months back.  I've not followed the
>> thread
>> > but recall a recent fix to ioremap.
>> >
>> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08836.html
>> >
>> Ouch.. commit 24f11ec001920f1cfaeeed8e8b55725d900bbb56[1] is what you are
>> speaking of? That commit is not present in pm branch :(
>> 
>
> Aye.. cherry-pick saves the day (yet again).. script runs without a
> hitch.. (though I admire the simple code that Tomi had put for the
> proving the same)..

Thanks, cherry picked into PM branch as well.

> Anyone know of any more similar memory -
> kmalloc/ioremap/dma_alloc_coherent/vm surprises since 2.6.28? ;) but
> that would be pretty lazy me I guess..:D

It's always an exchange.  We get fixes for known bugs, and in exchange
get new bugs that haven't been found yet. ;)

Anyways, PM branch should be moving to 2.6.29 in the next couple
weeks.  Primary hold up is trying to get clock and PM stuff stabilized
and agreed upon for upstream merge (see recent PRCM register access
thread for details.)

Kevin
