From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Tue, 11 Mar 2014 09:28:16 -0700
Message-ID: <20140311162816.GB7177@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com>
 <20140307164929.GC3789@atomide.com>
 <531DBCA8.80507@ti.com>
 <20140310154105.GA4882@atomide.com>
 <531EE25B.9060201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15627 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaCKQ2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2014 12:28:25 -0400
Content-Disposition: inline
In-Reply-To: <531EE25B.9060201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140311 03:19]:
> On 10/03/14 17:41, Tony Lindgren wrote:
> 
> >>> How about do a pull request for just the .dts changes against current
> >>> omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assuming
> >>> that just the .dts changes alone won't break anything.
> >>
> >> Unfortunately they do break. At least pinmuxing is moved from the global
> >> definitions to be handled by the respective display drivers, and there
> >> are some regulator_name hacks that the DT patches remove.
> > 
> > OK. Will that cause regressions for omap3 as that's still also booting
> > in legacy mode?
> 
> No, I don't think so. The problems revolve around the pdata-quirks, with
> current DSS support when booting with DT. It's rather difficult to split
> the series so that it could be merged freely in multiple parts.
> 
> If I split the series into three parts: 1) .dts changes 2) main DSS DT
> changes 3) removal of pdata-quirks etc, I run into problems. Both 1) and
> 2) work fine individually, but when both are merged, there are two
> competing systems, the proper DT stuff and the pdata-quirks stuff. And I
> haven't found out a simple way to manage that, as the whole display
> support is split into multiple independent devices.
> 
> One option would be to combine 1) and 3), so that when they are merged,
> there would be proper DT data, and the pdata-quirks would be removed so
> that it wouldn't be messing everything up. But that would, of course,
> mean that after merging 1+3, the display wouldn't work on those boards
> that rely on pdata-quirks, until 2) is merged.

OK, best to keep the series together then.
 
> >> I think those changes could be removed from my patches, and then added
> >> back later when everything else has been merged.
> > 
> > Or you could have a second branch that also merges in omap-for-v3.15/dt
> > branch that you can send later towards the merge window after the arm-soc
> > changes have been merged. If you want to do that, then feel free to add
> > my ack also for the .dts changes:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > If however those changes get postponed to v3.16, it's best that you'll
> > redo the branch as I'm sure we'll have other merge issues for v3.16.
> 
> Ok. At the moment I feel that the easiest option would be to keep the
> DSS DT series as it is, but merge omap-for-v3.15/dt to it and solve the
> conflicts. I'd keep that branch separate from the fbdev changes, so that
> I could send the DSS DT pull request later, when arm-soc has been pulled.

OK makes sense to me.
 
> >> The bigger issue is that suddenly there's lots of discussion about the
> >> display DT bindings. If those are not resolved very soon, I guess I have
> >> no choice but to again skip the merge window for the DSS DT changes.
> > 
> > OK, some of these more bindings can take easily six months to reach
> > some kind of resolution. You may be able to use TI specific unstable
> > bindings meanwhile if that makese sense.
> 
> Yep. I don't know... If the whole port/endpoint system that I currently
> use is changed totally, it might be painful to support both the TI
> specific bindings with the old format and the newer format.

OK that's up you guys in the display land, I have not followed the
latest bindings discussion.

Regards,

Tony
