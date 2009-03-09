From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Mon, 09 Mar 2009 15:12:56 -0700
Message-ID: <87d4cqwdjr.fsf@deeprootsystems.com>
References: <1236633661-11911-1-git-send-email-juha.yrjola@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:12389 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbZCIWNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 18:13:04 -0400
Received: by ey-out-2122.google.com with SMTP id 25so338515eya.37
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 15:13:01 -0700 (PDT)
In-Reply-To: <1236633661-11911-1-git-send-email-juha.yrjola@solidboot.com> (Juha Yrjola's message of "Mon\,  9 Mar 2009 23\:21\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: linux-omap@vger.kernel.org

Juha Yrjola <juha.yrjola@solidboot.com> writes:

> The reboot mode can be communicated to a bootloader (or the
> kernel itself) with a scratchpad register. This functionality
> is especially useful, if userspace is allowed to change
> the reboot mode.
>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/prcm.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index f945156..2f828cb 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -43,9 +43,18 @@ void omap_prcm_arch_reset(char mode)
>  
>  	if (cpu_is_omap24xx())
>  		prcm_offs = WKUP_MOD;
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap34xx()) {
> +		u32 l;
> +
>  		prcm_offs = OMAP3430_GR_MOD;
> -	else
> +		l = ('B' << 24) | ('M' << 16) | mode;
> +		/* Reserve the first word in scratchpad for communicating
> +		 * with the boot ROM. A pointer to a data structure
> +		 * describing the boot process can be stored there,
> +		 * cf. OMAP34xx TRM, Initialization / Software Booting
> +		 * Configuration. */
> +		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> +	} else
>  		WARN_ON(1);
>  
>  	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> -- 
> 1.6.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
