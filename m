From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/RFT 2/4] OMAP3: PM: PRCM interrupt: check MPUGRPSEL
 register
Date: Sun, 2 Aug 2009 18:11:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908021810020.19529@utopia.booyaka.com>
References: <1248458068-21747-1-git-send-email-khilman@deeprootsystems.com> <1248458068-21747-2-git-send-email-khilman@deeprootsystems.com> <1248458068-21747-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32842 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZHCALz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Aug 2009 20:11:55 -0400
In-Reply-To: <1248458068-21747-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, 24 Jul 2009, Kevin Hilman wrote:

> From: Paul Walmsley <paul@pwsan.com>
> 
> PM_WKST register contents should be ANDed with the contents of the
> MPUGRPSEL registers.  Otherwise the MPU PRCM interrupt handler could
> wind up clearing wakeup events meant for the IVA PRCM interrupt
> handler.  For a production version of this patch, we should not read
> MPUGRPSEL from the PRM, since those reads are very slow; rather, we
> should use a cached version from struct powerdomain (not yet
> implemented)

This patch is fine to go in.  Maybe alter the last sentence of the commit 
message to read something like "A future revision to this code should be 
to read a cached version of MPUGRPSEL from the powerdomain code, since 
PRM reads are relatively slow."

Then it would be:

Signed-off-by: Paul Walmsley <paul@pwsan.com>


> ---
>  arch/arm/mach-omap2/pm34xx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index f6cc71a..25372b7 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -210,8 +210,11 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
>  	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
>  	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
>  	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
> +	u16 grpsel_off = (regs == 3) ?
> +		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
>  
>  	wkst = prm_read_mod_reg(module, wkst_off);
> +	wkst &= prm_read_mod_reg(module, grpsel_off);
>  	if (wkst) {
>  		iclk = cm_read_mod_reg(module, iclk_off);
>  		fclk = cm_read_mod_reg(module, fclk_off);
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
