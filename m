From: Nishanth Menon <nm@ti.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Tue, 9 Dec 2014 10:57:46 -0600
Message-ID: <20141209165746.GA29935@kahuna>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5481D9BF.2090007@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10:13-20141205, Nishanth Menon wrote:
> On 12/05/2014 10:10 AM, Nishanth Menon wrote:
> > next-20141204 fails to boot, but next-20141203 boots fine with
> > omap2plus_defconfig.
> > 
> > Panda-ES(4460):
> > https://github.com/nmenon/kernel-test-logs/blob/next-20141204/omap2plus_defconfig/pandaboard-es.txt
> > Panda(4430):
> > https://github.com/nmenon/kernel-test-logs/blob/next-20141204/omap2plus_defconfig/pandaboard-vanilla.txt
> > 
> > at the point of hang (JTAG):
> >  pandaboard-es:
> > 	cpu0: http://slexy.org/view/s2eIFqkRd5
> > 	cpu1: http://slexy.org/view/s2Tysb6gpL
> > 
> > Case #1:
> > Disabling CPUIDLE allows boot to proceed. there does not seem to have
> > been any change in drivers/cpuidle and arch/arm/mach-omap2 w.r.t this.
> > 
> > Case #2: Reverting the following allows boot.
> > 
> > From next-20141204
> > 10df7d5 ARM: 8211/1: l2c: Add support for overriding prefetch settings
> > revert this  -> boot still fails
> > 
> > d42ced0 ARM: 8210/1: l2c: Get outer cache .write_sec callback from
> > mach_desc only if not NULL
> > revert this  -> boot still fails
> > 
> > 46b9af8 ARM: 8209/1: l2c: Add interface to ask hypervisor to configure L2C
> > revert this  -> boot still fails
> > 
> > c94e325 ARM: 8208/1: l2c: Refactor the driver to use commit-like
> > revert this  -> boot passed (first bad commit).
> > 
> > 
> 
> + linux-samsung soc and updated Thomaz's mail ID (gmail now).

Spend a few mins trying to track this down and it does look like commit
c94e325 does a kmemdup for the data as part of l2x0_of_init->__l2c_init

This fails since the invocation is in early_init. doing it a bit later
as the following hack makes it work
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 608079a..0bc6bd9 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -170,12 +170,19 @@ static const char *const omap4_boards_compat[] __initconst = {
 	NULL,
 };
 
+
+static void tmp_init_irq(void)
+{
+	omap_l2_cache_init();
+	omap_gic_of_init();
+}
+
 DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
-	.init_irq	= omap_gic_of_init,
+	.init_irq	= tmp_init_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
 	.init_time	= omap4_local_timer_init,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 03cbb16..f97847d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -627,7 +627,6 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_l2_cache_init();
 	omap_clk_soc_init = omap4xxx_dt_clk_init;
 }
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e5948c5..0ca90db 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -848,8 +848,11 @@ static int __init __l2c_init(const struct l2c_init_data *data,
 	 * context from callers can access the structure.
 	 */
 	l2x0_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
-	if (!l2x0_data)
+	if (!l2x0_data) {
+		pr_err("%s no mem %d\n", __func__, sizeof(*data));
+		dump_stack();
 		return -ENOMEM;
+	}
 
 	/*
 	 * Sanity check the aux values.  aux_mask is the bits we preserve
@@ -1647,6 +1650,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	struct device_node *np;
 	struct resource res;
 	u32 cache_id, old_aux;
+	int r;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1693,6 +1697,8 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	else
 		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 
-	return __l2c_init(data, aux_val, aux_mask, cache_id);
+	r = __l2c_init(data, aux_val, aux_mask, cache_id);
+	pr_err("%s: %d\n", __func__, r);
+	return r;
 }

-- 
Regards,
Nishanth Menon
