From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Sat, 27 Aug 2011 13:31:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108271306500.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <201108261741.29850.arnd@arndb.de> <20110827143736.GA10182@yookeroo.fritz.box> <5595208.OB5dBohxQP@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38715 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab1H0TbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 15:31:07 -0400
In-Reply-To: <5595208.OB5dBohxQP@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Amit Kucheria <amit.kucheria@canonical.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, 27 Aug 2011, Arnd Bergmann wrote:

> Right, and I guess we can simply ignore DMA and ioport resources because 
> they are extremely rare, right?

DMA resources are quite widely used.

For example, looking at the SoCs with some publicly-available 
documentation, the Motorola i.MX51 reference manual lists 47 SDMA request 
lines across about 17 different IP block types[1], and to pick a 
representative OMAP, the OMAP3430 technical reference manual lists 77 SDMA 
request lines, used by at least 9 different IP block types[2].

Also, many IP blocks have multiple DMA resources.  For example, the above 
references list UART, MCSPI, PATA, I2C, FIRI, MCBSP, SSI, CTI, CSPI, 
eCSPI, EMI, eSDHC, SPI, and DSS.


- Paul

1. Table 3-3, "SDMA Event Mapping".  _MCIMX51 Multimedia Applications 
   Processor Reference Manual (MCIMX51RM) Rev. 1 2/2010_.  Available from
   http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=i.MX515&fpsp=1&tab=Documentation_Tab

2. This is simply one example from the OMAP3430 TRM, but similar tables
   are available for OMAP2420, 2430, 3430, 3630, 4430, 4460, 4470, etc.
   Table 9-3, "SDMA Request Mapping". _OMAP34xx Multimedia Device Silicon 
   Revision 3.1.x Version J (SWPU223J)_ (public version).  Available from 
   http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12667

