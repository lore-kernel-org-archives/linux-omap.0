From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] arm: omap3: add manual control for mpu_iva voltdm usecounting
Date: Tue, 14 Feb 2012 11:35:51 -0800
Message-ID: <8762f96wdk.fsf@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
	<1329237402-26008-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52578 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800Ab2BNTf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 14:35:57 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so1061328pbc.33
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 11:35:53 -0800 (PST)
In-Reply-To: <1329237402-26008-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Tue, 14 Feb 2012 18:36:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> mpu_iva voltdm usecount is now decreased during idle. This will
> allow the voltagedomain to reflect actual usage, and will allow
> proper usage of vc callbacks.

I don't follow why this is needed in the idle path.

Why aren't the usecounts from clock/powerdomain disables (enables) causing this
voltdm disable (enable) to happen automatcially?

If these are needed, seems like they should be in the
pwrdm_[pre|post]_transition() hooks so they can be generic.

Kevin

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fc69875..14defaf 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -74,6 +74,7 @@ void (*omap3_do_wfi_sram)(void);
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
> +static struct voltagedomain *mpu_iva_voltdm;
>  
>  static inline void omap3_per_save_context(void)
>  {
> @@ -311,6 +312,8 @@ void omap_sram_idle(void)
>  		return;
>  	}
>  
> +	voltdm_pwrdm_disable(mpu_iva_voltdm);
> +
>  	/* NEON control */
>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
> @@ -393,6 +396,8 @@ void omap_sram_idle(void)
>  	}
>  	omap3_intc_resume_idle();
>  
> +	voltdm_pwrdm_enable(mpu_iva_voltdm);
> +
>  	pwrdm_post_transition();
>  
>  	/* PER */
> @@ -828,6 +833,9 @@ static int __init omap3_pm_init(void)
>  
>  	(void) clkdm_for_each(clkdms_setup, NULL);
>  
> +	mpu_iva_voltdm = voltdm_lookup("mpu_iva");
> +	voltdm_pwrdm_enable(mpu_iva_voltdm);
> +
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm == NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
