From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/6] OMAP: PM: register to the per-device PM QoS framework
Date: Thu, 17 Nov 2011 13:24:25 -0800
Message-ID: <87d3cq30ja.fsf@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:32819 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992Ab1KQVYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 16:24:30 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so1657586ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 13:24:29 -0800 (PST)
In-Reply-To: <1319032263-22699-4-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 19 Oct 2011 15:51:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Implement the devices wake-up latency constraints using the global
> device PM QoS notification handler which applies the constraints to the
> underlying layer by calling the corresponding function at hwmod level.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 3feb359..58b4b76 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -11,13 +11,16 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/notifier.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/opp.h>
> +#include <linux/pm_qos.h>
>  
>  #include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
>  #include <plat/common.h>
> +#include <plat/omap_hwmod.h>
>  
>  #include "voltage.h"
>  #include "powerdomain.h"
> @@ -242,11 +245,71 @@ static void __init omap4_init_voltages(void)
>  	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
>  }
>  
> +/* Interface to the per-device PM QoS framework */
> +static int omap2_dev_pm_qos_handler(struct notifier_block *nb,
> +				    unsigned long new_value,
> +				    void *req)
> +{
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	struct dev_pm_qos_request *dev_pm_qos_req = req;
> +
> +	pr_debug("OMAP PM CONSTRAINTS: req@0x%p, new_value=%lu\n",

s/CONSTRAINTS/constraints/
another one below.

> +		 req, new_value);
> +
> +	/* Look for the platform device for the constraint target device */
> +	pdev = to_platform_device(dev_pm_qos_req->dev);
> +
> +	/* Try to catch non platform devices */

why?

> +	if (pdev->name == NULL) {
> +		pr_err("%s: Error: platform device for device %s not valid\n",
> +		       __func__, dev_name(dev_pm_qos_req->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* Find the associated omap_device for dev */
> +	od = container_of(pdev, struct omap_device, pdev);

What about devices that are valid platform_devices, but not omap_devices?

> +	if (od->hwmods_cnt != 1) {
> +		pr_err("%s: Error: No unique hwmod for device %s\n",
> +		       __func__, dev_name(dev_pm_qos_req->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* Find the primary omap_hwmod for dev */
> +	oh = od->hwmods[0];
> +
> +	pr_debug("OMAP PM CONSTRAINTS: req@0x%p, dev=0x%p, new_value=%lu\n",
> +		 req, dev_pm_qos_req->dev, new_value);
> +
> +	/* Apply the constraint */
> +	return omap_hwmod_set_wkup_lat_constraint(oh, dev_pm_qos_req,
> +						  new_value);
> +}
> +
> +static struct notifier_block omap2_dev_pm_qos_notifier = {
> +	.notifier_call	= omap2_dev_pm_qos_handler,
> +};
> +
> +static int __init omap2_dev_pm_qos_init(void)
> +{
> +	int ret;
> +
> +	ret = dev_pm_qos_add_global_notifier(&omap2_dev_pm_qos_notifier);
> +	if (ret)
> +		WARN(1, KERN_ERR "Cannot add global notifier for dev PM QoS\n");

minor: could use WARN_ON()

> +	return ret;
> +}
> +
>  static int __init omap2_common_pm_init(void)
>  {
>  	omap2_init_processor_devices();
>  	omap_pm_if_init();
>  
> +	/* Register to the per-device PM QoS framework */
> +	omap2_dev_pm_qos_init();
> +
>  	return 0;
>  }
>  postcore_initcall(omap2_common_pm_init);

Kevin
