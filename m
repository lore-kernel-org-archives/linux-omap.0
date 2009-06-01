From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: LDP support
Date: Mon, 1 Jun 2009 17:16:57 +0100
Message-ID: <20090601161657.GE16580@n2100.arm.linux.org.uk>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk> <20090601160032.GA4825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49002 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZFAQRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 12:17:12 -0400
Content-Disposition: inline
In-Reply-To: <20090601160032.GA4825@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Mon, Jun 01, 2009 at 09:00:33AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090531 14:25]:
> > Okay, now that I've merged your tree, we've moved a few steps forward but
> > a couple of steps backward with LDP support:
> > 
> > 1. LDP LCD platform device added
> > 2. GPIO keyboard platform data added
> > 3. TWL4030 keyboard platform data added
> > 4. TSC2046 touchscreen platform data added
> > 5. MMC has regressed - no sign of the driver initializing, not even an
> >    error message from it, so I can't boot to check what the status of
> >    these are.
> 
> Do you have CONFIG_REGULATOR set in your .config? That seems to be missing
> from arch/arm/configs/omap_ldp_defconfig.

Yes, that fixes it.

I think it would be a good thing that a KERN_ERR message is displayed
to cover this case, since it currently fails completely silently.
