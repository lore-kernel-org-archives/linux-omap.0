From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Fix definition of SGX clock register
 bits
Date: Tue, 26 Aug 2008 23:05:42 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808262258480.4624@utopia.booyaka.com>
References: <20080827012736.GA10868@intune.research.nokia.com> <1219800687-11044-1-git-send-email-daniel.stone@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56043 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYH0FFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 01:05:43 -0400
In-Reply-To: <1219800687-11044-1-git-send-email-daniel.stone@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Daniel,

On Wed, 27 Aug 2008, Daniel Stone wrote:

> The GFX/SGX functional and interface clocks have different masks, for
> some unknown reason, so split EN_SGX_SHIFT into one each for fclk and
> iclk.

thanks for the fix, this looks mostly good - one comment:

> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index ffb695b..06a78a7 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -339,9 +339,11 @@
>  #define OMAP3430ES1_CLKACTIVITY_GFX_SHIFT		0
>  #define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
>  
> -/* CM_FCLKEN_SGX */
> -#define OMAP3430ES2_EN_SGX_SHIFT			1
> -#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
> +/* CM_FCLKEN_SGX/CM_ICLKEN_SGX */
> +#define OMAP3430ES2_EN_SGX_FSHIFT			1
> +#define OMAP3430ES2_EN_SGX_FMASK			(1 << 1)
> +#define OMAP3430ES2_EN_SGX_ISHIFT			0
> +#define OMAP3430ES2_EN_SGX_IMASK			(1 << 0)

To keep these consistent with prior practice in prm-regbits-34xx.h for
name collisions, could you change the above to look something like:

/* CM_FCLKEN_SGX */
#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT       1
#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK        (1 << 1)

/* CM_ICLKEN_SGX */
#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT       0
#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK        (1 << 0)

Ugly, but unambiguous.


- Paul
