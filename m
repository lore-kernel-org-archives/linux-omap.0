From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Tue, 12 Jun 2012 07:09:58 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997E0F@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42556 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab2FLHKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 03:10:06 -0400
In-Reply-To: <4FD6555D.4000508@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

This change is required only till driver migration of all platforms
are done, after it, this hackish patch has to be reverted. This has
been done so that existing interface will work for each patch of
this series as well as till all boards are migrated.

On Tue, Jun 12, 2012 at 02:00:21, Hunter, Jon wrote:

> >  __init int omap_gpmc_init(struct gpmc_pdata *pdata)
> >  {
> >  	struct omap_hwmod *oh;
> > -	struct platform_device *pdev;
> > +	static struct platform_device *pdev;
> >  	char *name = "omap-gpmc";
> >  	char *oh_name = "gpmc";
> >  
> > @@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
> >  		return -ENODEV;
> >  	}
> >  
> > +	if (pdev != NULL) {
> > +		clk_put(gpmc_l3_clk);
> > +		omap_device_delete(pdev->archdata.od);
> > +		platform_device_unregister(pdev);
> > +	}
> > +
> 
> I am not sure if I am missing something, but it appears that pdev will
> always be NULL here as it is a local uninitialised variable.

omap_gpmc_init will be called by board files once again, at that time,
existing omap device will be destroyed (resulting in driver remove being
executed, and inverse of omap_device_build is not available, hence
doing circus as above). Again omap device will be created, this time
with details about gpmc peripherals (first time, there were no
peripheral details provided, and this was done for old interface to work
with same driver), once this happens new interface will starting it's job.

This kind of change was required as old interface works at arch_init


 > +static int __init gpmc_pre_init(void)
> > +{
> > +	static struct gpmc_device_pdata *gpmc_device_data[1];
> > +	struct gpmc_pdata gpmc_data = {
> > +		.device_pdata	= gpmc_device_data,
> > +	};
> > +
> > +	return omap_gpmc_init(&gpmc_data);
> > +}
> > +postcore_initcall(gpmc_pre_init);
> > +
> 
> Not sure I see the point in the above function. Why not declare the
> gpmc_device_data struct as static in the file and access it directly
> instead of passing it in omap_gpmc_init(). The postcore_init can then
> call omap_gpmc_init() directly.

Can be done, but it is not necessary to make it available outside the
function

> 
> Shouldn't the post_initcall be added in patch #4, when the driver is
> created?

As this has to be reverted once all boards has been migrated, this was
made separate.

Regards
Afzal
