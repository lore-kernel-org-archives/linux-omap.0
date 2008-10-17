From: Tony Lindgren <tony@atomide.com>
Subject: git-pull request for i2c-omap changes (Re: [i2c] [PATCH 0/8]
	Updates for i2c-omap from linux-omap tree for review, v2)
Date: Fri, 17 Oct 2008 09:04:36 -0700
Message-ID: <20081017160436.GQ15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <20080929222310.GP2716@fluff.org.uk> <20080930053533.GB2779@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VB1oQhYtJt8uuzk+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60344 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbYJQQFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 12:05:12 -0400
Content-Disposition: inline
In-Reply-To: <20080930053533.GB2779@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org


--VB1oQhYtJt8uuzk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080929 22:33]:
> * Ben Dooks <ben-linux@fluff.org> [080930 01:23]:
> > On Thu, Sep 25, 2008 at 10:53:46AM +0300, Tony Lindgren wrote:
> > > Hi all,
> > > 
> > > Here's a repost of the whole series, the first series had a compile
> > > error starting with one of the patches. Sorry for the extra noise.
> > > 
> > > This series contains pending i2c-omap patches from linux-omap tree
> > > for review.
> > > 
> > > Looks like we've managed to pile up stuff in the omap tree for this
> > > driver again... Anyways, future patches will be coming straight via
> > > the i2c list.
> > > 
> > > The first two patches could be pushed as fixes to current -rc series,
> > > but I'm fine with them going in later too.
> > 
> > It is too late in the -rc series, and it will be easier to push the
> > lot in one go.
> 
> OK
> 
> > > I've left out some clean-up from the last patch so it won't conflict with
> > > omap ioremp changes that are currently in Russell King's devel
> > > branch.
> > 
> > If you can provide an url to a git tree to pull, that'd be great,
> > otherwise I'll apply from the series unless anyone else decides
> > there are problems with it.
> 
> Thanks for looking, I'll fix the issues you commented on and will
> repost. It may take a few days before I can get back on this again
> though.

Sorry for the delay in fixing these issues. Hopefully there's still
some time to get these in..

The minimal omap34xx support hit mainline yesterday, so if these
still can get integrated, people will be able to work on a bunch of
related drivers against the mainline.

This would enable at least drivers/mfd/twl4030*, and all the twl4030
related drivers. And also USB OTG for MUSB can be worked on. The twl4030
core code should be queued for integration, and MUSB stuff is already
integrated.

Regards,

Tony


--VB1oQhYtJt8uuzk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=pull

The following changes since commit 2e532d68a2b3e2aa6b19731501222069735c741c:
  Linus Torvalds (1):
        {pci,pnp} quirks.c: don't use deprecated print_fn_descriptor_symbol()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git i2c-for-ben

Chandra shekhar (1):
      i2c-omap: Add support for omap34xx

Jarkko Nikula (1):
      i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg

Nishanth Menon (1):
      i2c-omap: FIFO handling support and broken hw workaround for i2c-omap

Paul Walmsley (4):
      i2c-omap: Close suspected race between omap_i2c_idle() and omap_i2c_isr()
      i2c-omap: Mark init-only functions as __init
      i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
      i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()

Syed Mohammed Khasim (1):
      i2c-omap: Add high-speed support to omap-i2c

Tony Lindgren (1):
      i2c-omap: Clean-up i2c-omap

 arch/arm/mach-omap2/clock24xx.h |    4 +-
 drivers/i2c/busses/i2c-omap.c   |  335 ++++++++++++++++++++++++++++++---------
 2 files changed, 258 insertions(+), 81 deletions(-)

--VB1oQhYtJt8uuzk+--
