From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 5 Mar 2009 01:42:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43146 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZCEImZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 03:42:25 -0500
In-Reply-To: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com

Hello Eero,

On Thu, 5 Mar 2009, ext-eero.nurkkala@nokia.com wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> It is the bit 8 that is for FCLK. All other blocks in
> OMAPs use the bit 8 for denying FCLK idling.

Hmm.  Looking at the 34xx Rev O TRM register tables, it looks like most 
modules use bit 9 to indicate that FCLK should be kept on and bit 8 to 
indicate that the ICLK should be kept on?  DSI, DISPC, SR, DMA4 are some 
examples.

This of course contradicts some of the text, such as Table 16-6, 16-60, 
and 18-4.  CLOCKACTIVITY bits seem to attract documentation bugs; Table 
4-554 and 15.3.1.4.1 are other examples.

> This is an RFC, I'd like some discussion. Somebody
> double-check this?

Suggest you doublecheck with TI.  Richard Woodruff cc'ed; he might be able 
to clarify.


- Paul

> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0258b55..11057eb 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -157,7 +157,7 @@
>  #define SYSC_AUTOIDLE_MASK		(1 << 0)
>  
>  #define SYSC_IDLEMODE_SMART		0x2
> -#define SYSC_CLOCKACTIVITY_FCLK		0x2
> +#define SYSC_CLOCKACTIVITY_FCLK		0x1
>  
>  
>  struct omap_i2c_dev {
> -- 
> 1.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
