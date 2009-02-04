From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2-omap1-git 0/7] regulator and MMC updates...
Date: Wed, 4 Feb 2009 15:20:40 -0800
Message-ID: <200902041520.41100.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net> <20090204192725.GN7215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:46180 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754720AbZBDXUn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 18:20:43 -0500
In-Reply-To: <20090204192725.GN7215@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Wednesday 04 February 2009, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [090120 03:01]:
> > Several patches here:
> > 
> >  - New interface in regulator core ... in the regulator queue
> >    (presumably for 2.6.30 merge)
> > 
> >  - twl4030 regulator updates to use that interface

And now that you've merged that ... I'll send the twl4030 regulator
code up for 2.6.30 merge-to-mainline.


> > Given that second part, I think the twl4030 regulator code can
> > be submitted upstream.
> > 
> >  - Init updates for OMAP 3430 SDP ... regulators, MMC switches,
> >    and a bit more.
> > 
> >  - Minor Overo init update:  set up VMMC1
> > 
> >  - HSMMC init update:  pass device back so regulator setup can
> >    use it.  (Not as invasive as a cleaner fix would be...)
> > 
> >  - Beagle init update:  hook up the regulators used by MMC-1
> >    (relies on that init update)
> > 
> >  - SDP init update:  hook up regulators used by MMC-1 and MMC-2
> >    (also relies on that init update)
> > 
> > These go on top of patches I sent previously, to work around
> > a lockdep issue in the hsmmc driver (that might go to mainline
> > as a bugfix, assuming that driver goes to mainline for 2.6.29)
> > and correct the mach-omap2/mmc-twl4030.c power switching.
> > 
> > Once that's merged, it'll be ready to start using the regulator
> > calls to switch power for MMC on at least those platforms.
> 
> Pushing this series to l-o tree. Again, let me know what to add to the
> upstream queues (and when).

Those last five can go whenever you're ready ... assuming
nobody finds any trouble they cause.

- Dave


> 
> Regards,
> 
> Tony
> 
> 


