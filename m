From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
Date: Thu, 26 Apr 2012 09:10:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: khilman@ti.com, b-cousson@ti.com, tony@atomide.com, Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

a question

On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:

> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
> 
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
> 
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> So, in order to use option 2, deeper idle state MUST be disabled.
> 
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
> 
> We must support both sync timer and gptimer based clocksource as
> some OMAP based derivative SoCs like AM33XX does not have the
> sync timer.
> 
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
> 
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
> 
> So, the solution is,
> 
> Use standard kernel parameter ("clocksource=") to override
> default 32k_sync-timer, in addition to this, we also use hwmod database
> lookup mechanism, through which at run-time we can identify availability
> of 32k-sync timer on the device, else fall back to gptimer.

...

> -int __init omap_init_clocksource_32k(void)
> +/**
> + * omap_init_clocksource_32k - setup and register counter 32k as a
> + * kernel clocksource
> + * @pbase: base addr of counter_32k module
> + * @size: size of counter_32k to map
> + *
> + * Returns 0 upon success or negative error code upon failure.
> + *
> + */
> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
>  {
> -	static char err[] __initdata = KERN_ERR
> -			"%s: can't register clocksource!\n";
> -
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> -		u32 pbase;
> -		unsigned long size = SZ_4K;
> -		void __iomem *base;
> -		struct clk *sync_32k_ick;
> -
> -		if (cpu_is_omap16xx()) {
> -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> -			size = SZ_1K;
> -		} else if (cpu_is_omap2420())
> -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap2430())
> -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap34xx())
> -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap44xx())
> -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> -		else
> -			return -ENODEV;
> -
> -		/* For this to work we must have a static mapping in io.c for this area */
> -		base = ioremap(pbase, size);
> -		if (!base)
> -			return -ENODEV;
> -
> -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> -		if (!IS_ERR(sync_32k_ick))
> -			clk_enable(sync_32k_ick);
> -
> -		timer_32k_base = base;
> -
> -		/*
> -		 * 120000 rough estimate from the calculations in
> -		 * __clocksource_updatefreq_scale.
> -		 */
> -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> -				32768, NSEC_PER_SEC, 120000);
> -
> -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> -					  clocksource_mmio_readl_up))
> -			printk(err, "32k_counter");
> -
> -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> +	int ret;
> +	void __iomem *base;
> +	struct clk *sync32k_ick;
> +
> +	if (!pbase || !size)
> +		return -ENODEV;
> +	/*
> +	 * For this to work we must have a static mapping in io.c
> +	 * for this area
> +	 */
> +	base = ioremap(pbase, size);
> +	if (!base) {
> +		pr_err("32k_counter: failed to map base addr\n");
> +		return -ENODEV;
>  	}
> -	return 0;
> +
> +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> +	if (!IS_ERR(sync32k_ick))
> +		clk_enable(sync32k_ick);

You've added hwmod data for this IP block, which is good.  This will 
presumably cause the IP block to be idled on boot.  But you haven't 
converted this code to use either the hwmod enable code -- just using 
clk_get() isn't enough.  (Better would be to use a driver and the PM 
runtime functions, of course, but maybe this runs too early?)

If the 32k sync timer is in OCP force-idle, then that might produce the 
hangs you're seeing.


- Paul
