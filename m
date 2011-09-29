From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP DSS related board changes
Date: Thu, 29 Sep 2011 10:52:32 -0700
Message-ID: <20110929175232.GI6324@atomide.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
 <1317019053.1956.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41383 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab1I2Rwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Sep 2011 13:52:34 -0400
Content-Disposition: inline
In-Reply-To: <1317019053.1956.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110925 23:04]:
> On Tue, 2011-09-20 at 11:18 +0300, Tomi Valkeinen wrote:
> > Hi Tony,
> > 
> > Here is a bunch of board file patches related to DSS. They have all been sent
> > for review earlier, and are currently in my tree. Some of them depend on DSS
> > driver changes, so I'd like to keep them there to avoid compilation errors
> > (these won't compile if you apply them without patches from DSS tree).
> > 
> > Can you give your ack for these? Alternatively we can see which of these could
> > go through your tree and I can make a new set.
> 
> Tony, ping. I'd like to get these in for 3.2, as many DSS driver patches
> depend on some of these.

Sorry for the delay. Looks like these will conflict with your
earlier patches I have in the board branch and other cleanup.

I'll drop the earlier patches from my board branch so you can
queue all of them:

OMAP: Apollon: Port the display driver to new DSS2
OMAP: H4: Port the display driver to new DSS2
OMAP: LDP: Port the display driver to new DSS2
OMAP: 2420SDP: Port the display driver to new DSS2
OMAP: omap3touchbook: Remove unused lcd stuff
OMAP: RX51: Remove unused old omapfb stuff

Your new patches all look OK to me, just please check what we
have in omap cleanup branch as we don't have all that queud up
yet in next.

It's likely these will need to be rebased on those, so maybe wait
a bit with these or adjust them accordingly if possible.

Also, you might want to start looking into passing the configuration
from DT instead to avoid the platform init code. Probably the
panel configuration would be the place to start with that?

So for all of them:

Acked-by: Tony Lindgren <tony@atomide.com>

 
> > Thomas Weber (1):
> >   OMAP: Devkit8000: Change lcd driver to AT070TN83
> > 
> > Tomi Valkeinen (9):
> >   OMAP: DSS2: Change DSI device naming
> >   OMAP4: TWL: Add common omapdss supplies
> >   OMAP: DSS2: HDMI: use default dividers
> >   OMAP: use dvi panel driver instead of generic-dpi
> >   OMAP: stalker: Remove LCD device from board file
> >   OMAP: Add DDC i2c_bus_num to board files
> >   OMAP: 4430SDP: Remove unneeded lcd config
> >   OMAP4: 4430SDP: Add panel support to board file
> >   OMAP4: 4430SDP: Add picodlp support to board file
> > 
> >  arch/arm/mach-omap2/board-3430sdp.c      |    7 +-
> >  arch/arm/mach-omap2/board-4430sdp.c      |  208 ++++++++++++++++++++++++++----
> >  arch/arm/mach-omap2/board-am3517evm.c    |    6 +-
> >  arch/arm/mach-omap2/board-cm-t35.c       |    6 +-
> >  arch/arm/mach-omap2/board-devkit8000.c   |   10 +-
> >  arch/arm/mach-omap2/board-igep0020.c     |    8 +-
> >  arch/arm/mach-omap2/board-omap3beagle.c  |    8 +-
> >  arch/arm/mach-omap2/board-omap3evm.c     |    7 +-
> >  arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
> >  arch/arm/mach-omap2/board-omap3stalker.c |   40 +------
> >  arch/arm/mach-omap2/board-omap4panda.c   |    8 +-
> >  arch/arm/mach-omap2/board-overo.c        |    7 +-
> >  arch/arm/mach-omap2/display.c            |    6 +-
> >  arch/arm/mach-omap2/twl-common.c         |   11 ++-
> >  14 files changed, 230 insertions(+), 104 deletions(-)
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
