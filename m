From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC v2][PATCH 2/5] OMAP clock: Add UART4 autoidle bit for
 3630
Date: Fri, 26 Feb 2010 11:18:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002261117520.2701@utopia.booyaka.com>
References: <1267199592-2245-1-git-send-email-saaguirre@ti.com> <1267199592-2245-3-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35085 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965631Ab0BZSSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 13:18:38 -0500
In-Reply-To: <1267199592-2245-3-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 26 Feb 2010, Sergio Aguirre wrote:

> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

This patch is missing a patch description.

It also should be combined with your patch #1.

- Paul

> ---
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index a3a3ca0..834b671 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -649,6 +649,8 @@
>  #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)
>  
>  /* CM_AUTOIDLE_PER */
> +#define OMAP3630_AUTO_UART4				(1 << 18)
> +#define OMAP3630_AUTO_UART4_SHIFT			18
>  #define OMAP3430_AUTO_GPIO6				(1 << 17)
>  #define OMAP3430_AUTO_GPIO6_SHIFT			17
>  #define OMAP3430_AUTO_GPIO5				(1 << 16)
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
