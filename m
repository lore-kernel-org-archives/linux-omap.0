From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 21/23] usb: host: ehci: don't
	ensure register write
Date: Mon, 23 Feb 2009 21:08:14 +0200
Message-ID: <20090223190814.GE31792@frodo>
References: <1235415335-17408-13-git-send-email-me@felipebalbi.com> <1235415335-17408-14-git-send-email-me@felipebalbi.com> <1235415335-17408-15-git-send-email-me@felipebalbi.com> <1235415335-17408-16-git-send-email-me@felipebalbi.com> <1235415335-17408-17-git-send-email-me@felipebalbi.com> <1235415335-17408-18-git-send-email-me@felipebalbi.com> <1235415335-17408-19-git-send-email-me@felipebalbi.com> <1235415335-17408-20-git-send-email-me@felipebalbi.com> <1235415335-17408-21-git-send-email-me@felipebalbi.com> <1235415335-17408-22-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53730 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbZBWTIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:08:21 -0500
Content-Disposition: inline
In-Reply-To: <1235415335-17408-22-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, paul@pwsan.com

On Mon, Feb 23, 2009 at 08:55:33PM +0200, Felipe Balbi wrote:
> +#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
> +
>  /* omap_start_ehc
>   *	- Start the TI USBHOST controller
>   */
> @@ -274,32 +258,11 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
>  
>  	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
> -				OMAP3430ES2_ST_PERIPH2_CLK_MASK)) {
> +				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
>  		dev_dbg(omap->dev, "idlest2 = 0x%x\n",
>  			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> -
> -		if (time_after(timeout, jiffies)) {
> -			dev_dbg(omap->dev, "operation timed out\n");
> -			ret = -EINVAL;
> -			goto err_idlest2;
> -		}
> -	}
>  	/* End DPLL5 programming */

Hi Paul, could you look at how could we move dpll5 programming to clk
fw? This driver shouldn't have such code. Also, I guess this programming
is not right since I hear this driver doesn't enumerate anything.

-- 
balbi
