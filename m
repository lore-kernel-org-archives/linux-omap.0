From: Tony Lindgren <tony@atomide.com>
Subject: Re: RX-51: Platform support for lp5523
Date: Tue, 29 Mar 2011 12:33:01 -0700
Message-ID: <20110329193301.GP4016@atomide.com>
References: <20110329172922.GA19494@earth.universe>
 <20110329173647.GK4016@atomide.com>
 <20110329181615.GA20371@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63730 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1C2TdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 15:33:04 -0400
Content-Disposition: inline
In-Reply-To: <20110329181615.GA20371@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

* Sebastian Reichel <sre@debian.org> [110329 11:13]:
> On Tue, Mar 29, 2011 at 10:36:47AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [110329 10:26]:
> > > Is there any reason, that the rx51 platform code does not support
> > > the lp5523 chip? The chip driver itself is in the mainline kernel
> > > since 2.6.37-rc2.
> > 
> > Got a patch for that? As always, patches related to blinking leds
> > have a special high priority here! :)
> 
> Ameya Palande has written one, which is available at [0]. I added
> him to CC, so that he can comment on mainline inclusion.

OK. Ameya, can you please post it for review for this list with
linux-arm-kernel list Cc'd?

Regards,

Tony
 
> [0] http://gitorious.org/nokia-n900-kernel/nokia-n900-kernel/commit/54caed7bdc7e9f5aa84fe50f3bc321fc1ef600ad?format=patch


