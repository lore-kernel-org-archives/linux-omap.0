From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2 2/4] ARM: OMAP3+: PM: VP: move check of idle to separate function
Date: Fri, 01 Jun 2012 14:07:29 -0700
Message-ID: <87fwaespv2.fsf@ti.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com>
	<1338514899-3560-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45082 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759392Ab2FAVH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 17:07:29 -0400
Received: by pbcwy7 with SMTP id wy7so3440529pbc.31
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 14:07:27 -0700 (PDT)
In-Reply-To: <1338514899-3560-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 31 May 2012 20:41:37 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@ti.com>

Nishanth Menon <nm@ti.com> writes:

> In general, the idle check tends to be time sensitive so that the
> followon operation after the idle status verification is done in
> a timely manner. However, since we'd be using this in multiple
> places in follow-on patches, isolate this out to a separate inline
> function.
>
> As part of this change, convert the pr_warning to a rate limited
> warning as the situation is most probably going to stick around
> (since Voltage Processor state machine might be stuck) + a WARN_ONCE
> to ensure adequate attention is received. Document the information
> about idle timeout. Based on the idea from Kevin Hilman.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/vp.c |   55 ++++++++++++++++++++++++++++++++++++----------
>  arch/arm/mach-omap2/vp.h |    6 ++++-
>  2 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index faefef7..4723879 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -1,5 +1,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/ratelimit.h>
>  
>  #include "common.h"
>  
> @@ -9,6 +10,45 @@
>  #include "prm-regbits-44xx.h"
>  #include "prm44xx.h"
>  
> +/**
> + * _vp_wait_for_idle() - wait for voltage processor to idle
> + * @voltdm:	voltage domain
> + * @vp:		voltage processor instance
> + *
> + * In some conditions, it is important to ensure that Voltage Processor
> + * is idle before performing operations on the Voltage Processor(VP).
> + * This is primarily to ensure that VP state machine does not enter into
> + * invalid state.
> + *
> + * Returns -ETIMEDOUT if timeout occurs - This could be critical failure
> + * as it indicates that Voltage processor might have it's state machine
> + * stuck up without recovering out(theoretically should never happen
> + * ofcourse). Returns 0 if idle state is detected.
> + *
> + * Note: callers are expected to ensure requisite checks are performed
> + * on the pointers passed.
> + */
> +static inline int _vp_wait_for_idle(struct voltagedomain *voltdm,
> +				    struct omap_vp_instance *vp)
> +{
> +	int timeout;
> +
> +	omap_test_timeout((voltdm->read(vp->vstatus) &
> +			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
> +			  timeout);
> +
> +	if (timeout >= VP_IDLE_TIMEOUT) {
> +		/* Dont spam the console but ensure we catch attention */
> +		pr_warn_ratelimited("%s: vdd_%s idle timedout\n",

s/idle timedout/timeout waiting for VP idle/

> +				    __func__, voltdm->name);
> +		WARN_ONCE("vdd_%s idle timedout\n", voltdm->name);
> +

Maybe just leave the WARN_ONCE() here since all the callers are using
the rate-limited pr_warn() in the case of error.  Otherwise, there will
b a bunch of duplicated messages on the console.

> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  static u32 _vp_set_init_voltage(struct voltagedomain *voltdm, u32 volt)
>  {
>  	struct omap_vp_instance *vp = voltdm->vp;
> @@ -241,7 +281,6 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  {
>  	struct omap_vp_instance *vp;
>  	u32 vpconfig;
> -	int timeout;
>  
>  	if (!voltdm || IS_ERR(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
> @@ -267,16 +306,10 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  	vpconfig &= ~vp->common->vpconfig_vpenable;
>  	voltdm->write(vpconfig, vp->vpconfig);
>  
> -	/*
> -	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
> -	 */
> -	omap_test_timeout((voltdm->read(vp->vstatus) &
> -			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
> -			  timeout);
> -
> -	if (timeout >= VP_IDLE_TIMEOUT)
> -		pr_warning("%s: vdd_%s idle timedout\n",
> -			__func__, voltdm->name);
> +	if (_vp_wait_for_idle(voltdm, vp)) {
> +		pr_warn_ratelimited("%s: vdd_%s timedout after disable!!\n",

s/timedout/VP idle timeout/

> +				    __func__, voltdm->name);
> +	}
>  
>  	vp->enabled = false;
>  
> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
> index ac1d6cf..4655b39 100644
> --- a/arch/arm/mach-omap2/vp.h
> +++ b/arch/arm/mach-omap2/vp.h
> @@ -30,7 +30,11 @@ struct voltagedomain;
>  #define OMAP4_VP_VDD_IVA_ID 1
>  #define OMAP4_VP_VDD_MPU_ID 2
>  
> -/* XXX document */
> +/*
> + * Time out for Voltage processor in micro seconds. Typical latency is < 2uS,
> + * but worst case latencies could be around 3-200uS depending on where we
> + * interrupted VP's operation.
> + */
>  #define VP_IDLE_TIMEOUT		200
>  #define VP_TRANXDONE_TIMEOUT	300

Kevin
