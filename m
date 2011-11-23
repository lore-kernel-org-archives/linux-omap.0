From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the
 AVS driver framework
Date: Wed, 23 Nov 2011 15:34:37 -0800
Message-ID: <20111123233437.GA17638@google.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
 <1321974370-25800-26-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:64961 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1KWXem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 18:34:42 -0500
Received: by ggnp2 with SMTP id p2so96492ggn.1
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 15:34:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1321974370-25800-26-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>, nm@ti.com

...
> +int sr_configure_errgen(struct smartreflex *sr)
> +{
> +	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
> +	u32 sr_config, sr_errconfig;
> +
> +	if (IS_ERR_OR_NULL(sr))
> +		return -EINVAL;
> +
> +	if (!sr_calculate_clk_length(sr))
> +		return -EINVAL;
> +
> +	sr_config = sr->proto_sr_config;
> +	sr_config |=  SRCONFIG_ERRGEN_EN;
> +	sr_write_reg(sr, SRCONFIG, sr_config);
> +
> +	sr_errconfig = (pdata->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
> +		(pdata->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
> +		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
> +	sr_modify_reg(sr, sr->errconfig_offs, (SR_ERRWEIGHT_MASK |
> +		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
> +		sr_errconfig);
> +
> +	/* Enabling the interrupts if the ERROR module is used */
> +	sr_modify_reg(sr, sr->errconfig_offs,
> +		sr->vpboundint_en, (sr->vpboundint_en | sr->vpboundint_st));

Nishanth Menon has a patch for the reversed order of parameters for
mask and bits to set in the above.

> +
> +	return 0;
> +}

...
> +int __init sr_common_probe(struct platform_device *pdev,
> +			   struct smartreflex *sr)
> +{
> +	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
> +	struct resource *mem, *irq;
> +	int ret = 0;
> +
> +	sr->name = kasprintf(GFP_KERNEL, "sr_%s", pdata->name);
> +	if (!sr->name) {
> +		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
> +		return -ENODEV;

Need free(sr->name) ?

> +	}
> +
> +	mem = request_mem_region(mem->start, resource_size(mem),
> +					dev_name(&pdev->dev));
> +	if (!mem) {
> +		dev_err(&pdev->dev, "%s: no mem region\n", __func__);
> +		return -EBUSY;
> +	}
> +
> +	sr->base = ioremap(mem->start, resource_size(mem));
> +	if (!sr->base) {
> +		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
> +		ret = -ENOMEM;
> +		goto err_release_region;
> +	}
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "%s: no IRQ resource defined\n", __func__);
> +		ret = -ENODEV;
> +		goto err_iounmap;
> +	}
> +	sr->irq = irq->start;
> +
> +	ret = request_irq(sr->irq, sr->isr, 0, sr->name, (void *)sr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: could not register interrupt "
> +				    "handler\n", __func__);
> +		goto err_iounmap;
> +	}
> +
> +	pdata->sr = sr;
> +
> +	sr->pdev = pdev;
> +	sr->voltdm = pdata->voltdm;
> +
> +	sr->autocomp_active = false;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_irq_safe(&pdev->dev);
> +
> +#ifdef CONFIG_POWER_AVS_DEBUG
> +	ret = sr_debugfs_setup(pdev, sr);
> +	if (ret)
> +		goto err_free_irq;
> +#endif
> +
> +	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
> +
> +	return ret;
> +
> +err_free_irq:
> +	free_irq(sr->irq, (void *)sr);
> +err_iounmap:
> +	iounmap(sr->base);
> +err_release_region:
> +	release_mem_region(mem->start, resource_size(mem));
> +
> +	return ret;
> +}
> +
> +int __devexit sr_remove(struct platform_device *pdev)
> +{
> +	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
> +	struct smartreflex *sr;
> +	struct resource *mem;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	sr = pdata->sr;
> +	if (IS_ERR(sr)) {

Sometimes set to NULL, use IS_ERR_OR_NULL ?

> +		dev_warn(&pdev->dev, "%s: smartreflex struct not found\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (sr->autocomp_active)
> +		sr_stop_vddautocomp(sr);
> +#ifdef CONFIG_POWER_AVS_DEBUG
> +	if (sr->dbg_dir)
> +		debugfs_remove_recursive(sr->dbg_dir);
> +#endif
> +	free_irq(sr->irq, (void *)sr);
> +	iounmap(sr->base);

Need free(sr->name) ?

> +	kfree(sr);
> +	pdata->sr = NULL;
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mem->start, resource_size(mem));
> +
> +	return 0;
> +}

...
> +static irqreturn_t _interrupt(int irq, void *data)
> +{
> +	struct smartreflex *sr = (struct smartreflex *)data;
> +	u32 status = 0;
> +
> +	/* Read the status bits */
> +	sr_read_reg(sr, IRQSTATUS);
> +
> +	/* Clear them by writing back */
> +	sr_write_reg(sr, IRQSTATUS, status);

Felipe Balbi sent a patch to the list fixing the write of zero,
failing to clear the interrupts, to the list recently.


Todd
