From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix HW SAVEANDRESTORE shift define
Date: Wed, 01 Apr 2009 11:52:39 -0700
Message-ID: <873acsjjew.fsf@deeprootsystems.com>
References: <1238568174-28291-1-git-send-email-kalle.jokiniemi@digia.com>
	<1238568174-28291-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:11432 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760415AbZDASwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 14:52:44 -0400
Received: by wf-out-1314.google.com with SMTP id 29so186028wff.4
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2009 11:52:42 -0700 (PDT)
In-Reply-To: <1238568174-28291-2-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Wed\, 1 Apr 2009 09\:42\:54 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> The OMAP3430ES2_SAVEANDRESTORE_SHIFT macro is used
> by powerdomain code in
> "1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT" manner, but
> the definition was also (1 << 4), meaning we actually
> modified bit 16. So the definition needs to be 4.
>
> This fixes also a cold reset HW bug in OMAP3430 ES3.x
> where some of the efuse bits are not isolated during
> wake-up from off mode. This can cause randomish
> cold resets with off mode. Enabling the USBTLL hardware
> SAVEANDRESTORE causes the core power up assert to be
> delayed in a way that we will not get faulty values
> when boot ROM is reading the unisolated registers.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index d73eee8..d792c29 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -409,7 +409,7 @@
>  /* PM_PREPWSTST_CAM specific bits */
>  
>  /* PM_PWSTCTRL_USBHOST specific bits */
> -#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
> +#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
>  
>  /* RM_RSTST_PER specific bits */
>  
> -- 
> 1.5.4.3
