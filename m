From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Tue, 05 Oct 2010 14:44:45 -0700
Message-ID: <878w2cnwky.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1010021004150.15874-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58559 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab0JEVos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 17:44:48 -0400
Received: by pxi10 with SMTP id 10so1765653pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 14:44:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1010021004150.15874-100000@netrider.rowland.org>
	(Alan Stern's message of "Sat, 2 Oct 2010 10:12:10 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
>
>> > > In my opinion the _irq operations should really be one-shot, without
>> > > any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
>> > > the _irq resume should immediately fail and analogously for the _irq
>> > > suspend.  And so on.  As simple as reasonably possible.
>> > 
>> > But what if the device's own status is currently SUSPENDING or
>> > RESUMING?  Do you want to fail when that happens, instead of waiting
>> > for the concurrent operation to finish?
>> 
>> Yes.  IMO an _irq() suspend should only be allowed if the status is RPM_ACTIVE
>> and an _irq() resume should fail if the status is not RPM_SUSPENDED.  The
>> error code returned should depend on the situation, though.
>> 
>> > There's no way to prevent this
>> > on SMP systems, because a wakeup request can arrive while a
>> > software-initiated resume is in progress.
>> 
>> I know that. :-)
>
> I suspect Kevin will not want to live with this restriction, but I'd
> like to hear from him.  Kevin?

[ Apologies for the delays... I've been running around preparing OMAP PM
  stuff for the upcoming merge window. ]

I think I can live with the above restrictions (the _irq methods failing
unless they can immediately run.)  For the rare corner cases I've
currently run into, this will work fine as they happen because of a
wakeup IRQ, where we know the device is RPM_SUSPENDED.

Kevin



