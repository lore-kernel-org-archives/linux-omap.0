From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Thu, 13 Nov 2008 16:15:09 -0800
Message-ID: <200811131615.09767.david-b@pacbell.net>
References: <200811071645.15687.david-b@pacbell.net> <20081113222626.GM3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:29094 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751198AbYKNAPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 19:15:13 -0500
In-Reply-To: <20081113222626.GM3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Thursday 13 November 2008, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [081107 16:45]:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Minor cleanup to twl4030-core: define a helper function to populate
> > a single child node, and use it to replace six inconsistent versions
> > of the same logic.  Both object and source code shrink.
> > 
> > As part of this, some devices now have more IRQ resources:  battery
> > charger, keypad, ADC, and USB transceiver.  That will help to remove
> > some irq #defines that prevent this code from compiling on non-OMAP
> > platforms.
> 
> Pushing to linux-omap tree while waiting for this to fall down from
> mainline tree via Samuel's queue.

Hmm, better to revert this and send the updated version I sent
as part of the regulator series... that returns the platform
device, which is useful in setting up consumers of the regulator
devices.

I hadn't gotten any test results other than knowing Felipe was
using this.  So I'll hold off a bit on sending the updated
patch to Samuel, probably till end-of-week, on the grounds that
the keypad, battery, and ADC devices didn't get tested yet.

- Dave
