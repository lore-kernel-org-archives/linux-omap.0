From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: smp: Select local timers vs dummytimersupport runtime
Date: Wed, 23 Feb 2011 22:08:52 +0530
Message-ID: <780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
 <20110220110341.GA15494@n2100.arm.linux.org.uk> <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
 <20110223163635.GA16041@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54249 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754734Ab1BWQjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 11:39:05 -0500
Received: by mail-qy0-f173.google.com with SMTP id 36so3671658qyk.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 08:39:04 -0800 (PST)
In-Reply-To: <20110223163635.GA16041@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Wednesday, February 23, 2011 10:07 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com; David Brown; Daniel
> Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs
> dummytimersupport runtime
>
> On Sun, Feb 20, 2011 at 04:37:36PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Sent: Sunday, February 20, 2011 4:34 PM
> > > To: Santosh Shilimkar
> > > Cc: linux-omap@vger.kernel.org; khilman@ti.com; linux-arm-
> > > kernel@lists.infradead.org; tony@atomide.com; David Brown;
> Daniel
> > > Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm;
> Colin
> > > Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> > > Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs dummy
> > > timersupport runtime
> > >
> > > On Sat, Feb 12, 2011 at 04:59:43PM +0530, Santosh Shilimkar
> wrote:
> > > > -#ifndef CONFIG_LOCAL_TIMERS
> > > >  static void broadcast_timer_set_mode(enum clock_event_mode
> mode,
> > > >  	struct clock_event_device *evt)
> > > >  {
> > > >  }
> > > >
> > > > -static void local_timer_setup(struct clock_event_device *evt)
> > > > +static void dummy_timer_setup(struct clock_event_device *evt)
> > >
> > > Please call this broadcast_timer_setup().
> >
> > Right. Will fix this.
>
> Grr.  This conflicts horribly with the Versatile stuff.  Can you
> recreate
> against what currently appears in devel rather than mainline please?
Ok. I will pull your devel branch and rebase it
