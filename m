From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 6/6 v2] usb: musb: Add support for ti81xx platform
Date: Thu, 8 Sep 2011 17:33:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC6BF40B@dbde02.ent.ti.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
 <1315414945-19829-7-git-send-email-ajay.gupta@ti.com>
 <20110907191425.GB6506@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35445 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758329Ab1IHMDy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 08:03:54 -0400
In-Reply-To: <20110907191425.GB6506@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>

Hi,
> > +static int __devinit dsps_probe(struct platform_device *pdev) {
> > +	const struct platform_device_id *id =
> platform_get_device_id(pdev);
> > +	const struct dsps_musb_wrapper *wrp =
> > +				(struct dsps_musb_wrapper *)id->driver_data;
> > +	struct dsps_glue *glue;
> > +	struct resource *iomem;
> > +	int ret;
> > +
> > +	/* allocate glue */
> > +	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
> > +	if (!glue) {
> > +		dev_err(&pdev->dev, "unable to allocate glue memory\n");
> > +		ret = -ENOMEM;
> > +		goto err0;
> > +	}
> > +
> > +	/* get memory resource */
> > +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!iomem) {
> > +		dev_err(&pdev->dev, "failed to get usbss mem resourse\n");
> > +		ret = -ENODEV;
> > +		goto err1;
> > +	}
> > +
> > +	glue->dev = &pdev->dev;
> > +	glue->wrp = wrp;
> 
> wrp is marked __devinitconst, so I guess you need to copy it here,
> instead of just pointing to it.

Will fix in v3.

Thanks,
Ajay
> 
> --
> balbi
