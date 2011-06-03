From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept of default channel
Date: Fri, 03 Jun 2011 10:27:31 -0700
Message-ID: <878vtig70c.fsf@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
	<1306711180-8631-3-git-send-email-nm@ti.com> <87pqmvn6gk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54259 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab1FCR1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 13:27:35 -0400
Received: by mail-pw0-f51.google.com with SMTP id 9so1338381pwi.24
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 10:27:34 -0700 (PDT)
In-Reply-To: <87pqmvn6gk.fsf@ti.com> (Kevin Hilman's message of "Thu, 02 Jun
	2011 16:45:15 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Nishanth,

Kevin Hilman <khilman@ti.com> writes:

[...]

>
> So rather than take this patch, I'm just going to fold the following
> diff into "OMAP3+: VC: abstract out channel configuration" in voltdm_b.
> I'll also update the changelog noting that the TRM is wrong here in that
> it describes CORE as the default channel when it's in fact MPU.
>

FYI...

I modified this slightly in the current voltdm_* branch in that I'm now
using a 'u8 flags' in the VC struct intead of a bool for this since  I expect
to have some other reasons to use various flags.

Kevin

>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index fba352d..fa48944 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -33,21 +33,20 @@
>   * - command configuration address (RAC) and enable bit (RACEN)
>   * - command values for ON, ONLP, RET and OFF (CMD)
>   *
> - * This function currently only allows flexible configuration of
> - * the non-default channel (e.g. non-zero channels.)  Starting with
> - * OMAP4, only the non-zero channels can be configured.  Channel zero
> - * always uses the channel zero register values.  Therefore, the
> - * same limitation is imposed on OMAP3 for consistency.
> + * This function currently only allows flexible configuration of the
> + * non-default channel.  Starting with OMAP4, there are more than 2
> + * channels, with one defined as the default (on OMAP4, it's MPU.)
> + * Only the non-default channel can be configured.
>   */
>  static int omap_vc_config_channel(struct voltagedomain *voltdm)
>  {
>  	struct omap_vc_channel *vc = voltdm->vc;
>  
>  	/*
> -	 * For channel zero, the only configurable bit is RACEN.
> +	 * For default channel, the only configurable bit is RACEN.
>  	 * All others must stay at zero (see function comment above.)
>  	 */
> -	if (!vc->cfg_channel_sa_shift)
> +	if (vc->is_default_channel)
>  		vc->cfg_channel &= CFG_CHANNEL_RACEN;
>  
>  	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index f0fb61f..c216b57 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -84,6 +84,8 @@ struct omap_vc_channel {
>  	u32 smps_cmdra_mask;
>  	u8 cmdval_reg;
>  	u8 cfg_channel_sa_shift;
> +
> +	bool is_default_channel;
>  };
>  
>  extern struct omap_vc_channel omap3_vc_mpu;
> diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
> index fe4f4e5..5844b20 100644
> --- a/arch/arm/mach-omap2/vc44xx_data.c
> +++ b/arch/arm/mach-omap2/vc44xx_data.c
> @@ -58,6 +58,7 @@ struct omap_vc_channel omap4_vc_mpu = {
>  	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
>  	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
>  	.cfg_channel_sa_shift = OMAP4430_SA_VDD_MPU_L_SHIFT,
> +	.is_default_channel = true,
>  };
>  
>  struct omap_vc_channel omap4_vc_iva = {
