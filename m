From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 6/9] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
Date: Thu, 8 Aug 2013 00:03:54 -0700
Message-ID: <CA+Bv8Xau6c00ipmYFEapMnmHza3jymV8czqFuFnbr2hzGc=CcA@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-7-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:59698 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663Ab3HHHDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 03:03:55 -0400
Received: by mail-qc0-f177.google.com with SMTP id e11so1364718qcx.22
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 00:03:54 -0700 (PDT)
In-Reply-To: <1375811376-49985-7-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> OMAP timer code registers two timers - one as clocksource
> and one as clockevent. Since AM33XX has only one usable timer
> in the WKUP domain one of the timers needs suspend-resume
> support to restore the configuration to pre-suspend state.
>
> commit adc78e6 (timekeeping: Add suspend and resume
> of clock event devices) introduced .suspend and .resume
> callbacks for clock event devices. Leverages these
> callbacks to have AM33XX clockevent timer which is
> in not in WKUP domain to behave properly across system
> suspend.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/mach-omap2/timer.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b37e1fc..cce5d39 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -118,11 +118,43 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>         }
>  }
>
> +static void omap_clkevt_suspend(struct clock_event_device *unused)
> +{
> +       char name[10];
> +       struct omap_hwmod *oh;
> +
> +       sprintf(name, "timer%d", clkev.id);
> +       oh = omap_hwmod_lookup(name);
> +       if (!oh)
> +               return;
> +
> +       __omap_dm_timer_stop(&clkev, 1, clkev.rate);
> +       omap_hwmod_idle(oh);
> +}
> +
> +static void omap_clkevt_resume(struct clock_event_device *unused)
> +{
> +       char name[10];
> +       struct omap_hwmod *oh;
> +
> +       sprintf(name, "timer%d", clkev.id);
> +       oh = omap_hwmod_lookup(name);
> +       if (!oh)
> +               return;
> +
> +       omap_hwmod_enable(oh);
> +       __omap_dm_timer_load_start(&clkev,
> +                       OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> +       __omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
> +}
> +
>  static struct clock_event_device clockevent_gpt = {
>         .features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>         .rating         = 300,
>         .set_next_event = omap2_gp_timer_set_next_event,
>         .set_mode       = omap2_gp_timer_set_mode,
> +       .suspend        = omap_clkevt_suspend,
> +       .resume         = omap_clkevt_resume,
>  };
>
>  static struct property device_disabled = {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
