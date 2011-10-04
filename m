From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP DSS related board changes
Date: Mon, 3 Oct 2011 17:32:02 -0700
Message-ID: <20111004003202.GO6324@atomide.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
 <1317019053.1956.10.camel@deskari>
 <20110929175232.GI6324@atomide.com>
 <1317360043.1867.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47435 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752154Ab1JDAcF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 20:32:05 -0400
Content-Disposition: inline
In-Reply-To: <1317360043.1867.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110929 21:47]:
> On Thu, 2011-09-29 at 10:52 -0700, Tony Lindgren wrote:
> > 
> > Also, you might want to start looking into passing the configuration
> > from DT instead to avoid the platform init code. Probably the
> > panel configuration would be the place to start with that?
> 
> I haven't actually looked at DT yet, but one reason I've been writing
> and pushing these old omapfb cleanups is to get all omap2+ boards use
> the new dss driver, and thus hopefully making DT adaptation easier as I
> can (for now) ignore the old omapfb and omap1 boards regarding DT.

Right, makes sense.
 
> But yes, I definitely need to look at DT. Is there a driver to be used
> as a sample when looking at DT?

At this point maybe just see what's in mainline in arch/arm/boot/dts
and work your way back from there. The DT data should be pretty much
just registers and stay operating system independent. So some of these
things still need to be glued together by the bus/hwmod/driver probe
code.

Regards,

Tony
