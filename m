From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Fri, 13 Jul 2012 14:28:10 -0700
Message-ID: <20120713212810.GB20211@animalcreek.com>
References: <WC20120712081507.600002@terrafix.co.uk>
 <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com>
 <WC20120712144308.86003F@terrafix.co.uk>
 <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com>
 <WC20120713105737.0900A2@terrafix.co.uk>
 <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:41276 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2GMV2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 17:28:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Fri, Jul 13, 2012 at 12:26:13PM -0600, Paul Walmsley wrote:
> + Mark
> 
> On Fri, 13 Jul 2012, Joe Woodward wrote:
> 
> > Thanks Paul,
> > 
> > That patch does indeed seem to fix all my problems!
> > 
> > With it I can now suspend, and all power domains hit the target states.
> 
> OK, great.  That patch is basically a revert of 
> a819c4f16d5a2708c11e708fd59a96565c5384a8 ("ARM: OMAP3: PM: Only access IVA 
> if one exists").  Sounds like we need to discriminate between the case 
> where the IVA2 is present but has been efused off in some way (as in the 
> AM3703) vs. the case where the IVA2 is not present at all (as in the 
> AM35xx).
> 
> Mark, do you have the time to take a look at this?  Maybe omap3_has_iva() 
> needs to be split into omap3_has_iva() and omap3_has_usable_iva().  Or 
> maybe you can come up with a better idea...

Sure, I'll see what I can figure out.

Mark
