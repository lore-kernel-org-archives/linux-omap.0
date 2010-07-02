From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [RFC 5/7] OMAP: Introduce set_rate and get_rate API in omap
 device layer
Date: Fri, 2 Jul 2010 17:22:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305B05DAE@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com>
 <1278065909-32148-5-git-send-email-thara@ti.com>
 <1278065909-32148-6-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42047 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab0GBLwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:52:15 -0400
In-Reply-To: <1278065909-32148-6-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Gopinath, Thara
> Sent: Friday, July 02, 2010 3:48 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Sripathy,
> Vishwanath; Sawant, Anand; Basak, Partha; Gopinath, Thara
> Subject: [RFC 5/7] OMAP: Introduce set_rate and get_rate API in omap device layer
> 
> This patch adds omap_device_set_rate and omap_device_get_rate
> API's which can be used to generic device rate scaling.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/omap_device.c              |   87
> +++++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-
> omap/include/plat/omap_device.h
> index 3694b62..e0d06bb 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -114,6 +114,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
> 
> +int omap_device_set_rate(struct device *dev, unsigned long rate);
> +unsigned long omap_device_get_rate(struct device *dev);
> 
>  /*
>   * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 6614cba..900bb5d 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -85,6 +85,8 @@
> 
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/opp.h>
> +#include <plat/voltage.h>
> 
>  /* These parameters are passed to _omap_device_{de,}activate() */
>  #define USE_WAKEUP_LAT			0
> @@ -734,3 +736,88 @@ int omap_device_enable_clocks(struct omap_device *od)
>  	/* XXX pass along return value here? */
>  	return 0;
>  }
> +
> +/**
> + * omap_device_set_rate - Set a new rate at which the device is to operate
> + * @dev : the device pointer
> + * @rate : the rnew rate for the device.
> + *
> + * This API gets the device opp table associated with this device and
> + * tries putting the device to the requested rate and the voltage domain
> + * associated with the device to the voltage corresponding to the
> + * requested rate. Since multiple devices can be assocciated with a
> + * voltage domain this API finds out the possible voltage the
> + * voltage domain can enter and then decides on the final device
> + * rate. Return 0 on success else the error value
> + */
> +int omap_device_set_rate(struct device *dev, unsigned long rate)
> +{
> +	struct device_opp *dev_opp;
> +	struct omap_opp *opp;
> +	unsigned long volt, freq;
> +	int ret;
> +
> +	dev_opp = opp_find_dev_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_warn(dev, "%s: Unable to find device opp table\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	/* Get the possible rate from the opp layer */
> +	freq = rate;
> +	opp = opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "%s: Unable to find OPP for freq%ld\n",
> +			__func__, rate);
> +		return -ENODEV;
> +	}
> +	if (unlikely(freq != rate))
> +		dev_warn(dev, "%s: Available freq %ld != dpll freq %ld.\n",
> +			__func__, freq, rate);
> +
> +	/* Get the voltage corresponding to the requested frequency */
> +	volt = opp_get_voltage(opp);
> +
> +	/*
> +	 * Call into the voltage layer to get the final voltage possible
> +	 * for the voltage domain associated with the device.
> +	 */
> +
> +	ret = omap_volt_get_final(dev_opp->volt_domain, dev, &volt);
> +	if (ret) {
> +		dev_err(dev, "%s: Unable to get the final volt for scaling\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	/* Do the actual scaling */
> +	return omap_voltage_scale(dev_opp->volt_domain, volt);
This function also needs to be lock protected to avoid race conditions involved when multiple guys try to scale the voltage simultaneously.

> +}
> +
> +/**
> + * omap_device_get_rate - Gets the current operating rate of the device
> + * @dev - the device pointer
> + *
> + * This API returns the current operating rate of the device on success.
> + * Else returns the error value.
> + */
> +unsigned long omap_device_get_rate(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +
> +	dev_opp = opp_find_dev_opp(dev);
> +
> +	if (IS_ERR(dev_opp)) {
> +		dev_warn(dev, "%s: Unable to find device opp table\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	if (!dev_opp->get_rate) {
> +		dev_warn(dev, "%s: No get_rate API\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return dev_opp->get_rate(dev);
> +}
> --
> 1.7.0.rc1.33.g07cf0f

