From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 6/6 V3] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 25 Aug 2011 00:24:19 -0700
Message-ID: <20110825072419.GA12528@google.com>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
 <1314196632-8207-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:22086 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1HYHYz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 03:24:55 -0400
Content-Disposition: inline
In-Reply-To: <1314196632-8207-7-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Wed, Aug 24, 2011 at 08:07:12PM +0530, Keerthy wrote:
...
> +	temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));

Check NULL return.

temp_sensor->phy_base is never iounmapped in error paths or _remove
function.

...
> +static int __devexit omap_temp_sensor_remove(struct platform_device *pdev)
> +{
> +	struct omap_temp_sensor *temp_sensor = platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(&pdev->dev);
> +	kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
> +	sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +			&omap_temp_sensor_group);
> +	omap_temp_sensor_clk_disable(temp_sensor);
> +	free_irq(temp_sensor->irq, temp_sensor);

free_irq before omap_temp_sensor_clk_disable, to avoid ISR attempting
to access hardware while unclocked.

> +	clk_put(temp_sensor->clock);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	mutex_destroy(&temp_sensor->sensor_mutex);
> +	kfree(temp_sensor);
> +
> +	return 0;
> +}

Todd
