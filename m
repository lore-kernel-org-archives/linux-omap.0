From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Mon, 10 Mar 2014 08:41:06 -0700
Message-ID: <20140310154105.GA4882@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com>
 <20140307164929.GC3789@atomide.com>
 <531DBCA8.80507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35479 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754398AbaCJPlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 11:41:15 -0400
Content-Disposition: inline
In-Reply-To: <531DBCA8.80507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140310 06:26]:
> On 07/03/14 18:49, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 23:32]:
> >> Hi Tony,
> >>
> >> On 21/01/14 12:56, Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> Here's version 3 of the DSS DT series.
> >>
> >> Can you have a look at the arch/arm/ parts in the series and ack if
> >> they're ok, i.e, patches 1, 2, 32.
> > 
> > Patches 1, 2 & 32 look OK to me, so for those please feel free to add:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks.
> 
> > How about do a pull request for just the .dts changes against current
> > omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assuming
> > that just the .dts changes alone won't break anything.
> 
> Unfortunately they do break. At least pinmuxing is moved from the global
> definitions to be handled by the respective display drivers, and there
> are some regulator_name hacks that the DT patches remove.

OK. Will that cause regressions for omap3 as that's still also booting
in legacy mode?
 
> I think those changes could be removed from my patches, and then added
> back later when everything else has been merged.

Or you could have a second branch that also merges in omap-for-v3.15/dt
branch that you can send later towards the merge window after the arm-soc
changes have been merged. If you want to do that, then feel free to add
my ack also for the .dts changes:

Acked-by: Tony Lindgren <tony@atomide.com>

If however those changes get postponed to v3.16, it's best that you'll
redo the branch as I'm sure we'll have other merge issues for v3.16.
 
> The bigger issue is that suddenly there's lots of discussion about the
> display DT bindings. If those are not resolved very soon, I guess I have
> no choice but to again skip the merge window for the DSS DT changes.

OK, some of these more bindings can take easily six months to reach
some kind of resolution. You may be able to use TI specific unstable
bindings meanwhile if that makese sense.

Regards,

Tony
