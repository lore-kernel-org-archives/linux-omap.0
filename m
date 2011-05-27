From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH pm_wip/voltdm_nm] ARM: OMAP: Explicitly mask VPVOLTAGE field
Date: Fri, 27 May 2011 16:35:43 -0700
Message-ID: <87ipsvvhrk.fsf@ti.com>
References: <20110527030346.GA2720@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52772 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752741Ab1E0Xfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 19:35:47 -0400
Received: by mail-pw0-f49.google.com with SMTP id 8so1166032pwi.36
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 16:35:46 -0700 (PDT)
In-Reply-To: <20110527030346.GA2720@google.com> (Todd Poynor's message of
	"Thu, 26 May 2011 20:03:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org

Hi Todd,

Todd Poynor <toddpoynor@google.com> writes:

> Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
> relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
> in the upper bits.  Make this explicit using the mask and shift symbols
> already defined, added as new fields in struct omap_vp_common.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks for the patch.  Indeed it's better to make this explict.

Minor nit: we don't need both the mask and the shift defined.  Just add
the mask, and the code can use __ffs(mask) to get the shift value.  This
is what I've done in the rest of the VC/VP code.

Also, can you make the subject prefix 'OMAP: VP: ...' 

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/vp.c          |    3 ++-
>  arch/arm/mach-omap2/vp.h          |    4 ++++
>  arch/arm/mach-omap2/vp3xxx_data.c |    3 +++
>  arch/arm/mach-omap2/vp44xx_data.c |    2 ++
>  4 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index e7d38f6..c3b7fde 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -227,7 +227,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
>  		return 0;
>  	}
>  
> -	curr_vsel = voltdm->read(vp->voltage);
> +	curr_vsel = (voltdm->read(vp->voltage) & vp->common->vpvoltage_mask)
> +		>> vp->common->vpvoltage_shift;
>  
>  	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
>  		pr_warning("%s: PMIC function to convert vsel to voltage"
> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
> index 0d63267..cb62a7b 100644
> --- a/arch/arm/mach-omap2/vp.h
> +++ b/arch/arm/mach-omap2/vp.h
> @@ -63,6 +63,8 @@ struct omap_vp_ops {
>   * @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
>   * @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
>   * @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
> + * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
> + * @vpvoltage_shift: VPVOLTAGE field shift in PRM_VP*_VOLTAGE reg
>   */
>  struct omap_vp_common {
>  	u32 vpconfig_erroroffset_mask;
> @@ -79,6 +81,8 @@ struct omap_vp_common {
>  	u8 vlimitto_vddmin_shift;
>  	u8 vlimitto_vddmax_shift;
>  	u8 vlimitto_timeout_shift;
> +	u8 vpvoltage_mask;
> +	u8 vpvoltage_shift;
>  
>  	const struct omap_vp_ops *ops;
>  };
> diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
> index d429c44..0b149e0 100644
> --- a/arch/arm/mach-omap2/vp3xxx_data.c
> +++ b/arch/arm/mach-omap2/vp3xxx_data.c
> @@ -51,6 +51,9 @@ static const struct omap_vp_common omap3_vp_common = {
>  	.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT,
>  	.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT,
>  	.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT,
> +	.vpvoltage_mask = OMAP3430_VPVOLTAGE_MASK,
> +	.vpvoltage_shift = OMAP3430_VPVOLTAGE_SHIFT,
> +
>  	.ops = &omap3_vp_ops,
>  };
>  
> diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
> index 0daf2a4..174d6f7 100644
> --- a/arch/arm/mach-omap2/vp44xx_data.c
> +++ b/arch/arm/mach-omap2/vp44xx_data.c
> @@ -51,6 +51,8 @@ static const struct omap_vp_common omap4_vp_common = {
>  	.vlimitto_vddmin_shift = OMAP4430_VDDMIN_SHIFT,
>  	.vlimitto_vddmax_shift = OMAP4430_VDDMAX_SHIFT,
>  	.vlimitto_timeout_shift = OMAP4430_TIMEOUT_SHIFT,
> +	.vpvoltage_mask = OMAP4430_VPVOLTAGE_MASK,
> +	.vpvoltage_shift = OMAP4430_VPVOLTAGE_SHIFT,
>  	.ops = &omap4_vp_ops,
>  };
