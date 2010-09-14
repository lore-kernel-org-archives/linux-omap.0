From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 3/8] OMAP3: PM: Adding smartreflex driver support.
Date: Tue, 14 Sep 2010 10:04:09 -0700
Message-ID: <874odss1di.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-4-git-send-email-thara@ti.com>
	<87iq2ycozg.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0329441CFC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48838 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0INREb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 13:04:31 -0400
Received: by pzk34 with SMTP id 34so2501757pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 10:04:31 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0329441CFC@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Tue, 14 Sep 2010 21:28:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +   sr->is_sr_enable = 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * omap_smartreflex_enable : API to enable SR clocks and to call into the
>>>> + * registered smartreflex class enable API.
>>>> + * @voltdm - VDD pointer to which the SR module to be configured belongs to.
>>>> + *
>>>> + * This API is to be called from the kernel in order to enable
>>>> + * a particular smartreflex module. This API will do the initial
>>>> + * configurations to turn on the smartreflex module and in turn call
>>>> + * into the registered smartreflex class enable API.
>>>> + */
>>>> +void omap_smartreflex_enable(struct voltagedomain *voltdm)
>>>> +{
>>>> +   struct omap_sr *sr = _sr_lookup(voltdm);
>>>> +
>>>> +   if (IS_ERR(sr)) {
>>>> +           pr_warning("%s: omap_sr struct for sr_%s not found\n",
>>>> +                   __func__, voltdm->name);
>>>> +           return;
>>>> +   }
>>>> +
>>>> +   if (!sr->is_autocomp_active)
>>>> +           return;
>>>
>>>from here
>>>
>>>> +   if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
>>>> +           dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
>>>> +                   "registered\n", __func__);
>>>> +           return;
>>>> +   }
>>>> +   sr_class->enable(voltdm);
>>>
>>>to here, this looks an awful lot like sr_start_autocomp()
>
> Yes both will enable smartreflex. One is called from user side and other
> from kernel side. Are you suggesting creating a third API to just keep the above
> piece of code ??

No, I'm suggesting you just call sr_start_vddautocomp() here.

[...]

>>>> +};
>>>> +
>>>> +/*
>>>> + * Smartreflex module enable/disable interface.
>>>> + * NOTE: if smartreflex is not enabled from sysfs, these functions will not
>>>> + * do anything.
>>>> + */
>>>> +void omap_smartreflex_enable(struct voltagedomain *voltdm);
>>>> +void omap_smartreflex_disable(struct voltagedomain *voltdm);
>>>> +void omap_smartreflex_disable_reset_volt(struct voltagedomain *voltdm);
>>>> +
>>>> +/* Smartreflex driver hooks to be called from Smartreflex class driver */
>>>> +int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
>>>> +void sr_disable(struct voltagedomain *voltdm);
>>>> +int sr_configure_errgen(struct voltagedomain *voltdm);
>>>> +int sr_configure_minmax(struct voltagedomain *voltdm);
>>>> +
>>>> +/* API to register the smartreflex class driver with the smartreflex driver */
>>>> +int omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
>>>> +
>>>> +/* API to register the pmic specific data with the smartreflex driver. */
>>>> +void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data);
>>>> +#else
>>>> +static inline void omap_smartreflex_enable(struct voltagedomain *voltdm) {}
>>>> +static inline void omap_smartreflex_disable(struct voltagedomain *voltdm) {}
>>>> +static inline void omap_smartreflex_disable_reset_volt(
>>>> +           struct voltagedomain *voltdm) {}
>>>> +static inline void omap_sr_register_pmic(
>>>> +           struct omap_smartreflex_pmic_data *pmic_data) {}
>>>> +#endif
>>>> +#endif
>>>
>>>These function names could all be unified a bit better.  Some are
>>>'omap_smartreflex_', some are 'sr_' and some are 'omap_sr'.
>>>
>>>How about using 'omap_sr' for all the public functions.
>
> Yes sr_ are the APIs that will be called from smartreflex class driver
> and omap_smartreflex are the ones that will be called from rest of the code.
> I can change omap_smartreflex_ ones to omap_sr.

OK.

Kevin
