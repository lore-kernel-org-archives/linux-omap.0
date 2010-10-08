From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 05/16] OMAP3 DSS Driver register moved to mach_omap2
Date: Fri, 8 Oct 2010 12:24:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94B33E@dbde02.ent.ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
 <20101007210618.2bb542be@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab0JHGyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 02:54:35 -0400
In-Reply-To: <20101007210618.2bb542be@surf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
> Sent: Friday, October 08, 2010 12:36 AM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; paul@pwsan.com;
> Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v1 05/16] OMAP3 DSS Driver register moved to
> mach_omap2
> 
> Hello,
> 
> The patch title is a bit misleading, maybe it should rather be
> something like "Move OMAP3 DSS driver registration to
> mach-omap2/devices.c"/
> 
> On Wed,  6 Oct 2010 16:44:48 +0530
> Guruswamy Senthilvadivu <svadivu@ti.com> wrote:
> 
> >  /*---------------------------------------------------------------------
> ------*/
> > +#ifdef CONFIG_OMAP2_DSS
> > +
> > +static struct platform_device omap_display_device = {
> > +	.name          = "omapdisplay",
> > +	.id            = -1,
> > +	.dev            = {
> > +		.platform_data = NULL,
> > +	},
> 
> This .dev = {} part is useless. The compiler will automatically
> initialize unset fields to zero.
> 
[Senthil]  Thanks.  When I do code movement I don't change it.
I can submit additional patches to improvise the code.

> > +};
> > +
> > +void __init omap_display_init(struct omap_dss_board_info
> > +					*board_data)
> 
> *board_data should probably be on the same line as the argument type.
> 
[Senthil] Taken.
> > +{
> > +
> 
> The general kernel coding style seems to be that there shouldn't be
> such empty newlines at the beginning of functions.
> 
> > +	omap_display_device.dev.platform_data = board_data;
> > +
> > +	if (platform_device_register(&omap_display_device) < 0)
> > +		printk(KERN_ERR "Unable to register OMAP-Display device\n");
> > +
> > +
> 
> Unneeded newlines.
> 
[Senthil] Taken.
> > +	return ;
> 
> This return is not needed, we are at the end of a void function.
> 
> > @@ -712,7 +712,7 @@ static struct platform_driver omap_dss_driver = {
> >  	.suspend	= omap_dss_suspend,
> >  	.resume		= omap_dss_resume,
> >  	.driver         = {
> > -		.name   = "omapdss",
> > +		.name   = "omapdisplay",
> >  		.owner  = THIS_MODULE,
> >  	},
> >  };
> 
> There are other boards instantiating a platform_device with the omapdss
> name, so I think this change is going to break those boards. In my
> not-so-old linux-omap tree :
> 
> $ grep "\.name.*omapdss" *
> board-3430sdp.c:	.name		= "omapdss",
> board-am3517evm.c:	.name		= "omapdss",
> board-cm-t35.c:	.name		= "omapdss",
> board-devkit8000.c:	.name		= "omapdss",
> board-igep0020.c:	.name	= "omapdss",
> board-omap3beagle.c:	.name          = "omapdss",
> board-omap3evm.c:	.name		= "omapdss",
> board-omap3pandora.c:	.name		= "omapdss",
> board-omap3stalker.c:	.name	= "omapdss",
> board-rx51-video.c:	.name	= "omapdss",
> 
> Shouldn't these board files also be updated to use the new
> omap_display_init() function ?
> 
[Senthil] Yes, Taken. I would request for testing these additional changes.
> Regards,
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
