From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/10] OMAP DSS related board changes
Date: Fri, 30 Sep 2011 08:20:43 +0300
Message-ID: <1317360043.1867.15.camel@deskari>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
	 <1317019053.1956.10.camel@deskari>  <20110929175232.GI6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48470 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1I3FUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 01:20:50 -0400
Received: by bkat2 with SMTP id t2so1902682bka.22
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 22:20:47 -0700 (PDT)
In-Reply-To: <20110929175232.GI6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-09-29 at 10:52 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110925 23:04]:
> > On Tue, 2011-09-20 at 11:18 +0300, Tomi Valkeinen wrote:
> > > Hi Tony,
> > > 
> > > Here is a bunch of board file patches related to DSS. They have all been sent
> > > for review earlier, and are currently in my tree. Some of them depend on DSS
> > > driver changes, so I'd like to keep them there to avoid compilation errors
> > > (these won't compile if you apply them without patches from DSS tree).
> > > 
> > > Can you give your ack for these? Alternatively we can see which of these could
> > > go through your tree and I can make a new set.
> > 
> > Tony, ping. I'd like to get these in for 3.2, as many DSS driver patches
> > depend on some of these.
> 
> Sorry for the delay. Looks like these will conflict with your
> earlier patches I have in the board branch and other cleanup.
> 
> I'll drop the earlier patches from my board branch so you can
> queue all of them:

Ok, I'll add them to dss branch.

> OMAP: Apollon: Port the display driver to new DSS2
> OMAP: H4: Port the display driver to new DSS2
> OMAP: LDP: Port the display driver to new DSS2
> OMAP: 2420SDP: Port the display driver to new DSS2
> OMAP: omap3touchbook: Remove unused lcd stuff
> OMAP: RX51: Remove unused old omapfb stuff
> 
> Your new patches all look OK to me, just please check what we
> have in omap cleanup branch as we don't have all that queud up
> yet in next.

Sure, will do.

> It's likely these will need to be rebased on those, so maybe wait
> a bit with these or adjust them accordingly if possible.
> 
> Also, you might want to start looking into passing the configuration
> from DT instead to avoid the platform init code. Probably the
> panel configuration would be the place to start with that?

I haven't actually looked at DT yet, but one reason I've been writing
and pushing these old omapfb cleanups is to get all omap2+ boards use
the new dss driver, and thus hopefully making DT adaptation easier as I
can (for now) ignore the old omapfb and omap1 boards regarding DT.

But yes, I definitely need to look at DT. Is there a driver to be used
as a sample when looking at DT?

> So for all of them:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

 Tomi


