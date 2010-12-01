From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH v2 13/14] OMAP3: Add voltage dependency table for VDD1.
Date: Wed, 1 Dec 2010 21:02:13 +0530
Message-ID: <10d2210af9889a27da106af6ad195486@mail.gmail.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com> <1288366708-32302-14-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60735 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab0LAPch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 10:32:37 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so5374658fxm.41
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 07:32:36 -0800 (PST)
In-Reply-To: <1288366708-32302-14-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com

Thara,

> -----Original Message-----
> From: Gopinath, Thara
> Sent: Friday, October 29, 2010 9:08 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit;
> Sripathy, Vishwanath; Sawant, Anand; Gopinath, Thara
> Subject: [PATCH v2 13/14] OMAP3: Add voltage dependency table for
> VDD1.
>
> In OMAP3, for perfomrance reasons when VDD1 is at voltage above
> 1.075V, VDD2 should be at 1.15V for perfomrance reasons. This
> patch introduce this cross VDD dependency for OMAP3 VDD1.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> omap2/voltage.c
> index 6f85f75..241fac5 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -350,6 +350,23 @@ static struct omap_volt_data
> omap44xx_vdd_core_volt_data[] = {
>  	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain =
> 0x16},
>  };
>
> +/* OMAP 3430 MPU Core VDD dependency table */
> +static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
> +	{.main_vdd_volt = 975000, .dep_vdd_volt = 1050000},
> +	{.main_vdd_volt = 1075000, .dep_vdd_volt = 1050000},
> +	{.main_vdd_volt = 1200000, .dep_vdd_volt = 1150000},
> +	{.main_vdd_volt = 1270000, .dep_vdd_volt = 1150000},
> +	{.main_vdd_volt = 1350000, .dep_vdd_volt = 1150000},
> +	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
> +};
> +
> +static struct omap_vdd_dep_info omap34xx_vdd1_dep_info[] = {
> +	{
> +		.name	= "core",
> +		.dep_table = omap34xx_vdd1_vdd2_data,
> +	},
> +};

Dependency table for 3630 is missing. Pls add the same.
Also voltage values for 3630 does not match those on OPP table. Pls align
them.

Vishwa
> +
>  /* By default VPFORCEUPDATE is the chosen method of voltage scaling
> */
>  static bool voltscale_vpforceupdate = true;
>
> @@ -574,6 +591,8 @@ static void __init
> omap3_vdd_data_configure(struct omap_vdd_info *vdd)
>  			vdd->volt_data = omap34xx_vdd1_volt_data;
>  			vdd->volt_data_count =
>
> 	ARRAY_SIZE(omap34xx_vdd1_volt_data);
> +			vdd->dep_vdd_info = omap34xx_vdd1_dep_info;
> +			vdd->nr_dep_vdd =
> ARRAY_SIZE(omap34xx_vdd1_dep_info);
>  		}
>
>  		vdd->vp_reg.tranxdone_status =
> OMAP3430_VP1_TRANXDONE_ST_MASK;
> --
> 1.7.0.4
