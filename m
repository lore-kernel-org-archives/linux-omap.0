From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7 4/7] OMAP3: Clock: Added IDLEST definitions for SGX
Date: Thu, 18 Mar 2010 15:54:21 -0700
Message-ID: <87ocili6le.fsf@deeprootsystems.com>
References: <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
	<1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
	<1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
	<1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51624 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab0CRWyZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 18:54:25 -0400
Received: by pva4 with SMTP id 4so1403690pva.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 15:54:24 -0700 (PDT)
In-Reply-To: <1268408357-15621-4-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 12 Mar 2010 17\:39\:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Added definitions for OMAP3430ES2_ST_SGX_SHIFT and OMAP3430ES2_ST_SGX_MASK
> as these were missing.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

FYI... looks like Paul already merged this one.

Kevin

> ---
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index 6923deb..60f9b16 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -379,6 +379,10 @@
>  #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
>  #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK		(1 << 1)
>  
> +/* CM_IDLEST_SGX */
> +#define OMAP3430ES2_ST_SGX_SHIFT			1
> +#define OMAP3430ES2_ST_SGX_MASK				(1 << 1)
> +
>  /* CM_ICLKEN_SGX */
>  #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
>  #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK		(1 << 0)
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
