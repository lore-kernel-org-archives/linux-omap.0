From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Thu, 6 May 2010 08:44:30 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C74CE@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
 <20100505171938.GX29604@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEC153@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab0EFDOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 23:14:44 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DEEC153@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>



> -----Original Message-----
> From: Arce, Abraham 
> Sent: Thursday, May 06, 2010 6:18 AM
> To: Tony Lindgren
> Cc: G, Manjunath Kondaiah; linux-omap@vger.kernel.org; 
> spi-devel-general@lists.sourceforge.net
> Subject: RE: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
> 
> > > > > +
> > > > > +static void omap_ethernet_init(void)
> > > > > +{
> > > > > +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > > > > +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > > > > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > > > > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > > > > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> > > >
> > > > Any reason for not checking return value of gpio_request()?
> > > >
> > >
> > > Thought initially about them as dedicated lines for 
> ethernet avoiding
> > > both reasons to check for a gpio's request:
> > >
> > >  1. invalid gpio
> > >  2. already claimed gpio
> > 
> > You still need to check for the result.
> > 
> 
> Is the below approach ok? Using goto would make it better?
> 
>         int status;
> 
>         status = gpio_request(ETHERNET_KS8851_POWER_ENABLE, 
> "ethernet");
>         if (status < 0)

You need to have warning message about this failure.

>                 return status;
> 
>         gpio_request(ETHERNET_KS8851_QUART, "quart");
>         if (status < 0) {

-Ditto-

>                 gpio_free(ETHERNET_KS8851_POWER_ENABLE);
>                 return status;

Return to where? This function seems to be void, change signature
of this API.

>         }
> 
>         gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
>         if (status < 0) {

Bug! Checking previous status.

>                 gpio_free(ETHERNET_KS8851_POWER_ENABLE);
>                 gpio_free(ETHERNET_KS8851_QUART);
>                 return status;
>         }
> 
>         gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
>         gpio_direction_output(ETHERNET_KS8851_QUART, 1);
>         gpio_direction_input(ETHERNET_KS8851_IRQ);

Goto will be better approach  compared to above logic.

if(gpio_request(x)
	goto err1;

if(gpio_request(y)
	goto err2;

if(gpio_request(z)
	goto err3;
...	
	return 0;

err3:
	free(x);
err2:
	free(y);
err1:
	free(z);

	return status;

-Manjunath 