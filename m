From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: SDRC : Add comments on Errata i520 for Global SW reset
Date: Mon, 04 Oct 2010 08:36:14 -0700
Message-ID: <87d3rq2cnl.fsf@deeprootsystems.com>
References: <1286203176-32602-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58904 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0JDPlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:41:21 -0400
Received: by iwn5 with SMTP id 5so7056249iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 08:41:21 -0700 (PDT)
In-Reply-To: <1286203176-32602-1-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Mon, 4 Oct 2010 20:09:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> This patch adds comments on precatution to be taken if Global SW reset is
> used as the means to trigger sysem reset.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Please fix multi-line comment style.  

Search for 'multi-line' in Documentation/CodingStyle

Kevin


> ---
>  arch/arm/mach-omap2/prcm.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index c201374..fdc860e
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -157,6 +157,32 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
>  	else
>  		WARN_ON(1);
>  
> +	/* As per Errata i520, In some cases, user
> +	 * will not be able to access DDR memory after warm-reset.
> +	 * This situation occurs while the warm-reset happens during a read
> +	 * access to DDR memory. In that particular condition, DDR memory
> +	 * does not respond to a corrupted read command due to the warm
> +	 * reset occurence but SDRC is waiting for read completion.
> +	 * SDRC is not sensitive to the warm reset, but the interconect is
> +	 * reset on the fly, thus causing a misalignment between SDRC logic,
> +	 * interconect logic and DDR memory state.
> +	 * WORKAROUND:
> +	 * Steps to perform before a Warm reset is trigged:
> +	 * 1. enable self-refresh on idle request
> +	 * 2. put SDRC in idle
> +	 * 3. wait until SDRC goes to idle
> +	 * 4. generate SW reset (Global SW reset)
> +
> +	 * Steps to be performed after warm reset occurs (in bootloader):
> +	 * if HW warm reset is the source, apply below steps before any
> +	 * accesses to SDRAM:
> +	 * 1. Reset SMS and SDRC and wait till reset is complete
> +	 * 2. Re-initialize SMS, SDRC and memory
> +
> +	 * NOTE: Above work around is required only if arch reset is implemented
> +	 * using Global SW reset(GLOBAL_SW_RST). DPLL3 reset does not need
> +	 * the WA since it resets SDRC as well as part of cold reset. */
> +
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
>  						 OMAP2_RM_RSTCTRL);
