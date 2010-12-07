From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 3/3] ARM: omap4: Convert END() to ENDPROC() for
 correctlinkage with CONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 11:59:26 +0530
Message-ID: <c1241a78873c5a18f5e7b4df96ac2143@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org> <1291656937-24992-4-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37739 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046Ab0LGG31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 01:29:27 -0500
Received: by mail-qw0-f45.google.com with SMTP id 4so853846qwk.18
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 22:29:27 -0800 (PST)
In-Reply-To: <1291656937-24992-4-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

> -----Original Message-----
> From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-
> bounces@lists.linaro.org] On Behalf Of Dave Martin
> Sent: Monday, December 06, 2010 11:06 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Tony Lindgren; Dave Martin; linux-omap@vger.kernel.org; linaro-
> dev@lists.linaro.org
> Subject: [PATCH v2 3/3] ARM: omap4: Convert END() to ENDPROC() for
> correctlinkage with CONFIG_THUMB2_KERNEL
>
> almost all code for v7+ platforms) is deprecated/incorrect.
>
> ENDPROC() tags the affected symbol as a function symbol, which will
> ensure that link-time fixups don't accidentally switch to the
> wrong instruction set.
>
> omap_secondary_startup might still need to be changed to ARM,
> depending on the compatibility status of bootloaders.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> KernelVersion: 2.6.37-rc4

Looks ok to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
>  arch/arm/mach-omap2/omap-headsmp.S |    2 +-
>  arch/arm/mach-omap2/omap44xx-smc.S |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-
> omap2/omap-headsmp.S
> index 6ae937a..4ee6aec 100644
> --- a/arch/arm/mach-omap2/omap-headsmp.S
> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> @@ -45,5 +45,5 @@ hold:	ldr	r12,=0x103
>  	 * should now contain the SVC stack for this core
>  	 */
>  	b	secondary_startup
> -END(omap_secondary_startup)
> +ENDPROC(omap_secondary_startup)
>
> diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-
> omap2/omap44xx-smc.S
> index 1980dc3..e69d37d 100644
> --- a/arch/arm/mach-omap2/omap44xx-smc.S
> +++ b/arch/arm/mach-omap2/omap44xx-smc.S
> @@ -29,7 +29,7 @@ ENTRY(omap_smc1)
>  	dsb
>  	smc	#0
>  	ldmfd   sp!, {r2-r12, pc}
> -END(omap_smc1)
> +ENDPROC(omap_smc1)
>
>  ENTRY(omap_modify_auxcoreboot0)
>  	stmfd   sp!, {r1-r12, lr}
> @@ -37,7 +37,7 @@ ENTRY(omap_modify_auxcoreboot0)
>  	dsb
>  	smc	#0
>  	ldmfd   sp!, {r1-r12, pc}
> -END(omap_modify_auxcoreboot0)
> +ENDPROC(omap_modify_auxcoreboot0)
>
>  ENTRY(omap_auxcoreboot_addr)
>  	stmfd   sp!, {r2-r12, lr}
> @@ -45,7 +45,7 @@ ENTRY(omap_auxcoreboot_addr)
>  	dsb
>  	smc	#0
>  	ldmfd   sp!, {r2-r12, pc}
> -END(omap_auxcoreboot_addr)
> +ENDPROC(omap_auxcoreboot_addr)
>
>  ENTRY(omap_read_auxcoreboot0)
>  	stmfd   sp!, {r2-r12, lr}
> @@ -54,4 +54,4 @@ ENTRY(omap_read_auxcoreboot0)
>  	smc	#0
>  	mov	r0, r0, lsr #9
>  	ldmfd   sp!, {r2-r12, pc}
> -END(omap_read_auxcoreboot0)
> +ENDPROC(omap_read_auxcoreboot0)
> --
> 1.7.1
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
