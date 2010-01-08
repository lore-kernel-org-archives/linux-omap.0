From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] DSPBRIDGE: sysfs entry for global driver state
Date: Thu, 7 Jan 2010 20:17:26 -0600
Message-ID: <4B4695B6.1010305@ti.com>
References: <1262912431-29999-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45509 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab0AHCRb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 21:17:31 -0500
In-Reply-To: <1262912431-29999-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/07/2010 07:00 PM, the following:
> This patch creates a new sysfs entry to query the driver
> state without making any bridge direct call, this is
> useful to monitor driver state without creating any handle
> to bridge driver.
why sysfs and not debugfs considering that this is a debug feature?

this in my mind is a useful feature, no question, but I wonder if this 
is a feature we might want to expand upon and allow for user space 
applications to show beyond the basic run levels - show loading level(as 
an example) thru the same interface?? just my 2 cents..

> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |   87 +++++++++++++++++++++++++++++++
>  1 files changed, 87 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index c853854..3a4d058 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -58,11 +58,13 @@
>  #include <linux/init.h>
>  #include <linux/moduleparam.h>
>  #include <linux/cdev.h>
> +#include <linux/kobject.h>
>  
>  /*  ----------------------------------- DSP/BIOS Bridge */
>  #include <dspbridge/std.h>
>  #include <dspbridge/dbdefs.h>
>  #include <dspbridge/errbase.h>
> +#include <_tiomap.h>
>  
>  /*  ----------------------------------- Trace & Debug */
>  #include <dspbridge/gt.h>
> @@ -148,6 +150,10 @@ static int omap34xxbridge_suspend_lockout(
>  }
>  #endif
>  
> +/* Sysfs interface */
> +static void bridge_create_sysfs(struct platform_device *pdev);
> +static void bridge_destroy_sysfs(struct platform_device *pdev);
> +
>  #ifdef DEBUG
>  module_param(GT_str, charp, 0);
>  MODULE_PARM_DESC(GT_str, "GT string, default = NULL");
> @@ -297,6 +303,9 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>  	device_create(bridge_class, NULL, MKDEV(driver_major, driver_minor),
>  			NULL, "DspBridge");
>  
> +	/* Create sysfs interface */
> +	bridge_create_sysfs(pdev);
> +
>  	GT_init();
>  	GT_create(&driverTrace, "LD");
>  
> @@ -454,6 +463,9 @@ func_cont:
>  	SERVICES_Exit();
>  	GT_exit();
>  
> +	/* Remove driver sysfs entries */
> +	bridge_destroy_sysfs(pdev);
> +
>  	devno = MKDEV(driver_major, driver_minor);
>  	if (bridge_device) {
>  		cdev_del(&bridge_device->cdev);
> @@ -677,6 +689,81 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
>  }
>  #endif
>  
> +/*
> + * Sysfs

huh?

> + */
> +static ssize_t drv_state_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct WMD_DEV_CONTEXT *dev_ctxt;
> +	struct DEV_OBJECT *dev_obj = NULL;
> +	char *drv_state = "unknown";
> +
> +	dev_obj = (struct DEV_OBJECT *)DRV_GetFirstDevObject();
> +	DEV_GetWMDContext(dev_obj, &dev_ctxt);
> +
> +	if (!dev_ctxt)
> +		goto err;
> +
> +	switch (dev_ctxt->dwBrdState) {
> +	case BRD_STOPPED:
> +		drv_state = "stopped";
> +		break;
> +	case BRD_IDLE:
> +		drv_state = "idle";
> +		break;
> +	case BRD_RUNNING:
> +		drv_state = "running";
> +		break;
> +	case BRD_LOADED:
> +		drv_state = "loaded";
> +		break;
> +	case BRD_SLEEP_TRANSITION:
> +		drv_state = "sleep transition";
> +		break;
> +	case BRD_HIBERNATION:
> +		drv_state = "hibernation";
> +		break;
> +	case BRD_RETENTION:
> +		drv_state = "retention";
> +		break;
> +	case BRD_DSP_HIBERNATION:
> +		drv_state = "self initiated hibernation";
> +		break;
> +	case BRD_ERROR:
> +		drv_state = "error";
> +		break;
default?

> +	}
> +
> +err:
> +	return sprintf(buf, "%s\n", drv_state);
> +}
> +static DEVICE_ATTR(drv_state, S_IRUGO, drv_state_show, NULL);
> +
> +static struct attribute *attrs[] = {
> +	&dev_attr_drv_state.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = attrs,
> +};
> +
> +static void bridge_create_sysfs(struct platform_device *pdev)
> +{
> +	int error;
> +
> +	error = sysfs_create_group(&pdev->dev.kobj, &attr_group);
> +
> +	if (error)
> +		kobject_put(&pdev->dev.kobj);
> +}
> +
> +static void bridge_destroy_sysfs(struct platform_device *pdev)
> +{
> +	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
> +}
> +
>  /* Bridge driver initialization and de-initialization functions */
>  module_init(bridge_init);
>  module_exit(bridge_exit);


-- 
Regards,
Nishanth Menon
