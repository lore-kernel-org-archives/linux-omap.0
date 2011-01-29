From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Sat, 29 Jan 2011 22:44:43 +0530
Message-ID: <b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49927 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753699Ab1A2ROq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Jan 2011 12:14:46 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so4460081fxm.16
        for <linux-omap@vger.kernel.org>; Sat, 29 Jan 2011 09:14:45 -0800 (PST)
In-Reply-To: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: Jean Pihet-XID <j-pihet@ti.com>

Jean,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Thursday, January 13, 2011 9:49 PM
> To: linux-omap@vger.kernel.org
> Cc: Jean Pihet
> Subject: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>
> From: Jean Pihet <j-pihet@ti.com>
>
> Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
> is copied to internal SRAM and run from there.
> However only a small part of the code really needs to run from
> internal SRAM.
>
> This fix lets most of the ASM idle code run from the DDR
> in order to minimize the SRAM usage. No performance
> loss or gain can be measured with a 32KHz clock period.
>
> The only pieces of code that are mandatory in SRAM
> are:
> - the i443 erratum WA,
> - the i581 erratum WA,
> - the security extension code.
>
> SRAM usage:
> - original code:
>   . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>   . 1368 bytes for omap_sram_idle (used by suspend/resume in
> RETention),
>   . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode
> on ES3.x),
>   . 108 bytes for save_secure_ram_context (used on HS parts).
>
> With this fix the usage for suspend/resume in RETention goes down
> 312 bytes, so the
> gain in SRAM usage for suspend/resume is > 1KB.
>
> Tested on OMAP3EVM, Beagleboard (ES2.x) and N900 (ES3.1)
> in idle with full RET and OFF modes.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm.h        |   19 ++-
>  arch/arm/mach-omap2/pm34xx.c    |   19 ++-
>  arch/arm/mach-omap2/sleep34xx.S |  299 +++++++++++++++++++++++-----
> -----------
>  3 files changed, 200 insertions(+), 137 deletions(-)
>
[...]

> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 98d8232..ced85b5 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -163,8 +163,10 @@ ENTRY(save_secure_ram_context_sz)
>   *
>   *
>   * Notes:
> - * - this code gets copied to internal SRAM at boot and after wake-
> up
> - *   from OFF mode. The execution pointer in SRAM is
> _omap_sram_idle.
> + * - only the minimum set of functions gets copied to internal SRAM
> at boot
> + *   and after wake-up from OFF mode, cf. omap_push_sram_idle. The
> function
> + *   pointers in SDRAM or SRAM are called depending on the desired
> low power
> + *   target state.
>   * - when the OMAP wakes up it continues at different execution
> points
>   *   depending on the low power mode (non-OFF vs OFF modes),
>   *   cf. 'Resume path for xxx mode' comments.
> @@ -181,9 +183,15 @@ ENTRY(omap34xx_cpu_suspend)
>  	 *   3 - Both L1 and L2 lost
>  	 */
>
> -	/* Directly jump to WFI is the context save is not required */
> -	cmp	r1, #0x0
> -	beq	omap3_do_wfi
> +	/*
> +	 * For OFF mode: save context and jump to WFI in SDRAM
> (omap3_do_wfi)
> +	 * For non-OFF modes: jump to the WFI code in SRAM
> (omap3_do_wfi_sram)

Why is this distinction? For non-low power modes
it should be even safer to issue WFI from DDR itself.

Do I miss any errata here ?

> +	 */
> +	ldr	r4, omap3_do_wfi_sram_addr
> +	ldr	r5, [r4]
> +	cmp	r1, #0x0		@ If no context save required,
> +	bxeq	r5			@  jump to the WFI code in SRAM
