From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for
 each DSS HW IP
Date: Fri, 8 Oct 2010 12:41:35 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94B361@dbde02.ent.ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
 <20101007214957.79ca0a9b@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33945 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab0JHHLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 03:11:49 -0400
In-Reply-To: <20101007214957.79ca0a9b@surf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
> Sent: Friday, October 08, 2010 1:20 AM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; paul@pwsan.com;
> Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for
> each DSS HW IP
> 
> Hello Senthil,
> 
> I forgot one comment: in most Linux drivers, it is customary to put the
> platform_driver definition just above the driver initialization
> function, both of them at the end of the file. Of course, it's nothing
> mandatory, but most of the drivers are organized this way, making it
> easy for developers to find their way in all drivers.
> 
> So, in other words, this:
> 
[Senthil] I put it above as part of all the static methods and structures.
Will look at the other omap drivers before I change.
> > +/* DISPC HW IP initialisation */
> > +static int omap_dispchw_probe(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int omap_dispchw_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver omap_dispchw_driver = {
> > +	.probe          = omap_dispchw_probe,
> > +	.remove         = omap_dispchw_remove,
> > +	.driver         = {
> > +		.name   = "dss_dispc",
> > +		.owner  = THIS_MODULE,
> > +	},
> > +};
> 
> Should be just above this:
> 
> > +static int __init omap_dispc_init(void)
> > +{
> > +	return platform_driver_register(&omap_dispchw_driver);
> > +}
> > +
> > +device_initcall(omap_dispc_init);
> 
> Regards,
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
