From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAP: board file changes for DSS2 porting
Date: Wed, 11 May 2011 10:08:14 +0300
Message-ID: <20110511070813.GB4348@atomide.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
 <1304960499.2215.49.camel@deskari>
 <20110510133543.GJ30958@atomide.com>
 <1305036223.2045.74.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24465 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757271Ab1EKQOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 May 2011 12:14:48 -0400
Content-Disposition: inline
In-Reply-To: <1305036223.2045.74.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110510 17:00]:
> On Tue, 2011-05-10 at 16:35 +0300, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [110509 19:58]:
> > 
> > Do the dss platform data code coalescing patches affect these?
> 
> Do you mean the recent discussions about DSS regulator stuff? If so, no.
> These patches do not introduce any regulator uses.

OK
 
> > We just hate positive diffstats for arch/arm/*omap*/ for the upcoming
> > merge window :)
> 
> Well... I know, but if we want to port the old drivers to DSS2 it really
> can't be helped. The display device definitions in the board files are
> probably a bit more verbose with DSS2 than with old omapfb, due to more
> features and better configurability.
> 
> That said, if you want to calm down the arch/arm/*omap* changes for this
> merge window I can just postpone these (and some other display related
> board changes in dss2 tree) to the next one. They are not critical in
> any way regarding DSS2 development, they just would help us to clean up
> the old omapfb code (which probably won't affect arch/arm/*omap* much).

Let's do that, I guess that's your v2 of the set. Then we can have a
separate branch for the new code that we can then merge when we can.
 
> Speaking of which, the include file for DSS2 currently resides in
> arch/arm/plat-omap/include/plat/display.h. I guess this is not right
> place for it, as the driver itself is in drivers/, even if the driver is
> OMAP-only driver?

Yes it could be moved.
 
> > Also, these patches should also be posted to linux-arm-kernel list for
> > review before I can apply.
> 
> Ok. Should all arch/arm/*omap* code be posted to linux-arm-kernel also?
> I feel like spamming if I mail the patches to three different mailing
> lists =).

Yes, that way people on linux-arm-kernel can also review them.

Regards,

Tony
