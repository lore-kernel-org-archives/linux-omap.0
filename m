From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate
Date: Thu, 31 May 2012 16:23:03 -0700
Message-ID: <87vcjcvstk.fsf@ti.com>
References: <1337369601-14915-1-git-send-email-nm@ti.com>
	<1337369601-14915-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57154 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758630Ab2EaXXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 19:23:03 -0400
Received: by dajz8 with SMTP id z8so3041895daj.16
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 16:23:02 -0700 (PDT)
In-Reply-To: <1337369601-14915-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 18 May 2012 14:33:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinay Amancha <vinaykumar@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Ideally in the flow of DVFS programming, VP should be in idle state
> (since we disabled it) before entering forceupdate. Ensure that
> this is the case. Not doing this could cause VP statemachine
> to enter invalid states.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Signed-off-by: Vinay Amancha <vinaykumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/vp.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 925d869..985091b 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -123,6 +123,18 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
>  	u8 target_vsel, current_vsel;
>  	int ret, timeout = 0;
>  
> +/*

missing indent

> +	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
> +	 * This is an additional allowance to ensure we are in proper state
> +	 * to enter into forceupdate state transition.
> +	 */
> +	omap_test_timeout((voltdm->read(vp->vstatus)),
> +			  VP_IDLE_TIMEOUT, timeout);
> +
> +	if (timeout >= VP_IDLE_TIMEOUT)
> +		pr_warning("%s: vdd_%s idle timedout forceupdate(v=%ld)\n",
> +			   __func__, voltdm->name, target_volt);
> +

Again, some clean failure and error recovery should be done here instead
of just a print and bail.

Kevin

>  	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
>  	if (ret)
>  		return ret;
