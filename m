From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] Urgent omap timer fix for current merge window
Date: Tue, 7 May 2013 08:04:38 -0700
Message-ID: <20130507150438.GQ28721@atomide.com>
References: <20130506234610.GK28721@atomide.com>
 <201305071448.19868.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25656 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab3EGPEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 11:04:43 -0400
Content-Disposition: inline
In-Reply-To: <201305071448.19868.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Arnd Bergmann <arnd@arndb.de> [130507 05:54]:
> On Tuesday 07 May 2013, Tony Lindgren wrote:
> > The following changes since commit dc2d3db8137fba0f62d7517e1bea8a47f69fcbc4:
> > 
> >   Merge tag 'omap-for-v3.10/timer-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/drivers (2013-04-08 19:30:48 +0200)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window
> > 
> > for you to fetch changes up to 08a48be32ff31d38bcfec7d210c954cb62fd5cd7:
> > 
> >   ARM: OMAP4: change the device names in usb_bind_phy (2013-05-06 16:39:16 -0700)
> > 
> > ----------------------------------------------------------------
> > An urgent fix for a timer mismerge for and a regression fix for
> > musb device naming change.
> > 
> 
> Hi Tony,
> 
> Russell also ran into this problem, so I'm including these in the late/cleanup branch,
> which I'll send to Linus later today.

Thanks!

Tony
