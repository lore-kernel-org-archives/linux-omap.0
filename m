From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Fri, 8 Aug 2014 06:14:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408080613190.8332@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com> <20140729084930.GH29045@atomide.com> <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com> <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com> <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com> <20140730053940.GX29045@atomide.com> <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com> <20140731131107.GB29045@atomide.com> <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
 <20140801071056.GD29045@atomide.com> <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com> <CAOMZO5BmzaqVyHEJ0sqja8RgF2i_=FStSToJLwiX6NtTktNvCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46815 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaHHGOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2014 02:14:08 -0400
In-Reply-To: <CAOMZO5BmzaqVyHEJ0sqja8RgF2i_=FStSToJLwiX6NtTktNvCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel-build-reports@lists.linaro.org

On Thu, 7 Aug 2014, Fabio Estevam wrote:

> On Thu, Aug 7, 2014 at 7:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > It's commit a71e3c37960ce5f9c6a519bc1215e3ba9fa83e75:
> >
> > Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Date:   Wed Jul 23 16:47:31 2014 -0300
> >
> >     net: phy: Set the driver when registering an MDIO bus device
> >
> >     mdiobus_register() registers a device which is already bound to a driver.
> >     Hence, the driver pointer should be set properly in order to track down
> >     the driver associated to the MDIO bus.
> >
> >     This will be used to allow ethernet driver to pin down a MDIO bus driver,
> >     preventing it from being unloaded while the PHY device is running.
> >
> >     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >     Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> >     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >
> > What's bad is that this went in late during v3.16-rc fixes.  So now v3.16
> > itself is broken, and there's no way to fix it.
> 
> I have sent a patch reverting this commit and it is in mainline now.

That's great; thanks for letting us know.

>     The problem with the original commit is explained by Russell King:
> 
>     "It has the effect (as can be seen from the oops) of attaching the MDIO bus
>     device (itself is a bus-less device) to the platform driver, which means
>     that if the platform driver supports power management, it will be called
>     to power manage the MDIO bus device.
> 
>     Moreover, drivers do not expect to be called for power management
>     operations for devices which they haven't probed, and certainly not for
>     devices which aren't part of the same bus that the driver is registered
>     against."

Makes sense to me.


- Paul
