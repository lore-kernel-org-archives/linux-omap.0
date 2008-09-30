From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 0/8] Updates for i2c-omap from linux-omap tree
	for review, v2
Date: Tue, 30 Sep 2008 08:35:34 +0300
Message-ID: <20080930053533.GB2779@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <20080929222310.GP2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50449 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYI3FdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 01:33:13 -0400
Content-Disposition: inline
In-Reply-To: <20080929222310.GP2716@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

* Ben Dooks <ben-linux@fluff.org> [080930 01:23]:
> On Thu, Sep 25, 2008 at 10:53:46AM +0300, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's a repost of the whole series, the first series had a compile
> > error starting with one of the patches. Sorry for the extra noise.
> > 
> > This series contains pending i2c-omap patches from linux-omap tree
> > for review.
> > 
> > Looks like we've managed to pile up stuff in the omap tree for this
> > driver again... Anyways, future patches will be coming straight via
> > the i2c list.
> > 
> > The first two patches could be pushed as fixes to current -rc series,
> > but I'm fine with them going in later too.
> 
> It is too late in the -rc series, and it will be easier to push the
> lot in one go.

OK

> > I've left out some clean-up from the last patch so it won't conflict with
> > omap ioremp changes that are currently in Russell King's devel
> > branch.
> 
> If you can provide an url to a git tree to pull, that'd be great,
> otherwise I'll apply from the series unless anyone else decides
> there are problems with it.

Thanks for looking, I'll fix the issues you commented on and will
repost. It may take a few days before I can get back on this again
though.

Tony
