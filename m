From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] OMAP3:PM: introduce enabled flag to omap_opp
Date: Fri, 9 Oct 2009 16:17:49 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CC6CD18@dlee02.ent.ti.com>
References: <1255120059-10768-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40283 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbZJIVS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 17:18:28 -0400
In-Reply-To: <1255120059-10768-1-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>

Nishanth, 

Just one minor bug below.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Friday, October 09, 2009 3:28 PM
> To: linux-omap
> Cc: Menon, Nishanth; Kevin Hilman; Premi, Sanjeev
> Subject: [PATCH] OMAP3:PM: introduce enabled flag to omap_opp
> 
> We used to enable and disable OPPs based on
> rate being set to 0, this has been confusing in
> general. So, allow specific OPPs to be now
> enabled/disabled by an explicit enabled flag.
> 
> Recommendations from Kevin and Sanjeev contributed
> to this patch
> 
> Tested on: SDP3430
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c              |   32 
> ++++++++++++++--------------
>  arch/arm/mach-omap2/resource34xx.c        |    3 ++
>  arch/arm/plat-omap/include/mach/omap-pm.h |    2 +
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c 
> b/arch/arm/mach-omap2/pm34xx.c
> index cea3bca..a75d4d1 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -100,41 +100,41 @@ static struct prm_setup_vc prm_setup = {
>  };
>  
>  struct omap_opp omap3_mpu_rate_table[] = {
> -	{0, 0, 0},
> +	{0, 0, 0, 0},
>  	/*OPP1*/
> -	{S125M, VDD1_OPP1, 0x1E},
> +	{true, S125M, VDD1_OPP1, 0x1E, true},

The last "true" here is wrong.

Should just be:
	{true, S125M, VDD1_OPP1, 0x1E},

Regards,
Sergio

>  	/*OPP2*/
> -	{S250M, VDD1_OPP2, 0x26},
> +	{true, S250M, VDD1_OPP2, 0x26},
>  	/*OPP3*/
> -	{S500M, VDD1_OPP3, 0x30},
> +	{true, S500M, VDD1_OPP3, 0x30},
>  	/*OPP4*/
> -	{S550M, VDD1_OPP4, 0x36},
> +	{true, S550M, VDD1_OPP4, 0x36},
>  	/*OPP5*/
> -	{S600M, VDD1_OPP5, 0x3C},
> +	{true, S600M, VDD1_OPP5, 0x3C},
>  };
>  
>  struct omap_opp omap3_l3_rate_table[] = {
> -	{0, 0, 0},
> +	{0, 0, 0, 0},
>  	/*OPP1*/
> -	{0, VDD2_OPP1, 0x1E},
> +	{false, 0, VDD2_OPP1, 0x1E},
>  	/*OPP2*/
> -	{S83M, VDD2_OPP2, 0x24},
> +	{true, S83M, VDD2_OPP2, 0x24},
>  	/*OPP3*/
> -	{S166M, VDD2_OPP3, 0x2C},
> +	{true, S166M, VDD2_OPP3, 0x2C},
>  };
>  
>  struct omap_opp omap3_dsp_rate_table[] = {
> -	{0, 0, 0},
> +	{0, 0, 0, 0},
>  	/*OPP1*/
> -	{S90M, VDD1_OPP1, 0x1E},
> +	{true, S90M, VDD1_OPP1, 0x1E},
>  	/*OPP2*/
> -	{S180M, VDD1_OPP2, 0x26},
> +	{true, S180M, VDD1_OPP2, 0x26},
>  	/*OPP3*/
> -	{S360M, VDD1_OPP3, 0x30},
> +	{true, S360M, VDD1_OPP3, 0x30},
>  	/*OPP4*/
> -	{S400M, VDD1_OPP4, 0x36},
> +	{true, S400M, VDD1_OPP4, 0x36},
>  	/*OPP5*/
> -	{S430M, VDD1_OPP5, 0x3C},
> +	{true, S430M, VDD1_OPP5, 0x3C},
>  };
>  
>  const struct omap_opp_table omap3_mpu_opp_table = {
> diff --git a/arch/arm/mach-omap2/resource34xx.c 
> b/arch/arm/mach-omap2/resource34xx.c
> index 491e1dc..12de2c6 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -282,6 +282,9 @@ static int program_opp(int res, struct 
> omap_opp *opp, int target_level,
>  	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
>  	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
>  #endif
> +	/* only allow enabled OPPs */
> +	if (!opp[target_level].enabled)
> +		return -EINVAL;
>  
>  	/* Sanity check of the OPP params before attempting to set */
>  	if (!opp[target_level].rate || !opp[target_level].vsel)
> diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h 
> b/arch/arm/plat-omap/include/mach/omap-pm.h
> index 51216cf..33e1a3e 100644
> --- a/arch/arm/plat-omap/include/mach/omap-pm.h
> +++ b/arch/arm/plat-omap/include/mach/omap-pm.h
> @@ -21,6 +21,7 @@
>  
>  /**
>   * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
> + * @enabled: enabled if true, disabled if false
>   * @rate: target clock rate
>   * @opp_id: OPP ID
>   * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
> @@ -28,6 +29,7 @@
>   * Operating performance point data.  Can vary by OMAP chip 
> and board.
>   */
>  struct omap_opp {
> +	bool enabled;
>  	unsigned long rate;
>  	u8 opp_id;
>  	u16 vsel;
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 