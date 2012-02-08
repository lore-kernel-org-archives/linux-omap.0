From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 20:54:42 -0800
Message-ID: <20120208045441.GA20885@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <4F306016.9010203@ti.com>
 <20120207172809.GD26764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42952 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab2BHEyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 23:54:47 -0500
Content-Disposition: inline
In-Reply-To: <20120207172809.GD26764@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120207 08:57]:
> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
> 
> > The twl changes were done like that because it was assuming that
> > USE_OF and thus IRQ_DOMAIN will be enabled by default for all OMAP2+
> > platforms at 3.3 time.  The whole point of doing that was to reduce
> > the ifdefery in every drivers we have to adapt to DT.
> 
> Note that those drivers have been buildable on non-OMAP platforms for a
> very long time now in order to give better build coverage for the
> function drivers.

Good point and should be tested too while at it.

Regards,

Tony
