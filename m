From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
Date: Wed, 17 Jun 2009 16:17:02 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD8D89BE@dnce02.ent.ti.com>
References: <1245100312-2312-1-git-send-email-ubh@ti.com>
	<1245100312-2312-2-git-send-email-ubh@ti.com>
	<1245100312-2312-3-git-send-email-ubh@ti.com>
 <87fxe042sg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50746 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZFQORJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:17:09 -0400
In-Reply-To: <87fxe042sg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, June 16, 2009 10:27 AM
> To: Hald, Ulrik Bech
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
> 
> Ulrik Bech Hald <ubh@ti.com> writes:
> 
> > This patch enables the IVA2 and SECURE WDTs in the omap_wdt
> > driver for omap34xx family. SECURE will be available as
> > /dev/watchdog_secure on HS/EMU devices and IVA2 will be available
> > as /dev/watchdog_iva2. MPU will still be available as /dev/watchdog
> >
> > Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> > ---
> > This patch has a dependency on:
> > [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer
> reload
> >
> >  drivers/watchdog/omap_wdt.c |   51
> ++++++++++++++++++++++++++++++++++++------
> >  1 files changed, 43 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> > index f271385..85a92de 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -47,7 +47,15 @@
> >
> >  #include "omap_wdt.h"
> >
> > -static struct platform_device *omap_wdt_dev;
> > +#define NUM_WDTS	3
> > +
> > +enum {
> > +	SECURE_WDT = 1,
> > +	MPU_WDT,
> > +	IVA2_WDT,
> > +};
> > +
> > +static struct platform_device *omap_wdt_dev[NUM_WDTS];
> 
> If you're going to have shared numbers here, they should be shared and
> also used by the SoC init code.  IOW, the id's you're using in the
> devices.c file affects the numbering here.
> 
> Also, why not use zero-based numbering here and in devices.c, then
> you can avoide the 'pdev->id - 1' below.
> 
> >  static unsigned timer_margin;
> >  module_param(timer_margin, uint, 0);
> > @@ -139,8 +147,23 @@ static void omap_wdt_set_timeout(struct
> omap_wdt_dev *wdev)
> >   */
> >  static int omap_wdt_open(struct inode *inode, struct file *file)
> >  {
> > -	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
> > -	void __iomem *base = wdev->base;
> > +	struct omap_wdt_dev *wdev;
> > +	void __iomem *base;
> > +
> > +	/* by default MPU wdt is present across omap family */
> > +	wdev = platform_get_drvdata(omap_wdt_dev[1]);
> 
> Drop this and just use the inode match.
> 
Was considering that, but ended up defaulting value instead of error checking later. I'll change the above.

> > +	/* Find match between device node and wdt device */
> > +	int i;
> > +	for (i = 0; i < NUM_WDTS; i++) {
> > +		if (omap_wdt_dev[i]) {
> > +			wdev = platform_get_drvdata(omap_wdt_dev[i]);
> > +			if (iminor(inode) == wdev->omap_wdt_miscdev.minor)
> > +				break;
> > +		}
> > +	}
> 
> You should check for a valid match here.
> 
The sanity check I would choose here is

struct omap_wdt_dev *wdev = NULL;
...
<inode matching>
...
if(!wdev)
	return -ENODEV; 

> > +	base = wdev->base;
> >
> >  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
> >  		return -EBUSY;
> > @@ -271,7 +294,7 @@ static int __devinit omap_wdt_probe(struct
> platform_device *pdev)
> >  		goto err_get_resource;
> >  	}
> >
> > -	if (omap_wdt_dev) {
> > +	if (omap_wdt_dev[pdev->id-1]) {
> 
> With zero-based numbering, you can drop the -1.
> 
> >  		ret = -EBUSY;
> >  		goto err_busy;
> >  	}
> > @@ -317,10 +340,21 @@ static int __devinit omap_wdt_probe(struct
> platform_device *pdev)
> >  	omap_wdt_adjust_timeout(timer_margin);
> >
> >  	wdev->omap_wdt_miscdev.parent = &pdev->dev;
> > -	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
> > -	wdev->omap_wdt_miscdev.name = "watchdog";
> > +	wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
> >  	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
> >
> > +	switch (pdev->id) {
> > +	case SECURE_WDT:
> > +		wdev->omap_wdt_miscdev.name = "watchdog_secure";
> > +		break;
> > +	case IVA2_WDT:
> > +		wdev->omap_wdt_miscdev.name = "watchdog_iva2";
> > +		break;
> > +	case MPU_WDT:
> > +	default:
> > +		wdev->omap_wdt_miscdev.name = "watchdog";
> > +	}
> > +
> 
> The more think about this, the more I don't like this pdev->id
> switching in the driver.  The only thing it is needed for
> is to set the name of the node.
> 
> Instead, why not set the name in devices.c and pass it in
> using platform_data.
> 
> Then you can drop the enum and the pdev->id switching.
> 

That does simplify things a bit. Had overlooked that way of sharing info between device and driver.
So, devices.c would have something like:

static struct platform_device omap_secure_wdt_device = {
	.name = "omap_wdt",
	.id = 1,
	.num_resources = ARRAY_SIZE(secure_wdt_resources),
	.resource = secure_wdt_resources,
	.dev = {
		.platform_data = "watchdog_secure",
	},
};

And omap_wdt.c would have in probe():

wdev->omap_wdt_miscdev.name = (char *) pdev->dev.platform_data;

Is that more like what you had in mind?

/Ulrik
> >  	ret = misc_register(&(wdev->omap_wdt_miscdev));
> >  	if (ret)
> >  		goto err_misc;
> > @@ -332,7 +366,8 @@ static int __devinit omap_wdt_probe(struct
> platform_device *pdev)
> >  	/* autogate OCP interface clock */
> >  	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
> >
> > -	omap_wdt_dev = pdev;
> > +	/* keep track of the wdt platform devices in local device array */
> > +	omap_wdt_dev[pdev->id - 1] = pdev;
> >
> >  	return 0;
> >
> > @@ -384,7 +419,7 @@ static int __devexit omap_wdt_remove(struct
> platform_device *pdev)
> >  	iounmap(wdev->base);
> >
> >  	kfree(wdev);
> > -	omap_wdt_dev = NULL;
> > +	omap_wdt_dev[pdev->id-1] = NULL;
> >
> >  	return 0;
> >  }
> > --
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

