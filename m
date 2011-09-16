From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 23/25] OMAP4: PM: Add CPUidle support
Date: Fri, 16 Sep 2011 10:45:08 -0700
Message-ID: <87k498pejf.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-24-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37379 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754212Ab1IPRpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:45:15 -0400
Received: by yie13 with SMTP id 13so7590025yie.39
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 10:45:13 -0700 (PDT)
In-Reply-To: <1315144466-9395-24-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Add OMAP4 CPUIDLE support. CPU1 is left with defualt idle and
> the low power state for it is managed via cpu-hotplug.
>
> This patch adds MPUSS low power states in cpuidle.
>
> 	C1 - CPU0 ON + CPU1 ON + MPU ON
> 	C2 - CPU0 OFF + CPU1 OFF + MPU CSWR
> 	C3 - CPU0 OFF + CPU1 OFF + MPU OSWR
>
> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
> anymore just like CORE power domain. The deepest state supported is OSWr.
> Ofcourse when MPUSS and CORE PD transitions to OSWR along with device
> off mode, even the memory contemts are lost which is as good as
> the PD off state.
>
> On OMAP4 because of hardware constraints, no low power states are
> targeted when both CPUs are online and in SMP mode. The low power
> states are attempted only when secondary CPU gets offline to OFF
> through hotplug infrastructure.
>
> Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
> C-state latency profiling.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

A handful of minor comments below...

[...]

> +/**
> + * omap4_enter_idle - Programs OMAP4 to enter the specified state
> + * @dev: cpuidle device
> + * @state: The target state to be programmed
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified low power state selected by the governor.
> + * Returns the amount of time spent in the low power state.
> + */
> +static int omap4_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_state *state)
> +{
> +	struct omap4_idle_statedata *cx = cpuidle_get_statedata(state);
> +	struct timespec ts_preidle, ts_postidle, ts_idle;
> +	u32 cpu1_state;
> +
> +	/* Used to keep track of the total time in idle */
> +	getnstimeofday(&ts_preidle);
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	/*
> +	 * Keep demoting CPU0 C-state till CPU1 hits OFF state.

IMO, the working here isn't as clear as it could be.   IOW, I don't like
"keep demoting", which makes it sound iterative through a set of states, 
where what's happening here is a one-time decision.

Rather, what I think you mean is "CPU0 has to stay on (e.g in C1) until
CPU1 is off."

> +	 * This is necessary to honour hardware recommondation
> +	 * of triggeing all the possible low power modes once CPU1 is
> +	 * out of coherency and in OFF mode.
> +	 * Update dev->last_state so that governor stats reflects right
> +	 * data.
> +	 */
> +	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
> +	if (cpu1_state != PWRDM_POWER_OFF) {
> +		dev->last_state = dev->safe_state;
> +		cx = cpuidle_get_statedata(dev->safe_state);
> +	}
> +
> +	/* Call idle CPU PM enter notifier chain */

This comment doesn't add any value over the code.  If anything, a
comment explaining why it's only there for off-mode transitions would be
helpful.

> +	if (cx->cpu_state == PWRDM_POWER_OFF)
> +		cpu_pm_enter();

I think the CPU PM notifier usage should probably be a separate patch.

> +	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> +	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> +
> +	/* Call idle CPU cluster PM enter notifier chain */
> +	if ((cx->mpu_state == PWRDM_POWER_RET) &&
> +		(cx->mpu_logic_state == PWRDM_POWER_OFF))
> +			cpu_cluster_pm_enter();
> +
> +	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
> +
> +	/* Call idle CPU PM exit notifier chain */

As above, this comment doesn't add any value over the code.

While I understand why it's only done for CPU0 here (CPU1 is managed by
hotplug), we should anticipating the moment where we will have forgotten
why it's only done for CPU0, and add a comment here.

> +	if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
> +		cpu_pm_exit();
> +
> +	/* Call idle CPU cluster PM exit notifier chain */

again, comment not helpful

> +	if (omap4_mpuss_read_prev_context_state())
> +		cpu_cluster_pm_exit();
> +
> +	getnstimeofday(&ts_postidle);
> +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> +
> +	local_irq_enable();
> +	local_fiq_enable();
> +
> +	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
> +}
> +
> +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +
> +struct cpuidle_driver omap4_idle_driver = {
> +	.name =		"omap4_idle",
> +	.owner =	THIS_MODULE,
> +};
> +
> +/* Fill in the state data from the mach tables and register the driver_data */

if documented, it should have a kerneldoc header instead

> +static inline struct omap4_idle_statedata *_fill_cstate(
> +					struct cpuidle_device *dev,
> +					int idx, const char *descr)
> +{
> +	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
> +	struct cpuidle_state *state = &dev->states[idx];
> +
> +	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
> +	state->target_residency	= cpuidle_params_table[idx].target_residency;
> +	state->flags		= CPUIDLE_FLAG_TIME_VALID;
> +	state->enter		= omap4_enter_idle;
> +	cx->valid		= cpuidle_params_table[idx].valid;
> +	sprintf(state->name, "C%d", idx + 1);
> +	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
> +	cpuidle_set_statedata(state, cx);
> +
> +	return cx;
> +}

Kevin
