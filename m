From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU
	bootup
Date: Tue, 30 Nov 2010 23:32:04 +0000
Message-ID: <20101130233204.GB14383@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru> <20101130171658.GA24034@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101130171658.GA24034@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Jamie Iles <jamie.iles@picochip.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 08:16:58PM +0300, Anton Vorontsov wrote:
> +/*
> + * Initialise the CPU possible map early - this describes the CPUs
> + * which may be present or become present in the system.
> + */
> +void __init scu_init_cpus(void __iomem *scu_base)
> +{
> +	unsigned int ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> +	unsigned int i;
> +
> +	/* sanity check */
> +	if (ncores == 0) {
> +		pr_err("%s: strange CM count of 0? Default to 1\n", __func__);
> +		ncores = 1;
> +	}
> +
> +	if (ncores > NR_CPUS) {
> +		pr_warn("%s: no. of cores (%d) greater than configured "
> +		       "maximum of %d - clipping\n", __func__, ncores, NR_CPUS);
> +		ncores = NR_CPUS;
> +	}
> +
> +	for (i = 0; i < ncores; i++)
> +		set_cpu_possible(i, true);
> +}
> +
> +void __init scu_prepare_cpus(void __iomem *scu_base, unsigned int max_cpus)
> +{
> +	unsigned int ncores = num_possible_cpus();
> +	unsigned int cpu = smp_processor_id();
> +	int i;
> +
> +	smp_store_cpu_info(cpu);
> +
> +	/*
> +	 * are we trying to boot more cores than exist?
> +	 */
> +	if (max_cpus > ncores)
> +		max_cpus = ncores;
> +
> +	/*
> +	 * Initialise the present map, which describes the set of CPUs
> +	 * actually populated at the present time.
> +	 */
> +	for (i = 0; i < max_cpus; i++)
> +		set_cpu_present(i, true);
> +
> +	/*
> +	 * Initialise the SCU if there are more than one CPU and let
> +	 * them know where to start.
> +	 */
> +	if (max_cpus > 1) {
> +		/*
> +		 * Enable the local timer or broadcast device for the
> +		 * boot CPU, but only if we have more than one CPU.
> +		 */
> +		percpu_timer_setup();
> +
> +		scu_enable(scu_base);
> +	}
> +}

Note that I'll go with factoring this out into arch/arm/kernel/smp_scu.c
for the time being, but I'm not convinced about the other parts yet.

> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +#if __LINUX_ARM_ARCH__ >= 7
> +	dsb
> +#endif

Another question though - probably for Linus though - why is the u8500
code needing this dsb whereas other ARMv7 implementations don't appear
to require it?
