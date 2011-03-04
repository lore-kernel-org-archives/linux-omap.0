From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 5/8] OMAP: dmtimer: platform driver
Date: Thu, 03 Mar 2011 17:29:30 -0800
Message-ID: <87pqq7lll1.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36283 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751679Ab1CDB3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 20:29:33 -0500
Received: by mail-yw0-f51.google.com with SMTP id 4so726855ywg.24
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 17:29:32 -0800 (PST)
In-Reply-To: <1298546811-27055-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Add dmtimer platform driver functions which include:
> (1) platform driver initialization
> (2) driver probe function
> (3) driver remove function
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

[...]

> +/**
> + * omap_dm_timer_probe - probe function called for every registered device
> + * @pdev:	pointer to current timer platform device
> + *
> + * Called by driver framework at the end of device registration for all
> + * timer devices.
> + */
> +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct omap_dm_timer *timer;
> +	struct resource *mem, *irq, *ioarea;
> +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry(timer, &omap_timer_list, node)
> +		if (!pdata->is_early_init && timer->id == pdev->id) {
> +			timer->pdev = pdev;
> +			spin_unlock_irqrestore(&dm_timer_lock, flags);
> +			dev_dbg(&pdev->dev, "Regular Probed\n");
> +			return 0;
> +		}
> +	spin_unlock_irqrestore(&dm_timer_lock, flags);
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (unlikely(!irq)) {
> +		dev_err(&pdev->dev, "%s: no IRQ resource\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!mem)) {
> +		dev_err(&pdev->dev, "%s: no memory resource\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	ioarea = request_mem_region(mem->start, resource_size(mem),
> +			pdev->name);
> +	if (!ioarea) {
> +		dev_err(&pdev->dev, "%s: region already claimed\n", __func__);
> +		ret = -EBUSY;
> +		goto err_free_pdev;
> +	}
> +
> +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> +	if (!timer) {
> +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer\n",
> +			__func__);
> +		ret = -ENOMEM;
> +		goto err_release_ioregion;
> +	}
> +
> +	timer->io_base = ioremap(mem->start, resource_size(mem));
> +	if (!timer->io_base) {
> +		dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
> +		ret = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	/*
> +	 * Following func pointers are required by OMAP1's reset code
> +	 * in mach-omap1/dmtimer.c to access to low level read/write.
> +	 */
> +	if (pdata->is_omap16xx) {
> +		pdata->dm_timer_read_reg = omap_dm_timer_read_reg;
> +		pdata->dm_timer_write_reg = omap_dm_timer_write_reg;
> +		pdata->is_early_init = 0;
> +	}

Can this 'is_omap16xx' check be replaced with an IP revision check?

Kevin

