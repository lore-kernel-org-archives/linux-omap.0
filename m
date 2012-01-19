From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 11:24:56 -0800
Message-ID: <87r4yvv6k7.fsf@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk>
	<1326386551.1896.41.camel@deskari> <87obu8sfx3.fsf@ti.com>
	<1326432554.1700.6.camel@lappyti> <87zkdrpfha.fsf@ti.com>
	<1326712308.1875.18.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:44505 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932675Ab2ASTY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 14:24:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so296061iag.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 11:24:58 -0800 (PST)
In-Reply-To: <1326712308.1875.18.camel@deskari> (Tomi Valkeinen's message of
	"Mon, 16 Jan 2012 13:11:48 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Fri, 2012-01-13 at 11:30 -0800, Kevin Hilman wrote:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>
>> > pm_runtime_put() is called inside omapdss driver's .suspend callback. So
>> > I guess that means the system suspend has started. However, the logs
>> > show that the runtime_suspend callback _is_ being called before the
>> > system suspend is finished, so the workqueue can't be frozen...
>> 
>> ...or there are other ways that the runtime_suspend callback is called.
>> 
>> In order to ensure that devices are properly idled for system-wide
>> suspend, The OMAP PM domain layer will call the drivers
>> ->runtime_suspend callback during "late" suspend (using the PM domain's
>> _noirq callbacks.)
>> 
>> This is there so that even when runtime PM has been disabled (via
>> userspace, or pm_runtime_forbid() calls) the driver can still be
>> properly idled before suspend.
>> 
>> In your case, I suspect you're seeing the driver's ->runtime_suspend
>> callback called during late suspend, not by the PM workqueue.
>
> Ok, that explains the invocation of the callbacks.
>
>> I don't understand DSS enough to make sense of the logs you sent, so not
>> sure how to be of more help.
>
> Well, I think I can summarize the situation:
>
> Normally, when the user wants to turn a display off, the panel drivers
> call DSS functions to disable the corresponding output, leading to
> pm_runtime_put() calls.
>
> In system suspend case, the suspend callback initiates the turning off
> of the displays, which again leads to pm_runtime_put() calls.
>
> Now, you already said using pm_runtime_put_sync version is the correct
> way when suspending. But to use that I need to either always use
> pm_runtime_put_sync, or add an extra boolean which marks that we're
> suspending, and pass that around, or make it a DSS global variable.

I'm not sure why can't you use the sync version just in the suspend
callback?

> Both of those options sound a bit ugly to me. So my two questions are,
>
> 1) Is there something funny with the DSS architecture to have a problem
> like this? I tried to grep around, but I didn't see any other driver
> doing something like that (but I could've missed it).
>
> 2) why can't the PM framework handle this, by directing the
> pm_runtime_put calls to the _sync version when suspending. Somehow it
> feels strange to me that the driver needs to care about that.

This has been a big debate with the runtime PM framework in general.
Some of us have argued that system PM and runtime PM should be more
unified, and that runtime PM calls should work "normally" from system
suspend.  After all, system suspend could be considered simply a forced
idle/quiecient state state where all the runtime callbacks kick in to
idle the system.  However those of us arguing for that lost the battle
with the PM core maintainers, and system PM and runtime PM have to be
managed separately.

I've "worked around" that by using the PM domain level calls to ensure
runtime PM callbacks are called on system suspend, but the side effect
is the complications you've run into.

So for now, if you use runtime PM in your system PM you have to use the
sync versions.  For most drivers I've dealt with, that means just using
sync version in the suspend callback is required, but maybe the
interaction of the various DSS subblocks means you need the sync version
everywhere.

Kevin



