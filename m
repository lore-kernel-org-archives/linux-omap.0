From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC PATCH] musb: fix =?UTF-8?Q?=22musb=5Fhdrc=3A=20invalid=20ep=20?=
 =?UTF-8?Q?=38=22=20messages?=
Date: Thu, 10 Apr 2008 14:21:07 -0500
Message-ID: <9d815fa4ee93235dc9f6ed4feb29e74e@felipebalbi.com>
References: <alpine.DEB.1.00.0804101143550.10613@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60145 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYDJTVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 15:21:11 -0400
In-Reply-To: <alpine.DEB.1.00.0804101143550.10613@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net



On Thu, 10 Apr 2008 11:45:32 -0600 (MDT), Paul Walmsley <paul@pwsan.com>
wrote:
> 
> This patch fixes the "musb_hdrc: invalid ep 8" messages that show up on
> boot with current linux-omap git head on OMAP3430SDP ES2.1.  I guess that
> the musb driver comes up in FIFO mode 4 with 16 endpoints defined, but
the
> driver is limited to 8 endpoints by macros in hdrc_cnf.h.
> 
> Anyway, I don't know much about MUSB.  David or Felipe, maybe you could
> take a quick look at this patch?

I had this same patch queued for sending but i was waiting until i finished
a whole series for musb driver. :-)

It's acked, if dave doesn't have any comments i think it should be applied.

> 
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by Felipe Balbi <felipe.balbi@nokia.com>

> 
> ---
>  include/asm-arm/arch-omap/hdrc_cnf.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-omap/include/asm-arm/arch-omap/hdrc_cnf.h
> ===================================================================
> --- linux-omap.orig/include/asm-arm/arch-omap/hdrc_cnf.h	2007-08-27
> 02:19:07.000000000 -0600
> +++ linux-omap/include/asm-arm/arch-omap/hdrc_cnf.h	2008-04-01
> 11:10:34.000000000 -0600
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
>  /* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are
used
> */
> @@ -163,7 +163,7 @@
>   * Legal values are 2 - 16
>   * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
>   */
> -#define MUSB_C_NUM_EPS 8
> +#define MUSB_C_NUM_EPS 16
> 
>  /* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits
> */
>  #define MUSB_C_EPMAX_BITS 12
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

