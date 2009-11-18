From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 9/9 v2] omap3: pm: introduce 3630 opps
Date: Wed, 18 Nov 2009 14:07:04 -0600
Message-ID: <4B0453E8.30503@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com> <1258092322-30833-2-git-send-email-nm@ti.com> <1258092322-30833-3-git-send-email-nm@ti.com> <1258092322-30833-4-git-send-email-nm@ti.com> <1258092322-30833-5-git-send-email-nm@ti.com> <1258092322-30833-6-git-send-email-nm@ti.com> <1258092322-30833-7-git-send-email-nm@ti.com> <1258092322-30833-8-git-send-email-nm@ti.com> <1258092322-30833-9-git-send-email-nm@ti.com> <1258092322-30833-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42002 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149AbZKRUHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 15:07:12 -0500
In-Reply-To: <1258092322-30833-10-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>


Menon, Nishanth wrote:
> Introduce the OMAP3630 OPPs including the defined OPP tuples.
> 
> Further information on OMAP3630 can be found here:
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12836&contentId=52606
> 
> OMAP36xx family introduces:
> VDD1 with 4 OPPs, of which OPP3 & 4 are available only on devices yet
> to be introduced in 36xx family. Meanwhile, VDD2 has 2 opps.
> 
> Range of OPPs supported by Devices(tentative)->
>            |<-3630-600->| (default)
>            |<-      3630-800  ->| (device: TBD)
>            |<-      3630-1000             ->| (device: TBD)
> H/w OPP-> OPP50 OPP100       OPP-Turbo   OPP1G-SB
> VDD1      OPP1  OPP2         OPP3        OPP4
> VDD2      OPP1  OPP2         OPP2        OPP2
> 
> Note:
> a) TI h/w naming for OPPs are now standardized in terms of OPP50, 100,
>    Turbo and SB. This maps as shown above to the opp IDs (s/w term).
> b) For boards which need custom VDD1/2 OPPs, the opp table can be
>    updated by the board file on a need basis after the
>    omap3_pm_init_opp_table call. The OPPs introduced here are the
>    official OPP table at this point in time.
> 
> Tested on: SDP3430, SDP3630
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: SuiLun Lam <s-lam@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap3-opp.h |    9 ++++
>  arch/arm/mach-omap2/pm34xx.c    |   87 +++++++++++++++++++++++++++++++-------
>  2 files changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
> index 7f27f44..a5880b8 100644
> --- a/arch/arm/mach-omap2/omap3-opp.h
> +++ b/arch/arm/mach-omap2/omap3-opp.h
> @@ -4,22 +4,31 @@
>  #include <plat/omap-pm.h>
>  
>  /* MPU speeds */
> +#define S1000M  1000000000
> +#define S800M   800000000
>  #define S600M   600000000
>  #define S550M   550000000
>  #define S500M   500000000
> +#define S300M   300000000
>  #define S250M   250000000
>  #define S125M   125000000
>  
>  /* DSP speeds */
> +#define S875M   875000000
> +#define S660M   660000000
> +#define S520M   520000000
>  #define S430M   430000000
>  #define S400M   400000000
>  #define S360M   360000000
> +#define S260M   260000000
>  #define S180M   180000000
>  #define S90M    90000000
>  
>  /* L3 speeds */
>  #define S83M    83000000
> +#define S100M   100000000
>  #define S166M   166000000
> +#define S200M   200000000
>  
>  extern struct omap_opp *omap3_mpu_rate_table;
>  extern struct omap_opp *omap3_dsp_rate_table;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 14131f8..86137bb 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -141,6 +141,41 @@ static __initdata struct omap_opp omap34xx_dsp_rate_table[] = {
>  	{0, 0, 0, 0},
>  };
>  
> +static __initdata struct omap_opp omap36xx_mpu_rate_table[] = {
> +	{0, 0, 0, 0},
> +	/*OPP1 - 930mV - OPP50*/
> +	{true, S300M, VDD1_OPP1, 0x1a},
> +	/*OPP2 - 1.100V - OPP100*/
> +	{true, S600M, VDD1_OPP2, 0x28},
> +	/*OPP3 - 1.260V - OPP-Turbo*/
> +	{false, S800M, VDD1_OPP3, 0x34},
> +	/*OPP4 - 1.310V - OPP-SB*/
> +	{false, S1000M, VDD1_OPP4, 0x38},
> +	{0, 0, 0, 0},
> +};
> +
> +static __initdata struct omap_opp omap36xx_l3_rate_table[] = {
> +	{0, 0, 0, 0},
> +	/*OPP1 - 930mV - OPP50 */
> +	{true, S100M, VDD2_OPP1, 0x1a},
> +	/*OPP2 - 1.375V - OPP100, OPP-Turbo, OPP-SB*/


Nishanth, can you correct the above comment? This should be 1.1375V and 
not 1.375V.

Cheers
Jon
