From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Mon, 03 May 2010 15:40:33 -0700
Message-ID: <871vdssj6m.fsf@deeprootsystems.com>
References: <1272922018-11388-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43967 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab0ECWkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 18:40:37 -0400
Received: by pxi5 with SMTP id 5so485916pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 15:40:36 -0700 (PDT)
In-Reply-To: <1272922018-11388-1-git-send-email-mike@android.com> (Mike Chan's message of "Mon\,  3 May 2010 14\:26\:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com

Mike Chan <mike@android.com> writes:

> IO events can also come from GPIO modules, which reside in the PER domain.
> It is possible for the PER to enter RET while CORE is still in ON.
> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
> wakeup in this case, unless we enable it.
>
> Signed-off-by: Mike Chan <mike@android.com>

Thanks for moving this up to before the potential transition of PER.

But...

> ---
>  arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index ea0000b..2b2eaaa 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -371,6 +371,13 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
>  
> +	/* Enable IO-PAD and IO-CHAIN wakeups */
> +	if (per_next_state < PWRDM_POWER_ON ||
> +			core_next_state < PWRDM_POWER_ON) {
> +		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
> +		omap3_enable_io_chain();
> +	}
> +

oops, both next_states will always be PWRDM_POWER_ON here as they
haven't yet been read...

>  	/* PER */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>  	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);

until here.

Kevin

