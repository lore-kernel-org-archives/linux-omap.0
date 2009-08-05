From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix SDRC register addresses
Date: Wed, 05 Aug 2009 08:10:11 -0700
Message-ID: <87skg68ffw.fsf@deeprootsystems.com>
References: <1249477918-7200-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:63618 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934578AbZHEPKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:10:13 -0400
Received: by pzk34 with SMTP id 34so104425pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 08:10:13 -0700 (PDT)
In-Reply-To: <1249477918-7200-1-git-send-email-ext-roger.quadros@nokia.com> (Roger Quadros's message of "Wed\,  5 Aug 2009 16\:11\:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> SDRC addresses are offset from OMAP3430_SDRC_RT_BASE and not
> OMAP3430_SMS_RT_BASE.
> This fixes OFF mode on EMU/HS devices.
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Indeed, this was a merge goof on my part.  Will fold into
earlier patch to undo.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/sleep34xx.S |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 807b23e..53b6da9 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -49,13 +49,13 @@
>  #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
>  						+ SCRATCHPAD_MEM_OFFS)
>  #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> -#define SDRC_SYSCONFIG_P	(OMAP3430_SMS_RT_BASE + SDRC_SYSCONFIG)
> -#define SDRC_MR_0_P		(OMAP3430_SMS_RT_BASE + SDRC_MR_0)
> -#define SDRC_EMR2_0_P		(OMAP3430_SMS_RT_BASE + SDRC_EMR2_0)
> -#define SDRC_MANUAL_0_P		(OMAP3430_SMS_RT_BASE + SDRC_MANUAL_0)
> -#define SDRC_MR_1_P		(OMAP3430_SMS_RT_BASE + SDRC_MR_1)
> -#define SDRC_EMR2_1_P		(OMAP3430_SMS_RT_BASE + SDRC_EMR2_1)
> -#define SDRC_MANUAL_1_P		(OMAP3430_SMS_RT_BASE + SDRC_MANUAL_1)
> +#define SDRC_SYSCONFIG_P	(OMAP3430_SDRC_RT_BASE + SDRC_SYSCONFIG)
> +#define SDRC_MR_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_MR_0)
> +#define SDRC_EMR2_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_EMR2_0)
> +#define SDRC_MANUAL_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_MANUAL_0)
> +#define SDRC_MR_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_MR_1)
> +#define SDRC_EMR2_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_EMR2_1)
> +#define SDRC_MANUAL_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_MANUAL_1)
>  #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
> -- 
> 1.6.0.4
