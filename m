From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Thu, 7 May 2009 13:51:25 -0700
Message-ID: <20090507205124.GE5593@atomide.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763207AbZEGUvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:51:33 -0400
Content-Disposition: inline
In-Reply-To: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

One more comment on this patch below.

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090507 00:29]:
> This patch adds SMP platform files support for OMAP4430SDP. TI's OMAP4430
> SOC is based on ARM Cortex-A9 SMP architecture. It's a dual core SOC
> with GIC used for interrupt handling and SCU for cache coherency.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-headsmp.S    |   49 +++++++
>  arch/arm/mach-omap2/omap-smp.c        |  238 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/scu.h |   28 ++++
>  arch/arm/plat-omap/include/mach/smp.h |   56 ++++++++
>  4 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
>  create mode 100644 arch/arm/mach-omap2/omap-smp.c
>  create mode 100644 arch/arm/plat-omap/include/mach/scu.h
>  create mode 100644 arch/arm/plat-omap/include/mach/smp.h
> 

> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> new file mode 100644
> index 0000000..1d18acb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap-smp.c

<snip snip>

> +int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	unsigned long timeout;
> +
> +	/*
> +	 * Set synchronisation state between this boot processor
> +	 * and the secondary one
> +	 */
> +	spin_lock(&boot_lock);
> +
> +	/*
> +	 * The secondary processor is waiting for an event to come out of
> +	 * wfe. Release it, then wait for it to flag that it has been
> +	 * released by resetting cpu_release.
> +	 *
> +	 * Singal the ROM code that the secondary core can be released
> +	 */
> +	cpu_release = cpu;
> +	__raw_writel(cpu, OMAP4_AUXCOREBOOT_REG1);
> +	flush_cache_all();
> +	/*
> +	 * Send a 'sev' to wake the secondary core again because
> +	 * ROM code will put core in WFE till the cpu_release
> +	 * flag is set.
> +	 */
> +	set_event();
> +	mb();
> +
> +	timeout = jiffies + (1 * HZ);
> +	while (time_before(jiffies, timeout)) {
> +		smp_rmb();
> +		if (cpu_release == -1)
> +			break;
> +
> +		udelay(10);
> +	}
> +
> +	/*
> +	 * Now the secondary core is starting up let it run its
> +	 * calibrations, then wait for it to finish
> +	 */
> +	spin_unlock(&boot_lock);
> +
> +	return cpu_release != -1 ? -ENOSYS : 0;
> +}

The "Singal" should be "Signal" above :)

Tony
