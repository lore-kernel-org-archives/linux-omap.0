From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Program SDRC to send self refresh on timeout of AUTO_CNT
Date: Mon, 15 Jun 2009 12:14:44 -0700
Message-ID: <87k53d8g2j.fsf@deeprootsystems.com>
References: <1244566841-5393-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:28425 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZFOTVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 15:21:50 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2425404qwd.37
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 12:21:52 -0700 (PDT)
In-Reply-To: <1244566841-5393-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Tue\,  9 Jun 2009 22\:30\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Rajendra Nayak <rnayak@ti.com> writes:

> Due to an OMAP3 errata (1.142), on HS/EMU devices SDRC should be
> programed to issue automatic self refresh on timeout
> of AUTO_CNT = 1 prior to any transition to OFF mode.
> This is needed only on sil rev's ES3.0 and above.
>
> This patch enables the above needed WA in the SDRC power register
> value stored in scratchpad, so that ROM code restores this value
> in SDRC POWER on the wakeup path.
> The original SDRC POWER register value is stored and restored back
> in omap_sram_idle() function.
>
> This fixes some random crashes observed while stressing suspend
> on HS/EMU devices.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/control.c          |   16 +++++++++++++++-
>  arch/arm/mach-omap2/pm34xx.c           |   24 +++++++-----------------
>  arch/arm/plat-omap/include/mach/sdrc.h |    6 ++++++
>  3 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 60de860..c9407c0 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -265,7 +265,21 @@ void omap3_save_scratchpad_contents(void)
>  			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
>  	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
>  	sdrc_block_contents.dll_b_ctrl = 0x0;
> -	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
> +	/*
> +	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
> +	 * be programed to issue automatic self refresh on timeout
> +	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
> +	 */
> +	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
> +			&& (omap_rev() >= OMAP3430_REV_ES3_0))
> +		sdrc_block_contents.power = (sdrc_read_reg(SDRC_POWER) &
> +				~(SDRC_POWER_AUTOCOUNT_MASK|
> +				SDRC_POWER_CLKCTRL_MASK)) |
> +				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
> +				SDRC_SELF_REFRESH_ON_AUTOCOUNT;
> +	else
> +		sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
> +
>  	sdrc_block_contents.cs_0 = 0x0;
>  	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
>  	sdrc_block_contents.mr_0 = (sdrc_read_reg(SDRC_MR_0) & 0xFFFF);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b925501..a9ef670 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -57,12 +57,6 @@
>  
>  static int regset_save_on_suspend;
>  
> -#define SDRC_POWER_AUTOCOUNT_SHIFT 8
> -#define SDRC_POWER_AUTOCOUNT_MASK (0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
> -#define SDRC_POWER_CLKCTRL_SHIFT 4
> -#define SDRC_POWER_CLKCTRL_MASK (0x3 << SDRC_POWER_CLKCTRL_SHIFT)
> -#define SDRC_SELF_REFRESH_ON_AUTOCOUNT (0x2 << SDRC_POWER_CLKCTRL_SHIFT)
> -
>  /* Scratchpad offsets */
>  #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
>  #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
> @@ -405,19 +399,15 @@ void omap_sram_idle(void)
>  	}
>  
>  	/*
> -	 * Force SDRAM controller to self-refresh mode after timeout on
> -	 * autocount. This is needed on ES3.0 to avoid SDRAM controller
> -	 * hang-ups.
> -	 */
> +	* On EMU/HS devices ROM code restores a SRDC value
> +	* from scratchpad which has automatic self refresh on timeout
> +	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> +	* Hence store/restore the SDRC_POWER register here.
> +	*/
>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
>  	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
> -	    core_next_state == PWRDM_POWER_OFF) {
> +	    core_next_state == PWRDM_POWER_OFF)
>  		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
> -		sdrc_write_reg((sdrc_pwr &
> -			~(SDRC_POWER_AUTOCOUNT_MASK|SDRC_POWER_CLKCTRL_MASK)) |
> -			(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
> -			SDRC_SELF_REFRESH_ON_AUTOCOUNT, SDRC_POWER);
> -	}
>  
>  	if (regset_save_on_suspend)
>  		pm_dbg_regset_save(1);
> @@ -430,7 +420,7 @@ void omap_sram_idle(void)
>  	_omap_sram_idle(omap3_arm_context, save_state);
>  	cpu_init();
>  
> -	/* Restore normal SDRAM settings */
> +	/* Restore normal SDRC POWER settings */
>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
>  	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
>  	    core_next_state == PWRDM_POWER_OFF)
> diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
> index a678bc8..4af5c6a 100644
> --- a/arch/arm/plat-omap/include/mach/sdrc.h
> +++ b/arch/arm/plat-omap/include/mach/sdrc.h
> @@ -44,6 +44,12 @@
>  #define SDRC_RFR_CTRL_1		0x0D4
>  #define SDRC_MANUAL_1		0x0D8
>  
> +#define SDRC_POWER_AUTOCOUNT_SHIFT	8
> +#define SDRC_POWER_AUTOCOUNT_MASK	(0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
> +#define SDRC_POWER_CLKCTRL_SHIFT	4
> +#define SDRC_POWER_CLKCTRL_MASK		(0x3 << SDRC_POWER_CLKCTRL_SHIFT)
> +#define SDRC_SELF_REFRESH_ON_AUTOCOUNT	(0x2 << SDRC_POWER_CLKCTRL_SHIFT)
> +
>  /*
>   * These values represent the number of memory clock cycles between
>   * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
