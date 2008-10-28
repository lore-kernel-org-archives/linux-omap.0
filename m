From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers
	removed
Date: Tue, 28 Oct 2008 03:25:38 +0200
Message-ID: <20081028012538.GA32518@frodo>
References: <20081027204323.GA7539@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54243 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYJ1BZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2008 21:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20081027204323.GA7539@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 27, 2008 at 01:43:24PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> I've updated our git tree to 2.6.28-rc2, so please check that I did
> not mis-merge any of your code that's not yet in the mainline tree.
> 
> I've also removed the old omap audio and v4l drivers as we've discussed
> earlier. The development for these drivers should be happening in
> the alsa and v4l lists.
> 
> I'll be removing more old drivers, such as drivers/mtd and
> drivers/video.. But let's first figure out what we want to get merged
> upstream from there.

we should get anything out of drivers/i2c/chips since Jean wanna get rid
of that directory. So if you apply the patches I wrote to lp5521 I'm
fixing a few stuff and moving that driver to drivers/leds. After that I
could send that driver to Richard.

I'd also say the old 770 drivers should be kicked out as patches (on
muru.com??) and remerged via the proper subsystem maintainers.

n8x0 are still too "new" to do that, but we should get some more effort
in merging those drivers upstream. If anyone wanna help, that would be
really appreciated. I'll try to do what I can with my small spare time.

-- 
balbi
