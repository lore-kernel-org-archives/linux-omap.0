From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire during suspend
Date: Thu, 09 Dec 2010 07:56:40 -0800
Message-ID: <87zksfc53b.fsf@deeprootsystems.com>
References: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
	<AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64983 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0LIP4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 10:56:45 -0500
Received: by pva4 with SMTP id 4so540831pva.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 07:56:45 -0800 (PST)
In-Reply-To: <AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
	(Vitaly Wool's message of "Thu, 9 Dec 2010 00:51:29 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Vitaly Wool <vitalywool@gmail.com> writes:

> On Wed, Dec 8, 2010 at 11:40 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> @@ -120,8 +133,9 @@ static void omap2_enter_full_retention(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto no_sleep=
;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Block console output in case it is on =
one of the OMAP UARTs */
>> - =C2=A0 =C2=A0 =C2=A0 if (try_acquire_console_sem())
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_sleep;
>> + =C2=A0 =C2=A0 =C2=A0 if (!is_suspending())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (try_acquire_c=
onsole_sem())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto no_sleep;
>
> Combine into one if?

personal preference I guess.  I prefer it nested.

>
> <snip>
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_prepare_idle(0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_prepare_idle(1);
>> @@ -136,7 +150,8 @@ static void omap2_enter_full_retention(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_resume_idle(1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_resume_idle(0);
>>
>> - =C2=A0 =C2=A0 =C2=A0 release_console_sem();
>> + =C2=A0 =C2=A0 =C2=A0 if (!is_suspending())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_console_s=
em();
>>
>> =C2=A0no_sleep:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (omap2_pm_debug) {
>> @@ -284,6 +299,12 @@ out:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable();
>> =C2=A0}
>>
>> +static int omap2_pm_begin(suspend_state_t state)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 suspend_state =3D state;
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>
> Do you really need a return code here?

yes, this function prototype is defined by the driver model, not by me.

>> =C2=A0static int omap2_pm_prepare(void)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We cannot sleep in idle until we have =
resumed */
>> @@ -333,10 +354,18 @@ static void omap2_pm_finish(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_hlt();
>> =C2=A0}
>>
>> +static void omap2_pm_end(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 suspend_state =3D PM_SUSPEND_ON;
>> + =C2=A0 =C2=A0 =C2=A0 return;
>> +}
>
> Redundant return.

but harmless

>> +
>> =C2=A0static struct platform_suspend_ops omap_pm_ops =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .begin =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
omap2_pm_begin,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.prepare =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D o=
map2_pm_prepare,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.enter =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D omap2_pm_enter,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.finish =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D o=
map2_pm_finish,
>> + =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D omap2_pm_end,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D suspend_valid_only_mem,
>> =C2=A0};
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 0ec8a04..648b8c5 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -50,6 +50,19 @@
>> =C2=A0#include "sdrc.h"
>> =C2=A0#include "control.h"
>>
>> +#ifdef CONFIG_SUSPEND
>> +static suspend_state_t suspend_state =3D PM_SUSPEND_ON;
>> +static inline bool is_suspending(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return (suspend_state !=3D PM_SUSPEND_ON);
>> +}
>> +#else
>> +static inline bool is_suspending(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return false;
>> +}
>> +#endif
>> +
>> =C2=A0/* Scratchpad offsets */
>> =C2=A0#define OMAP343X_TABLE_ADDRESS_OFFSET =C2=A0 =C2=A0 0xc4
>> =C2=A0#define OMAP343X_TABLE_VALUE_OFFSET =C2=A0 =C2=A0 =C2=A0 0xc0
>> @@ -387,10 +400,11 @@ void omap_sram_idle(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Block console output in case it is on =
one of the OMAP UARTs */
>> - =C2=A0 =C2=A0 =C2=A0 if (per_next_state < PWRDM_POWER_ON ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 core_next_state < PWRDM_POWER_O=
N)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (try_acquire_c=
onsole_sem())
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto console_still_active;
>> + =C2=A0 =C2=A0 =C2=A0 if (!is_suspending())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (per_next_stat=
e < PWRDM_POWER_ON ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cor=
e_next_state < PWRDM_POWER_ON)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (try_acquire_console_sem())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto console_still_active;
>
> Oh well, 3 nested ifs...

again, personal preference.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
