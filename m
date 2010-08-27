From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 12:25:49 +0200
Message-ID: <4C7792AD.80804@ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46769 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0H0K0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 06:26:01 -0400
In-Reply-To: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Jean Pihet <jean.pihet@swing.be>, Nicole Chalhoub <n-chalhoub@ti.com>, Vincent Bour <v-bour@ti.com>

Hi Vishwa,

On 8/28/2010 12:08 AM, vishwanath.sripathy@linaro.org wrote:
> From: Vishwanath BS<vishwanath.sripathy@linaro.org>
>
> This patch has instrumentation code for measuring latencies for
> various CPUIdle C states for OMAP. Idea here is to capture the
> timestamp at various phases of CPU Idle and then compute the sw
> latency for various c states. For OMAP, 32k clock is chosen as
> reference clock this as is an always on clock. wkup domain memory
> (scratchpad memory) is used for storing timestamps. One can see the
> worstcase latencies in below sysfs entries (after enabling CONFIG_CPU_IDLE_PROF
> in .config). This information can be used to correctly configure cpu idle
> latencies for various C states after adding HW latencies for each of
> these sw latencies.
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency

FYI, Jean is currently working on using standard Linux probes in order 
to instrument CPUIdle / CPUfreq. I'm not sure it is doable, but it might 
better to use standard method to do that instead of purely OMAP3 
specific stuff. This code will not scale easily on OMAP4.

Do you have a dump of the latency you measured do far?

> THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>
> Signed-off-by: Vishwanath BS<vishwanath.sripathy@linaro.org>
> Cc: linaro-dev@lists.linaro.org
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |   58 ++++++++++++++++--
>   arch/arm/mach-omap2/pm.h          |    5 ++
>   arch/arm/mach-omap2/sleep34xx.S   |  121 +++++++++++++++++++++++++++++++++++++
>   drivers/cpuidle/Kconfig           |    5 ++
>   drivers/cpuidle/sysfs.c           |   16 +++++-
>   include/linux/cpuidle.h           |    3 +
>   6 files changed, 202 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 3d3d035..398bef8
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -25,6 +25,7 @@
>   #include<linux/sched.h>
>   #include<linux/cpuidle.h>
>
> +#include<linux/clk.h>
>   #include<plat/prcm.h>
>   #include<plat/irqs.h>
>   #include<plat/powerdomain.h>
> @@ -86,6 +87,11 @@ static struct cpuidle_params cpuidle_params_table[] = {
>          {1, 10000, 30000, 300000},
>   };
>
> +#ifdef CONFIG_CPU_IDLE_PROF

Cannot you use _PROFILING instead? _PROF does not sound very meaningful 
for my point of view.

