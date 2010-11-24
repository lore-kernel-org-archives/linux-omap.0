From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Tue, 23 Nov 2010 16:11:31 -0800
Message-ID: <87mxozd1ho.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1011222204440.26293-100000@netrider.rowland.org>
	<201011232351.11340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38647 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab0KXALg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 19:11:36 -0500
Received: by gwj20 with SMTP id 20so469996gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 16:11:35 -0800 (PST)
In-Reply-To: <201011232351.11340.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 23 Nov 2010 23:51:11 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, November 23, 2010, Alan Stern wrote:
>> On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:
>> 
>> > > > Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
>> > > > we need it, exactly?
>> > > 
>> > > Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
>> > > irq-safe version of rpm_idle() then drivers wouldn't be able to call 
>> > > pm_runtime_put_sync() from within an interrupt handler.
>> > 
>> > Right.  Which they can't do now, can they?
>> 
>> True.  That was the point of this patch -- to allow interrupt handlers
>> to do runtime PM, which they can't do now.
>
> The original idea was to allow suspend and resume to be carried out
> with interrupts off, not necessarily by interrupt handlers.  We've never
> considered doing that with _idle before.
>
>> > Why do you think we should allow them to do that?
>> 
>> Are you suggesting that interrupt handlers stick to pm_runtime_suspend 
>> and pm_runtime_resume, and ignore pm_runtime_get_sync and 
>> pm_runtime_put_sync?
>
> Why do they need the _sync versions?  What exactly is wrong with
> calling
>
> pm_runtime_put_noidle()
> pm_runtime_suspend()
>
> from an interrupt handler if it really wants the synchronous suspend to be
> carried out at this point?
>
> I don't really see a reason for calling pm_runtime_put_sync() by an interrupt
> handler, but perhaps I'm overlooking something important.

While I like the idea of the symmetry of having both _get_sync() and
_put_sync() callable from an interrupt handler, I can't currently think
of a situation where we would need to _put_sync() in the ISR.  A
standard _put() should suffice for all cases I can imagine.

Kevin
