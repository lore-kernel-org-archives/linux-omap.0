From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Wed, 5 May 2010 10:19:39 -0700
Message-ID: <20100505171938.GX29604@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60138 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EERTl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 13:19:41 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>

* Arce, Abraham <x0066660@ti.com> [100505 01:06]:
> Manjunath,
> 
> > > +
> > > +static void omap_ethernet_init(void)
> > > +{
> > > +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > > +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> > 
> > Any reason for not checking return value of gpio_request()?
> > 
> 
> Thought initially about them as dedicated lines for ethernet avoiding
> both reasons to check for a gpio's request:
> 
>  1. invalid gpio
>  2. already claimed gpio

You still need to check for the result.

Tony
