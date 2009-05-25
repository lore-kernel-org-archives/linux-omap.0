From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ARM: OMAP3: Initialize more devices for LDP
Date: Mon, 25 May 2009 14:20:09 +0100
Message-ID: <20090525132009.GJ18290@sirena.org.uk>
References: <20090522223543.31586.44534.stgit@localhost> <20090522224541.31586.68943.stgit@localhost> <20090525125920.GD30553@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56535 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbZEYNUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 09:20:12 -0400
Content-Disposition: inline
In-Reply-To: <20090525125920.GD30553@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, May 25, 2009 at 01:59:20PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 22, 2009 at 03:45:41PM -0700, Tony Lindgren wrote:

> > +	/* link regulators to MMC adapters */
> > +	ldp_vmmc1_supply.dev = mmc[0].dev;

> This feels wrong - setup after registering devices.  All it takes is to
> have to move various device drivers to be earlier in the initialization
> ordering and things start breaking in unexpected ways.

> If MMC controls the Vmmc1 supply, then why does the Vmmc1 supply need
> the struct device pointer for the MMC controller?

Like the clock API the regulator API looks up clients for regulators
based on a combination of the struct device for the client driver and
the name of the supply.  Unfortunately with both the I2C and SPI APIs
the struct device is only available once the driver has probed so this
can't be set up with static data prior to probe, hence this sort of
bodge.

Long term I think we'll want to fix I2C and SPI to let us have static
data for this.
