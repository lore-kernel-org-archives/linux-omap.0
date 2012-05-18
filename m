From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Thu, 17 May 2012 17:10:04 -0700
Message-ID: <20120518001004.GJ17852@atomide.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
 <87y5oqtpnw.fsf@ti.com>
 <20120517231251.GH17852@atomide.com>
 <87mx56s6nz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:46747 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933088Ab2ERAKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 20:10:08 -0400
Content-Disposition: inline
In-Reply-To: <87mx56s6nz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120517 17:00]:
> 
> Argh, then $SUBJECT patch here has caused brokeness in multiple ways.
> It managed to break both runtime suspend and runtime resume at the same
> time. :(
> 
> The change added by this patch to runtime_suspend effectively disables
> the fix I did in 68942edb09 (gpio/omap: fix wakeups on level-triggered GPIOs)
> causing the sluggish network problems to reappear, since that GPIO IRQ
> is no longer causing wakeups.
>
> Simple fix is below, which just moves the check added in $SUBJECT patch
> below the workaround for the edge/level fix.  Can you confirm it works
> on Zoom3 (applies on gpio/next + my previous fix.)

Thanks yes having both of your fixes applied fixes the issues I was
seeing, so for both:

Tested-by: Tony Lindgren <tony@atomide.com>
 
> I didn't notice the same problem on Overo, but I guess it's because
> Overo had some enabled non-wakeup GPIOs in the same bank, so it didn't
> bypass the level-triggered IRQ fix.

Makes sense for why it only appears on some boards.
 
> In the mean time, they're availble in my for_3.5/fixes/gpio-2 branch.

I'll merge that also into l-o master for some more testing before
the merge window.

Regards,

Tony
