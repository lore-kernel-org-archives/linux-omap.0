From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 05/13] OMAP: Introduce device scale implementation
Date: Mon, 7 Feb 2011 20:26:12 +0530
Message-ID: <a0c5800a1a6deb384f012aa8bf184194@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-6-git-send-email-vishwanath.bs@ti.com>
 <87d3n7u6pc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43657 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752926Ab1BGO4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 09:56:14 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so5049345fxm.29
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 06:56:13 -0800 (PST)
In-Reply-To: <87d3n7u6pc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, February 04, 2011 9:35 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 05/13] OMAP: Introduce device scale
> implementation
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > This patch adds omap_device_scale API  which can be used to generic
> > device rate scaling.
>
> I would've expected a new omap_device_* API to be part of the
> omap_device layer, not added here.
Given that this API does not deal with any of the omap_device layer
functions or data structures, I am not sure if it logically belongs to
omap device layer. If you think it should belong to omap_device layer just
because the name starts with omap_device, I would rather rename this API.

>
> > Based on original patch from Thara.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Thara Gopinath <thara@ti.com>
> > ---
> >  arch/arm/mach-omap2/dvfs.c             |  116
> ++++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/dvfs.h |    7 ++
> >  2 files changed, 123 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-
> omap2/dvfs.c
> > index c9d3894..05a9ce3 100755
> > --- a/arch/arm/mach-omap2/dvfs.c
> > +++ b/arch/arm/mach-omap2/dvfs.c
> > @@ -19,6 +19,7 @@
> >  #include <plat/common.h>
> >  #include <plat/voltage.h>
> >  #include <plat/omap_device.h>
> > +#include <plat/smartreflex.h>
> >
> >  /**
> >   * struct omap_dev_user_list - Structure maitain userlist per device
> > @@ -585,6 +586,121 @@ static int omap_dvfs_voltage_scale(struct
> omap_vdd_dvfs_info *dvfs_info)
> >  }
> >
> >  /**
> > + * omap_device_scale() - Set a new rate at which the device is to
> operate
> > + * @req_dev:	pointer to the device requesting the scaling.
> > + * @target_dev:	pointer to the device that is to be scaled
> > + * @rate:	the rnew rate for the device.
> > + *
> > + * This API gets the device opp table associated with this device and
> > + * tries putting the device to the requested rate and the voltage
> domain
> > + * associated with the device to the voltage corresponding to the
> > + * requested rate. Since multiple devices can be assocciated with a
> > + * voltage domain this API finds out the possible voltage the
> > + * voltage domain can enter and then decides on the final device
> > + * rate. Return 0 on success else the error value
> > + */
>
> Here would be a good place to describe why both the requesting device
> and the target device need to be tracked.
OK

