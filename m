From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 20 Jan 2012 10:06:48 -0800
Message-ID: <871uquqmdj.fsf@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk>
	<1326386551.1896.41.camel@deskari> <87obu8sfx3.fsf@ti.com>
	<1326432554.1700.6.camel@lappyti> <87zkdrpfha.fsf@ti.com>
	<1326712308.1875.18.camel@deskari> <87r4yvv6k7.fsf@ti.com>
	<1327043773.1921.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58402 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754094Ab2ATSGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 13:06:52 -0500
Received: by mail-gy0-f175.google.com with SMTP id r1so365011ghr.6
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 10:06:51 -0800 (PST)
In-Reply-To: <1327043773.1921.17.camel@deskari> (Tomi Valkeinen's message of
	"Fri, 20 Jan 2012 09:16:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Thu, 2012-01-19 at 11:24 -0800, Kevin Hilman wrote:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>
>> > Now, you already said using pm_runtime_put_sync version is the correct
>> > way when suspending. But to use that I need to either always use
>> > pm_runtime_put_sync, or add an extra boolean which marks that we're
>> > suspending, and pass that around, or make it a DSS global variable.
>> 
>> I'm not sure why can't you use the sync version just in the suspend
>> callback?
>
> To do that the suspend callback should be the one that disables the
> device and calls pm_runtime_suspend. With DSS that's not the case, it's
> the panel drivers that are in charge of enabling/disabling DSS (by
> calling appropriate functions in omapdss).

Ah, OK.  makes sense.

> The only thing that the omapdss suspend callback does is to call the
> normal disable functions on the display drivers. This leads to calls to
> disable-functions on the dss hwmod drivers, and then pm_runtime_put
> calls. But at the point the pm_runtime funcs are called, the code has no
> idea that we're actually doing system suspend. Thus I'd need to pass
> that information somehow, probably with a global variable.
>
> And while that's not difficult to do, it sure feels a bit ugly.
>
> I think I'll just change the pm_runtime_put calls to sync versions for
> now. I imagine the perf impact with the change should be negligible.
> I'll return to this issue after the devtree adaptation has been made, as
> it changes the child-parent relations of the dss related devices, and
> perhaps managing the PM states will also get a bit easier.

Sounds reasonable.

Kevin
