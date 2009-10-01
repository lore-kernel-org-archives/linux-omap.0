From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap3: ehci: remove DPLL5 programming
Date: Thu, 1 Oct 2009 15:13:01 +0300
Message-ID: <20091001121301.GJ15131@nokia.com>
References: <1254332221-29490-1-git-send-email-gadiyar@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22330 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510AbZJAMOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:14:20 -0400
Content-Disposition: inline
In-Reply-To: <1254332221-29490-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anand Gadiyar <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Sep 30, 2009 at 07:37:01PM +0200, ext Anand Gadiyar wrote:
> omap3: ehci: remove DPLL5 programming
> 
> DPLL5 programming should be taken care of by the clock framework.
> The driver should not need to worry about programming this
> explicitly.
> 
> Also, the DPLL5 m and n values used were valid only for a
> specific value of the system clock. So they would not work
> correctly for other input frequencies anyway.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

We really needed to remove that, thanks a lot Anand.

> ---
> Needs http://patchwork.kernel.org/patch/46216/ to
> ensure the DPLL is locked correctly.
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index f2771cf..7efc2f5 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -225,8 +225,6 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
> -
>  /* omap_start_ehc
>   *	- Start the TI USBHOST controller
>   */
> @@ -239,29 +237,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  
>  	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
>  
> -	/* Start DPLL5 Programming:
> -	 * Clock Framework is not doing this now:
> -	 * This will be done in clock framework later
> -	 */
> -	/* Enable DPLL 5 : Based on Input of 13Mhz*/
> -	cm_write_mod_reg((12 << OMAP3430ES2_PERIPH2_DPLL_DIV_SHIFT)|
> -			(120 << OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT),
> -			PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
> -
> -	cm_write_mod_reg(1 << OMAP3430ES2_DIV_120M_SHIFT,
> -			PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
> -
> -	cm_write_mod_reg((7 << OMAP3430ES2_PERIPH2_DPLL_FREQSEL_SHIFT) |
> -			(7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
> -			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
> -
> -	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
> -				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
> -		dev_dbg(omap->dev, "idlest2 = 0x%x\n",
> -			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> -	/* End DPLL5 programming */
> -
> -
>  	/* Enable Clocks for USBHOST */
>  	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
>  	if (IS_ERR(omap->usbhost_ick)) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
