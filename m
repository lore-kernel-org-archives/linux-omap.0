From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 17:28:09 +0000
Message-ID: <20120207172809.GD26764@sirena.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <4F306016.9010203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:51029 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab2BGR2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 12:28:14 -0500
Content-Disposition: inline
In-Reply-To: <4F306016.9010203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:

> The twl changes were done like that because it was assuming that
> USE_OF and thus IRQ_DOMAIN will be enabled by default for all OMAP2+
> platforms at 3.3 time.  The whole point of doing that was to reduce
> the ifdefery in every drivers we have to adapt to DT.

Note that those drivers have been buildable on non-OMAP platforms for a
very long time now in order to give better build coverage for the
function drivers.
