From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 16 Dec 2011 17:47:41 +0530
Message-ID: <4EEB36E5.8020504@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com> <4ED85835.7080108@ti.com> <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:41702 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab1LPMRs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 07:17:48 -0500
Received: by yenm3 with SMTP id m3so2725747yen.26
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 04:17:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Friday 16 December 2011 04:46 PM, Paul Walmsley wrote:
>
> Hi Rajendra,
>
> I've combined your patches down to one patch and changed the logic a
> little bit.  It looks to me that the update and clear context registers
> can be done in one step, since an IP block shouldn't lose context when
> it's enabled.  But maybe I'm missing something?

Thanks for the patch. The changes look fine and I also did a quick
test on an internal tree which supports core OSWR and it seems to
work fine too.

regards,
Rajendra

>
> Anyway, I'd appreciate any comments you might have, and if you have an
> environment where you can test this patch, that would also be very
> welcome.
>
>
> - Paul
>
> From: Rajendra Nayak<rnayak@ti.com>
> Date: Fri, 16 Dec 2011 04:12:48 -0700
> Subject: [PATCH] ARM: OMAP: hwmod: Add support for per hwmod/module context
>   lost count
>
> OMAP4 has module specific context lost registers which makes it now
> possible to have module level context loss count, instead of relying
> on the powerdomain level context count.
>
> Add 2 private hwmod api's to update/clear the hwmod/module specific
> context lost counters/register.
>
> Update the module specific context_lost_counter and clear the hardware
> bits just after enabling the module.
>
> omap_hwmod_get_context_loss_count() now returns the hwmod context loss
> count them on platforms where they exist (OMAP4), else fall back on
> the pwrdm level counters for older platforms.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> [paul@pwsan.com: added function kerneldoc, fixed structure kerneldoc,
>   rearranged structure to avoid memory waste, marked fns as OMAP4-specific,
>   prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
>   and clear, merged patches]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   54 ++++++++++++++++++++++++--
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++-
>   2 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 0a89335..5702462 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1435,6 +1435,42 @@ static int _reset(struct omap_hwmod *oh)
>   }
>
>   /**
> + * _omap4_update_context_lost - increment hwmod context loss counter if
> + * hwmod context was lost, and clear hardware context loss reg
> + * @oh: hwmod to check for context loss
> + *
> + * If the PRCM indicates that the hwmod @oh lost context, increment
> + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> + * bits.  XXX Will not work correctly if the RM_*_CONTEXT register
> + * offset is 0 -- probably a flag should be used to avoid this
> + * situation, rather than testing @oh->prcm.omap4.context_offs.  No
> + * return value.
> + */
> +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> +{
> +	u32 r;
> +
> +	if (!cpu_is_omap44xx())
> +		return;
> +
> +	if (!oh->prcm.omap4.context_offs)
> +		return;
> +
> +	r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> +					oh->clkdm->pwrdm.ptr->prcm_offs,
> +					oh->prcm.omap4.context_offs);
> +
> +	if (!r)
> +		return;
> +
> +	oh->prcm.omap4.context_lost_counter++;
> +
> +	omap4_prminst_write_inst_reg(r, oh->clkdm->pwrdm.ptr->prcm_partition,
> +				     oh->clkdm->pwrdm.ptr->prcm_offs,
> +				     oh->prcm.omap4.context_offs);
> +}
> +
> +/**
>    * _enable - enable an omap_hwmod
>    * @oh: struct omap_hwmod *
>    *
> @@ -1512,6 +1548,8 @@ static int _enable(struct omap_hwmod *oh)
>   	_enable_clocks(oh);
>   	_enable_module(oh);
>
> +	_omap4_update_context_lost(oh);
> +
>   	r = _wait_target_ready(oh);
>   	if (!r) {
>   		/*
> @@ -2640,17 +2678,25 @@ ohsps_unlock:
>    * omap_hwmod_get_context_loss_count - get lost context count
>    * @oh: struct omap_hwmod *
>    *
> - * Query the powerdomain of of @oh to get the context loss
> - * count for this device.
> + * Returns the context loss count of associated with @oh
> + * upon success, or zero if no context loss data is available.
>    *
> - * Returns the context loss count of the powerdomain assocated with @oh
> - * upon success, or zero if no powerdomain exists for @oh.
> + * On OMAP4, this queries the per-hwmod context loss register,
> + * assuming one exists.  If not, or on OMAP2/3, this queries the
> + * enclosing powerdomain context loss count.
>    */
>   int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
>   {
>   	struct powerdomain *pwrdm;
>   	int ret = 0;
>
> +	/*
> +	 * XXX This should use a flag to determine whether to check
> +	 * context_offs, as context_offs == 0 is potentially valid
> +	 */
> +	if (cpu_is_omap44xx()&&  oh->prcm.omap4.context_offs)
> +		return oh->prcm.omap4.context_lost_counter;
> +
>   	pwrdm = omap_hwmod_get_pwrdm(oh);
>   	if (pwrdm)
>   		ret = pwrdm_get_context_loss_count(pwrdm);
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1a13c02..3aea95e 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -361,9 +361,12 @@ struct omap_hwmod_omap2_prcm {
>
>   /**
>    * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
> - * @clkctrl_reg: PRCM address of the clock control register
> - * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
> + * @clkctrl_offs: offset of the PRCM clock control register
> + * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
> + * @context_offs: offset of the RM_*_CONTEXT register
>    * @submodule_wkdep_bit: bit shift of the WKDEP range
> + * @modulemode: allowable modulemodes
> + * @context_lost_counter: Count of module level context lost
>    */
>   struct omap_hwmod_omap4_prcm {
>   	u16		clkctrl_offs;
> @@ -371,6 +374,7 @@ struct omap_hwmod_omap4_prcm {
>   	u16		context_offs;
>   	u8		submodule_wkdep_bit;
>   	u8		modulemode;
> +	unsigned	context_lost_counter;
>   };
>
>

