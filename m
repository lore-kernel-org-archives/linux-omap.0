From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 10/22] OMAP3: PM: Adding voltage table support in voltage driver.
Date: Tue, 27 Apr 2010 11:58:08 -0700
Message-ID: <87y6g8iuyn.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:55014 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0D0S6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 14:58:12 -0400
Received: by pzk42 with SMTP id 42so9187550pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 11:58:11 -0700 (PDT)
In-Reply-To: <1271408597-3066-11-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces the framework to create voltage table per
> VDD basis in voltage driver. Each VDD will have one voltage table,
> which in turn will contain one entry per voltage supported and
> other data associated with the voltage like smartreflex N-target
> values. This patch also generates voltage tables for VDD1 and VDD2 of
> OMAP3430 and passes them as dev_attr to sr_device.c in order
> to populate the smartreflex n-target values.
>
> These voltage tables are extended in a later patch to contain more
> voltage specific information like errminlimt and errorgain values.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +-
>  arch/arm/mach-omap2/smartreflex.c          |   27 +--------
>  arch/arm/mach-omap2/smartreflex.h          |   13 +----
>  arch/arm/mach-omap2/sr_device.c            |   42 ++----------
>  arch/arm/mach-omap2/voltage.c              |   93 +++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/voltage.h              |   15 +++++
>  6 files changed, 118 insertions(+), 79 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 049e4e2..1f41310 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -23,6 +23,7 @@
>  
>  #include "prm-regbits-34xx.h"
>  #include "smartreflex.h"
> +#include "voltage.h"
>  
>  /*
>   * OMAP3xxx hardware module integration data
> @@ -240,14 +241,13 @@ static u32 omap34xx_sr1_test_nvalues[] = {
>  };
>  
>  static struct omap_smartreflex_dev_data omap34xx_sr1_dev_attr = {
> -	.volts_supported	= 5,
>  	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
>  	.sennenable_shift	= OMAP343X_SR1_SENNENABLE_SHIFT,
>  	.senpenable_shift	= OMAP343X_SR1_SENPENABLE_SHIFT,
>  	.efuse_nvalues_offs	= omap34xx_sr1_efuse_offs,
>  	.test_sennenable	= 0x3,
>  	.test_senpenable	= 0x3,
> -	.test_nvalues		= omap34xx_sr1_test_nvalues
> +	.test_nvalues		= omap34xx_sr1_test_nvalues,

unrelated change, should be in original patch that adds this struct.

>  };
>  
>  static struct omap_hwmod omap34xx_sr1_hwmod = {
> @@ -276,14 +276,13 @@ static u32 omap34xx_sr2_test_nvalues[] = {
>  };
>  
>  static struct omap_smartreflex_dev_data omap34xx_sr2_dev_attr = {
> -	.volts_supported	= 3,
>  	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
>  	.sennenable_shift	= OMAP343X_SR2_SENNENABLE_SHIFT,
>  	.senpenable_shift	= OMAP343X_SR2_SENPENABLE_SHIFT,
>  	.efuse_nvalues_offs	= omap34xx_sr2_efuse_offs,
>  	.test_sennenable	= 0x3,
>  	.test_senpenable	= 0x3,
> -	.test_nvalues		= omap34xx_sr2_test_nvalues
> +	.test_nvalues		= omap34xx_sr2_test_nvalues,

ditto

>  };
>  

[...]

>  /**
> + * omap_get_voltage_table : API to get the voltage table associated with a
> + *			    particular voltage domain.
> + *
> + * @vdd : the voltage domain id for which the voltage table is required
> + * @volt_data : the voltage table for the particular vdd which is to be
> + *		populated by this API
> + * @volt_count : number of distinct voltages supported by this vdd which
> + *		is to be populated by this API.
> + *
> + * This API populates the voltage table associated with a VDD and the count
> + * of number of voltages supported into the passed parameter pointers.
> + */
> +void omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data,
> +						int *volt_count)
> +{
> +	*volt_data = vp_reg[vdd].volt_data;
> +	*volt_count = vp_reg[vdd].volt_data_count;
> +}

How about returning the count instad of in another pointer.

> +/**
> + * omap_match_volt : API to get the voltage table entry for a particular
> + *		     voltage
> + * @vdd : the voltage domain id for whose voltage table has to be searched
> + * @volt : the voltage to be searched in the voltage table
> + * @volt_data : the matching voltage table entry which has to be populate
> + *		by this API.
> + *
> + * This API searches through the voltage table for the required voltage
> + * domain and tries to find a matching entry for the passed voltage volt.
> + * If a matching entry is found volt_data is populated with that entry.
> + * Returns -ENXIO if not voltage table exisits for the passed voltage
> + * domain or if there is no matching entry. On success returns true.
> + */
> +int omap_match_volt(int vdd, unsigned long volt,
> +				struct omap_volt_data *volt_data)
> +{
> +	int i;
> +
> +	if (!vp_reg[vdd].volt_data) {
> +		pr_notice("voltage table does not exist for VDD %d\n", vdd + 1);
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < vp_reg[vdd].volt_data_count; i++) {
> +		if (vp_reg[vdd].volt_data[i].voltage == volt) {
> +			*volt_data = vp_reg[vdd].volt_data[i];
> +			return 0;
> +		}
> +	}
> +	pr_notice("Unable to match the current voltage with \
> +				the voltage table for VDD %d\n", vdd + 1);
> +	return -ENXIO;
> +}
> +
> +/**
>   * omap_voltage_init : Volatage init API which does VP and VC init.
>   */
>  void __init omap_voltage_init(void)
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 663c6fe..cc3308e 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -63,6 +63,17 @@
>  
>  /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
>  
> +/**
> + * omap_volt_data - Omap voltage specific data.
> + *
> + * @voltage	: The possible voltage value
> + * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
> + */
> +struct omap_volt_data {
> +	unsigned long	voltage;
> +	u32		sr_nvalue;

both could be unsigned long (or u32)

> +};
> +
>  void omap_voltageprocessor_enable(int vp_id);
>  void omap_voltageprocessor_disable(int vp_id);
>  void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
> @@ -70,5 +81,9 @@ void omap_voltage_init(void);
>  int omap_voltage_scale(int vdd, unsigned long target_volt,
>  					unsigned long current_volt);
>  void omap_reset_voltage(int vdd);
> +void omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data,
> +						int *volt_count);
> +int omap_match_volt(int vdd, unsigned long volt,
> +				struct omap_volt_data *volt_data);
>  unsigned long get_curr_vdd1_voltage(void);
>  unsigned long get_curr_vdd2_voltage(void);

Kevin
