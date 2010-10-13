From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [RFC PATCHv3 2/7] OMAP SSI: Introducing OMAP SSI driver
Date: Wed, 13 Oct 2010 11:09:53 +0300
Message-ID: <1286957393.6570.819.camel@localhost>
References: <1286787988-29013-1-git-send-email-carlos.chinea@nokia.com>
	 <1286787988-29013-3-git-send-email-carlos.chinea@nokia.com>
	 <20101012204927.GY25462@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55940 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab0JMIJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Oct 2010 04:09:22 -0400
In-Reply-To: <20101012204927.GY25462@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-10-12 at 22:49 +0200, ext Tony Lindgren wrote:
> * Carlos Chinea <carlos.chinea@nokia.com> [101011 01:58]:
> > Introduces the OMAP SSI driver in the kernel.
> > 
> > The Synchronous Serial Interface (SSI) is a legacy version
> > of HSI. As in the case of HSI, it is mainly used to connect
> > Application engines (APE) with cellular modem engines (CMT)
> > in cellular handsets.
> > 
> > It provides a multichannel, full-duplex, multi-core communication
> > with no reference clock. The OMAP SSI block is capable of reaching
> > speeds of 110 Mbit/s.
> > 
> > Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
> 
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/ssi.c
> 
> > +static struct resource ssi_resources[] = {
> > +	/* SSI controller */
> > +	[0] = {
> > +		.start	= 0x48058000,
> > +		.end	= 0x48058fff,
> > +		.name	= "omap_ssi_sys",
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	/* GDD */
> > +	[1] = {
> > +		.start	= 0x48059000,
> > +		.end	= 0x48059fff,
> > +		.name	= "omap_ssi_gdd",
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[2] = {
> > +		.start	= 71,
> > +		.end	= 71,
> > +		.name	= "ssi_gdd",
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +	/* SSI port 1 */
> > +	[3] = {
> > +		.start	= 0x4805a000,
> > +		.end	= 0x4805a7ff,
> > +		.name	= "omap_ssi_sst1",
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[4] = {
> > +		.start	= 0x4805a800,
> > +		.end	= 0x4805afff,
> > +		.name	= "omap_ssi_ssr1",
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[5] = {
> > +		.start	= 67,
> > +		.end	= 67,
> > +		.name	= "ssi_p1_mpu_irq0",
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +	[6] = {
> > +		.start	= 69,
> > +		.end	= 69,
> > +		.name	= "ssi_p1_mpu_irq1",
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +	[7] = {
> > +		.start	= 0,
> > +		.end	= 0,
> > +		.name	= "ssi_p1_cawake",
> > +		.flags	= IORESOURCE_IRQ | IORESOURCE_UNSET,
> > +	},
> > +};
> 
> Are these resources the same for omap2, 3 & 4?

Yes in the case of omap2 and omap3.
For omap4, It is my understanding that SSI will be replaced by HSI.

Anyway, good that you has brought this up as it has forced me to crosscheck the values and I have just realized that IRQ number for ssi_p1_mpu_irq1 (which is not currently used by the driver) is wrong. It should be 68.

> 
> > +static void ssi_pdev_release(struct device *dev)
> > +{
> > +}
> 
> Not needed.
> 
> > +static struct platform_device ssi_pdev = {
> > +	.name		= "omap_ssi",
> > +	.id		= 0,
> > +	.num_resources	= ARRAY_SIZE(ssi_resources),
> > +	.resource	= ssi_resources,
> > +	.dev		= {
> > +				.release	= ssi_pdev_release,
> > +				.platform_data	= &ssi_pdata,
> > +	},
> > +};
> 
> Dummy release not needed here either.
> 

Ok. I'll change that.

> > +static int __init ssi_init(void)
> > +{
> > +	return platform_device_register(&ssi_pdev);
> > +}
> > +subsys_initcall(ssi_init);
> 
> This will probably cause trouble on omap2 and 4?
> 
> To me it seems that you should at least return early on the unsupported
> platforms.
> 

I will add dependencies to ARCH_OMAP2 and ARCH_OMAP3 for OMAP_SSI , so
it will not be added to omap4.

> You might want to consider updating this for omap hwmod as it will
> automate the platform_device and PM related issues to some extent.
> 

Ok, I will have a look at this.

> Regards,
> 
> Tony

Thanks for the review :)
Carlos
-- 
Carlos Chinea <carlos.chinea@nokia.com>

