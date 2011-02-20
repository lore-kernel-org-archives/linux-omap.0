From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: smp: Select local timers vs dummy timersupport runtime
Date: Sun, 20 Feb 2011 16:37:36 +0530
Message-ID: <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com> <20110220110341.GA15494@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52426 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733Ab1BTLHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 06:07:39 -0500
Received: by mail-qw0-f41.google.com with SMTP id 7so1377774qwd.0
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 03:07:38 -0800 (PST)
In-Reply-To: <20110220110341.GA15494@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, February 20, 2011 4:34 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com; David Brown; Daniel
> Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs dummy
> timersupport runtime
>
> On Sat, Feb 12, 2011 at 04:59:43PM +0530, Santosh Shilimkar wrote:
> > -#ifndef CONFIG_LOCAL_TIMERS
> >  static void broadcast_timer_set_mode(enum clock_event_mode mode,
> >  	struct clock_event_device *evt)
> >  {
> >  }
> >
> > -static void local_timer_setup(struct clock_event_device *evt)
> > +static void dummy_timer_setup(struct clock_event_device *evt)
>
> Please call this broadcast_timer_setup().

Right. Will fix this.

Regards
Santosh
