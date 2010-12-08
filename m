From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire
 during suspend
Date: Thu, 9 Dec 2010 00:51:29 +0100
Message-ID: <AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
References: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f170.google.com ([209.85.216.170]:51381 "EHLO
	mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0LHX7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 18:59:14 -0500
Received: by qyk10 with SMTP id 10so6054519qyk.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 15:58:53 -0800 (PST)
In-Reply-To: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 8, 2010 at 11:40 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> @@ -120,8 +133,9 @@ static void omap2_enter_full_retention(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto no_sleep;
>
> =A0 =A0 =A0 =A0/* Block console output in case it is on one of the OM=
AP UARTs */
> - =A0 =A0 =A0 if (try_acquire_console_sem())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_sleep;
> + =A0 =A0 =A0 if (!is_suspending())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_acquire_console_sem())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_sleep;

Combine into one if?
Hi Kevin,

<snip>

> =A0 =A0 =A0 =A0omap_uart_prepare_idle(0);
> =A0 =A0 =A0 =A0omap_uart_prepare_idle(1);
> @@ -136,7 +150,8 @@ static void omap2_enter_full_retention(void)
> =A0 =A0 =A0 =A0omap_uart_resume_idle(1);
> =A0 =A0 =A0 =A0omap_uart_resume_idle(0);
>
> - =A0 =A0 =A0 release_console_sem();
> + =A0 =A0 =A0 if (!is_suspending())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_console_sem();
>
> =A0no_sleep:
> =A0 =A0 =A0 =A0if (omap2_pm_debug) {
> @@ -284,6 +299,12 @@ out:
> =A0 =A0 =A0 =A0local_irq_enable();
> =A0}
>
> +static int omap2_pm_begin(suspend_state_t state)
> +{
> + =A0 =A0 =A0 suspend_state =3D state;
> + =A0 =A0 =A0 return 0;
> +}

Do you really need a return code here?

> =A0static int omap2_pm_prepare(void)
> =A0{
> =A0 =A0 =A0 =A0/* We cannot sleep in idle until we have resumed */
> @@ -333,10 +354,18 @@ static void omap2_pm_finish(void)
> =A0 =A0 =A0 =A0enable_hlt();
> =A0}
>
> +static void omap2_pm_end(void)
> +{
> + =A0 =A0 =A0 suspend_state =3D PM_SUSPEND_ON;
> + =A0 =A0 =A0 return;
> +}

Redundant return.

> +
> =A0static struct platform_suspend_ops omap_pm_ops =3D {
> + =A0 =A0 =A0 .begin =A0 =A0 =A0 =A0 =A0=3D omap2_pm_begin,
> =A0 =A0 =A0 =A0.prepare =A0 =A0 =A0 =A0=3D omap2_pm_prepare,
> =A0 =A0 =A0 =A0.enter =A0 =A0 =A0 =A0 =A0=3D omap2_pm_enter,
> =A0 =A0 =A0 =A0.finish =A0 =A0 =A0 =A0 =3D omap2_pm_finish,
> + =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D omap2_pm_end,
> =A0 =A0 =A0 =A0.valid =A0 =A0 =A0 =A0 =A0=3D suspend_valid_only_mem,
> =A0};
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 0ec8a04..648b8c5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -50,6 +50,19 @@
> =A0#include "sdrc.h"
> =A0#include "control.h"
>
> +#ifdef CONFIG_SUSPEND
> +static suspend_state_t suspend_state =3D PM_SUSPEND_ON;
> +static inline bool is_suspending(void)
> +{
> + =A0 =A0 =A0 return (suspend_state !=3D PM_SUSPEND_ON);
> +}
> +#else
> +static inline bool is_suspending(void)
> +{
> + =A0 =A0 =A0 return false;
> +}
> +#endif
> +
> =A0/* Scratchpad offsets */
> =A0#define OMAP343X_TABLE_ADDRESS_OFFSET =A0 =A0 0xc4
> =A0#define OMAP343X_TABLE_VALUE_OFFSET =A0 =A0 =A0 0xc0
> @@ -387,10 +400,11 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Block console output in case it is on one of the OM=
AP UARTs */
> - =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON ||
> - =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_acquire_console_sem())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto console_still_acti=
ve;
> + =A0 =A0 =A0 if (!is_suspending())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_O=
N)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_acquire_console=
_sem())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto co=
nsole_still_active;

Oh well, 3 nested ifs...

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
