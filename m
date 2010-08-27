From: Silesh C V <silesh@ti.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 15:28:00 +0530
Message-ID: <AANLkTi=oUSQmRDBo0USs2Xx5oa=fcpMqY-dvWZU4RYN3@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62286 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab0H0J6D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 05:58:03 -0400
Received: by gwj17 with SMTP id 17so1048765gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 02:58:01 -0700 (PDT)
In-Reply-To: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.sripathy@linaro.org
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

g 28, 2010 at 3:38 AM,  <vishwanath.sripathy@linaro.org> wrote:
> From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>
> This patch has instrumentation code for measuring latencies for
> various CPUIdle C states for OMAP. Idea here is to capture the
> timestamp at various phases of CPU Idle and then compute the sw
> latency for various c states. For OMAP, 32k clock is chosen as
> reference clock this as is an always on clock. wkup domain memory
> (scratchpad memory) is used for storing timestamps. One can see the
> worstcase latencies in below sysfs entries (after enabling CONFIG_CPU=
_IDLE_PROF
> in .config). This information can be used to correctly configure cpu =
idle
> latencies for various C states after adding HW latencies for each of
> these sw latencies.
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>
> THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>
> Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> Cc: linaro-dev@lists.linaro.org
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 58 ++++++++++++++++--
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A05 ++
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 | =A0121 +++++++++++++++++++++=
++++++++++++++++
> =A0drivers/cpuidle/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++
> =A0drivers/cpuidle/sysfs.c =A0 =A0 =A0 =A0 =A0 | =A0 16 +++++-
> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A06 files changed, 202 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 3d3d035..398bef8
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -25,6 +25,7 @@
> =A0#include <linux/sched.h>
> =A0#include <linux/cpuidle.h>
>
> +#include <linux/clk.h>
> =A0#include <plat/prcm.h>
> =A0#include <plat/irqs.h>
> =A0#include <plat/powerdomain.h>
> @@ -86,6 +87,11 @@ static struct cpuidle_params cpuidle_params_table[=
] =3D {
> =A0 =A0 =A0 =A0{1, 10000, 30000, 300000},
> =A0};
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +static struct clk *clk_32k;
> +#define CONVERT_32K_USEC(lat) (lat * (USEC_PER_SEC/clk_get_rate(clk_=
32k)))
> +#endif
> +
> =A0static int omap3_idle_bm_check(void)
> =A0{
> =A0 =A0 =A0 =A0if (!omap3_can_sleep())
> @@ -115,21 +121,28 @@ static int _cpuidle_deny_idle(struct powerdomai=
n *pwrdm,
> =A0* Called from the CPUidle framework to program the device to the
> =A0* specified target state selected by the governor.
> =A0*/
> +
> =A0static int omap3_enter_idle(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpuidle_state *=
state)
> =A0{
> =A0 =A0 =A0 =A0struct omap3_processor_cx *cx =3D cpuidle_get_statedat=
a(state);
> =A0 =A0 =A0 =A0struct timespec ts_preidle, ts_postidle, ts_idle;
> =A0 =A0 =A0 =A0u32 mpu_state =3D cx->mpu_state, core_state =3D cx->co=
re_state;
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 int idle_time, latency;
> + =A0 =A0 =A0 long sleep_time, wkup_time, total_sleep_time;
> + =A0 =A0 =A0 long preidle_time, postidle_time;
> +#endif
>
> =A0 =A0 =A0 =A0current_cx_state =3D *cx;
>
> - =A0 =A0 =A0 /* Used to keep track of the total time in idle */
> - =A0 =A0 =A0 getnstimeofday(&ts_preidle);
> -
> =A0 =A0 =A0 =A0local_irq_disable();
> =A0 =A0 =A0 =A0local_fiq_disable();
> -
> + =A0 =A0 =A0 /* Used to keep track of the total time in idle */
> + =A0 =A0 =A0 getnstimeofday(&ts_preidle);
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 preidle_time =3D omap3_sram_get_32k_tick();
> +#endif
> =A0 =A0 =A0 =A0pwrdm_set_next_pwrst(mpu_pd, mpu_state);
> =A0 =A0 =A0 =A0pwrdm_set_next_pwrst(core_pd, core_state);
>
> @@ -153,9 +166,39 @@ return_sleep_time:
> =A0 =A0 =A0 =A0getnstimeofday(&ts_postidle);
> =A0 =A0 =A0 =A0ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 postidle_time =3D omap3_sram_get_32k_tick();
> +#endif
> =A0 =A0 =A0 =A0local_irq_enable();
> =A0 =A0 =A0 =A0local_fiq_enable();
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
> +
> + =A0 =A0 =A0 /* take care of overflow */
> + =A0 =A0 =A0 if (postidle_time < preidle_time)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 postidle_time +=3D (u32) 0xffffffff;
> + =A0 =A0 =A0 if (wkup_time < sleep_time)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkup_time +=3D (u32) 0xffffffff;
> +
> + =A0 =A0 =A0 idle_time =3D postidle_time - preidle_time;
> + =A0 =A0 =A0 total_sleep_time =3D wkup_time - =A0sleep_time;
> + =A0 =A0 =A0 latency =3D idle_time - total_sleep_time;
> + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
> +
> + =A0 =A0 =A0 /* calculate average latency after ignoring sprious one=
s */
> + =A0 =A0 =A0 if ((total_sleep_time > 0) && (latency > state->actual_=
latency)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (latency >=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->actual_latency =3D CONVERT_32K_U=
SEC(latency);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D (sleep_time - preidle_time)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->sleep_latency =3D CONVERT_32K_US=
EC(latency);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D postidle_time - wkup_time;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->wkup_latency =3D CONVERT_32K_USE=
C(latency);
> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_se=
c * USEC_PER_SEC;
> =A0}
>
> @@ -423,7 +466,9 @@ int __init omap3_idle_init(void)
> =A0 =A0 =A0 =A0struct omap3_processor_cx *cx;
> =A0 =A0 =A0 =A0struct cpuidle_state *state;
> =A0 =A0 =A0 =A0struct cpuidle_device *dev;
> -
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 static struct device dummy_device;
> +#endif
> =A0 =A0 =A0 =A0mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
> =A0 =A0 =A0 =A0core_pd =3D pwrdm_lookup("core_pwrdm");
>
> @@ -456,6 +501,9 @@ int __init omap3_idle_init(void)
>
> =A0 =A0 =A0 =A0omap3_cpuidle_update_states();
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 clk_32k =3D clk_get(&dummy_device, "wkup_32k_fck");
> +#endif
> =A0 =A0 =A0 =A0if (cpuidle_register_device(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: CPUidle register =
device failed\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 3de6ece..e62e87d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -82,4 +82,9 @@ extern unsigned int save_secure_ram_context_sz;
> =A0extern unsigned int omap24xx_cpu_suspend_sz;
> =A0extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +extern u32 omap3_sram_get_wkup_time();
> +extern u32 omap3_sram_get_sleep_time();
> +extern u32 omap3_sram_get_32k_tick();
> +#endif
> =A0#endif
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index d522cd7..8dec5ef 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -59,6 +59,20 @@
> =A0#define SDRC_DLLA_STATUS_V =A0 =A0 OMAP34XX_SDRC_REGADDR(SDRC_DLLA=
_STATUS)
> =A0#define SDRC_DLLA_CTRL_V =A0 =A0 =A0 OMAP34XX_SDRC_REGADDR(SDRC_DL=
LA_CTRL)
>
> +#define TIMER_32K_SYNC_P =A0 =A0 =A0 0x48320010
> +#define TIMER_32K_SYNC =A0 =A0 =A0 =A0 OMAP2_L4_IO_ADDRESS(TIMER_32K=
_SYNC_P)
> +
> +#define SCRATCHPAD_SLEEP_TIME_OFFSET 0x9f8
> +#define SCRATCHPAD_WKUP_TIME_OFFSET 0x9fc
> +#define SCRATCHPAD_SLEEP_TIME =A0OMAP343X_CTRL_REGADDR(SCRATCHPAD_SL=
EEP_TIME_OFFSET)
> +#define SCRATCHPAD_WKUP_TIME =A0 OMAP343X_CTRL_REGADDR(SCRATCHPAD_WK=
UP_TIME_OFFSET)
> +#define SCRATCHPAD_WKUP_TIME_P OMAP343X_CTRL_BASE + SCRATCHPAD_WKUP_=
TIME_OFFSET
> +
> +#define CM_ICLKEN_WKUP OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN)
> +#define CM_ICLKEN_WKUP_P =A0 =A0 =A0 OMAP3430_CM_BASE + WKUP_MOD + C=
M_ICLKEN
> +#define CM_IDLEST_WKUP OMAP34XX_CM_REGADDR(WKUP_MOD, CM_IDLEST)
> +#define CM_IDLEST_WKUP_P =A0 =A0 =A0 OMAP3430_CM_BASE + WKUP_MOD + C=
M_IDLEST
> +
> =A0 =A0 =A0 =A0 .text
> =A0/* Function to aquire the semaphore in scratchpad */
> =A0ENTRY(lock_scratchpad_sem)
> @@ -183,7 +197,31 @@ api_params:
> =A0 =A0 =A0 =A0.word =A0 0x4, 0x0, 0x0, 0x1, 0x1
> =A0ENTRY(save_secure_ram_context_sz)
> =A0 =A0 =A0 =A0.word =A0 . - save_secure_ram_context
> +#ifdef CONFIG_CPU_IDLE_PROF
> +ENTRY(omap3_sram_get_wkup_time)
> + =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stack
> + =A0 =A0 =A0 ldr r0, wkup_time
> + =A0 =A0 =A0 ldr r0, [r0]
> + =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and return
> +ENTRY(omap3_sram_get_wkup_time_sz)
> + =A0 =A0 =A0 =A0.word =A0 . - omap3_sram_get_wkup_time
> +
> +ENTRY(omap3_sram_get_sleep_time)
> + =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stack
> + =A0 =A0 =A0 ldr r0, sleep_time
> + =A0 =A0 =A0 ldr r0, [r0]
> + =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and return
> +ENTRY(omap3_sram_get_sleep_time_sz)
> + =A0 =A0 =A0 =A0.word =A0 . - omap3_sram_get_sleep_time
>
> +ENTRY(omap3_sram_get_32k_tick)
> + =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stack
> + =A0 =A0 =A0 ldr r0, sync_32k_timer
> + =A0 =A0 =A0 ldr r0, [r0]
> + =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and return
> +ENTRY(omap3_sram_get_32k_tick_sz)
> + =A0 =A0 =A0 =A0.word =A0 . - omap3_sram_get_32k_tick
> +#endif
> =A0/*
> =A0* Forces OMAP into idle state
> =A0*
> @@ -207,6 +245,13 @@ loop:
> =A0 =A0 =A0 =A0cmp =A0 =A0 r1, #0x0
> =A0 =A0 =A0 =A0/* If context save is required, do that and execute wf=
i */
> =A0 =A0 =A0 =A0bne =A0 =A0 save_context_wfi
> +
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 ldr r4, sync_32k_timer
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 ldr r6, sleep_time
> + =A0 =A0 =A0 str r5, [r6]
> +#endif
> =A0 =A0 =A0 =A0/* Data memory barrier and Data sync barrier */
> =A0 =A0 =A0 =A0mov =A0 =A0 r1, #0
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r1, c7, c10, 4
> @@ -224,8 +269,25 @@ loop:
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 ldr r4, iclken_wkup
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 orr r5, r5, #0x4
> + =A0 =A0 =A0 str r5, [r4]
> + =A0 =A0 =A0 ldr r4, idlest_wkup
> +wait_idlest:
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
> + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x0
> + =A0 =A0 =A0 bne =A0 =A0 wait_idlest
> + =A0 =A0 =A0 ldr r4, sync_32k_timer
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 ldr r6, wkup_time
> + =A0 =A0 =A0 str r5, [r6]
> +#endif
> =A0 =A0 =A0 =A0bl wait_sdrc_ok
>
> +
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ restore regs and return
> =A0restore_es3:
> =A0 =A0 =A0 =A0/*b restore_es3*/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ Enable=
 to debug restore code
> @@ -247,6 +309,23 @@ copy_to_sram:
> =A0 =A0 =A0 =A0blx =A0 =A0 r1
> =A0restore:
> =A0 =A0 =A0 =A0/* b restore*/ =A0@ Enable to debug restore code
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 ldr r4, iclken_wkup_p
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 orr r5, r5, #0x4
> + =A0 =A0 =A0 str r5, [r4]
> + =A0 =A0 =A0 ldr r4, idlest_wkup_p
> +wait_idlest1:
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
> + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x0
> + =A0 =A0 =A0 bne =A0 =A0 wait_idlest1
> + =A0 =A0 =A0 ldr r4, sync_32k_timer_p
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 ldr r6, wkup_time_p
> + =A0 =A0 =A0 str r5, [r6]
> +#endif
> +
> =A0 =A0 =A0 =A0 /* Check what was the reason for mpu reset and store =
the reason in r9*/
> =A0 =A0 =A0 =A0 /* 1 - Only L1 and logic lost */
> =A0 =A0 =A0 =A0 /* 2 - Only L2 lost - In this case, we wont be here *=
/
> @@ -587,6 +666,12 @@ finished:
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 2, r10, c0, c0, 0
> =A0 =A0 =A0 =A0isb
> =A0skip_l2_inval:
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 ldr r4, sync_32k_timer
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 ldr r6, sleep_time
> + =A0 =A0 =A0 str r5, [r6]
> +#endif
> =A0 =A0 =A0 =A0/* Data memory barrier and Data sync barrier */
> =A0 =A0 =A0 =A0mov =A0 =A0 r1, #0
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r1, c7, c10, 4
> @@ -603,6 +688,22 @@ skip_l2_inval:
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 ldr r4, iclken_wkup
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 orr r5, r5, #0x4
> + =A0 =A0 =A0 str r5, [r4]
> + =A0 =A0 =A0 ldr r4, idlest_wkup
> +wait_idlest2:
> + =A0 =A0 =A0 ldr r5, [r4]
> + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
> + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x0
> + =A0 =A0 =A0 bne =A0 =A0 wait_idlest2
> + =A0 =A0 =A0 ldr r4, sync_32k_timer
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 ldr r6, wkup_time
> + =A0 =A0 =A0 str r5, [r6]
> +#endif
> =A0 =A0 =A0 =A0bl wait_sdrc_ok
> =A0 =A0 =A0 =A0/* restore regs and return */
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc}
> @@ -668,5 +769,25 @@ cache_pred_disable_mask:
> =A0 =A0 =A0 =A0.word =A0 0xFFFFE7FB
> =A0control_stat:
> =A0 =A0 =A0 =A0.word =A0 CONTROL_STAT
> +#ifdef CONFIG_CPU_IDLE_PROF
> +sync_32k_timer:
> + =A0 =A0 =A0 .word TIMER_32K_SYNC
> +sync_32k_timer_p:
> + =A0 =A0 =A0 .word TIMER_32K_SYNC_P
> +sleep_time:
> + =A0 =A0 =A0 .word SCRATCHPAD_SLEEP_TIME
> +wkup_time:
> + =A0 =A0 =A0 .word SCRATCHPAD_WKUP_TIME
> +wkup_time_p:
> + =A0 =A0 =A0 .word SCRATCHPAD_WKUP_TIME_P
> +iclken_wkup:
> + =A0 =A0 =A0 .word CM_ICLKEN_WKUP
> +iclken_wkup_p:
> + =A0 =A0 =A0 .word CM_ICLKEN_WKUP_P
> +idlest_wkup:
> + =A0 =A0 =A0 .word CM_IDLEST_WKUP
> +idlest_wkup_p:
> + =A0 =A0 =A0 .word CM_IDLEST_WKUP_P
> +#endif
> =A0ENTRY(omap34xx_cpu_suspend_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap34xx_cpu_suspend
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 7dbc4a8..147456d 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -18,3 +18,8 @@ config CPU_IDLE_GOV_MENU
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on CPU_IDLE && NO_HZ
> =A0 =A0 =A0 =A0default y
> +
> +config CPU_IDLE_PROF
> + =A0 =A0 =A0 bool

Should not this be something like bool "CPU idle profiling " so that
this entry shows up in
'make menuconfig' ? and this should have dependency on ARCH_OMAP3 also =
?

> + =A0 =A0 =A0 depends on CPU_IDLE
> + =A0 =A0 =A0 default n
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 0310ffa..a3e9db1 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -249,6 +249,11 @@ define_show_state_ull_function(usage)
> =A0define_show_state_ull_function(time)
> =A0define_show_state_str_function(name)
> =A0define_show_state_str_function(desc)
> +#ifdef CONFIG_CPU_IDLE_PROF
> +define_show_state_function(actual_latency)
> +define_show_state_function(sleep_latency)
> +define_show_state_function(wkup_latency)
> +#endif
>
> =A0define_one_state_ro(name, show_state_name);
> =A0define_one_state_ro(desc, show_state_desc);
> @@ -256,7 +261,11 @@ define_one_state_ro(latency, show_state_exit_lat=
ency);
> =A0define_one_state_ro(power, show_state_power_usage);
> =A0define_one_state_ro(usage, show_state_usage);
> =A0define_one_state_ro(time, show_state_time);
> -
> +#ifdef CONFIG_CPU_IDLE_PROF
> +define_one_state_ro(actual_latency, show_state_actual_latency);
> +define_one_state_ro(sleep_latency, show_state_sleep_latency);
> +define_one_state_ro(wkup_latency, show_state_wkup_latency);
> +#endif
> =A0static struct attribute *cpuidle_state_default_attrs[] =3D {
> =A0 =A0 =A0 =A0&attr_name.attr,
> =A0 =A0 =A0 =A0&attr_desc.attr,
> @@ -264,6 +273,11 @@ static struct attribute *cpuidle_state_default_a=
ttrs[] =3D {
> =A0 =A0 =A0 =A0&attr_power.attr,
> =A0 =A0 =A0 =A0&attr_usage.attr,
> =A0 =A0 =A0 =A0&attr_time.attr,
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 &attr_actual_latency.attr,
> + =A0 =A0 =A0 &attr_sleep_latency.attr,
> + =A0 =A0 =A0 &attr_wkup_latency.attr,
> +#endif
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 55215cc..6474f6a 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -43,6 +43,9 @@ struct cpuidle_state {
>
> =A0 =A0 =A0 =A0int (*enter) =A0 =A0(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_state =
*state);
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 u32 actual_latency, sleep_latency, wkup_latency;
> +#endif
> =A0};
>
> =A0/* Idle State Flags */
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Silesh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
