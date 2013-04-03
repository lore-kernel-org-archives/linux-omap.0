From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 17/18] ARM: OMAP4+: CPUidle: Add OMAP5 idle driver support
Date: Wed, 03 Apr 2013 14:25:05 -0700
Message-ID: <87fvz7qpce.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-18-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63764 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760497Ab3DCVZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 17:25:08 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1073459pdc.14
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 14:25:08 -0700 (PDT)
In-Reply-To: <1364205910-32392-18-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The OMAP5 idle driver can re-use OMAP4 CPUidle driver implementation thanks
> to compatible MPUSS design.
>
> Though unlike OMAP4, on OMAP5 devices, MPUSS CSWR (Close Switch
> Retention) power states can be achieved with respective power states
> on CPU0 and CPU1 power domain. This mode was broken on OMAP4 devices
> because of hardware limitation.

I'm a bit confused by the description here.

I gather from the code that this means that CPU0 and CPU1 can hit CSWR
independently, correct?

> Also there is no CPU low power entry order requirement like
> master CPU etc for CSWR C-state, which is icing on the cake. 

Even on secure devices?

> Code makes use of voting scheme for cluster low power state to support
> MPUSS CSWR C-state.

The voting scheme and associated locking should be better described
here, or commented in the code itself.

> Supported OMAP5 CPUidle C-states:
>         C1 - CPU0 ON(WFI) + CPU1 ON(WFI) + MPUSS ON
>         C2 - CPU0 CSWR + CPU1 CSWR + MPUSS CSWR
>         C3 - CPU0 OFF + CPU1 OFF + MPUSS OSWR
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			int index)
> +{
> +	struct idle_statedata *cx = state_ptr + index;
> +	int cpu_id = smp_processor_id();
> +	unsigned long flag;
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);

I think the CPUidle core handles the broadcast notification now.

> +	raw_spin_lock_irqsave(&mpu_lock, flag);
> +	cx->mpu_state_vote++;

How about using an atomic_t and atomic_inc()/atomic_dec() instead, which
will avoid the need for a spinlock.

Even with that, it still seems potentially racy.  Do you need a memory
barrier here to be sure that any changes from another CPU are visible
here, and vice versa?

> +	if (cx->mpu_state_vote == num_online_cpus()) {
> +		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> +		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> +	}
> +	raw_spin_unlock_irqrestore(&mpu_lock, flag);
> +
> +	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
> +
> +	raw_spin_lock_irqsave(&mpu_lock, flag);
> +	if (cx->mpu_state_vote == num_online_cpus())
> +		omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
> +	cx->mpu_state_vote--;
> +	raw_spin_unlock_irqrestore(&mpu_lock, flag);
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
> +
> +	return index;
> +}

Kevin