> +static struct clk *clk_32k;
> +#define CONVERT_32K_USEC(lat) (lat * (USEC_PER_SEC/clk_get_rate(clk_32k)))
> +#endif
> +
>   static int omap3_idle_bm_check(void)
>   {
>          if (!omap3_can_sleep())
> @@ -115,21 +121,28 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>    * Called from the CPUidle framework to program the device to the
>    * specified target state selected by the governor.
>    */
> +
>   static int omap3_enter_idle(struct cpuidle_device *dev,
>                          struct cpuidle_state *state)
>   {
>          struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
>          struct timespec ts_preidle, ts_postidle, ts_idle;
>          u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       int idle_time, latency;
> +       long sleep_time, wkup_time, total_sleep_time;
> +       long preidle_time, postidle_time;
> +#endif
>
>          current_cx_state = *cx;
>
> -       /* Used to keep track of the total time in idle */
> -       getnstimeofday(&ts_preidle);
> -
>          local_irq_disable();
>          local_fiq_disable();
> -
> +       /* Used to keep track of the total time in idle */
> +       getnstimeofday(&ts_preidle);
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       preidle_time = omap3_sram_get_32k_tick();
> +#endif
>          pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>          pwrdm_set_next_pwrst(core_pd, core_state);
>
> @@ -153,9 +166,39 @@ return_sleep_time:
>          getnstimeofday(&ts_postidle);
>          ts_idle = timespec_sub(ts_postidle, ts_preidle);
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       postidle_time = omap3_sram_get_32k_tick();
> +#endif
>          local_irq_enable();
>          local_fiq_enable();
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       sleep_time = omap3_sram_get_sleep_time();
> +       wkup_time = omap3_sram_get_wkup_time();
> +
> +       /* take care of overflow */
> +       if (postidle_time<  preidle_time)
> +               postidle_time += (u32) 0xffffffff;
> +       if (wkup_time<  sleep_time)
> +               wkup_time += (u32) 0xffffffff;
> +
> +       idle_time = postidle_time - preidle_time;
> +       total_sleep_time = wkup_time -  sleep_time;
> +       latency = idle_time - total_sleep_time;
> +       sleep_time = omap3_sram_get_sleep_time();
> +       wkup_time = omap3_sram_get_wkup_time();
> +
> +       /* calculate average latency after ignoring sprious ones */
> +       if ((total_sleep_time>  0)&&  (latency>  state->actual_latency)
> +&&  (latency>= 0)) {
> +               state->actual_latency = CONVERT_32K_USEC(latency);
> +               latency = (sleep_time - preidle_time);
> +               state->sleep_latency = CONVERT_32K_USEC(latency);
> +               latency = postidle_time - wkup_time;
> +               state->wkup_latency = CONVERT_32K_USEC(latency);
> +       }
> +#endif
> +
>          return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
>   }
>
> @@ -423,7 +466,9 @@ int __init omap3_idle_init(void)
>          struct omap3_processor_cx *cx;
>          struct cpuidle_state *state;
>          struct cpuidle_device *dev;
> -
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       static struct device dummy_device;
> +#endif
>          mpu_pd = pwrdm_lookup("mpu_pwrdm");
>          core_pd = pwrdm_lookup("core_pwrdm");
>
> @@ -456,6 +501,9 @@ int __init omap3_idle_init(void)
>
>          omap3_cpuidle_update_states();
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       clk_32k = clk_get(&dummy_device, "wkup_32k_fck");
> +#endif
>          if (cpuidle_register_device(dev)) {
>                  printk(KERN_ERR "%s: CPUidle register device failed\n",
>                         __func__);
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 3de6ece..e62e87d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -82,4 +82,9 @@ extern unsigned int save_secure_ram_context_sz;
>   extern unsigned int omap24xx_cpu_suspend_sz;
>   extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#ifdef CONFIG_CPU_IDLE_PROF
> +extern u32 omap3_sram_get_wkup_time();
> +extern u32 omap3_sram_get_sleep_time();
> +extern u32 omap3_sram_get_32k_tick();
> +#endif
>   #endif
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index d522cd7..8dec5ef 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -59,6 +59,20 @@
>   #define SDRC_DLLA_STATUS_V     OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>   #define SDRC_DLLA_CTRL_V       OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>
> +#define TIMER_32K_SYNC_P       0x48320010
> +#define TIMER_32K_SYNC         OMAP2_L4_IO_ADDRESS(TIMER_32K_SYNC_P)

We are trying to get rid of all the direct usage of physical address and 
hard coded virtual address translation in the code.
So please do not access the timer like that.

> +
> +#define SCRATCHPAD_SLEEP_TIME_OFFSET 0x9f8
> +#define SCRATCHPAD_WKUP_TIME_OFFSET 0x9fc
> +#define SCRATCHPAD_SLEEP_TIME  OMAP343X_CTRL_REGADDR(SCRATCHPAD_SLEEP_TIME_OFFSET)
> +#define SCRATCHPAD_WKUP_TIME   OMAP343X_CTRL_REGADDR(SCRATCHPAD_WKUP_TIME_OFFSET)
> +#define SCRATCHPAD_WKUP_TIME_P OMAP343X_CTRL_BASE + SCRATCHPAD_WKUP_TIME_OFFSET
> +
> +#define CM_ICLKEN_WKUP OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN)
> +#define CM_ICLKEN_WKUP_P       OMAP3430_CM_BASE + WKUP_MOD + CM_ICLKEN
> +#define CM_IDLEST_WKUP OMAP34XX_CM_REGADDR(WKUP_MOD, CM_IDLEST)
> +#define CM_IDLEST_WKUP_P       OMAP3430_CM_BASE + WKUP_MOD + CM_IDLEST

Same issue, do not use any macros based on OMAP2_L4_IO_ADDRESS 
translation macros.

> +
>           .text
>   /* Function to aquire the semaphore in scratchpad */
>   ENTRY(lock_scratchpad_sem)
> @@ -183,7 +197,31 @@ api_params:
>          .word   0x4, 0x0, 0x0, 0x1, 0x1
>   ENTRY(save_secure_ram_context_sz)
>          .word   . - save_secure_ram_context
> +#ifdef CONFIG_CPU_IDLE_PROF
> +ENTRY(omap3_sram_get_wkup_time)
> +    stmfd   sp!, {lr}     @ save registers on stack

Not needed in your case, you are not using lr in your code.

> +       ldr r0, wkup_time
> +       ldr r0, [r0]
> +    ldmfd   sp!, {pc}     @ restore regs and return

Not needed either.

> +ENTRY(omap3_sram_get_wkup_time_sz)
> +        .word   . - omap3_sram_get_wkup_time
> +
> +ENTRY(omap3_sram_get_sleep_time)
> +    stmfd   sp!, {lr}     @ save registers on stack

Ditto

> +       ldr r0, sleep_time
> +       ldr r0, [r0]
> +    ldmfd   sp!, {pc}     @ restore regs and return

Ditto

> +ENTRY(omap3_sram_get_sleep_time_sz)
> +        .word   . - omap3_sram_get_sleep_time
>
> +ENTRY(omap3_sram_get_32k_tick)
> +    stmfd   sp!, {lr}     @ save registers on stack

Ditto

> +       ldr r0, sync_32k_timer
> +       ldr r0, [r0]
> +    ldmfd   sp!, {pc}     @ restore regs and return

Ditto

> +ENTRY(omap3_sram_get_32k_tick_sz)
> +        .word   . - omap3_sram_get_32k_tick
> +#endif

Why do you need assembly code to do that? Cannot you access directly 
these variable from the C code?

>   /*
>    * Forces OMAP into idle state
>    *
> @@ -207,6 +245,13 @@ loop:
>          cmp     r1, #0x0
>          /* If context save is required, do that and execute wfi */
>          bne     save_context_wfi
> +
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       ldr r4, sync_32k_timer
> +       ldr     r5, [r4]
> +       ldr r6, sleep_time
> +       str r5, [r6]
> +#endif
>          /* Data memory barrier and Data sync barrier */
>          mov     r1, #0
>          mcr     p15, 0, r1, c7, c10, 4
> @@ -224,8 +269,25 @@ loop:
>          nop
>          nop
>          nop
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       ldr r4, iclken_wkup
> +       ldr r5, [r4]
> +       orr r5, r5, #0x4
> +       str r5, [r4]
> +       ldr r4, idlest_wkup
> +wait_idlest:
> +       ldr r5, [r4]
> +       and     r5, r5, #0x4
> +       cmp     r5, #0x0
> +       bne     wait_idlest
> +       ldr r4, sync_32k_timer
> +       ldr     r5, [r4]
> +       ldr r6, wkup_time
> +       str r5, [r6]
> +#endif

What are you trying to do exactly in that case? Could you describe that 
a little bit?

Regards,
Benoit

>          bl wait_sdrc_ok
>
> +
>          ldmfd   sp!, {r0-r12, pc}               @ restore regs and return
>   restore_es3:
>          /*b restore_es3*/               @ Enable to debug restore code
> @@ -247,6 +309,23 @@ copy_to_sram:
>          blx     r1
>   restore:
>          /* b restore*/  @ Enable to debug restore code
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       ldr r4, iclken_wkup_p
> +       ldr r5, [r4]
> +       orr r5, r5, #0x4
> +       str r5, [r4]
> +       ldr r4, idlest_wkup_p
> +wait_idlest1:
> +       ldr r5, [r4]
> +       and     r5, r5, #0x4
> +       cmp     r5, #0x0
> +       bne     wait_idlest1
> +       ldr r4, sync_32k_timer_p
> +       ldr r5, [r4]
> +       ldr r6, wkup_time_p
> +       str r5, [r6]
> +#endif
> +
>           /* Check what was the reason for mpu reset and store the reason in r9*/
>           /* 1 - Only L1 and logic lost */
>           /* 2 - Only L2 lost - In this case, we wont be here */
> @@ -587,6 +666,12 @@ finished:
>          mcr     p15, 2, r10, c0, c0, 0
>          isb
>   skip_l2_inval:
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       ldr r4, sync_32k_timer
> +       ldr     r5, [r4]
> +       ldr r6, sleep_time
> +       str r5, [r6]
> +#endif
>          /* Data memory barrier and Data sync barrier */
>          mov     r1, #0
>          mcr     p15, 0, r1, c7, c10, 4
> @@ -603,6 +688,22 @@ skip_l2_inval:
>          nop
>          nop
>          nop
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       ldr r4, iclken_wkup
> +       ldr r5, [r4]
> +       orr r5, r5, #0x4
> +       str r5, [r4]
> +       ldr r4, idlest_wkup
> +wait_idlest2:
> +       ldr r5, [r4]
> +       and     r5, r5, #0x4
> +       cmp     r5, #0x0
> +       bne     wait_idlest2
> +       ldr r4, sync_32k_timer
> +       ldr     r5, [r4]
> +       ldr r6, wkup_time
> +       str r5, [r6]
> +#endif
>          bl wait_sdrc_ok
>          /* restore regs and return */
>          ldmfd   sp!, {r0-r12, pc}
> @@ -668,5 +769,25 @@ cache_pred_disable_mask:
>          .word   0xFFFFE7FB
>   control_stat:
>          .word   CONTROL_STAT
> +#ifdef CONFIG_CPU_IDLE_PROF
> +sync_32k_timer:
> +       .word TIMER_32K_SYNC
> +sync_32k_timer_p:
> +       .word TIMER_32K_SYNC_P
> +sleep_time:
> +       .word SCRATCHPAD_SLEEP_TIME
> +wkup_time:
> +       .word SCRATCHPAD_WKUP_TIME
> +wkup_time_p:
> +       .word SCRATCHPAD_WKUP_TIME_P
> +iclken_wkup:
> +       .word CM_ICLKEN_WKUP
> +iclken_wkup_p:
> +       .word CM_ICLKEN_WKUP_P
> +idlest_wkup:
> +       .word CM_IDLEST_WKUP
> +idlest_wkup_p:
> +       .word CM_IDLEST_WKUP_P
> +#endif
>   ENTRY(omap34xx_cpu_suspend_sz)
>          .word   . - omap34xx_cpu_suspend
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 7dbc4a8..147456d 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -18,3 +18,8 @@ config CPU_IDLE_GOV_MENU
>          bool
>          depends on CPU_IDLE&&  NO_HZ
>          default y
> +
> +config CPU_IDLE_PROF
> +       bool
> +       depends on CPU_IDLE
> +       default n
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 0310ffa..a3e9db1 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -249,6 +249,11 @@ define_show_state_ull_function(usage)
>   define_show_state_ull_function(time)
>   define_show_state_str_function(name)
>   define_show_state_str_function(desc)
> +#ifdef CONFIG_CPU_IDLE_PROF
> +define_show_state_function(actual_latency)
> +define_show_state_function(sleep_latency)
> +define_show_state_function(wkup_latency)
> +#endif
>
>   define_one_state_ro(name, show_state_name);
>   define_one_state_ro(desc, show_state_desc);
> @@ -256,7 +261,11 @@ define_one_state_ro(latency, show_state_exit_latency);
>   define_one_state_ro(power, show_state_power_usage);
>   define_one_state_ro(usage, show_state_usage);
>   define_one_state_ro(time, show_state_time);
> -
> +#ifdef CONFIG_CPU_IDLE_PROF
> +define_one_state_ro(actual_latency, show_state_actual_latency);
> +define_one_state_ro(sleep_latency, show_state_sleep_latency);
> +define_one_state_ro(wkup_latency, show_state_wkup_latency);
> +#endif
>   static struct attribute *cpuidle_state_default_attrs[] = {
>          &attr_name.attr,
>          &attr_desc.attr,
> @@ -264,6 +273,11 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>          &attr_power.attr,
>          &attr_usage.attr,
>          &attr_time.attr,
> +#ifdef CONFIG_CPU_IDLE_PROF
> +&attr_actual_latency.attr,
> +&attr_sleep_latency.attr,
> +&attr_wkup_latency.attr,
> +#endif
>          NULL
>   };
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 55215cc..6474f6a 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -43,6 +43,9 @@ struct cpuidle_state {
>
>          int (*enter)    (struct cpuidle_device *dev,
>                           struct cpuidle_state *state);
> +#ifdef CONFIG_CPU_IDLE_PROF
> +       u32 actual_latency, sleep_latency, wkup_latency;
> +#endif
>   };
>
>   /* Idle State Flags */
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

