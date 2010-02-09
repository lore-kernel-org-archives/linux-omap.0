From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP3: PM: remove TWL4030 A2S script before reboot
Date: Tue, 9 Feb 2010 14:35:29 -0800
Message-ID: <20100209223529.GK21755@atomide.com>
References: <1265226207-22971-1-git-send-email-mturquette@ti.com>
 <1265226207-22971-2-git-send-email-mturquette@ti.com>
 <1265226207-22971-3-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab0BIWex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 17:34:53 -0500
Content-Disposition: inline
In-Reply-To: <1265226207-22971-3-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@gmail.com>
Cc: linux-omap@vger.kernel.org, Mike Turquette <mturquette@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

* Mike Turquette <mturquette@gmail.com> [100203 11:42]:
> Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
> necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
> in the sleep script being executed on TWL4030. This usually results in
> VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
> MPU Watch Dog reset or worse, an irrecoverable hang.

The first patch is OK is for Samuel, but this needs to be updated
against Paul's clock changes. One comment below too.
 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 0d30e53..0d6d1d6 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -28,6 +28,7 @@
>  #include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/cpufreq.h>
> +#include <linux/i2c/twl.h>
>  
>  #include <plat/cpu.h>
>  #include <plat/clock.h>
> @@ -311,6 +312,8 @@ struct clk_functions omap2_clk_functions = {
>   */
>  void omap2_clk_prepare_for_reboot(void)
>  {
> +	int err = 0;
> +
>  	/* REVISIT: Not ready for 343x */
>  #if 0
>  	u32 rate;
> @@ -321,6 +324,18 @@ void omap2_clk_prepare_for_reboot(void)
>  	rate = clk_get_rate(sclk);
>  	clk_set_rate(vclk, rate);
>  #endif
> +
> +	/*
> +	 * PRCM on OMAP3 will drive SYS_OFFMODE low during DPLL3 warm reset.
> +	 * This causes Gaia sleep script to execute, usually killing VDD1 and
> +	 * VDD2 while code is running.  WA is to disable the sleep script
> +	 * before warm reset.
> +	 */
> +#ifdef CONFIG_TWL4030_POWER
> +	err = twl4030_remove_script(TWL4030_SLEEP_SCRIPT);
> +	if (err)
> +		pr_err("twl4030: error trying to disable sleep script!\n");
> +#endif

This needs to work in cases where we have multiple companion chips
compiled in. You may have twl4030 support compiled in, but no twl4030
hardware on the board. It needs to be based on I2C detected chips during
init somehow.

In the omap for-next branch we already support booting 2420, 34xx, 36xx
and 4430 with the same kernel binary. So please update accordingly.

Regards,

Tony
