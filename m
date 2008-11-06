From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Thu, 06 Nov 2008 10:23:07 +0200
Message-ID: <1225959787.8052.27.camel@tubuntu>
References: <20081104160946.19071.44903.stgit@tubuntu>
	 <20081104161038.19071.98198.stgit@tubuntu>
	 <20081105122725.cb1c0b2f.jarkko.nikula@nokia.com>
	 <200811051521.48924.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62180 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbYKFIX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 03:23:29 -0500
In-Reply-To: <200811051521.48924.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Thu, 2008-11-06 at 01:21 +0200, ext David Brownell wrote:
> On Wednesday 05 November 2008, Jarkko Nikula wrote:
> > > +     r = gpio_request(beagle_display_data_dvi.panel_reset_gpio,
> "DVI reset GPIO");
> > > +     if(r < 0) {
> >
> > GPIO label "DVI reset" is enough.
> 
> Surely this ** doesn't work ** at least against the OMAP git tree
> which already has:

Well, it surely does! =)

But good catch, I'll fix it. There's probably a warning on kernel log
about "can't get a gpio".

> 
>         omap_cfg_reg(J25_34XX_GPIO170);
>         gpio_request(170, "DVI_nPD");
>         /* REVISIT leave DVI powered down until it's needed ... */
>         gpio_direction_output(170, true);
> 
> Label matches the DVI chip, not board schematics.  Agreed,
> it's not a reset.
> 
> I'd like to see any FB/DSS/... updates have the property that
> the TFP410 chip is powered down *unless* both (a) the frame
> buffer/DSS/... driver is active, and (b) the DVI channel is
> in use.
> 
> So for example a kernel without FB/DSS/... configured, that
> DVI chip is never powered up.  And when only the S-Video channel
> is used, DVI isn't powered up either.
> 
Well, my drivers do not enable the DVI chip unless DVI is in use. It is
in use by default, but you can turn it off. And if the whole DSS is not
compiled in, then no body will turn the DVI chip on.

However, the bootloader turns the DVI chip on (at least the default
beagle board u-boot). If the kernel by default turns the DVI chip off,
and then later on when the DSS starts, we'll have a glitch on the
display. Not that there currently is support for glitchless transition
from bootloader display to kernel display, but still...

> - Dave
> 
 Tomi

