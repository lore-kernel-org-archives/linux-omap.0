From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: PM/UART 3.5-rc5: UART Rx wakeups not quite right?
Date: Mon, 16 Jul 2012 16:26:01 +0100
Message-ID: <WC20120716152601.80015F@terrafix.co.uk>
References: <WC20120705133859.690032@terrafix.co.uk> <87boju2s8x.fsf@ti.com> <20120716084002.GN7955@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:36705 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261Ab2GPP0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 11:26:17 -0400
In-Reply-To: <20120716084002.GN7955@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

-----Original Message-----
From: Felipe Balbi <balbi@ti.com>
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Felipe Balbi <balbi@ti.com>, "linux-
omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Mon, 16 Jul 2012 11:40:03 +0300
Subject: Re: PM/UART 3.5-rc5: UART Rx wakeups not quite right?

> Hi,
> 
> On Thu, Jul 05, 2012 at 07:32:30AM -0700, Kevin Hilman wrote:
> > "Joe Woodward" <jw@terrafix.co.uk> writes:
> > 
> > > Are there any patches floating around to fix UART Rx wakeups for
> 3.5?
> > >
> > > I have a GUMSTIX Overo with various things hanging off the UARTs,
> one
> > > of which (on ttyO0) sends in periodic (GPS) data.
> > >
> > > I don't want this data to wake the OMAP from system suspend.
> > >
> > > I would normally disable UART Rx wakeup for ttyO0:
> > > # echo "disabled" > /sys/devices/platform/omap_uart.0/power/wakeup
> > >
> > > This works on 3.5-rc5 (i.e. I can suspend, and not immediately
> wake) UNTIL
> > > I run an application that opens /dev/ttyO0.
> > >
> > > At this point when entering system suspend ttyO0 wakes the OMAP up
> > > immediately, even though the SYSFS reports the wakeup as
> "disabled".
> > >
> > > Any ideas?
> > 
> > Sounds like a bug.
> > 
> > Unfortunately, the OMAP UART driver is currently without an owner as
> far
> > as I know.
> > 
> > Felipe, who is looking after the UART driver now?
> 
> you said it right. It's without an owner. Joe, any chance you could
> help
> by bisecting the problem down to a commit ?
> 
> -- 
> balbi

It's a bit more complicated than just doing a bisect.

Basically using SYSFS to enable/disable wake-from-UART worked in 3.3. This broke in 
3.4, but Govindraj.R cooked up some patches to try to get it going again. There was lots 
of discussion, but it seems these patches never made it anywhere.

I was (incorrectly) assuming this would be fixed in 3.5.

After hunting through the mailing lists I've found this version of his patches:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/096013.html

I applied these to 3.4:
[PATCH v2] tty: omap-serial: configure wakeup mechanism based on port usage. [1]
[PATCH] tty: serial_core: Utilise/Enable the set_wake uart ops [2]
[PATCH 1/2 v4] ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level 
wakeup events [3]
[PATCH v3 2/2] ARM: omap3: pm: Remove uart module level wakeup configurations [4]

They seem to stop wake-from-UART for 3.4 (which is all I need), but I'm not sure they 
are actually working (as I can't then enable wake-from-UART via the SYSFS).

When these patches are applied to 3.5rc7 things go a bit wrong. Wakeup's from the 
UART are stopped, but normal IO wakeups now take seconds to respond, and 
occassionaly I can't get out of suspend at all.

There is a later version of these patches[5] based on "git://git.pwsan.com/linux-2.6 
hwmod_soc_conditional_cleanup_3.5". However, as far as I can tell the first of these 
does not apply.

So basically, I would like to get back to the 3.3 behaviour of having control of the wake-
from-UART via SYSFS, or at least to be able to disable wake-from-UART completely...

Cheers,
Joe


[1] http://marc.info/?l=linux-omap&m=133527588923598&w=2
[2] http://marc.info/?l=linux-omap&m=133518614022144&w=2
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/096162.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/096012.html
[5] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/098524.html



