From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 2/4] PM / Domains: add setter for dev.pm_domain
Date: Sun, 25 Oct 2015 16:18:18 +0100
Message-ID: <2258737.mym2G0FovV@vostro.rjw.lan>
References: <1445441654-31778-1-git-send-email-tomeu.vizoso@collabora.com> <1445441654-31778-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445441654-31778-3-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, David Airlie <airlied@linux.ie>, Tomas Winkler <tomas.winkler@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, October 21, 2015 05:34:12 PM Tomeu Vizoso wrote:
> Adds a function that sets the pointer to dev_pm_domain in struct device
> and that warns if the device has already finished probing. The reason
> why we want to enforce that is because in the general case that can
> cause problems and also that we can simplify code quite a bit if we can
> always assume that.
> 
> This patch also changes all current code that directly sets the
> dev.pm_domain pointer.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v9:
> - Add docs noting the need for the device lock to be held before calling
>   dev_pm_domain_set()
> 
> Changes in v8:
> - Add dev_pm_domain_set() and update code to use it
> 
>  arch/arm/mach-omap2/omap_device.c |  7 ++++---
>  drivers/acpi/acpi_lpss.c          |  5 +++--
>  drivers/acpi/device_pm.c          |  5 +++--
>  drivers/base/power/clock_ops.c    |  5 +++--
>  drivers/base/power/common.c       | 21 +++++++++++++++++++++
>  drivers/base/power/domain.c       |  4 ++--
>  drivers/gpu/vga/vga_switcheroo.c  | 10 +++++-----
>  drivers/misc/mei/pci-me.c         |  5 +++--
>  drivers/misc/mei/pci-txe.c        |  5 +++--
>  include/linux/pm_domain.h         |  3 +++
>  10 files changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 4cb8fd9f741f..204101d11632 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -32,6 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/notifier.h>
> @@ -168,7 +169,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  			r->name = dev_name(&pdev->dev);
>  	}
>  
> -	pdev->dev.pm_domain = &omap_device_pm_domain;
> +	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
>  
>  	if (device_active) {
>  		omap_device_enable(pdev);
> @@ -180,7 +181,7 @@ odbfd_exit1:
>  odbfd_exit:
>  	/* if data/we are at fault.. load up a fail handler */
>  	if (ret)
> -		pdev->dev.pm_domain = &omap_device_fail_pm_domain;
> +		dev_pm_domain_set(&pdev->dev, &omap_device_fail_pm_domain);
>  
>  	return ret;
>  }
> @@ -701,7 +702,7 @@ int omap_device_register(struct platform_device *pdev)
>  {
>  	pr_debug("omap_device: %s: registering\n", pdev->name);
>  
> -	pdev->dev.pm_domain = &omap_device_pm_domain;
> +	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
>  	return platform_device_add(pdev);
>  }
>  
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index f51bd0d0bc17..cc6e1abc69b3 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/clk-lpss.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  
> @@ -706,7 +707,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>  
>  	switch (action) {
>  	case BUS_NOTIFY_ADD_DEVICE:
> -		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
> +		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
>  		if (pdata->dev_desc->flags & LPSS_LTR)
>  			return sysfs_create_group(&pdev->dev.kobj,
>  						  &lpss_attr_group);
> @@ -714,7 +715,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>  	case BUS_NOTIFY_DEL_DEVICE:
>  		if (pdata->dev_desc->flags & LPSS_LTR)
>  			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
> -		pdev->dev.pm_domain = NULL;
> +		dev_pm_domain_set(&pdev->dev, NULL);
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 4806b7f856c4..8c5955bf9bbf 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -22,6 +22,7 @@
>  #include <linux/export.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
>  #include "internal.h"
> @@ -1076,7 +1077,7 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
>  	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
> -		dev->pm_domain = NULL;
> +		dev_pm_domain_set(dev, NULL);
>  		acpi_remove_pm_notifier(adev);
>  		if (power_off) {
>  			/*
> @@ -1128,7 +1129,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  		return -EBUSY;
>  
>  	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
> -	dev->pm_domain = &acpi_general_pm_domain;
> +	dev_pm_domain_set(dev, &acpi_general_pm_domain);
>  	if (power_on) {
>  		acpi_dev_pm_full_power(adev);
>  		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 652b5a367c1f..e80fda6c03a9 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -15,6 +15,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
>  #ifdef CONFIG_PM
> @@ -346,7 +347,7 @@ static int pm_clk_notify(struct notifier_block *nb,
>  		if (error)
>  			break;
>  
> -		dev->pm_domain = clknb->pm_domain;
> +		dev_pm_domain_set(dev, clknb->pm_domain);
>  		if (clknb->con_ids[0]) {
>  			for (con_id = clknb->con_ids; *con_id; con_id++)
>  				pm_clk_add(dev, *con_id);
> @@ -359,7 +360,7 @@ static int pm_clk_notify(struct notifier_block *nb,
>  		if (dev->pm_domain != clknb->pm_domain)
>  			break;
>  
> -		dev->pm_domain = NULL;
> +		dev_pm_domain_set(dev, NULL);
>  		pm_clk_destroy(dev);
>  		break;
>  	}
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index f32b802b98f4..a70f8a5cdfd7 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -128,3 +128,24 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>  		dev->pm_domain->detach(dev, power_off);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> +
> +/**
> + * dev_pm_domain_set - Set PM domain of a device.
> + * @dev: Device whose PM domain is to be set.
> + * @pd: PM domain to be set, or NULL.
> + *
> + * Sets the PM domain the device belongs to. The PM domain of a device needs
> + * to be set before its probe finishes (it's bound to a driver).
> + *
> + * This function must be called with the device lock held.

So obviously every caller of this function that doesn't lock the device has to
be called with the device locked already.

Have you verified that this is the case?

Thanks,
Rafael
