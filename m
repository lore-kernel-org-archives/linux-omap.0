From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under
 drivers
Date: Mon, 24 Nov 2014 07:44:04 -0800
Message-ID: <20141124154403.GB2817@atomide.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-4-git-send-email-tony@atomide.com>
 <547301AB.9040905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbaKXPqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 10:46:39 -0500
Content-Disposition: inline
In-Reply-To: <547301AB.9040905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

* Roger Quadros <rogerq@ti.com> [141124 02:02]:
> On 11/21/2014 08:34 PM, Tony Lindgren wrote:
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -41,6 +41,14 @@ config TI_EMIF
> >  	  parameters and other settings during frequency, voltage and
> >  	  temperature changes
> >  
> > +config OMAP_GPMC
> > +	bool
> 
> We should depend on ARCH_OMAP2PLUS. Other platforms won't benefit
> anything from this driver.

We can't do that yet until we have sorted out the remaining platform
data issues with arch/arm/mach-omap2/*gpmc*.c files.

So OMAP_GPMC is currently a silent Kconfig option that does not show
up as the description after the bool is not there, we select
OMAP_GPMC automatically based on ARCH_OMAP2PLUS.

Once we have the remaining legacy code issues sorted out, we can
make this into just a regular device driver.

Regards,

Tony
