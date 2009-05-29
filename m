From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ARM: OMAP3: Initialize regulators for Beagle and
	Overo
Date: Fri, 29 May 2009 11:05:26 +0100
Message-ID: <20090529100525.GC13820@sirena.org.uk>
References: <20090525174517.19679.18805.stgit@localhost> <20090525174938.19679.51804.stgit@localhost> <20090528162027.GG20736@n2100.arm.linux.org.uk> <20090528173319.GE32453@atomide.com> <20090528180011.GA4574@sirena.org.uk> <20090528194834.GV20736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46848 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbZE2KF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 06:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20090528194834.GV20736@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

On Thu, May 28, 2009 at 08:48:34PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 28, 2009 at 07:00:13PM +0100, Mark Brown wrote:

> > Eh, no, not really.  It's the same as the clock API in this regard - if
> > you want the struct device can be NULL and you can do a name based
> > lookup only but then you have to pass the name around in platform data
> > to support configurability.  If the clock API implements some other
> > solutions we'll probably follow them but I'm not aware of any.

> That's not quite what we're talking about.  With clkdev, you specify
> device name itself, rather than address-of-struct-device.  Using the
> device name gives you independence from the initialization or creation
> of the struct device (if indeed the struct device is created at all.)

Hrm, that does seem like a neat approach for avoiding the problems with
buses like I2C - I'll look into adding support for it, but at this point
it's not likely to be in time for the next merge window.  Thanks!
