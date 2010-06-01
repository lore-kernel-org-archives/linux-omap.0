From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Tue, 1 Jun 2010 11:41:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
 <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51009 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0FAGLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 02:11:41 -0400
In-Reply-To: <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, May 28, 2010 2:43 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
> 
> Hook into the platform bus methods for suspend and resume and
> use the omap_device API to automatically idle and enable the
> device on suspend and resume.
> 
> This allows device drivers to get rid of direct management of their
> clocks in their suspend/resume paths, and let omap_device do it for
> them.
> 
> We currently use the _noirq (late suspend, early resume) versions of
> the suspend/resume methods to ensure that the device is not disabled
> too early for any drivers also using the _noirq methods.
> 
> NOTE: only works for devices with omap_hwmod support.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm_bus.c |   61 
> ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm_bus.c 
> b/arch/arm/mach-omap2/pm_bus.c
> index 69acaa5..3787da8 100644
> --- a/arch/arm/mach-omap2/pm_bus.c
> +++ b/arch/arm/mach-omap2/pm_bus.c
> @@ -70,3 +70,64 @@ int platform_pm_runtime_idle(struct device *dev)
>  };
>  #endif /* CONFIG_PM_RUNTIME */
>  
> +#ifdef CONFIG_SUSPEND
> +int platform_pm_suspend_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *odev = to_omap_device(pdev);
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->suspend_noirq)
> +			ret = drv->pm->suspend_noirq(dev);
> +	}
> +
> +	if (omap_device_is_valid(odev)) {
> +		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
> +			dev_dbg(dev, "no automatic bus-level 
> system resume.\n");
> +			return 0;
> +		}
> +
> +		dev_dbg(dev, "%s\n", __func__);
> +		omap_device_idle(pdev);

Is it expected that a device is always in enabled state at this point?
If the device is already in idle a call to omap_device_idle unconditionally
throws up warnings from the omap_device api.

> +	} else {
> +		dev_dbg(dev, "not an omap_device\n");
> +	}
> +
> +	return ret;
> +}
> +
> +int platform_pm_resume_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *odev = to_omap_device(pdev);
> +	int ret = 0;
> +
> +	if (omap_device_is_valid(odev)) {
> +		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
> +			dev_dbg(dev, "no automatic bus-level 
> system resume.\n");
> +			return 0;
> +		}
> +
> +		dev_dbg(dev, "%s\n", __func__);
> +		omap_device_enable(pdev);
> +	} else {
> +		dev_dbg(dev, "not an omap_device\n");
> +	}
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->resume_noirq)
> +			ret = drv->pm->resume_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +#endif /* CONFIG_SUSPEND */
> -- 
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 