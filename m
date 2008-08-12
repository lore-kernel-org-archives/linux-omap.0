From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Tue, 12 Aug 2008 15:40:03 +0300
Message-ID: <874p5q8l0c.fsf@trdhcp146196.ntc.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<002f01c8f7c5$0790fea0$LocalHost@wipultra1382>
	<39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45829 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYHLMlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 08:41:04 -0400
In-Reply-To: <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Wed, 6 Aug 2008 18:42:23 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Rajendra,

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> Hi,
>
> Re-posting a refreshed version of these patches.
>
> regards
> Rajendra

I think these are beginning to look good to me, altought patches can't
be applied using git. Few things:

Check wether serial can sleep is missing from omap3_enter_idle and it
should be removed from omap3_can_sleep:

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cp=
uidle34xx.c
index a02da6d..16ff30b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -431,7 +431,7 @@ static int omap3_enter_idle(struct cpuidle_device *=
dev,
=20
        current_cx_state =3D *cx;
=20
-       if (cx->type =3D=3D OMAP3_STATE_C0) {
+       if (cx->type =3D=3D OMAP3_STATE_C0 || !omap_serial_can_sleep())=
 {
                /* Do nothing for C0, not even a wfi */
                return 0;
        }

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index f68fa0a..f9b3676 100644
@@ -391,8 +391,6 @@ int omap3_can_sleep(void)
                return 0;
        if (atomic_read(&sleep_block) > 0)
                return 0;
-       if (!omap_serial_can_sleep())
-               return 0;
        return 1;
 }

Doing this would make serial console to work faster.

_omap_sram_idle should be non-static:

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index f68fa0a..133a666 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -60,7 +60,7 @@ u32 restore_pointer_address;
=20
 static LIST_HEAD(pwrst_list);
=20
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
+void (*_omap_sram_idle)(u32 *addr, int save_state);
=20
 static void (*saved_idle)(void);
=20
Serial and gpio clock disabling and gpio_prepare/resume can be removed
from omap3_pm_idle because they are already done in
omap_sram_idle. And if omap_serial_can_sleep is removed from
omap3_can_sleep it should be added to omap3_pm_idle. Omap3_pm_idle can
be also put behind #ifndef CONFIG_CPU_IDLE:

+#ifndef CONFIG_CPU_IDLE
 static void omap3_pm_idle(void)
 {
        local_irq_disable();
@@ -454,33 +455,16 @@ static void omap3_pm_idle(void)
        if (omap_irq_pending())
                goto out;
=20
-       omap2_gpio_prepare_for_retention();
-
-       if (clocks_off_while_idle) {
-               omap_serial_enable_clocks(0, 0);
-               omap_serial_enable_clocks(0, 1);
-               omap_serial_enable_clocks(0, 2);
-               /* XXX This is for gpio fclk hack. Will be removed as
-                * gpio driver * handles fcks correctly */
-               per_gpio_clk_disable();
-       }
+       if (!omap_serial_can_sleep())
+               goto out;
=20
        omap_sram_idle();
=20
-       if (clocks_off_while_idle) {
-               omap_serial_enable_clocks(1, 0);
-               omap_serial_enable_clocks(1, 1);
-               omap_serial_enable_clocks(1, 2);
-               /* XXX This is for gpio fclk hack. Will be removed as
-                * gpio driver * handles fcks correctly */
-               per_gpio_clk_enable();
-       }
-
-       omap2_gpio_resume_after_retention();
 out:
        local_fiq_enable();
        local_irq_enable();
 }
+#endif /* CONFIG_CPU_IDLE */

I would like to see also some reformatting. E.g. patch 11 contains
lots of code which is not related to "CORE context save/restore". It
might be also good idea to enable only non-off mode C states and have
a pwrdms_setup function which is something like this:

static int __init pwrdms_setup(struct powerdomain *pwrdm)
{
	struct power_state *pwrst;

	if (!pwrdm->pwrsts)
		return 0;

	pwrst =3D kmalloc(sizeof(struct power_state), GFP_KERNEL);
	if (!pwrst)
		return -ENOMEM;
	pwrst->pwrdm =3D pwrdm;
	pwrst->next_state =3D PWRDM_POWER_RET;
	list_add(&pwrst->node, &pwrst_list);

	if (pwrdm_has_hdwr_sar(pwrdm))
		pwrdm_enable_hdwr_sar(pwrdm);

#ifdef CONFIG_CPU_IDLE
	/* Let cpuidle do selection here */
	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") || !strcmp(pwrst->pwrdm-=
>name, "mpu_pwrdm") ||
	    !strcmp(pwrst->pwrdm->name, "neon_pwrdm"))
		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
	else
#endif
		return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
}

This way cpuidle code would be in a state that it could be applied on
linux-omap tree and it wouldn't break anything. Then have
e.g. separate patch for testing off state. This patch could modify
code to set next states to off and mark off mode C states as a valid.

>
>> Hi,
>>
>> I am sending an updated patch set for CPUidle which includes all
>> fixes/comments
>> posted on the previous set by Jouni/Richard W/Peter and others.
>>
>> The Following are the fixes
>> 1) Uart clock enable/disable moved out of the context save/restore p=
atch
>> 2) GPIO IRQENABLE save/restore fix from Richard
>> 3) Fixes from Jouni which do the following
>> 	1. Add wkdep between neon and mpu
>> 	2. Add wkdep between per and core
>> 	3. Deny hwsup mode before writing next pwrst state
>> 	4. Make sure that order in idle loop is such that clocks are
>> _really_
>>    		enabled before accessing registers (serial & gpio).
>> 4) Safe state idle fix from Richard
>> 5) Uart smart-force fix from Richard
>> 6) Toggle IO-PAD enable/disable in idle
>>
>> As earlier these patches apply on top of Jouni's workaround patch se=
t
>> ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
>>
>> The following is neccessay even with a minimal config to achieve OFF=
=2E
>> $ echo 1 > /sys/power/sleep_while_idle
>> $ echo 1 > /sys/power/clocks_off_while_idle
>>
>> regards,
>> Rajendra
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
