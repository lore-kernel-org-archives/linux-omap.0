From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 0/8] Updates for i2c-omap from linux-omap tree
	for review, v2
Date: Mon, 29 Sep 2008 23:23:10 +0100
Message-ID: <20080929222310.GP2716@fluff.org.uk>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:54780 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751477AbYI2WXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 18:23:15 -0400
Content-Disposition: inline
In-Reply-To: <1222329234-31473-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

On Thu, Sep 25, 2008 at 10:53:46AM +0300, Tony Lindgren wrote:
> Hi all,
> 
> Here's a repost of the whole series, the first series had a compile
> error starting with one of the patches. Sorry for the extra noise.
> 
> This series contains pending i2c-omap patches from linux-omap tree
> for review.
> 
> Looks like we've managed to pile up stuff in the omap tree for this
> driver again... Anyways, future patches will be coming straight via
> the i2c list.
> 
> The first two patches could be pushed as fixes to current -rc series,
> but I'm fine with them going in later too.

It is too late in the -rc series, and it will be easier to push the
lot in one go.
 
> I've left out some clean-up from the last patch so it won't conflict with
> omap ioremp changes that are currently in Russell King's devel
> branch.

If you can provide an url to a git tree to pull, that'd be great,
otherwise I'll apply from the series unless anyone else decides
there are problems with it.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
