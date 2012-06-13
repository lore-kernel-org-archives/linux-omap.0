From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Wed, 13 Jun 2012 05:55:44 -0700
Message-ID: <20120613125543.GU12766@atomide.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <20120612064757.GE12766@atomide.com>
 <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14896 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab2FMMzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:55:47 -0400
Content-Disposition: inline
In-Reply-To: <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com

* Zumeng Chen <zumeng.chen@gmail.com> [120612 09:41]:
> 2012/6/12 Tony Lindgren <tony@atomide.com>
> 
> > * Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> > > If we don't set proper debouce time for ads7846, then there are
> > > flooded interrupt counters of ads7846 responding to one time
> > > touch on screen, so the driver couldn't work well.
> > >
> > > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > > to omap_ads7846_init, so it's more proper to set it in driver level
> > > after having gpio_request done.
> > >
> > > This patch has been validated on 3530evm.
> > >
> > > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> > Please remove my Signed-off-by, where does that come from?
> >
> HI Tony,
> 
> This comes from git://arago-project.org/git/projects/linux-omap3.git
> The commit ID is 53c5ec31, we set gpio_debounce in arch/board
> level.

Weird, I have no recollection of doing anything with that file..
Just remove my Signed-off-by please.

Tony
