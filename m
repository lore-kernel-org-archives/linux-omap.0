From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 3/9] ARM: OMAP3: cpuidle - set enable_off_mode as static
Date: Fri, 23 Mar 2012 13:22:32 +0100
Message-ID: <CAORVsuVBC2TgVyt-PFWV878mXpM1GqETQnzdVi0ZYH-2x8D4nQ@mail.gmail.com>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
	<1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33505 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab2CWMWd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 08:22:33 -0400
Received: by vbbff1 with SMTP id ff1so1439297vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 05:22:32 -0700 (PDT)
In-Reply-To: <1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> This variable is only used in the pm-debug.c file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> =A0arch/arm/mach-omap2/pm-debug.c | =A0 =A02 +-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 | =A0 30 ++++++++++++--------=
----------
> =A02 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> index 814bcd9..86aa398 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -38,7 +38,7 @@
> =A0#include "prm2xxx_3xxx.h"
> =A0#include "pm.h"
>
> -u32 enable_off_mode;
> +static u32 enable_off_mode;
It is stil needed in cpuidle34xx.c.

>
> =A0#ifdef CONFIG_DEBUG_FS
> =A0#include <linux/debugfs.h>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index af73a86..f5c3072 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -25,6 +25,18 @@ extern int omap4_idle_init(void);
> =A0extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *u=
nused);
> =A0extern int (*omap_pm_suspend)(void);
>
> +/*
> + * cpuidle mach specific parameters
> + *
> + * The board code can override the default C-states definition using
> + * omap3_pm_init_cpuidle
> + */
> +struct cpuidle_params {
> + =A0 =A0 =A0 u32 exit_latency; =A0 =A0 =A0 /* exit_latency =3D sleep=
 + wake-up latencies */
> + =A0 =A0 =A0 u32 target_residency;
> + =A0 =A0 =A0 u8 valid; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* validates the =
C-state */
> +};
> +
Is this move needed? This will be removed in a later patch.

> =A0#if defined(CONFIG_PM_OPP)
> =A0extern int omap3_opp_init(void);
> =A0extern int omap4_opp_init(void);
> @@ -39,27 +51,9 @@ static inline int omap4_opp_init(void)
> =A0}
> =A0#endif
>
> -/*
> - * cpuidle mach specific parameters
> - *
> - * The board code can override the default C-states definition using
> - * omap3_pm_init_cpuidle
> - */
> -struct cpuidle_params {
> - =A0 =A0 =A0 u32 exit_latency; =A0 =A0 =A0 /* exit_latency =3D sleep=
 + wake-up latencies */
> - =A0 =A0 =A0 u32 target_residency;
> - =A0 =A0 =A0 u8 valid; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* validates the =
C-state */
> -};
> -
> =A0extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
> =A0extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, i=
nt state);
>
> -#ifdef CONFIG_PM_DEBUG
> -extern u32 enable_off_mode;
> -#else
> -#define enable_off_mode 0
> -#endif
> -
> =A0#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> =A0extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev=
);
> =A0#else
> --
> 1.7.5.4
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
