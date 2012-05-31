From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit
Date: Thu, 31 May 2012 16:27:28 -0700
Message-ID: <87k3zsvsm7.fsf@ti.com>
References: <1337369601-14915-1-git-send-email-nm@ti.com>
	<1337369601-14915-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:59965 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758635Ab2EaX12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 19:27:28 -0400
Received: by dadg9 with SMTP id g9so2046829dad.12
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 16:27:27 -0700 (PDT)
In-Reply-To: <1337369601-14915-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 18 May 2012 14:33:21 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Currently we check against the entire 32 bits of the status register
> Where, bits 1-31 are marked as reserved and mentioned in TRM as read
> returns undefined values. 

ouch

> Hence, check against purely the vpinidle status bit.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Reported-by: Vinay Amancha <vinaykumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks for the fix.

Looking at this combined with the previous patches, since this same
thing is done several places, it looks like we need a helper function
'omap_vp_wait_for_idle()' or similar.  That function will do the check,
wait for timeout, and return an error if failure.  The callers can than
do appropriate error handling upon failure.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/vp.c          |   15 +++++++++------
>  arch/arm/mach-omap2/vp.h          |    1 +
>  arch/arm/mach-omap2/vp3xxx_data.c |    1 +
>  arch/arm/mach-omap2/vp44xx_data.c |    1 +
>  4 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 985091b..cdcac16 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -128,8 +128,9 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
>  	 * This is an additional allowance to ensure we are in proper state
>  	 * to enter into forceupdate state transition.
>  	 */
> -	omap_test_timeout((voltdm->read(vp->vstatus)),
> -			  VP_IDLE_TIMEOUT, timeout);
> +	omap_test_timeout((voltdm->read(vp->vstatus) &
> +			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
> +			  timeout);
>  
>  	if (timeout >= VP_IDLE_TIMEOUT)
>  		pr_warning("%s: vdd_%s idle timedout forceupdate(v=%ld)\n",
> @@ -278,8 +279,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
>  	 * Depending on if we catch VP in the middle of an SR operation.
>  	 */
> -	omap_test_timeout((voltdm->read(vp->vstatus)),
> -			  VP_IDLE_TIMEOUT, timeout);
> +	omap_test_timeout((voltdm->read(vp->vstatus) &
> +			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
> +			  timeout);
>  
>  	if (timeout >= VP_IDLE_TIMEOUT)
>  		pr_warning("%s: vdd_%s idle timedout before disable\n",
> @@ -293,8 +295,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  	/*
>  	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
>  	 */
> -	omap_test_timeout((voltdm->read(vp->vstatus)),
> -			  VP_IDLE_TIMEOUT, timeout);
> +	omap_test_timeout((voltdm->read(vp->vstatus) &
> +			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
> +			  timeout);
>  
>  	if (timeout >= VP_IDLE_TIMEOUT)
>  		pr_warning("%s: vdd_%s idle timedout after disable\n",
> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
> index 0abf895..876b5ab 100644
> --- a/arch/arm/mach-omap2/vp.h
> +++ b/arch/arm/mach-omap2/vp.h
> @@ -73,6 +73,7 @@ struct omap_vp_common {
>  	u8 vpconfig_initvdd;
>  	u8 vpconfig_forceupdate;
>  	u8 vpconfig_vpenable;
> +	u8 vstatus_vpidle;
>  	u8 vstepmin_stepmin_shift;
>  	u8 vstepmin_smpswaittimemin_shift;
>  	u8 vstepmax_stepmax_shift;
> diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
> index bd89f80..a65909b 100644
> --- a/arch/arm/mach-omap2/vp3xxx_data.c
> +++ b/arch/arm/mach-omap2/vp3xxx_data.c
> @@ -44,6 +44,7 @@ static const struct omap_vp_common omap3_vp_common = {
>  	.vpconfig_initvdd = OMAP3430_INITVDD_MASK,
>  	.vpconfig_forceupdate = OMAP3430_FORCEUPDATE_MASK,
>  	.vpconfig_vpenable = OMAP3430_VPENABLE_MASK,
> +	.vstatus_vpidle = OMAP3430_VPINIDLE_MASK,
>  	.vstepmin_smpswaittimemin_shift = OMAP3430_SMPSWAITTIMEMIN_SHIFT,
>  	.vstepmax_smpswaittimemax_shift = OMAP3430_SMPSWAITTIMEMAX_SHIFT,
>  	.vstepmin_stepmin_shift = OMAP3430_VSTEPMIN_SHIFT,
> diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
> index 8c031d1..9d14881 100644
> --- a/arch/arm/mach-omap2/vp44xx_data.c
> +++ b/arch/arm/mach-omap2/vp44xx_data.c
> @@ -44,6 +44,7 @@ static const struct omap_vp_common omap4_vp_common = {
>  	.vpconfig_initvdd = OMAP4430_INITVDD_MASK,
>  	.vpconfig_forceupdate = OMAP4430_FORCEUPDATE_MASK,
>  	.vpconfig_vpenable = OMAP4430_VPENABLE_MASK,
> +	.vstatus_vpidle = OMAP4430_VPINIDLE_MASK,
>  	.vstepmin_smpswaittimemin_shift = OMAP4430_SMPSWAITTIMEMIN_SHIFT,
>  	.vstepmax_smpswaittimemax_shift = OMAP4430_SMPSWAITTIMEMAX_SHIFT,
>  	.vstepmin_stepmin_shift = OMAP4430_VSTEPMIN_SHIFT,
