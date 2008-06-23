From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] usb: musb: musb on omap3 has 32 endpoints
Date: Mon, 23 Jun 2008 14:10:09 +0300
Message-ID: <20080623111009.GM7741@atomide.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.179] ([63.208.196.179]:63236 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752338AbYFWLJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:09:44 -0400
Content-Disposition: inline
In-Reply-To: <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080613 13:05]:
> Fix hdrc_cnf.h for omap3 configuration.

Does this break the configuration for omap2?

We should set these dynamically if different for omap2 and omap3
so we can compile both into the same kernel.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  include/asm-arm/arch-omap/hdrc_cnf.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/hdrc_cnf.h b/include/asm-arm/arch-omap/hdrc_cnf.h
> index 74c8432..271214c 100644
> --- a/include/asm-arm/arch-omap/hdrc_cnf.h
> +++ b/include/asm-arm/arch-omap/hdrc_cnf.h
> @@ -14,11 +14,11 @@
>  
>  /* ** Number of Tx endpoints ** */
>  /* Legal values are 1 - 16 (this value includes EP0) */
> -#define MUSB_C_NUM_EPT 8
> +#define MUSB_C_NUM_EPT 16
>  
>  /* ** Number of Rx endpoints ** */
>  /* Legal values are 1 - 16 (this value includes EP0) */
> -#define MUSB_C_NUM_EPR 8
> +#define MUSB_C_NUM_EPR 16
>  
>  /* ** Endpoint 1 to 15 direction types ** */
>  /* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are used */
> @@ -163,7 +163,7 @@
>   * Legal values are 2 - 16
>   * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
>   */
> -#define MUSB_C_NUM_EPS 8
> +#define MUSB_C_NUM_EPS 16
>  
>  /* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits */
>  #define MUSB_C_EPMAX_BITS 12
> -- 
> 1.5.6.rc1
> 
