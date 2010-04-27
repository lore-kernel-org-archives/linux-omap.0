From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3EVM: Update pad configuration for wakeup enabled pads
Date: Tue, 27 Apr 2010 08:16:53 -0700
Message-ID: <87fx2hq61m.fsf@deeprootsystems.com>
References: <1272369361-25147-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47284 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0D0PQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 11:16:57 -0400
Received: by pxi17 with SMTP id 17so2219407pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 08:16:57 -0700 (PDT)
In-Reply-To: <1272369361-25147-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Tue\, 27 Apr 2010 17\:26\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
> if wakeup capabilities are enabled on a pad. During OFF mode testing
> on OMAP3530 EVM, it was observed that the device was not residing in
> the OFF state. The device enters into the OFF state and immediately exits
> from that state as if an IO wakeup event has occured. The issue was traced
> down to the pad configuration of wkaeup enabled pad's.

Nice.

> Also, the pad configuration is included only if the respective drivers are
> enabled in the defconfig.

Hmm, do you really want this?  If you don't have the driver enabled,
you have to rely on the bootloader settings of these pads which may
also be wrong and trigger an IO wakeup as well.

Kevin


> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 017bb2f..ce66ef0 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -650,12 +650,16 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
>  
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> +#ifdef CONFIG_KEYBOARD_TWL4030
>  	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
> -				OMAP_PIN_OFF_INPUT_PULLUP |
> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>  				OMAP_PIN_OFF_WAKEUPENABLE),
> +#endif
> +#ifdef CONFIG_TOUCHSCREEN_ADS7846
>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> -				OMAP_PIN_OFF_INPUT_PULLUP |
> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>  				OMAP_PIN_OFF_WAKEUPENABLE),
> +#endif
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #else
> -- 
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
