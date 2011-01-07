From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Fri, 07 Jan 2011 13:55:05 -0600
Message-ID: <4D276F99.1080007@ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40899 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753775Ab1AGTzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:55:09 -0500
Received: by mail-yi0-f42.google.com with SMTP id 28so7022213yia.15
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 11:55:09 -0800 (PST)
In-Reply-To: <1294421217-18730-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi had written, on 01/07/2011 11:26 AM, the following:
> The eFuse registers do not contain the nValue to be used
> with 720MHz (OPP6). This patch implements procedure to
> calculate the nValue(OPP6) based on the nValue(OPP5).
> 
>   [1] SPRUFF1D-June 2009 section 1.5.2.1.1
Where is this doc?
http://focus-webapps.ti.com/general/docs/sitesearch/searchsite.tsp;jsessionid=TKKPEXXTMNJCPQC1JAWBVQQ?selectedTopic=1653260327&numRecords=25&searchTerm=SPRUFF1D&statusCode=null

Google seems to point to:
http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
but ti.com responds with document not found.


> 
> This is first attempt to fit this mechanism into new
> smartreflex framework. Do note a FIXME which is added
> to illustrate the calculations; and express need for
> a mechanism to get nValues for each OPP.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/sr_device.c           |   54 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.c             |    1 +
>  arch/arm/plat-omap/include/plat/voltage.h |    1 +
>  3 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index 786d685..43640a3 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -38,6 +38,51 @@ static struct omap_device_pm_latency omap_sr_latency[] = {
>  	},
>  };
>  
> +static void swcalc_opp6_RG(u32 rFuse, u32 gainFuse, u32 deltaNT,
> +                               u32* rAdj, u32* gainAdj)
> +{
> +       u32 nAdj;
> +       u32 g, r;
> +
> +       nAdj = ((1 << (gainFuse + 8))/rFuse) + deltaNT;
> +
> +       for (g = 0; g < GAIN_MAXLIMIT; g++) {
> +               r = (1 << (g + 8)) / nAdj;
> +               if (r < 256) {
> +                       *rAdj = r;
> +                       *gainAdj = g;
> +               }
> +       }
> +}
> +
> +#define SWCALC_OPP6_DELTA_NNT	379
> +#define SWCALC_OPP6_DELTA_PNT	227
> +#define GAIN_MAXLIMIT		16

Magic numbers - do they scale from 3430 to 3630?

> +
> +static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)
so what does this actually do?
> +{
> +       u32 opp6_nvalue;
> +       u32 opp5_senPgain, opp5_senNgain, opp5_senPRN, opp5_senNRN;
> +       u32 opp6_senPgain, opp6_senNgain, opp6_senPRN, opp6_senNRN;
> +
> +       opp5_senPgain = (opp5_nvalue & 0x00f00000) >> 0x14;
> +       opp5_senNgain = (opp5_nvalue & 0x000f0000) >> 0x10;
> +
> +       opp5_senPRN = (opp5_nvalue & 0x0000ff00) >> 0x8;
> +       opp5_senNRN = (opp5_nvalue & 0x000000ff);
> +
> +       swcalc_opp6_RG(opp5_senNRN, opp5_senNgain, SWCALC_OPP6_DELTA_NNT,
> +                               &opp6_senNRN, &opp6_senNgain);
> +
> +       swcalc_opp6_RG(opp5_senPRN, opp5_senPgain, SWCALC_OPP6_DELTA_PNT,
> +                               &opp6_senPRN, &opp6_senPgain);
> +
> +       opp6_nvalue = (opp6_senPgain << 0x14) | (opp6_senNgain < 0x10) |
> +                       (opp6_senPRN << 0x8) | opp6_senNRN;
> +
> +       return opp6_nvalue;
> +}
> +
>  /* Read EFUSE values from control registers for OMAP3430 */
>  static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
>  				struct omap_sr_data *sr_data)
> @@ -72,6 +117,15 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
>  		nvalue_table[i].nvalue = v;
>  	}
>  
> +	/*
> +	 * FIXME: This is a temporary hack. Need to identify better
> +	 *        mechanism to find nvalues corresponding to an OPP.
> +	 */
> +	if (cpu_is_omap34xx() && omap3_has_720mhz()) {
> +		nvalue_table[count-1].nvalue = swcalc_opp6_nvalue(
> +					nvalue_table[count-2].nvalue);
> +	}
> +
Sorry, Dumb question:
a) You are using OPP5's nTarget to use in OPP6's nTarget? is'nt it fused 
in for OPP6 offset?
b) you are using OMAP343X_CONTROL_FUSE_OPP5_VDD1 itself
c) these should be __init functions.
d) how would you allow this code to work with 3440?
e) next time could you please try STOP using CaMELCASInG in your 
variables and functions?
f) please add sufficient documentation in kernel-doc style to allow us 
to understand the story below?
g) dont use magic numbers
h) please take care of ROUND_DOWN and ROUND_UP and truncation errors
i) is this equation ONLY valid for opp5 ntarget modification on 
OMAP3530? or valid for 3440 as well? or valid for any OPP ntarget 
modification?

>  	sr_data->nvalue_table = nvalue_table;
>  	sr_data->nvalue_count = count;
>  }
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index ed6079c..f23b6d7 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -258,6 +258,7 @@ static struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
>  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
>  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
>  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
> +	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP6_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
you might as well use OPP6_VDD1 for CONTROL_FUSE?

>  	VOLT_DATA_DEFINE(0, 0, 0, 0),
>  };
>  
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 0ff1233..f3f87a6 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -31,6 +31,7 @@
>  #define OMAP3430_VDD_MPU_OPP3_UV		1200000
>  #define OMAP3430_VDD_MPU_OPP4_UV		1270000
>  #define OMAP3430_VDD_MPU_OPP5_UV		1350000
> +#define OMAP3430_VDD_MPU_OPP6_UV                1350000
>  
>  #define OMAP3430_VDD_CORE_OPP1_UV		975000
>  #define OMAP3430_VDD_CORE_OPP2_UV		1050000


-- 
Regards,
Nishanth Menon
