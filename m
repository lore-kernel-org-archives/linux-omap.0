From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 18 Jul 2012 10:26:54 -0700
Message-ID: <20120718172654.GA27904@animalcreek.com>
References: <WC20120713105737.0900A2@terrafix.co.uk>
 <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
 <20120717004010.GA6612@animalcreek.com>
 <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
 <WC20120717100848.280191@terrafix.co.uk>
 <alpine.DEB.2.00.1207171326510.28834@utopia.booyaka.com>
 <20120718022035.GC18663@animalcreek.com>
 <WC20120718100634.8301FB@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56227 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2GRR06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 13:26:58 -0400
Content-Disposition: inline
In-Reply-To: <WC20120718100634.8301FB@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, Jul 18, 2012 at 11:06:34AM +0100, Joe Woodward wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>

> > How does this look?

> > Subject: [PATCH] ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature
> > 
> > It appears that the am3703 and possibly the am3715 SoCs
> > have an active IVA subsystem even though the CONTROL_IDCODE
> > register indicates that they don't.  From experimentation,
> > it seems that the IVA still requires some registers to be
> > initialized even though we don't want it fully functional.
> > 
> > To accomplish this, add a new feature (OMAP3_HAS_IVA_REGS)
> > that indicates that the IVA should be initialized but not
> > really used.
> > 
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > ---

> Tested on a GUMSTIX Overo AirSTORM (AM3703-based), and that fixes the problem for me, thanks!

Great!  Thanks for testing, Joe.

Paul, Kevin, any comments?
