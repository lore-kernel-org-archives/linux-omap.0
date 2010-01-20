From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
Date: Wed, 20 Jan 2010 10:34:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001201033120.3977@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com> <1264001442-20078-2-git-send-email-thara@ti.com> <1264001442-20078-3-git-send-email-thara@ti.com> <1264001442-20078-4-git-send-email-thara@ti.com> <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com> <1264001442-20078-7-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37323 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab0ATRec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 12:34:32 -0500
In-Reply-To: <1264001442-20078-7-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Thara,

two comments:

On Wed, 20 Jan 2010, Thara Gopinath wrote:

> DPLL4 autoidle is controlled through the register CM_PLL_AUTOIDLE
> which is to be restored by rom code from the scratchpad in case
> of a core domain context loss. But enabling this bit in scratchpad
> causes rom code to take an extra 20 ms delay in the restore path.
> To avoid this delay this bit is not enabled in the scratchpad today.
> This means after a core off happens DPLL4 autoidle is never again
> enabled back.
> This patch enables DPLL4 autoidle in case of core domain losing
> context.

Shouldn't this be contingent on whether DPLL4 autoidle was enabled before 
the CORE off transition?

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e4db1ea..6e6d954 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -520,6 +520,14 @@ void omap_sram_idle(void)
>  			 */
>  			if (cpu_is_omap3430())
>  				usb_musb_disable_autoidle();
> +			/* We do not program the scratchpad to restore back
> +			 * PER DPLL in autoidle due to 20 ms delay in
> +			 * rom code restore path. So enable it explicitly
> +			 * after core off
> +			 */

This multi-line comment needs to be fixed to conform to 
Documentation/CodingStyle.

> +			cm_rmw_mod_reg_bits(
> +				0x0, (1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
> +				PLL_MOD, CM_AUTOIDLE);
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
