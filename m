From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event handler
Date: Mon, 10 Sep 2012 16:21:19 +0530
Message-ID: <CAP05o4J_baRm0i5dg-vHjpgJeBWiNdtUFbCd1vK53ks9rz-Utg@mail.gmail.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49187 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755922Ab2IJKvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 06:51:21 -0400
Received: by ggnl1 with SMTP id l1so2854417ggn.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 03:51:20 -0700 (PDT)
In-Reply-To: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wrona <wrona.vy@gmail.com>

On Mon, Sep 10, 2012 at 4:08 PM, Ruslan Bilovol <ruslan.bilovol@ti.com> wrote:
> OMAP mux now parses active wakeup events from pad registers and calls
> corresponding handler, if handler is not registered - corresponding
> hwmod ISRs once a wakeup is detected.
> This is useful for cases when routing wakeups to corresponding hwmod
> ISRs complicates those ISRs handlers (for example, ISR handler may
> not know who the interrupt source is)
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c                    |   14 +++++++++--
>  arch/arm/mach-omap2/omap_hwmod.c             |   29 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 9fe6829..2918638 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -372,6 +372,7 @@ static bool omap_hwmod_mux_scan_wakeups(struct omap_hwmod_mux_info *hmux,
>         int i, irq;
>         unsigned int val;
>         u32 handled_irqs = 0;
> +       bool retval = false;
>
>         for (i = 0; i < hmux->nr_pads_dynamic; i++) {
>                 struct omap_device_pad *pad = hmux->pads_dynamic[i];
> @@ -384,8 +385,15 @@ static bool omap_hwmod_mux_scan_wakeups(struct omap_hwmod_mux_info *hmux,
>                 if (!(val & OMAP_WAKEUP_EVENT))
>                         continue;
>
> -               if (!hmux->irqs)
> -                       return true;
> +               if (hmux->wakeup_handler && hmux->wakeup_handler[i]) {
> +                       hmux->wakeup_handler[i](hmux);
> +                       continue;
> +               }
> +
> +               if (!hmux->irqs) {
> +                       retval = true;
> +                       continue;
> +               }
>
>                 irq = hmux->irqs[i];
>                 /* make sure we only handle each irq once */
> @@ -397,7 +405,7 @@ static bool omap_hwmod_mux_scan_wakeups(struct omap_hwmod_mux_info *hmux,
>                 generic_handle_irq(mpu_irqs[irq].irq);
>         }
>
> -       return false;
> +       return retval;
>  }
>
>  /**
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 6ca8e51..9a41d65 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -3656,6 +3656,35 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
>  }
>
>  /**
> + * omap_hwmod_pad_wakeup_handler - add wakeup handler for an I/O pad wakeup
> + * @oh: struct omap_hwmod * containing hwmod mux entries
> + * @pad_idx: array index in oh->mux of the hwmod mux entry to handle wakeup
> + * @wakeup_handler: the wakeup_handler function to trigger on wakeup
> + */
> +int omap_hwmod_pad_wakeup_handler(struct omap_hwmod *oh, int pad_idx,
> +               int (*wakeup_handler)(struct omap_hwmod_mux_info *hmux))
> +{
> +       might_sleep();
> +
> +       if (!oh || !oh->mux || pad_idx < 0 ||
> +                       pad_idx >= oh->mux->nr_pads_dynamic)
> +               return -EINVAL;
> +
> +       if (!oh->mux->wakeup_handler) {
> +               /* XXX What frees this? */
> +               oh->mux->wakeup_handler =
> +                               kzalloc(sizeof(*(oh->mux->wakeup_handler)) *
> +                               oh->mux->nr_pads_dynamic, GFP_KERNEL);
> +
> +               if (!oh->mux->wakeup_handler)
> +                       return -ENOMEM;
> +       }
> +       oh->mux->wakeup_handler[pad_idx] = wakeup_handler;
> +
> +       return 0;
> +}
> +
> +/**
>   * omap_hwmod_init - initialize the hwmod code
>   *
>   * Sets up some function pointers needed by the hwmod code to operate on the
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 6132972..5c2bcc7 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -110,6 +110,7 @@ struct omap_hwmod_mux_info {
>         int                             nr_pads_dynamic;
>         struct omap_device_pad          **pads_dynamic;
>         int                             *irqs;
> +       int                             (**wakeup_handler)(struct omap_hwmod_mux_info *hmux);
>         bool                            enabled;
>  };
>
> @@ -646,6 +647,9 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>
>  int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
>
> +int omap_hwmod_pad_wakeup_handler(struct omap_hwmod *oh, int pad_idx,
> +               int (*wakeup_handler)(struct omap_hwmod_mux_info *hmux));
> +
>  extern void __init omap_hwmod_init(void);
>
>  const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
> --
> 1.7.1
>

This is good idea!
         if tero is Ok with this patch ; I will use this for ehci
remote wakeup implementation.

regards
keshava
