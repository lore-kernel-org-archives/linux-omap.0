From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] OMAP: McBSP not working if CONFIG_PM_RUNTIME not set
Date: Wed, 8 Jun 2011 00:16:43 +0200
Message-ID: <201106080016.43271.jkrzyszt@tis.icnet.pl>
References: <201106072118.33632.jkrzyszt@tis.icnet.pl> <87pqmpnxxe.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50166 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756956Ab1FGWRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 18:17:23 -0400
In-Reply-To: <87pqmpnxxe.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-pm@lists.linux-foundation.org

On Tue 07 Jun 2011 at 23:17:49 Kevin Hilman wrote:
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> writes:
> > ... Or should
> > arch/arm/mach-omap1/pm_bus.c be always built in and
> > pm_runtime_clk_add_notifier() called from there in order to enable
> > clocks on device initialization even if CONFIG_PM_RUNTIME is not
> > set? Or still a better solution?
> 
> You're on the right track already.
> 
> Yes, the notifier init should be done even on the !PM_RUNTIME case so
> that clocks are enabled when the device is added and disabled when
> the device is removed.
> 
> Can you try the patch below (only compile tested)

It's OK, but kind of no-op unless something like below is also applied. 
With it appended to your patch, you can add my Tested-by or what-else-by 
you may find appropriate.

Thanks,
Janusz

---
--- git/arch/arm/mach-omap1/Makefile.orig	2011-06-06 18:06:57.000000000 +0200
+++ git/arch/arm/mach-omap1/Makefile	2011-06-07 23:40:11.000000000 +0200
@@ -4,14 +4,14 @@
 
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
-obj-y += clock.o clock_data.o opp_data.o reset.o
+obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
+obj-$(CONFIG_PM) += pm.o sleep.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
--

> If it works, and with your Tested-by, I'll queue this as a fix for
> v3.0-rc.
> 
> Thanks,
> 
> Kevin
> 
> >From 971a6b1ba5cbca7b38fb14ae834b124c6e7bf9b5 Mon Sep 17 00:00:00
> >2001
> 
> From: Kevin Hilman <khilman@ti.com>
> Date: Tue, 7 Jun 2011 14:13:33 -0700
> Subject: [PATCH] OMAP1: PM: register notifiers with generic clock ops
> even when !PM_RUNTIME
> 
> When runtime PM is disabled, device clocks need to be enabled on
> device add and disabled on device remove.  This currently is not
> happening because in the !PM_RUNTIME case, no notifiers are
> registered for OMAP1 devices.
> 
> Fix this by ensuring notifiers are registered, even in the
> !PM_RUNTIME case.
> 
> Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap1/pm_bus.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/pm_bus.c
> b/arch/arm/mach-omap1/pm_bus.c index fe31d93..334fb88 100644
> --- a/arch/arm/mach-omap1/pm_bus.c
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -56,9 +56,13 @@ static struct dev_power_domain
> default_power_domain = { USE_PLATFORM_PM_SLEEP_OPS
>  	},
>  };
> +#define OMAP1_PWR_DOMAIN (&default_power_domain)
> +#else
> +#define OMAP1_PWR_DOMAIN NULL
> +#endif /* CONFIG_PM_RUNTIME */
> 
>  static struct pm_clk_notifier_block platform_bus_notifier = {
> -	.pwr_domain = &default_power_domain,
> +	.pwr_domain = OMAP1_PWR_DOMAIN,
>  	.con_ids = { "ick", "fck", NULL, },
>  };
> 
> @@ -72,4 +76,4 @@ static int __init omap1_pm_runtime_init(void)
>  	return 0;
>  }
>  core_initcall(omap1_pm_runtime_init);
> -#endif /* CONFIG_PM_RUNTIME */
> +
