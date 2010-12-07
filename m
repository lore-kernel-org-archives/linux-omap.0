From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP2+: PM/serial: fix console semaphore acquire during suspend
Date: Tue, 7 Dec 2010 22:22:18 +0100
Message-ID: <AANLkTinTT0LmMRvZbhnS2-9VTUy0yBDZ_gR=nN+nskKm@mail.gmail.com>
References: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40893 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0LGVWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 16:22:19 -0500
Received: by qyk12 with SMTP id 12so384296qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 13:22:19 -0800 (PST)
In-Reply-To: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Tue, Dec 7, 2010 at 9:50 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
> hold console semaphore while OMAP UARTs are disabled) added use of th=
e
> console semaphore to protect UARTs from being accessed after disabled
> during idle, but this causes problems in suspend.
>
> During suspend, the console semaphore is already held by the time we =
reach
> the OMAP suspend path, so the try_acquire_console_sem() will always f=
ail and
> suspend will be aborted.
>
> To fix, introduce a check so the console semaphore is only attempted
> during idle, and not during suspend.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tested OK on Beagleboard with suspend and idle with RET and OFF modes

Tested-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

> ---
> Applies to Tony's omap-fixes branch.
>
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 24 ++++++++++++++++++------
> =A01 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 0ec8a04..122ef3c 100644
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
>
> =A0 =A0 =A0 =A0/* PER */
> =A0 =A0 =A0 =A0if (per_next_state < PWRDM_POWER_ON) {
> @@ -514,8 +528,6 @@ out:
> =A0}
>
> =A0#ifdef CONFIG_SUSPEND
> -static suspend_state_t suspend_state;
> -
> =A0static int omap3_pm_prepare(void)
> =A0{
> =A0 =A0 =A0 =A0disable_hlt();
> --
> 1.7.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
