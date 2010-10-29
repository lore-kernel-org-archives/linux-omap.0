From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4 3/9] OMAP3: PM: Adding smartreflex device file.
Date: Fri, 29 Oct 2010 10:18:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D398ACE@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
 <1288195856-11011-4-git-send-email-thara@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D310D1C@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D56@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab0J2EtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 00:49:06 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D56@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



> -----Original Message-----
> From: Gopinath, Thara
> Sent: Thursday, October 28, 2010 8:56 PM
> To: Varadarajan, Charulatha; linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit; Sripathy,
> Vishwanath; Sawant, Anand
> Subject: RE: [PATCH v4 3/9] OMAP3: PM: Adding smartreflex device file.
> 
> 
> 
> >>-----Original Message-----
> >>From: Varadarajan, Charulatha
> >>Sent: Thursday, October 28, 2010 11:09 AM
> >>To: Gopinath, Thara; linux-omap@vger.kernel.org
> >>Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit;
> Sripathy,
> >>Vishwanath; Sawant, Anand
> >>Subject: RE: [PATCH v4 3/9] OMAP3: PM: Adding smartreflex device file.
> >>
> >>Thara,
> >>
> >>> -----Original Message-----
> >>> From: linux-omap-owner@vger.kernel.org
> >>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gopinath, Thara
> >>> Sent: Wednesday, October 27, 2010 9:41 PM
> >>> To: linux-omap@vger.kernel.org
> >>> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson,
> >>> Benoit; Sripathy, Vishwanath; Sawant, Anand; Gopinath, Thara
> >>> Subject: [PATCH v4 3/9] OMAP3: PM: Adding smartreflex device file.
> >>>
> >>> This patch adds support for device registration of various
> >>> smartreflex module present in the system. This patch introduces
> >>> the platform data for smartreflex devices which include
> >>> the efused and test n-target vaules, module enable/disable
> >>> pointers and a parameter to indicate whether smartreflex
> >>> autocompensation needs to be enabled on init or not.
> >>> Currently auocompensation is enabled on init by default
> >>> for OMAP3430 ES3.1 chip.
> >>>
> >>> Signed-off-by: Thara Gopinath <thara@ti.com>
> >>> ---
> >>>  arch/arm/mach-omap2/Makefile    |    2 +-
> >>>  arch/arm/mach-omap2/sr_device.c |  177
> >>> +++++++++++++++++++++++++++++++++++++++
> >>>  2 files changed, 178 insertions(+), 1 deletions(-)
> >>>  create mode 100644 arch/arm/mach-omap2/sr_device.c
> >>>
> >>
> >><<snip>>
> >>
> >>> +
> >>> +static int sr_dev_init(struct omap_hwmod *oh, void *user)
> >>
> >>Since *user is unused, you may rename it to *unused
> 
> Ok will do.
> 
> >>
> >>> +{
> >>> +	struct omap_sr_data *sr_data;
> >>> +	struct omap_sr_dev_data *sr_dev_data;
> >>> +	struct omap_device *od;
> >>> +	char *name = "smartreflex";
> >>> +	static int i;
> >>> +
> >>> +	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
> >>> +	if (!sr_data) {
> >>> +		pr_err("%s: Unable to allocate memory for %s
> >>> sr_data.Error!\n",
> >>> +			__func__, oh->name);
> >>> +		return -ENOMEM;
> >>> +	}
> >>> +
> >>> +	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
> >>> +	if (unlikely(!sr_dev_data)) {
> >>> +		pr_err("%s: dev atrribute is NULL\n", __func__);
> >>> +		goto exit;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * OMAP3430 ES3.1 chips by default come with Efuse burnt
> >>> +	 * with parameters required for full functionality of
> >>> +	 * smartreflex AVS feature like ntarget values , sennenable
> >>> +	 * and senpenable. So enable the SR AVS feature during boot up
> >>> +	 * itself if it is a OMAP3430 ES3.1 chip.
> >>> +	 */
> >>> +	sr_data->enable_on_init = false;
> >>> +	if (cpu_is_omap343x())
> >>> +		if (omap_rev() == OMAP3430_REV_ES3_1)
> >>> +			sr_data->enable_on_init = true;
> >>> +
> >>> +	sr_data->voltdm =
> >>> omap_voltage_domain_lookup(sr_dev_data->vdd_name);
> >>> +	if (IS_ERR(sr_data->voltdm)) {
> >>> +		pr_err("%s: Unable to get voltage domain
> >>> pointer for VDD %s\n",
> >>> +			__func__, sr_dev_data->vdd_name);
> >>> +		goto exit;
> >>> +	}
> >>> +
> >>> +	sr_dev_data->volts_supported = omap_voltage_get_volttable(
> >>> +			sr_data->voltdm, &sr_dev_data->volt_data);
> >>> +	if (!sr_dev_data->volts_supported) {
> >>> +		pr_warning("%s: No Voltage table registerd fo VDD%d."
> >>> +			"Something really wrong\n\n", __func__, i + 1);
> >>> +		goto exit;
> >>> +	}
> >>> +
> >>> +	sr_set_nvalues(sr_dev_data, sr_data);
> >>> +
> >>> +	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
> >>> +			       omap_sr_latency,
> >>> +			       ARRAY_SIZE(omap_sr_latency), 0);
> >>
> >>Patch 4 should come before patch 3 in the series. Otherwise, this
> >>would fail during a git-bisect.
> 
> Why?? All patches individually compile and boot.

Oh data for SR is filled only in patch 4 but oh is being used here.
Wouldn't that create a problem?

> 
> >>
> >>> +	if (IS_ERR(od))
> >>> +		pr_warning("%s: Could not build omap_device for
> >>> %s: %s.\n\n",
> >>> +			__func__, name, oh->name);
> >>
> >>Return error.
> >>
> >>> +exit:
> >>> +	i++;
> >>> +	kfree(sr_data);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int __init omap_devinit_smartreflex(void)
> >>> +{
> >>> +	return omap_hwmod_for_each_by_class("smartreflex",
> >>> sr_dev_init, NULL);
> >>> +}
> >>> +device_initcall(omap_devinit_smartreflex);
> >>> --
> >>> 1.7.0.4
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> linux-omap" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
