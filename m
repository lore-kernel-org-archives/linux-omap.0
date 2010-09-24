From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Fri, 24 Sep 2010 12:57:43 -0700
Message-ID: <87lj6q9ao8.fsf@deeprootsystems.com>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
	<1285325785-6163-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52743 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0IXT5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 15:57:45 -0400
Received: by pwj6 with SMTP id 6so726397pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 12:57:45 -0700 (PDT)
In-Reply-To: <1285325785-6163-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 24 Sep 2010 16:26:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> There is no need to keep omap3 sleep code in SRAM. 
> This code can be run very well on DDR.

/me remains skeptical

> This would help us to instrument CPUIdle latencies.

Indeed, but...

I'm afraid we will need a much more descriptive changelog here,
describing in detail why this will still work, and what about the
previous motiviations for running SRAM has changed such that this will
work out of SRAM.

> Tested on ZOOM3.

Tested in what way?  This path is used for both idle and suspend, and 
needs to be validated for retention and off mode.

Kevin

> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Kevin Hillman <khilman@deeprootsystems.com>
> Cc: <Linaro> linaro-dev@lists.linaro.org
> ---
>  arch/arm/mach-omap2/pm34xx.c |    9 +--------
>  1 files changed, 1 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 85ef245..ed9d12c 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -79,8 +79,6 @@ struct power_state {
>  
>  static LIST_HEAD(pwrst_list);
>  
> -static void (*_omap_sram_idle)(u32 *addr, int save_state);
> -
>  static int (*_omap_save_secure_sram)(u32 *addr);
>  
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> @@ -360,9 +358,6 @@ void omap_sram_idle(void)
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
>  
> -	if (!_omap_sram_idle)
> -		return;
> -
>  	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(core_pwrdm);
> @@ -438,7 +433,7 @@ void omap_sram_idle(void)
>  	 * get saved. The restore path then reads from this
>  	 * location and restores them back.
>  	 */
> -	_omap_sram_idle(omap3_arm_context, save_state);
> +	omap34xx_cpu_suspend(omap3_arm_context, save_state);
>  	cpu_init();
>  
>  	if (is_suspending())
> @@ -995,8 +990,6 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
>  
>  void omap_push_sram_idle(void)
>  {
> -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> -					omap34xx_cpu_suspend_sz);
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
>  		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
>  				save_secure_ram_context_sz);
