From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 16:13:30 +0000
Message-ID: <WC20120111161330.3602C8@terrafix.co.uk>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <4F0D9B15.4070803@ti.com> <WC20120111151532.4602C0@terrafix.co.uk> <4F0DB020.2080804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:33890 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933565Ab2AKQOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 11:14:03 -0500
In-Reply-To: <4F0DB020.2080804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit <a0393947@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, khilman@ti.com, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

-----Original Message-----
From: Archit <a0393947@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, <khilman@ti.com>, <linux-omap@vger.kernel.org>, Tomi Valkeinen 
<tomi.valkeinen@ti.com>
Date: Wed, 11 Jan 2012 21:22:00 +0530
Subject: Re: DSS2/PM on 3.2 broken?

> Hi,
> 
> On Wednesday 11 January 2012 08:45 PM, Joe Woodward wrote:
> > ...snip...
> >
> >>
> >> Could you enable omapdss debug by adding 'omapdss.debug=1 debug' in
> >> your bootargs and share logs?
> >
> > As requested:
> >
> > # echo mem>  /sys/power/state
> > [   37.371734] PM: Syncing filesystems ... done.
> > [   37.397460] PM: Preparing system for mem sleep
> > [   37.402923] Freezing user space processes ... (elapsed 0.02
> seconds) done.
> > [   37.432312] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> > [   37.463256] PM: Entering mem sleep
> > [   37.467132] Suspending console(s) (use no_console_suspend to
> debug)
> >
> > #### SYSTEM SUSPENDS HERE
> >
> > [   37.587646] omapdss CORE: suspend 2
> > [   37.776000] omapdss DISPC: dispc_runtime_put
> > [   37.776336] omapdss DSS: dss_runtime_put
> > [   37.779693] PM: suspend of devices complete after 305.389 msecs
> > [   37.786010] omapdss DISPC: dispc_save_context
> > [   37.786437] omapdss DISPC: context saved, ctx_loss_count 0
> > [   37.786560] omapdss DSS: dss_runtime_put
> > [   37.786773] omapdss DSS: dss_save_context
> > [   37.786895] omapdss DSS: context saved
> > [   37.787384] PM: late suspend of devices complete after 7.446 msecs
> > [   40.932312] Successfully put all powerdomains to target state
> > [   40.934509] omapdss DSS: dss_restore_context
> > [   40.934661] omapdss DSS: context restored
> > [   40.934814] omapdss DSS: dss_runtime_get
> > [   40.934967] @@@ dss_runtime_get::pm_runtime_get_sync() return val
> = -13
> 
> This resume/restore looks to be happening a bit early according to me. 
> All the resuming should happen after the print 'omapdss CORE: resume'.
> 
> One experiment worth trying would be to reboot/halt the kernel which 
> will lead to only shutdown of DSS, and no resume. This will help us 
> figure out if the issue is in the suspend or resume path.
> 
> Archit

I'm not 100% sure what you mean for me to do here?

Do you mean to halt the kernel after suspending, but before resuming? If so, how would I go about doing this?

If I just reboot or poweroff I get the following...

# poweroff
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
[   43.310607] omapdss CORE: shutdown
[   43.499053] omapdss DISPC: dispc_runtime_put
[   43.504272] omapdss DISPC: dispc_save_context
[   43.509399] omapdss DISPC: context saved, ctx_loss_count 0
[   43.515747] omapdss DSS: dss_runtime_put
[   43.521453] omapdss DSS: dss_runtime_put
[   43.527221] System halted.

# reboot
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   25.652008] omapdss CORE: shutdown
[   25.836120] omapdss DISPC: dispc_runtime_put
[   25.841125] omapdss DISPC: dispc_save_context
[   25.846221] omapdss DSS: dss_runtime_put
[   25.851776] omapdss DISPC: context saved, ctx_loss_count 0
[   25.857788] omapdss DSS: dss_runtime_put
[   25.864074] Restarting system.

Cheers,
Joe


