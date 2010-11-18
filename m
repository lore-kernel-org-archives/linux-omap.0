From: Nishanth Menon <nm@ti.com>
Subject: RE: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 08:57:10 -0600
Message-ID: <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com> <1290091906-32539-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58800 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757964Ab0KRO5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 09:57:13 -0500
Received: by mail-wy0-f176.google.com with SMTP id 19so3691133wyf.7
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 06:57:12 -0800 (PST)
In-Reply-To: <1290091906-32539-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Kevin Hillman <khilman@deeprootsystems.com>, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jean Pihet
> Sent: Thursday, November 18, 2010 8:52 AM
> To: linux-omap@vger.kernel.org
> Cc: Vishwanath BS; Kevin Hillman; Jean Pihet
> Subject: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
>
> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> For historical reasons the OMAP3 sleep code is run from SRAM.
> This code can run from DDR which provides better performance and
> leaves the SRAM available for other uses.
>
> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
> with full RET and OFF modes.

Sorry, But I disagree with this patch.

There is a silicon errata which cannot be handled with this - RTA disable
- errata i608

You need to disable RTA while coming out of OFF - we cannot handle this on

GP devices if this is not done.

>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Kevin Hillman <khilman@deeprootsystems.com>
>
> Changed the commit comments.
>
> Cc: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    9 +--------
>  1 files changed, 1 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 75c0cd1..035ca47 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -65,8 +65,6 @@ struct power_state {
>
>  static LIST_HEAD(pwrst_list);
>
> -static void (*_omap_sram_idle)(u32 *addr, int save_state);
> -
>  static int (*_omap_save_secure_sram)(u32 *addr);
>
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> @@ -346,9 +344,6 @@ void omap_sram_idle(void)
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
>
> -	if (!_omap_sram_idle)
> -		return;
> -
>  	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(core_pwrdm);
> @@ -422,7 +417,7 @@ void omap_sram_idle(void)
>  	 * get saved. The restore path then reads from this
>  	 * location and restores them back.
>  	 */
> -	_omap_sram_idle(omap3_arm_context, save_state);
> +	omap34xx_cpu_suspend(omap3_arm_context, save_state);
>  	cpu_init();
>
>  	/* Restore normal SDRC POWER settings */
> @@ -972,8 +967,6 @@ static int __init clkdms_setup(struct clockdomain
> *clkdm, void *unused)
>
>  void omap_push_sram_idle(void)
>  {
> -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> -					omap34xx_cpu_suspend_sz);
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
>  		_omap_save_secure_sram =
> omap_sram_push(save_secure_ram_context,
>  				save_secure_ram_context_sz);
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
