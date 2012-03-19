From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 12:30:06 +0000
Message-ID: <20120319123006.GC16389@n2100.arm.linux.org.uk>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk> <20120317004706.GF7276@atomide.com> <20120317211505.GA4720@n2100.arm.linux.org.uk> <1332149601.2144.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35715 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab2CSMaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 08:30:25 -0400
Content-Disposition: inline
In-Reply-To: <1332149601.2144.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Mar 19, 2012 at 11:33:21AM +0200, Tomi Valkeinen wrote:
> But that's a bigger work item, so what I did in the series above is that
> I changed platform_driver_register()s to platform_driver_probe()s. All
> the DSS subdevices are present at boot time and are non-hotpluggable, so
> I think that should work fine.

platform_driver_probe() is just a wrapper around platform_driver_register() -
the difference between the two is that _probe() will temporarily set the
probe method in the passed driver structure, call platform_driver_register(),
and then NULL the probe method out.

So, merely changing platform_driver_register() for platform_driver_probe()
won't solve the deadlock.

I'm not sure what's caused this regression, as I can't see any DSS changes,
nor core driver model changes which would account for this.  Has something
changed in hwmod to cause this?

It is _very_ important that we discover what has caused this regression
and prevent it going upstream until the problem is resolved.  Until we
know that, I suggest that _no_ OMAP changes go upstream during this
merge window until we understand what's caused this.
