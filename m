From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
Date: Mon, 2 Jun 2014 09:38:41 -0700
Message-ID: <20140602163841.GC11004@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1>
 <20140528180607.GB4707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30675 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491AbaFBQiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2014 12:38:46 -0400
Content-Disposition: inline
In-Reply-To: <20140528180607.GB4707@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140528 11:11]:
> * Lee Jones <lee.jones@linaro.org> [140528 00:14]:
> > Thanks Tony, here's the pull-request:
> > 
> > The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:
> > 
> >   Linux 3.14 (2014-03-30 20:40:15 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-omap-v3.16-1
> > 
> > for you to fetch changes up to 43fef47f94a1ae46fb2720dada32fa3b5547bee2:
> > 
> >   mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle (2014-05-28 08:06:18 +0100)
> > 
> > ----------------------------------------------------------------
> > Second immutable branch between MFD and OMAP due for the v3.16 merge window.
> 
> Thanks a lot, this will make it easier for me to chase down potential
> PM related regressions ;) I'm merging this for testing only into the
> linux-omap master branch, no need for me to include it into any
> of my upstream heading branches.

Lee, I'm not seeing this in linux next, did you maybe forget to merge
it into the MFD tree?

Regards,

Tony
