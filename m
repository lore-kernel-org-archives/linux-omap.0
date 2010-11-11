From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 04/14] OMAP: Introduce API to register a device with a voltagedomain
Date: Wed, 10 Nov 2010 16:49:26 -0800
Message-ID: <87sjz8y99l.fsf@deeprootsystems.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43675 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401Ab0KKAta (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 19:49:30 -0500
Received: by ywc21 with SMTP id 21so199254ywc.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 16:49:30 -0800 (PST)
In-Reply-To: <1288366708-32302-5-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 29 Oct 2010 21:08:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds an API in the voltage layer that
> can be used  during omap_device_build to register the built
> device with the voltage domain. This API is to be typically called
> only once per device during the device registeration. This approach
> makes it easy during dvfs to scale all the devices associated with
> a voltage domain and then scale the voltage domain.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

>  /* Generic voltage init functions */
> @@ -1240,6 +1251,40 @@ int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
>  	return 0;
>  }
>  
> +int omap_voltage_add_dev(struct voltagedomain *voltdm, struct device *dev)

minor nit: I prefer this be a 'register' function,
e.g. omap_voltage_register (or _register_dev)

[...]

> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index abe933c..7c902a6 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -86,6 +86,7 @@
>  
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/voltage.h>
>  
>  /* These parameters are passed to _omap_device_{de,}activate() */
>  #define USE_WAKEUP_LAT			0
> @@ -453,6 +454,17 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	for (i = 0; i < oh_cnt; i++) {
>  		hwmods[i]->od = od;
>  		_add_optional_clock_alias(od, hwmods[i]);
> +		if (hwmods[i]->vdd_name) {

Use:

                if (!is_early_device && hwmods[i]->vdd_name)              

> +			struct omap_hwmod *oh = hwmods[i];
> +			struct voltagedomain *voltdm;
> +
> +			if (is_early_device)
> +				continue;

and drop this check


> +			voltdm = omap_voltage_domain_lookup(oh->vdd_name);
> +			if (!omap_voltage_add_dev(voltdm, &od->pdev.dev))
> +				oh->voltdm = voltdm;
> +		}
>  	}
>  
>  	if (ret)

Kevin

