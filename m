From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2 OneNAND GPIO fix
Date: Thu, 8 Jan 2009 15:12:01 +0200
Message-ID: <20090108131201.GF27566@atomide.com>
References: <200812111759.15180.jpihet@mvista.com> <200812161928.49147.jpihet@mvista.com> <20090108121037.GB27566@atomide.com> <200901081356.54429.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56367 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbZAHNMC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 08:12:02 -0500
Content-Disposition: inline
In-Reply-To: <200901081356.54429.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org

* Jean Pihet <jpihet@mvista.com> [090108 14:57]:
> On Thursday 08 January 2009 13:10:37 Tony Lindgren wrote:
> > * Jean Pihet <jpihet@mvista.com> [081216 20:29]:
> > > Tony,
> > >
> > > > Yeah, should be about to get pulled into Russell's queue, also
> > > > available here:
> > > >
> > > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=s
> > > >hort log;h=hsmmc-init
> > > >
> > > > So Jean, if you can check what still needs to be patched there, and
> > > > we can queue it via omap-fixes.
> > >
> > > Here is the patch against the hsmmc-init branch.
> > > The patch changes the include path and the request/free free omap calls
> > > to the standard version.
> >
> > Oops, I should have used this patch instead yesterday.. We could add
> > your changes as a clean-up patch later on though once the currently
> > pending stuff gets into mainline. Maybe refresh and resubmit then?
> Ok! When will it hit the mainline?

Hopefully within few days.

Tony


> 
> >
> > Thanks,
> >
> > Tony
> >
> > > Regards,
> > > Jean.
> > >
> > > From a4f548c3f51c9a349decc761dd539499902873f5 Mon Sep 17 00:00:00 2001
> > > From: Jean Pihet <jpihet@mvista.com>
> > > Date: Tue, 16 Dec 2008 19:22:45 +0100
> > > Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver
> > >
> > > This patch replaces some legacy OMAP GPIO calls with the standard
> > > calls.
> > >
> > > Tested on OMAP3 EVM board.
> > >
> > > Signed-off-by: Jean Pihet <jpihet@mvista.com>
> > > ---
> > >  drivers/mtd/onenand/omap2.c |    9 +++++----
> > >  1 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> > > index d1e0b8e..f223303 100644
> > > --- a/drivers/mtd/onenand/omap2.c
> > > +++ b/drivers/mtd/onenand/omap2.c
> > > @@ -34,11 +34,11 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/io.h>
> > > +#include <linux/gpio.h>
> > >
> > >  #include <asm/mach/flash.h>
> > >  #include <mach/gpmc.h>
> > >  #include <mach/onenand.h>
> > > -#include <mach/gpio.h>
> > >  #include <mach/pm.h>
> > >
> > >  #include <mach/dma.h>
> > > @@ -629,7 +629,8 @@ static int __devinit omap2_onenand_probe(struct
> > > platform_device *pdev)
> > >  	}
> > >
> > >  	if (c->gpio_irq) {
> > > -		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
> > > +		r = gpio_request(c->gpio_irq, "OneNAND Irq");
> > > +		if (r < 0) {
> > >  			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
> > >  				"OneNAND\n", c->gpio_irq);
> > >  			goto err_iounmap;
> > > @@ -726,7 +727,7 @@ err_release_dma:
> > >  		free_irq(gpio_to_irq(c->gpio_irq), c);
> > >  err_release_gpio:
> > >  	if (c->gpio_irq)
> > > -		omap_free_gpio(c->gpio_irq);
> > > +		gpio_free(c->gpio_irq);
> > >  err_iounmap:
> > >  	iounmap(c->onenand.base);
> > >  err_release_mem_region:
> > > @@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct
> > > platform_device *pdev)
> > >  	platform_set_drvdata(pdev, NULL);
> > >  	if (c->gpio_irq) {
> > >  		free_irq(gpio_to_irq(c->gpio_irq), c);
> > > -		omap_free_gpio(c->gpio_irq);
> > > +		gpio_free(c->gpio_irq);
> > >  	}
> > >  	iounmap(c->onenand.base);
> > >  	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
> > > --
> > > 1.5.4.4.21.gc4a6c
> > >
> > > From a4f548c3f51c9a349decc761dd539499902873f5 Mon Sep 17 00:00:00 2001
> > > From: Jean Pihet <jpihet@mvista.com>
> > > Date: Tue, 16 Dec 2008 19:22:45 +0100
> > > Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver
> > >
> > > This patch replaces some legacy OMAP GPIO calls with the standard
> > > calls.
> > >
> > > Tested on OMAP3 EVM board.
> > >
> > > Signed-off-by: Jean Pihet <jpihet@mvista.com>
> > > ---
> > >  drivers/mtd/onenand/omap2.c |    9 +++++----
> > >  1 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> > > index d1e0b8e..f223303 100644
> > > --- a/drivers/mtd/onenand/omap2.c
> > > +++ b/drivers/mtd/onenand/omap2.c
> > > @@ -34,11 +34,11 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/io.h>
> > > +#include <linux/gpio.h>
> > >
> > >  #include <asm/mach/flash.h>
> > >  #include <mach/gpmc.h>
> > >  #include <mach/onenand.h>
> > > -#include <mach/gpio.h>
> > >  #include <mach/pm.h>
> > >
> > >  #include <mach/dma.h>
> > > @@ -629,7 +629,8 @@ static int __devinit omap2_onenand_probe(struct
> > > platform_device *pdev) }
> > >
> > >  	if (c->gpio_irq) {
> > > -		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
> > > +		r = gpio_request(c->gpio_irq, "OneNAND Irq");
> > > +		if (r < 0) {
> > >  			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
> > >  				"OneNAND\n", c->gpio_irq);
> > >  			goto err_iounmap;
> > > @@ -726,7 +727,7 @@ err_release_dma:
> > >  		free_irq(gpio_to_irq(c->gpio_irq), c);
> > >  err_release_gpio:
> > >  	if (c->gpio_irq)
> > > -		omap_free_gpio(c->gpio_irq);
> > > +		gpio_free(c->gpio_irq);
> > >  err_iounmap:
> > >  	iounmap(c->onenand.base);
> > >  err_release_mem_region:
> > > @@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct
> > > platform_device *pdev) platform_set_drvdata(pdev, NULL);
> > >  	if (c->gpio_irq) {
> > >  		free_irq(gpio_to_irq(c->gpio_irq), c);
> > > -		omap_free_gpio(c->gpio_irq);
> > > +		gpio_free(c->gpio_irq);
> > >  	}
> > >  	iounmap(c->onenand.base);
> > >  	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
> > > --
> > > 1.5.4.4.21.gc4a6c
> 
> 
