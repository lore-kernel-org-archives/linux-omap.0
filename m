From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v14 05/12] OMAP: dmtimer: platform driver
Date: Mon, 11 Jul 2011 16:10:55 -0700
Message-ID: <20110711231055.GA8312@google.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
 <1310383759-19059-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:56511 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1GKXLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 19:11:40 -0400
Content-Disposition: inline
In-Reply-To: <1310383759-19059-6-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

On Mon, Jul 11, 2011 at 04:59:12PM +0530, Tarun Kanti DebBarma wrote:
> Add dmtimer platform driver functions which include:
> (1) platform driver initialization
> (2) driver probe function
> (3) driver remove function
> 
...
> +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> +	if (!timer) {
> +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
> +			__func__);
> +		ret = -ENOMEM;
> +		goto err_release_ioregion;
> +	}
> +
> +	timer->io_base = ioremap(mem->start, resource_size(mem));
> +	if (!timer->io_base) {
> +		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
> +		ret = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
> +		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
> +		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
> +	} else {
> +		timer->func_offset = 0;
> +		timer->intr_offset = 0;

Don't need to init kzalloc'ed fields to zero.

> +	}
> +
> +	timer->id = pdev->id;
> +	timer->irq = irq->start;
> +	timer->pdev = pdev;
> +	timer->reserved = 0;

And here.

> +err_free_pdev:
> +	kfree(pdata);

pdata wasn't allocated here, shouldn't be freed here.

> +	platform_device_unregister(pdev);

The platform device wasn't registered here.

...
> +static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
> +{
> +	struct omap_dm_timer *timer, *tmp;
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {


Don't need list_for_each_entry_safe, you have the lock protecting list
modifications held and IRQs off.

> +		if (timer->pdev->id == pdev->id) {
> +			kfree(timer->pdev->dev.platform_data);


Not allocated by this driver.

> +			platform_device_del(timer->pdev);


Not added by this driver.

> +			list_del(&timer->node);
> +			kfree(timer);


Todd

