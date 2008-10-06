From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 3/3] lp5521: move to drivers/leds
Date: Mon, 6 Oct 2008 15:54:57 +0300
Message-ID: <20081006125457.GA16255@kos.to>
References: <1223284291-7675-4-git-send-email-felipe.balbi@nokia.com> <20081006110851.GA8580@kos.to> <20081006111721.GE2806@atomide.com> <20081006115103.GN7437@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:56316 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbYJFMy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Oct 2008 08:54:58 -0400
Content-Disposition: inline
In-Reply-To: <20081006115103.GN7437@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Mathias Nyman <mathias.nyman@nokia.com>, rpurdie@rpsys.net

On Mon, Oct 06, 2008 at 02:51:03PM +0300, Felipe Balbi wrote:
> On Mon, Oct 06, 2008 at 02:17:23PM +0300, Tony Lindgren wrote:
> > * Riku Voipio <riku.voipio@iki.fi> [081006 14:09]:
> > > On Mon, Oct 06, 2008 at 12:11:31PM +0300, Felipe Balbi wrote:
> > > > This driver should be sitting together with the other
> > > > led drivers.
> > > 
> > > But this driver actually doesn't implement the led sysfs interface.
> > > If the driver is changed to implement the led framework interface,
> > > we break the existing n810 userland and expose only limited subset
> > > of lp5521 features for userland..
> > 
> > Maybe this feature should be a distro specific hack on top of
> > the mainline tree?
> 
> the problem is that led api (afaict) doesn't really have abstraction for
> rgb leds like the one we use. It can only handle blinky leds and on/off
> transitions and we need more functionality.

RGB can somewhat be handled, by creating three led devices:

n810:red:foo
n810:gree:foo
n810:blue:foo

blinking could also be done, but that would be suboptimal. Mainly
we would lose all the cool fading etc stuff than can be programmed
to run on lp5521 without main cpu intervention..

> This driver will probably loop around for a while until we find out that
> led api needs to be extended.

Or implement a minimal led api (off/brightness) as well as keep the
custom interface for time being, if that's ok with Richard (the led
subsystem maintainer).

-- 
"rm -rf" only sounds scary if you don't have backups
