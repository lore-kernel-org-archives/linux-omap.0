From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Tue, 4 Jan 2011 15:17:21 -0800
Message-ID: <20110104231721.GO7771@atomide.com>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
 <87aajg7dzu.fsf@ti.com>
 <1294181154.18162.39.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10609 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab1ADXR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 18:17:28 -0500
Content-Disposition: inline
In-Reply-To: <1294181154.18162.39.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110104 14:45]:
> On Tue, 2011-01-04 at 09:52 -0800, Kevin Hilman wrote:
> > Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> > 
> > > In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
> > > updating reg and l values. However, at the end of the function we
> > > perform a write:
> > >
> > > 	__raw_writel(l, reg);
> > >
> > > So on OMAP2+ we end up writing 0 to the bank->base which is not
> > > correct (typically this points to GPIO_REVISION register).
> > >
> > > Fix this by returning immediately after call to
> > > set_24xx_gpio_triggering().
> > >
> > > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > 
> > Acked-by: Kevin Hilman <khilman@ti.com>
> > 
> > Tony, this should be added to omap-for-linus as it fixes a problem in
> > the recently merged GPIO omap_device/hwmod conversion.
> 
> On second thought, it's a bit late for the main 2.6.38 window, so will
> queue this in my pm-fixes branch for the .38-rc cycle.

Yeah let's not mess with omap-for-linus right now, but instead start
queueing up fixes for -rc1.

Tony
