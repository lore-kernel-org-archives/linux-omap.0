From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/7] OMAP3: add comments for low power code errata
Date: Fri, 17 Dec 2010 16:07:26 +0530
Message-ID: <f8a6e81a27f08443f58e64dc9c5947e7@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56963 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006Ab0LQKh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 05:37:27 -0500
Received: by mail-yw0-f41.google.com with SMTP id 3so251967ywj.14
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:37:27 -0800 (PST)
In-Reply-To: <1292580506-4421-7-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Friday, December 17, 2010 3:38 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 6/7] OMAP3: add comments for low power code errata
>
> From: Jean Pihet <j-pihet@ti.com>
>
> Errata covered:
> - 1.157 & 1.185
> - i443
> - i581
>
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/pm34xx.c    |    4 ++--
>  arch/arm/mach-omap2/sleep34xx.S |   11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index adc0917..267f015 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -148,7 +148,7 @@ static void omap3_core_save_context(void)
>
>  	/*
>  	 * Force write last pad into memory, as this can fail in some
> -	 * cases according to erratas 1.157, 1.185
> +	 * cases according to errata 1.157, 1.185
>  	 */
>  	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
>  		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
> @@ -446,7 +446,7 @@ void omap_sram_idle(void)
>  	/*
>  	* On EMU/HS devices ROM code restores a SRDC value
>  	* from scratchpad which has automatic self refresh on timeout
> -	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> +	* of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
>  	* Hence store/restore the SDRC_POWER register here.
>  	*/
>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 12061fd..8e5004a 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -592,6 +592,7 @@ usettbr0:
>   * Internal functions
>   */
>
> +/* This function implements the erratum ID i443 WA, applies to 34xx >=
> ES3.0 */
>  	.text
>  ENTRY(es3_sdrc_fix)
>  	ldr	r4, sdrc_syscfg		@ get config addr
> @@ -637,6 +638,16 @@ sdrc_manual_1:
>  ENTRY(es3_sdrc_fix_sz)
>  	.word	. - es3_sdrc_fix
>
> +/*
> + * This function implements the erratum ID i581 WA:
> + *  SDRC state restore before accessing the SDRAM
> + *
> + * Only used at return from non-OFF mode. For OFF
> + * mode the ROM code configures the SDRC and
> + * the DPLL before calling the restore code directly
> + * from DDR.
> + */
> +
>  /* Make sure SDRC accesses are ok */
>  wait_sdrc_ok:
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
