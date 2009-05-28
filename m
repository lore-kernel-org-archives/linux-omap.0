From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ARM: OMAP3: Initialize regulators for Beagle and
	Overo
Date: Thu, 28 May 2009 19:00:13 +0100
Message-ID: <20090528180011.GA4574@sirena.org.uk>
References: <20090525174517.19679.18805.stgit@localhost> <20090525174938.19679.51804.stgit@localhost> <20090528162027.GG20736@n2100.arm.linux.org.uk> <20090528173319.GE32453@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36273 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZE1SAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 14:00:24 -0400
Content-Disposition: inline
In-Reply-To: <20090528173319.GE32453@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

On Thu, May 28, 2009 at 10:33:20AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 09:20]:

> > I really hate it when I see this kind of initialization after registration.
> > It feels totally wrong and fragile.

> > At one point, I had clkdev matching using struct device pointer as well,
> > but it was realised that was far too limiting - you couldn't declare
> > clock entries without first having all devices setup, and then you run
> > into problems with ordering.

> > It looks like the regulator stuff is suffering this same problem - it
> > wants to match by struct device pointer.  That's fine if all your
> > struct device's are statically allocated, but as soon as you start
> > having dynamic ones, it gets _much_ harder to cope with.

> Yeah. I believe Mark is working on sorting out the regulator fwk issues
> regarding this.

Eh, no, not really.  It's the same as the clock API in this regard - if
you want the struct device can be NULL and you can do a name based
lookup only but then you have to pass the name around in platform data
to support configurability.  If the clock API implements some other
solutions we'll probably follow them but I'm not aware of any.

Otherwise it's more likely that if I personally do anything on this I'd
work on getting I2C and similar subsystems to make the struct device
more readily available to board code.
