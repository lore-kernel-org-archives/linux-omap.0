From: Tony Lindgren <tony@atomide.com>
Subject: Re: LDP support
Date: Tue, 28 Apr 2009 15:42:37 -0700
Message-ID: <20090428224237.GT22457@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61639 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZD1Wmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 18:42:45 -0400
Content-Disposition: inline
In-Reply-To: <20090428220712.GF29277@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
> Tony, et.al.,
> 
> Any ideas when more LDP support will be pushed into mainline (such as
> the framebuffer support)?

I'll be looking at the board-*.c patches for the next merge window
hopefully this week or next week.

Looks like LDP keyboard, touchscreen & RTC are pretty much ready
to go. Then the MMC has some regulator updates, but AFAIK the MMC
should work OK already.

For the framebuffer, Imre and Tomi know the status the best, so
I've added them to Cc.

Imre has been meaning to send a bunch of drivers/video/omap changes
to the fbdev list for a while now and LDP framebuffer may depend on
those. Imre, any news on the status of sending the fb patches
upstream?

Then there are the upcoming DSS patches from Tomi, but those still
need some work before they're ready to go.

Regards,

Tony
