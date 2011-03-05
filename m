From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 4/5] OMAP: GPIO: call save/restore ctxt from GPIO driver
Date: Sat, 5 Mar 2011 09:45:29 +0430
Message-ID: <AANLkTinAM-PjFFSmgoy2Akj5ARpPnxzO93XOe=mJybts@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-5-git-send-email-charu@ti.com> <87k4geedf1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35905 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750949Ab1CEFQL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 00:16:11 -0500
Received: by fxm17 with SMTP id 17so3430210fxm.5
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 21:16:09 -0800 (PST)
In-Reply-To: <87k4geedf1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com

On Sat, Mar 5, 2011 at 02:50, Kevin Hilman <khilman@ti.com> wrote:
> Charulatha V <charu@ti.com> writes:
>
>> Make gpio_prepare_for_idle() & gpio_resume_after_idle() functions
>> handle save context & restore context respectively in OMAP GPIO driv=
er
>> instead of calling these functions directly from pm layer. This woul=
d
>> be useful while modifying the OMAP GPIO driver to use PM runtime fra=
mework.
>
> Excellent!

Thanks.

>
> I really like this change, but have some minor issues with the
> implementation.
>
> Basically, you should no longer need to manually read PER prev state.
> Instead, in prepare_for_idle(), call
> omap_device_get_context_loss_count(), in resume_from_idle() call it
> again. =A0 If the count is different, you need to restore context.

Okay, will do this way.

>
> This way, you don't need to modify the resume_from_idle function, *an=
d*
> you can get rid of the read of PER prev state.
>
> Otherwise, I like this change.
>
> Kevin
>
>> Also modfiy gpio_prepare_for_idle() & gpio_resume_after_idle()
>> to do nothing if none of the GPIOs in a bank is being used.
>>
>> Also remove usage of cpu_is_* checks from the above mentioned
>> functions
>
>> Signed-off-by: Charulatha V <charu@ti.com>
>>
>> Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> (2430-SDP testing)
>> ---
>> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 | =A0 20 +---
>> =A0arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0218 +++=
+++++++++++++----------------
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A04 +-
>> =A04 files changed, 113 insertions(+), 131 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24=
xx.c
>> index 97feb3a..b71072d 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -162,7 +162,7 @@ no_sleep:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D timespec_to_ns(&ts_idle) * NSEC_=
PER_USEC;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_pm_dump(0, 1, tmp);
>> =A0 =A0 =A0 }
>> - =A0 =A0 omap2_gpio_resume_after_idle();
>> + =A0 =A0 omap2_gpio_resume_after_idle(0);
>>
>> =A0 =A0 =A0 clk_enable(osc_ck);
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 2f864e4..07af07e 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -90,16 +90,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm=
;
>> =A0static struct powerdomain *core_pwrdm, *per_pwrdm;
>> =A0static struct powerdomain *cam_pwrdm;
>>
>> -static inline void omap3_per_save_context(void)
>> -{
>> - =A0 =A0 omap_gpio_save_context();
>> -}
>> -
>> -static inline void omap3_per_restore_context(void)
>> -{
>> - =A0 =A0 omap_gpio_restore_context();
>> -}
>> -
>> =A0static void omap3_enable_io_chain(void)
>> =A0{
>> =A0 =A0 =A0 int timeout =3D 0;
>> @@ -408,8 +398,6 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(3);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_gpio_prepare_for_idle(per_going_of=
f);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (per_next_state =3D=3D PWRDM_POWER_OFF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_per_=
save_context();
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* CORE */
>> @@ -473,10 +461,12 @@ void omap_sram_idle(void)
>>
>> =A0 =A0 =A0 /* PER */
>> =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int is_per_prev_state_off;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_prev_state =3D pwrdm_read_prev_pwrst=
(per_pwrdm);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap2_gpio_resume_after_idle();
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (per_prev_state =3D=3D PWRDM_POWER_OFF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_per_restore_context(=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 is_per_prev_state_off =3D (per_prev_state =
=3D=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 PWRDM_POWER_OFF) ? 1 : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap2_gpio_resume_after_idle(is_per_prev_s=
tate_off);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(3);
>> =A0 =A0 =A0 }
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index 1da3233..10792b6 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -175,6 +175,9 @@ struct gpio_bank {
>> =A0 =A0 =A0 const char *pwrdm_name;
>> =A0};
>>
>> +static void omap_gpio_save_context(struct gpio_bank *bank);
>> +static void omap_gpio_restore_context(struct gpio_bank *bank);
>> +
>> =A0/*
>> =A0 * TODO: Cleanup gpio_bank usage as it is having information
>> =A0 * related to all instances of the device
>> @@ -1860,8 +1863,6 @@ static struct sys_device omap_gpio_device =3D =
{
>>
>> =A0#endif
>>
>> -#ifdef CONFIG_ARCH_OMAP2PLUS
>> -
>
> Why remove this? =A0 This will just be bloat for OMAP1-only builds.

Just thought of removing all CONFIG_ARCH_* #ifdefs. Anyways, I will
not retain this check in my next version.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
