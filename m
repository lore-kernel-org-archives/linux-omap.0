From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 03/13] OMAP: Implement Basic DVFS
Date: Mon, 7 Feb 2011 19:48:13 +0530
Message-ID: <da15cb476bc1779775448cc5dcd372f3@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-4-git-send-email-vishwanath.bs@ti.com>
 <87mxmcy51u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58349 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693Ab1BGOSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 09:18:14 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so5859632fxm.5
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 06:18:13 -0800 (PST)
In-Reply-To: <87mxmcy51u.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, February 04, 2011 6:44 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 03/13] OMAP: Implement Basic DVFS
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > This patch introduces an API to perform DVFS for a given voltage
> domain.
> > It takes omap_vdd_dvfs_info pointer as input parameter, computes
> the highest
> > requested voltage for that vdd and scales all the devices in that vdd
to
> the
> > requested frequency along with voltage scaling.
> >
> > Based on original patch from Thara.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Thara Gopinath <thara@ti.com>
> > ---
> >  arch/arm/mach-omap2/dvfs.c |   87
> +++++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 86 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-
> omap2/dvfs.c
> > index 8832e4a..cefc2be 100755
> > --- a/arch/arm/mach-omap2/dvfs.c
> > +++ b/arch/arm/mach-omap2/dvfs.c
> > @@ -21,7 +21,7 @@
> >  #include <plat/omap_device.h>
> >
> >  /**
> > - * struct omap_dev_user_list - Structure maitain userlist per devide
> > + * struct omap_dev_user_list - Structure maitain userlist per device
>
> this typo should be done in the original patch, not here.
OK
>
> >   *
> >   * @dev:       The device requesting for a particular frequency
> >   * @node:      The list head entry
> > @@ -413,6 +413,91 @@ static int
> omap_dvfs_remove_freq_request(struct omap_vdd_dvfs_info *dvfs_info,
> >  }
> >
> >  /**
> > + * omap_dvfs_voltage_scale() : API to scale the devices associated
> with a
> > + *						voltage domain vdd
voltage.
>
> This function scales both voltage and frequency, so the name
> voltage_scale() is a bit misleading.
Does omap_dvfs_do_dvfs look good?
>
> > + * @dvfs_info: omap_vdd_dvfs_info pointer for the required vdd
> > + *
> > + * This API runs through the list of devices associated with the
> > + * voltage domain and scales the device rates to the one requested
> > + * by the user or those corresponding to the new voltage of the
> > + * voltage domain. Target voltage is the highest voltage in the
> vdd_user_list.
> > + *
> > + * Returns 0 on success
> > + * else the error value.
> > + */
> > +static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info
> *dvfs_info)
> > +{
> > +	unsigned long curr_volt;
> > +	int is_volt_scaled = 0;
>
> should be a bool
ok
>
> > +	struct omap_vdd_dev_list *temp_dev;
> > +	struct plist_node *node;
> > +	int ret = 0;
> > +	struct voltagedomain *voltdm;
> > +	unsigned long volt;
> > +
> > +	if (!dvfs_info || IS_ERR(dvfs_info)) {
> > +		pr_warning("%s: VDD specified does not exist!\n",
> __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	voltdm = dvfs_info->voltdm;
> > +
> > +	mutex_lock(&dvfs_info->scaling_mutex);
> > +
> > +	/* Find the highest voltage being requested */
> > +	node = plist_last(&dvfs_info->user_list);
> > +	volt = node->prio;
> > +
> > +	curr_volt = omap_voltage_get_nom_volt(voltdm);
> > +
> > +	if (curr_volt == volt) {
> > +		is_volt_scaled = 1;
> > +	} else if (curr_volt < volt) {
> > +		ret = omap_voltage_scale_vdd(voltdm, volt);
> > +		if (ret) {
> > +			pr_warning("%s: Unable to scale the %s to %ld
> volt\n",
> > +						__func__, voltdm->name,
> volt);
> > +			mutex_unlock(&dvfs_info->scaling_mutex);
> > +			return ret;
> > +		}
> > +		is_volt_scaled = 1;
> > +	}
> > +
> > +	list_for_each_entry(temp_dev, &dvfs_info->dev_list, node) {
> > +		struct device *dev;
> > +		struct opp *opp;
> > +		unsigned long freq;
> > +
> > +		dev = temp_dev->dev;
>
> if you're doing this assignment here, might as well make 'dev' the
> iterator instead of temp_dev.
temp_dev holds pointer to omap_vdd_dev_list where as dev points to actual
device pointer. Hence this assignment.
>
> This section would benefit with some comments.  If I understand the
> code
> correctly, something like:
>
> If a frequency has been requested, use the highest requested frequency.
>
> > +		if (!plist_head_empty(&temp_dev->user_list)) {
> > +			node = plist_last(&temp_dev->user_list);
> > +			freq = node->prio;
>
> otherwise check if device has OPP for this voltage
>
> > +		} else {
> > +			opp = omap_dvfs_find_voltage(dev, volt);
> > +			if (IS_ERR(opp))
> > +				continue;
>
> This needs a comment to, but I'm not sure I understand what's going on
> here.  What it seems like:
>
> if this device has no OPP for this voltage, just silently move on to the
> next device?   doesn't seem quite right, but not sure I fully grok the
> failure modes of omap_dvfs_find_voltage()
Yes, your understanding is right. omap_dvfs_find_voltage will return error
if the device does not have an OPP table.
Typically devices should not register with a vdd (using
omap_dvfs_register_device) if it has no OPP table associated with it. So
ideally we should not hit this error case. But only exception so far is SR
driver. SR hwmod has vdd_name field set so as to get voltagedomain
pointers. But SR does not have any opp table. So there is no harm in
ignoring the error and moving to next device.

Vishwa
>
> Kevin
>
> > +			freq = opp_get_freq(opp);
> > +		}
> > +
> > +		if (freq == omap_device_get_rate(dev)) {
> > +			dev_dbg(dev, "%s: Already at the requested"
> > +				"rate %ld\n", __func__, freq);
> > +			continue;
> > +		}
> > +
> > +		ret |= omap_device_set_rate(dev, freq);
> > +	}
> > +
> > +	if (!is_volt_scaled && !ret)
> > +		omap_voltage_scale_vdd(voltdm, volt);
> > +
> > +	mutex_unlock(&dvfs_info->scaling_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> >   * omap_dvfs_init() - Initialize omap dvfs layer
> >   *
> >   * Initalizes omap dvfs layer. It basically allocates memory for
