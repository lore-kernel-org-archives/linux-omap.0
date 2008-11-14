From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Fri, 14 Nov 2008 02:35:58 +0200
Message-ID: <20081114002948.GB19711@frodo>
References: <200811071645.15687.david-b@pacbell.net> <20081113222626.GM3106@atomide.com> <200811131615.09767.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54180 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbYKNAgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 19:36:06 -0500
Content-Disposition: inline
In-Reply-To: <200811131615.09767.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Thu, Nov 13, 2008 at 04:15:09PM -0800, David Brownell wrote:
> On Thursday 13 November 2008, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [081107 16:45]:
> > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > Minor cleanup to twl4030-core: define a helper function to populate
> > > a single child node, and use it to replace six inconsistent versions
> > > of the same logic.  Both object and source code shrink.
> > > 
> > > As part of this, some devices now have more IRQ resources:  battery
> > > charger, keypad, ADC, and USB transceiver.  That will help to remove
> > > some irq #defines that prevent this code from compiling on non-OMAP
> > > platforms.
> > 
> > Pushing to linux-omap tree while waiting for this to fall down from
> > mainline tree via Samuel's queue.
> 
> Hmm, better to revert this and send the updated version I sent
> as part of the regulator series... that returns the platform
> device, which is useful in setting up consumers of the regulator
> devices.
> 
> I hadn't gotten any test results other than knowing Felipe was
> using this.  So I'll hold off a bit on sending the updated
> patch to Samuel, probably till end-of-week, on the grounds that
> the keypad, battery, and ADC devices didn't get tested yet.

The new add_child() works quite ok and simplifies a lot the code. But
the regulator driver, I think we can hold a bit as that needs careful
testing.

-- 
balbi
