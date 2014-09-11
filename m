From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 30/35] irqchip: add irq-omap-intc.h header
Date: Thu, 11 Sep 2014 14:08:01 -0700
Message-ID: <20140911210800.GI18849@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-31-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140728 14:19]:
> OMAP INTC irqchip driver will be moved under
> drivers/irqchip/ soon but we still have a dependency
> with mach-omap2 when it comes to idle functions.
> 
> In order to make it easy to share those function
> prototypes with OMAP PM code, we introduce this new
> header.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c        |  1 +
>  arch/arm/mach-omap2/board-am3517crane.c    |  1 +
>  arch/arm/mach-omap2/board-am3517evm.c      |  1 +
>  arch/arm/mach-omap2/board-cm-t35.c         |  1 +
>  arch/arm/mach-omap2/board-cm-t3517.c       |  1 +
>  arch/arm/mach-omap2/board-devkit8000.c     |  1 +
>  arch/arm/mach-omap2/board-ldp.c            |  1 +
>  arch/arm/mach-omap2/board-omap3beagle.c    |  1 +
>  arch/arm/mach-omap2/board-omap3logic.c     |  1 +
>  arch/arm/mach-omap2/board-omap3pandora.c   |  1 +
>  arch/arm/mach-omap2/board-omap3stalker.c   |  1 +
>  arch/arm/mach-omap2/board-omap3touchbook.c |  1 +
>  arch/arm/mach-omap2/board-overo.c          |  1 +
>  arch/arm/mach-omap2/board-rx51.c           |  1 +
>  arch/arm/mach-omap2/board-ti8168evm.c      |  1 +
>  arch/arm/mach-omap2/common.h               |  9 ---------
>  arch/arm/mach-omap2/cpuidle34xx.c          |  1 +
>  arch/arm/mach-omap2/irq.c                  |  1 +
>  arch/arm/mach-omap2/pm24xx.c               |  1 +
>  arch/arm/mach-omap2/pm34xx.c               |  1 +
>  include/linux/irqchip/irq-omap-intc.h      | 32 ++++++++++++++++++++++++++++++
>  21 files changed, 51 insertions(+), 9 deletions(-)

I ended up setting up another branch without this patch
at omap-for-v3.12/intc-v2. It now has dependency to the
SoC changes from Nishant and the const cleanup fix from Uwe.

This patch is not needed, let's leave this out, the functions
needed by the platform code won't need to be in a separate
header file as they are only needed by the platform code.

If you have a chance, can you please repost the remainging
patches to do the actual move to drivers, but without this
patch? And if we are lucky we'll get an ack from the
drivers/irqchip maintainers and I can apply those changes too
into omap-for-v3.12/intc-v2 ;)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
