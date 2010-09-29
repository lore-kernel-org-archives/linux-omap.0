From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 02/11] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Wed, 29 Sep 2010 14:21:08 -0700
Message-ID: <8739ssutyz.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56068 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0I2VVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 17:21:14 -0400
Received: by pxi10 with SMTP id 10so299195pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 14:21:14 -0700 (PDT)
In-Reply-To: <1285166719-19352-3-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds voltage driver support for OMAP3. The driver
> allows  configuring the voltage controller and voltage
> processors during init and exports APIs to enable/disable
> voltage processors, scale voltage and reset voltage.
> The driver also maintains the global voltage table on a per
> VDD basis which contains the various voltages supported by the
> VDD along with per voltage dependent data like smartreflex
> n-target value, errminlimit and voltage processor errorgain.
> The driver allows scaling of VDD voltages either through
> "vc bypass method" or through "vp forceupdate method" the
> choice being configurable through the board file.
>
> This patch contains code originally in linux omap pm branch
> smartreflex driver.  Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +static void __init vdd_data_configure(struct omap_vdd_info *vdd)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_vdd_data_configure(vdd);
> +}
> +
> +static void __init init_voltagecontroller(void)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_init_voltagecontroller();
> +}

Drop these two functions...

[...]

> +/**
> + * omap_voltage_init : Volatage init API which does VP and VC init.
> + */
> +static int __init omap_voltage_init(void)
> +{
> +	int i;

...and setup function pointers in these cpu_is checks.  Something like
the below (not even compile tested.)

       void (*vdd_data_configure)(void);
       void (*init_voltageprocessor)(void);

> +
> +	if (cpu_is_omap34xx()) {
> +		volt_mod = OMAP3430_GR_MOD;
> +		vdd_info = omap3_vdd_info;
> +		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;

                vdd_data_configure = omap3_vdd_data_configure;
                init_voltageprocessor = omap3_init_voltageprocessor;

> +	} else {
> +		pr_warning("%s: voltage driver support not added\n", __func__);
> +		return 0;
> +	}
> +	init_voltagecontroller();
> +	for (i = 0; i < nr_scalable_vdd; i++) {
> +		vdd_data_configure(&vdd_info[i]);
> +		init_voltageprocessor(&vdd_info[i]);
> +	}
> +	return 0;
> +}
> +core_initcall(omap_voltage_init);

We really want to minimize the cpu_is_* checks, and ideally they should
only be present in the first __init function.

Kevin
