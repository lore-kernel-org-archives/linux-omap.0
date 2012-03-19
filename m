From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 15:01:09 +0000
Message-ID: <201203191501.10232.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120317104751.4F00E3E0910@localhost> <20120319130222.GC5705@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63972 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031663Ab2CSPBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 11:01:35 -0400
In-Reply-To: <20120319130222.GC5705@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, Thierry Reding <thierry.reding@avionic-design.de>, rob.herring@calxeda.com, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org

On Monday 19 March 2012, Mark Brown wrote:
> On Sat, Mar 17, 2012 at 10:47:51AM +0000, Grant Likely wrote:
> 
> > After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
> > I definitely prefer the fixed property name plus a separate names property.
> > It is easier to use common code with that scheme, and easier to statically
> > check for correctness.
> 
> It's not a fantastic experience when using the bindings as the arrays
> grow large, though - keeping things matched up isn't much fun especially
> if any of the elements in the array are optional.

Maybe one can use named properties in a new device node in that case,
like this:

	bus {
		dma: dma-controller {
			#dma-cells = <1>;
		};

		device {
			compatible = "device";
			channel: dma-channel {
				type = <0x1>;
				name = "foo";
				number = <23>;
				direction = <3>;
			};
			dma-requests = <&dma &channel>;
		};
	};

In this case, the dma engine's filter function would look up
the dma-channel device node from the phandle passed in the argument
to the dma-requests property, while a simpler dma engine would
just use a single number to identify a channel there.

	Arnd
