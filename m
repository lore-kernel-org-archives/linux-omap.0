From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 5/8] OMAP: dmtimer: platform driver
Date: Fri, 4 Mar 2011 12:26:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A3603BF@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-6-git-send-email-tarun.kanti@ti.com>
 <87pqq7lll1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab1CDG4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:56:23 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p246uKQ9012299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 00:56:22 -0600
In-Reply-To: <87pqq7lll1.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 04, 2011 6:59 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v11 5/8] OMAP: dmtimer: platform driver
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > Add dmtimer platform driver functions which include:
> > (1) platform driver initialization
> > (2) driver probe function
> > (3) driver remove function
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> [...]
> 
> > +/**
> > + * omap_dm_timer_probe - probe function called for every registered
> device
> > + * @pdev:	pointer to current timer platform device
> > + *
> > + * Called by driver framework at the end of device registration for all
> > + * timer devices.
> > + */
> > +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	unsigned long flags;
> > +	struct omap_dm_timer *timer;
> > +	struct resource *mem, *irq, *ioarea;
> > +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> > +
> > +	if (!pdata) {
> > +		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	spin_lock_irqsave(&dm_timer_lock, flags);
> > +	list_for_each_entry(timer, &omap_timer_list, node)
> > +		if (!pdata->is_early_init && timer->id == pdev->id) {
> > +			timer->pdev = pdev;
> > +			spin_unlock_irqrestore(&dm_timer_lock, flags);
> > +			dev_dbg(&pdev->dev, "Regular Probed\n");
> > +			return 0;
> > +		}
> > +	spin_unlock_irqrestore(&dm_timer_lock, flags);
> > +
> > +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (unlikely(!irq)) {
> > +		dev_err(&pdev->dev, "%s: no IRQ resource\n", __func__);
> > +		ret = -ENODEV;
> > +		goto err_free_pdev;
> > +	}
> > +
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (unlikely(!mem)) {
> > +		dev_err(&pdev->dev, "%s: no memory resource\n", __func__);
> > +		ret = -ENODEV;
> > +		goto err_free_pdev;
> > +	}
> > +
> > +	ioarea = request_mem_region(mem->start, resource_size(mem),
> > +			pdev->name);
> > +	if (!ioarea) {
> > +		dev_err(&pdev->dev, "%s: region already claimed\n", __func__);
> > +		ret = -EBUSY;
> > +		goto err_free_pdev;
> > +	}
> > +
> > +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> > +	if (!timer) {
> > +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer\n",
> > +			__func__);
> > +		ret = -ENOMEM;
> > +		goto err_release_ioregion;
> > +	}
> > +
> > +	timer->io_base = ioremap(mem->start, resource_size(mem));
> > +	if (!timer->io_base) {
> > +		dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
> > +		ret = -ENOMEM;
> > +		goto err_free_mem;
> > +	}
> > +
> > +	/*
> > +	 * Following func pointers are required by OMAP1's reset code
> > +	 * in mach-omap1/dmtimer.c to access to low level read/write.
> > +	 */
> > +	if (pdata->is_omap16xx) {
> > +		pdata->dm_timer_read_reg = omap_dm_timer_read_reg;
> > +		pdata->dm_timer_write_reg = omap_dm_timer_write_reg;
> > +		pdata->is_early_init = 0;
> > +	}
> 
> Can this 'is_omap16xx' check be replaced with an IP revision check?
Hmm, this not really!
Unless we introduce a new version to indicate OMAP1.
If this is what you mean I will make the change.

> 
> Kevin