>
> > +int omap_device_scale(struct device *req_dev, struct device
> *target_dev,
> > +			unsigned long rate)
> > +{
> > +	struct opp *opp;
> > +	unsigned long volt, freq, min_freq, max_freq;
> > +	struct omap_vdd_dvfs_info *dvfs_info;
> > +	struct platform_device *pdev;
> > +	struct omap_device *od;
> > +	int ret = 0;
> > +
> > +	pdev = container_of(target_dev, struct platform_device, dev);
> > +	od = container_of(pdev, struct omap_device, pdev);
> > +
> > +	/*
> > +	 * Figure out if the desired frquency lies between the
> > +	 * maximum and minimum possible for the particular device
> > +	 */
> > +	min_freq = 0;
> > +	if (IS_ERR(opp_find_freq_ceil(target_dev, &min_freq))) {
> > +		dev_err(target_dev, "%s: Unable to find lowest opp\n",
> > +						__func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	max_freq = ULONG_MAX;
> > +	if (IS_ERR(opp_find_freq_floor(target_dev, &max_freq))) {
> > +		dev_err(target_dev, "%s: Unable to find highest opp\n",
> > +						__func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (rate < min_freq)
> > +		freq = min_freq;
> > +	else if (rate > max_freq)
> > +		freq = max_freq;
> > +	else
> > +		freq = rate;
> > +
>
> OK, frome here on, I would expect the adjusted value 'freq' to be used
> instead of 'rate', but that is not the case below.
>
> > +	opp = opp_find_freq_ceil(target_dev, &freq);
> > +	if (IS_ERR(opp)) {
> > +		dev_err(target_dev, "%s: Unable to find OPP for
> freq%ld\n",
> > +			__func__, rate);
> > +		return -ENODEV;
> > +	}
Freq is appropriate than rate here. Will fix it.
> > +
> > +	/* Get the voltage corresponding to the requested frequency */
> > +	volt = opp_get_voltage(opp);
> > +
> > +	/*
> > +	 * Call into the voltage layer to get the final voltage possible
> > +	 * for the voltage domain associated with the device.
> > +	 */
>
> This comment doesn't match the following code.
OK. Will fix it. Copy paste error.
>
> > +	if (rate) {
>
> Why is rate used here, and not freq?
Freq can never be 0. If somebody wants to remove his DVFS request (he does
not really care about the device frequency), then he can pass rate as 0.
Hence rate is used.
>
> > +		dvfs_info = get_dvfs_info(od->hwmods[0]->voltdm);
> > +
> > +		ret = omap_dvfs_add_freq_request(dvfs_info, req_dev,
> > +						target_dev, freq);
> > +		if (ret) {
> > +			dev_err(target_dev, "%s: Unable to add frequency
> request\n",
> > +				__func__);
> > +			return ret;
> > +		}
> > +
> > +		ret = omap_dvfs_add_vdd_user(dvfs_info, req_dev, volt);
> > +		if (ret) {
> > +			dev_err(target_dev, "%s: Unable to add voltage
> request\n",
> > +				__func__);
> > +			omap_dvfs_remove_freq_request(dvfs_info,
> req_dev,
> > +				target_dev);
> > +			return ret;
> > +		}
> > +	} else {
>
> The function comments don't describe this case.  Namely, that if you
> pass in rate = 0, it removes any previous requests for the requesting
> device.
OK. Will add that in function comments.
>
> > +		dvfs_info = get_dvfs_info(od->hwmods[0]->voltdm);
> > +
> > +		ret = omap_dvfs_remove_freq_request(dvfs_info,
> req_dev,
> > +				target_dev);
> > +		if (ret) {
> > +			dev_err(target_dev, "%s: Unable to remove
> frequency request\n",
> > +				__func__);
> > +			return ret;
> > +		}
> > +
> > +		ret = omap_dvfs_remove_vdd_user(dvfs_info, req_dev);
> > +		if (ret) {
> > +			dev_err(target_dev, "%s: Unable to remove voltage
> request\n",
> > +				__func__);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* Do the actual scaling */
> > +	ret = omap_dvfs_voltage_scale(dvfs_info);
>
> ok
>
> > +	if (!ret)
> > +		if (omap_device_get_rate(target_dev) >= rate)
> > +			return 0;
> > +
>
> but this bit needs some explanation.  IIUC: if the _voltage_scale()
> fails (which also scales the frequency) but the frequency was
> sucessfully changed, then return success.
Yes, this is basically to cater for situations where some of the devices
in the associated vdd have locked their frequencies. In that case, voltage
scaling would not have happened where as frequency for the requested
device has been set successfully. In that case return success. Will add
these in function comments.
>
> Also 'rate' is used here where 'freq' would be expected.
OK. Will fix it.

Vishwa
>
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(omap_device_scale);
> > +
> > +/**
> >   * omap_dvfs_init() - Initialize omap dvfs layer
> >   *
> >   * Initalizes omap dvfs layer. It basically allocates memory for
> > diff --git a/arch/arm/plat-omap/include/plat/dvfs.h b/arch/arm/plat-
> omap/include/plat/dvfs.h
> > index 1302990..1be2b9d 100644
> > --- a/arch/arm/plat-omap/include/plat/dvfs.h
> > +++ b/arch/arm/plat-omap/include/plat/dvfs.h
> > @@ -17,11 +17,18 @@
> >
> >  #ifdef CONFIG_PM
> >  int omap_dvfs_register_device(struct voltagedomain *voltdm, struct
> device *dev);
> > +int omap_device_scale(struct device *req_dev, struct device *dev,
> > +			unsigned long rate);
> >  #else
> >  static inline int omap_dvfs_register_device(struct voltagedomain
> *voltdm,
> >  		struct device *dev)
> >  {
> >  	return -EINVAL;
> >  }
> > +static inline int omap_device_scale(struct device *req_dev, struct
> devices
> > +			*target_dev, unsigned long rate);
> > +{
> > +	return -EINVAL;
> > +}
> >  #endif
> >  #endif
>
> Kevin
