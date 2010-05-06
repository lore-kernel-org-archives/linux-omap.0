From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Thu, 6 May 2010 14:33:36 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C77AE@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
 <20100505171938.GX29604@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEC153@dlee03.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74CE@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74DE@dbde02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEC1CE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab0EFJDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 05:03:48 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DEEC1CE@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>



> -----Original Message-----
> From: Arce, Abraham 
> Sent: Thursday, May 06, 2010 9:49 AM
> To: G, Manjunath Kondaiah; Tony Lindgren
> Cc: linux-omap@vger.kernel.org; 
> spi-devel-general@lists.sourceforge.net
> Subject: RE: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
> 
> Manjunath,
> 
> > > > > > > > +
> > > > > > > > +static void omap_ethernet_init(void)
> > > > > > > > +{
> > > > > > > > +	
> gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > > > > > > > +	
> gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > > > > > > > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > > > > > > > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > > > > > > > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> > > > > > >
> > > > > > > Any reason for not checking return value of 
> gpio_request()?
> > > > > > >
> 
> [snip]
> 
> > Minor changes:
> > if (gpio_request(x))
> > 	return status;
> > if (gpio_request(y))
> > 	goto err1;
> > if (gpio_request(z))
> > 	goto err2;
> > ...
> > 	return 0;
> > 
> > err2:
> > 	free(y);
> > 
> > err1:
> > 	free(x);
> > 	return status;
> 
> How about this patch?
> 
> Note. I am thinking in spi_register_board_info registration:
> 
> 1. to be done if ethernet fails, other spi dev can be added in future

No use. Since, for a given board SPI chip select lines are physically 
connected to external slave devices, you can't register another SPI 
slave device for same chip select.

> 2. not to be done if ethernet fails, no other dev in spi bus 1 for now
> 
> What is the best approach? Is it to keep #2?

Seems to be ok for chip select #0. If we have another device on bus 1 with
different chip select number, then registration should succeed. However, this
may not be the case with omap4 sdp board since it might have only one spi
device on bus1.

-Manjunath