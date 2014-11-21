From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under
 drivers
Date: Fri, 21 Nov 2014 10:45:34 -0800
Message-ID: <20141121184533.GV7046@atomide.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-4-git-send-email-tony@atomide.com>
 <20141121183911.GA7508@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41311 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751130AbaKUSpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 13:45:46 -0500
Content-Disposition: inline
In-Reply-To: <20141121183911.GA7508@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

* Felipe Balbi <balbi@ti.com> [141121 10:40]:
> On Fri, Nov 21, 2014 at 10:34:16AM -0800, Tony Lindgren wrote:
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -41,6 +41,14 @@ config TI_EMIF
> >  	  parameters and other settings during frequency, voltage and
> >  	  temperature changes
> >  
> > +config OMAP_GPMC
> > +	bool
> 
> shouldn't you make this selectable ? I might want to build a kernel
> without GPMC support because my board just doesn't use GPMC :-)

Eventually yes, but let's keep it separate from this move. We'd have
to do something like this:

- Make omap MTD drivers depend on OMAP_GPMC

- Make tusb6010 depend on OMAP_GPMC

- Make smc911x depend on OMAP_GPMC

- Build arch/arm/mach-omap2/*gpmc*.c conditionally
  depending on OMAP_GPMC

Adding stubs for omap-gpmc probably does not make sense as these
devices really depend on GPMC.

Regards,

Tony
