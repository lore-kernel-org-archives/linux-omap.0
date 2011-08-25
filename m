From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH 6/6 V3] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 25 Aug 2011 08:54:57 -0700
Message-ID: <1314287697.2796.38.camel@groeck-laptop>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
	 <1314196632-8207-7-git-send-email-j-keerthy@ti.com>
	 <20110825072419.GA12528@google.com>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:53510 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab1HYPzu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 11:55:50 -0400
In-Reply-To: <20110825072419.GA12528@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, 2011-08-25 at 03:24 -0400, Todd Poynor wrote:
> On Wed, Aug 24, 2011 at 08:07:12PM +0530, Keerthy wrote:
> ...
> > +	temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> 
> Check NULL return.
> 
> temp_sensor->phy_base is never iounmapped in error paths or _remove
> function.
> 
> ...
> > +static int __devexit omap_temp_sensor_remove(struct platform_device *pdev)
> > +{
> > +	struct omap_temp_sensor *temp_sensor = platform_get_drvdata(pdev);
> > +
> > +	hwmon_device_unregister(&pdev->dev);

Should be 
	hwmon_device_unregister(temp_sensor->hwmon_dev);
since that is what was registered, but then the following accesses using
temp_sensor->hwmon_dev won't work anymore and should probably use
&pdev->dev.kobj as parameter instead. Overall the use of
temp_sensor->hwmon_dev vs. &pdev->dev looks questionable to me.

> > +	kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
> > +	sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> > +			&omap_temp_sensor_group);
> > +	omap_temp_sensor_clk_disable(temp_sensor);
> > +	free_irq(temp_sensor->irq, temp_sensor);
> 
> free_irq before omap_temp_sensor_clk_disable, to avoid ISR attempting
> to access hardware while unclocked.
> 
Also, t_cold and t_hot interrupts should be disabled before calling
free_irq (and actually before anything is unregistered).

> > +	clk_put(temp_sensor->clock);
> > +	dev_set_drvdata(&pdev->dev, NULL);
> > +	mutex_destroy(&temp_sensor->sensor_mutex);
> > +	kfree(temp_sensor);
> > +
> > +	return 0;
> > +}
> 
> Todd


