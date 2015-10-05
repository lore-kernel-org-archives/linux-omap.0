From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: N900: always enable IBE bit
Date: Mon, 5 Oct 2015 15:53:30 +0200
Message-ID: <20151005135330.GA12068@xo-6d-61-c0.localdomain>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437612483-30160-2-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi!

> The kernel's workaround for Errata 430973 consists of a BTAC/BTB
> flush at context switch. This requires the IBE bit being set, which
> should normally be done by the bootloader.
> 
> Since the Nokia N900's bootloader is not easily replaceable,
> a pdata quirk enables the IBE bit for the Nokia N900. Until
> e748994f5cc5, the flush at context switch required
> CONFIG_ARM_ERRATA_430973, so the same check has been used
> for setting the IBE bit.
> 
> Since all sold N900s are assumed to be affected, the guard
> can be removed now, so that the IBE bit is always set.

Is the qemu affected?

Does qemu have enough secure support not to fail on this?

Best regards,

							Pavel
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  arch/arm/mach-omap2/board-rx51.c   |  2 --
>  arch/arm/mach-omap2/pdata-quirks.c | 11 ++---------
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 2d1e5a6..3df01cc 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -108,11 +108,9 @@ static void __init rx51_init(void)
>  	rx51_peripherals_init();
>  
>  	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
> -#ifdef CONFIG_ARM_ERRATA_430973
>  		pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
>  		/* set IBE to 1 */
>  		rx51_secure_update_aux_cr(BIT(6), 0);
> -#endif
>  	}
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 821171c..0aa438d 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -249,18 +249,11 @@ static void __init nokia_n900_legacy_init(void)
>  	hsmmc2_internal_input_clk();
>  
>  	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
> -		if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) {
> -			pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
> -			/* set IBE to 1 */
> -			rx51_secure_update_aux_cr(BIT(6), 0);
> -		} else {
> -			pr_warn("RX-51: Not enabling ARM errata 430973 workaround\n");
> -			pr_warn("Thumb binaries may crash randomly without this workaround\n");
> -		}
> +		pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
> +		rx51_secure_update_aux_cr(BIT(6), 0); /* set IBE to 1 */
>  
>  		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
>  		platform_device_register(&omap3_rom_rng_device);
> -
>  	}
>  }
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
