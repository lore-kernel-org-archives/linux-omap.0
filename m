From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Use MMIO clocksource for 32kHz counter
Date: Mon, 27 Jun 2011 12:11:02 -0700
Message-ID: <20110627191102.GV23145@atomide.com>
References: <20110627123315.GB1777@n2100.arm.linux.org.uk>
	<20110627123754.GQ23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110627123754.GQ23145@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110627 05:33]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110627 05:28]:
> > --- a/arch/arm/plat-omap/counter_32k.c
> > +++ b/arch/arm/plat-omap/counter_32k.c
> > +#ifdef CONFIG_ARCH_OMAP16XX
> > +		else if (cpu_is_omap16xx())
> > +			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);

BTW, the above should have been OMAP1_IO_ADDRESS instead..
  
> You should be able to replace the above with just ioremap as we now
> have the static mappings.

..here's a patch to use ioremap with comment added about the static
mapping requirements.

Thanks for getting rid of hopefully the last remaining omap_readl
for omap2+ BTW :)

Tony


--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -106,34 +106,30 @@ int __init omap_init_clocksource_32k(void)
 			"%s: can't register clocksource!\n";
 
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
+		u32 pbase;
+		unsigned long size = SZ_4K;
 		void __iomem *base;
 		struct clk *sync_32k_ick;
 
-		if (0)
-			base = NULL;
-#ifdef CONFIG_ARCH_OMAP16XX
-		else if (cpu_is_omap16xx())
-			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);
-#endif
-#ifdef CONFIG_SOC_OMAP2420
-		else if (cpu_is_omap2420())
-			base = OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x10);
-#endif
-#ifdef CONFIG_SOC_OMAP2430
+		if (cpu_is_omap16xx()) {
+			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
+			size = SZ_1K;
+		} else if (cpu_is_omap2420())
+			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap2430())
-			base = OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x10);
-#endif
-#ifdef CONFIG_ARCH_OMAP3
+			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap34xx())
-			base = OMAP2_L4_IO_ADDRESS(OMAP3430_32KSYNCT_BASE + 0x10);
-#endif
-#ifdef CONFIG_ARCH_OMAP4
+			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap44xx())
-			base = OMAP2_L4_IO_ADDRESS(OMAP4430_32KSYNCT_BASE + 0x10);
-#endif
+			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
 		else
 			return -ENODEV;
 
+		/* For this to work we must have a static mapping in io.c for this area */
+		base = ioremap(pbase, size);
+		if (!base)
+			return -ENODEV;
+
 		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
 		if (!IS_ERR(sync_32k_ick))
 			clk_enable(sync_32k_ick);
