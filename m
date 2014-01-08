From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arm: omap2plus_defconfig: enable more drivers
Date: Wed, 8 Jan 2014 11:18:56 -0800
Message-ID: <20140108191856.GF31323@atomide.com>
References: <1382710831-5758-1-git-send-email-balbi@ti.com>
 <20131025144426.GA15154@atomide.com>
 <20131025155123.GF4400@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21697 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaAHTTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 14:19:00 -0500
Content-Disposition: inline
In-Reply-To: <20131025155123.GF4400@gimli>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [131025 08:51]:
> Hi,
> 
> On Fri, Oct 25, 2013 at 07:44:26AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [131025 07:20]:
> > > enable a few more drivers as modules on omap2plus_defconfig,
> > > this helps us getting more platforms working out of the box
> > > by just building omap2plus_defconfig.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > Hi Tony,
> > > 
> > > would you consider enabling these drivers ? I didn't, yet,
> > > make sure that these drivers won't cause PM regressions. Wanted
> > > to make sure you'd be ok enabling so many of them.
> > 
> > Sure, we should have all common drivers enabled, preferrably as
> > loadable modules where possible.
> > 
> > Probably at least MUSB gadgets need to be loadable modulees as at
> > least I have my test setup in a rack with USB cables connected
> > all the time. That way the PM tests can be done without the USB
> > modules loaded.
> > 
> > Or maybe we can just PM runtime suspend the USB drivers for PM
> > tests?
> 
> I'd rather just unload the drivers if they cause issues. The thing is
> that with a patch like $subject, we get more working out-of-the-box and
> since most everything is really already in mainline (at least after
> v3.13 merge window) except for DTS (which should go up on v3.14, all the
> pending stuff), then we should be in really good shape after enabling
> all the necessary modules.

Just to update the status on this, I've been hoping to get the
omap3 PM regression issues out of the way before enabling drivers
so we can test for the regressions easily. I've applied patches to
enable some of these in omap-for-v3.14/fixes-not-urgent, so this
patch will eventually need to be slightly updated.

Regards,

Tony
