From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [RFC PATCH 5/6 V2] OMAP4: Temperature sensor device support
Date: Thu, 18 Aug 2011 22:47:05 -0700
Message-ID: <20110819054705.GB2901@google.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
 <1313664735-8917-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:63486 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab1HSFrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 01:47:10 -0400
Content-Disposition: inline
In-Reply-To: <1313664735-8917-6-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Aug 18, 2011 at 04:22:14PM +0530, Keerthy wrote:
...
> +int omap_temp_sensor_device_idle(struct omap_device *od)
> +{
> +	struct	omap_temp_sensor_registers	*registers;
> +	struct	resource			*mem;
> +	void	__iomem				*phy_base;
> +	unsigned long				timeout;
> +	u32					ret = 0, temp;
> +
> +	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&od->pdev.dev, "no mem resource\n");
> +		ret = -EINVAL;
> +		goto plat_res_err;
> +	}
> +
> +	phy_base = ioremap(mem->start, resource_size(mem));

Check NULL return.

> +
> +	if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
> +		registers = &omap_mpu_temp_sensor_registers;
> +
> +	temp = __raw_readl(phy_base + registers->temp_sensor_ctrl);

Compile warning on possible use of uninitialized value?

Suggest return error if string comparison (ugh) does not match.

> +	temp |= registers->bgap_tempsoff_mask;
> +
> +	/* BGAP_TEMPSOFF should be set to 1 before gating clock */
> +	__raw_writel(temp, phy_base + registers->temp_sensor_ctrl);
> +	temp = __raw_readl(phy_base + registers->bgap_status);
> +	timeout = jiffies + msecs_to_jiffies(5);
> +
> +	/* wait till the clean stop bit is set or till the timeout expires */
> +	while (!(temp | registers->status_clean_stop_mask) &&
> +			!(time_after(jiffies, timeout))) {
> +		temp = __raw_readl(phy_base + registers->bgap_status);
> +		usleep_range(500, 2000);
> +	}
> +
> +	if (time_after(jiffies, timeout))
> +		dev_err(&od->pdev.dev, "Clean stop bit not set\n");
> +
> +	ret = omap_device_idle_hwmods(od);
> +
> +plat_res_err:
> +	return ret;

phy_base not saved anywhere, VM leak.  Need iounmap(phy_base).

> +}
> +
> +int omap_temp_sensor_device_activate(struct omap_device *od)
> +{
> +	struct	omap_temp_sensor_registers	*registers;
> +	struct	resource			*mem;
> +	void	__iomem				*phy_base;
> +	u32					ret = 0, temp;
> +
> +	ret = omap_device_enable_hwmods(od);
> +	if (ret < 0)
> +		return ret;
> +	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&od->pdev.dev, "no mem resource\n");
> +		return -EINVAL;
> +	}
> +
> +	phy_base = ioremap(mem->start, resource_size(mem));

Check NULL return.

> +
> +	if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
> +		registers = &omap_mpu_temp_sensor_registers;
> +
> +	temp = __raw_readl(phy_base + registers->temp_sensor_ctrl);

Error out if not "mpu".

> +	temp &= ~(registers->bgap_tempsoff_mask);
> +	/* BGAP_TEMPSOFF should be reset to 0 */
> +	__raw_writel(temp,
> +			phy_base + registers->temp_sensor_ctrl);
> +
> +	return 0;

iounmap(phy_base)

> +}
> +
> +static struct omap_device_pm_latency omap_temp_sensor_latency[] = {
> +	{
> +		.deactivate_func = omap_temp_sensor_device_idle,
> +		.activate_func =  omap_temp_sensor_device_activate,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	}
> +};
> +
> +static DEFINE_IDR(temp_sensor_device_idr);
> +
> +static int temp_sensor_dev_init(struct omap_hwmod *oh, void *user)
> +{
> +	struct	omap_temp_sensor_pdata		*temp_sensor_pdata;
> +	struct	omap_device			*od;
> +	struct	omap_temp_sensor_dev_attr	*temp_sensor_dev_attr;
> +	int					ret = 0;
> +	int					num;
> +	struct	mutex			sensor_mutex;	/* sensor mutex */
> +
> +	mutex_init(&sensor_mutex);
> +
> +	temp_sensor_pdata =
> +	    kzalloc(sizeof(*temp_sensor_pdata), GFP_KERNEL);
> +	if (!temp_sensor_pdata) {
> +		dev_err(&oh->od->pdev.dev,
> +			"Unable to allocate memory for temp sensor pdata\n");
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&sensor_mutex);

Mutex just init'ed above, this code can't run concurrent with any
other accessors.

> +	ret = idr_pre_get(&temp_sensor_device_idr, GFP_KERNEL);
> +	if (ret < 0) {
> +		mutex_unlock(&sensor_mutex);
> +		goto fail_id;
> +	}
> +	ret = idr_get_new(&temp_sensor_device_idr, temp_sensor_pdata, &num);
> +	if (ret < 0) {
> +		mutex_unlock(&sensor_mutex);
> +		goto fail_id;
> +	}
> +	mutex_unlock(&sensor_mutex);
> +
> +	temp_sensor_dev_attr = oh->dev_attr;
> +	if (!strcmp(temp_sensor_dev_attr->name, "mpu"))
> +		temp_sensor_pdata->registers = &omap_mpu_temp_sensor_registers;
> +
> +	od = omap_device_build("omap_temp_sensor", num,
> +		oh, temp_sensor_pdata, sizeof(*temp_sensor_pdata),
> +	       omap_temp_sensor_latency,
> +			ARRAY_SIZE(omap_temp_sensor_latency), 0);

Inconsistent tabbing.

> +	if (IS_ERR(od)) {
> +		dev_warn(&oh->od->pdev.dev,
> +			"Could not build omap_device for %s\n", oh->name);
> +		ret = PTR_ERR(od);
> +	}
> +
> +fail_id:
> +	kfree(temp_sensor_pdata);
> +
> +	return ret;
> +}


Todd
