From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 board code in 3.14
Date: Thu, 21 Nov 2013 10:58:45 -0800
Message-ID: <20131121185844.GA10023@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
 <20131116141226.GD10317@atomide.com>
 <20131116155031.GA5104@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44915 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab3KUS6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 13:58:47 -0500
Content-Disposition: inline
In-Reply-To: <20131116155031.GA5104@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@ring0.de> [131116 07:51]:
> On Sat, Nov 16, 2013 at 06:12:26AM -0800, Tony Lindgren wrote:
> > [...]
> > >  b) I could not get the 32GB eMMC working. For me the chip is not found
> > >     and I don't know how to debug it.
> > 
> > OK the eMMC issue might be related to the control module PBIAS
> > register support missing. If so, that should be fixable with the
> > auxdata until we have a minimal control module device driver to
> > deal with the PBIAS and expose those features as regulators to
> > the omap-hsmmc driver.
> 
> I wasn't aware, that PBIAS register support is missing for DT
> boot. The existing board code uses a 2.8-3.0V regulator for mmc1,
> so missing PBIAS is probably the problem.

Right, sorry I was confused, looks like we don't need to worry about
that. And looks like Balaji just posted patches for the PBIAS support.

Also, I just posted a patch to fix the eMMC that you may want to
try out.
 
> > > [...]
> > > 
> > > My suggestion would be:
> > >  1. Find a better workaround for omapdss to acquire the SDI
> > >     regulator. My current hack is obviously not acceptable.
> > >  2. Load the panel driver via DT as seen above and reference
> > >     the omapdss interface with something like the above
> > >     "ti,dss-source".
> > 
> > To me it seems that we should be able to add minimal panel entries to DT
> > if we stick to existing standard bindings. Then the timings etc can be
> > set up based on the compatible flag. So I would leave out the properties
> > for ti,sdi-datapairs and ti,dss-source for now, and just set those in
> > the driver based on the sony,acx565akm compatible flag. Or maybe it should
> > be sony,acx565akm-n900 if there's some board specific configuration info.
> 
> So we add reset-gpio and label to the DT data (they are panel
> specific and independent of omapdss) and just hardcode "dsi.0"
> with 2 data lanes into the driver? That sounds fine for me.
> 
> If neither Tomi nor anybody else has better ideas I will cook a
> patch for that. I'm not sure how to setup the vdds_sdi regulator for
> omapdss, though. Is there an example for a legacy driver using a DT
> regulator available?

Not that I know of :) But I guess only the panel driver would need to
parse the compatible flag and the rest of the DSS could still be
initialize the legacy way if needed.

Regards,

Tony
