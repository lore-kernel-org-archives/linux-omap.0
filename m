From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Wed, 30 Aug 2006 01:22:13 -0700
Message-ID: <200608300122.14254.david-b@pacbell.net>
References: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
	<200608291251.57807.david-b@pacbell.net>
	<20060830075733.GH27668@atomide.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2qU9EhOJoLtyVpH"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060830075733.GH27668@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_2qU9EhOJoLtyVpH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 30 August 2006 12:57 am, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [060829 22:52]:
> > On Tuesday 29 August 2006 7:34 am, Tony Lindgren wrote:
> > > 
> > > Sounds like it should be capable of waking up the system if 32KHz clock
> > > is on and the wake-up events are configured properly.
> > 
> > Yes.  I had more of a look at things, and have a patch (yet to be tested)
> > that should let many more things be wakeup event sources.  MPUIO irqs,
> > GPIOs not in the first bank, non-MPUI/GPIO irqs (like RTC), etc.
> 
> Cool. 

hmm, not sure when I'll have a chance to test it, so here it is...

--Boundary-00=_2qU9EhOJoLtyVpH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake.patch"

Handle wakeup irqs more correctly and completely ... the set of wakeup
events is dynmically specified, not statically, and any IRQ is eligible.

 - (PLATFORM) Add/use MPUIO/ARMIO wakeup event handling, as for GPIO.

 - (PLATFORM) Enabling a GPIO or MPUIO irq as a wakeup event source
   automatically enables its parent MPU L1 or L2 IRQ; this is easy
   now that wakeup enables/disables are properly refcounted.

 - (OMAP1) Move pm wakeup event setup from pm.c into irq.c so that it can
   obey driver {en,dis}able_irq_wake() calls ... so now any L1 or L2
   IRQ source can be a wakeup event, not just a small static group.
   
 - (OMAP1) Only L1->L2 cascades are always marked as wakeup sources.

This means that drivers can now use /sys/devices/.../power/wakeup userspace
configuration for board-specific policies about activating wakeup sources.

UNTESTED.

TODO:  Various drivers, notably the keypad driver, need to learn about
being device_can_wakeup() and {en,dis}able_irq_wake().



Index: osk2/arch/arm/plat-omap/gpio.c
===================================================================
--- osk2.orig/arch/arm/plat-omap/gpio.c	2006-08-29 09:02:28.000000000 -0700
+++ osk2/arch/arm/plat-omap/gpio.c	2006-08-29 09:15:37.000000000 -0700
@@ -646,13 +646,17 @@ static inline void _set_gpio_irqenable(s
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
 	switch (bank->method) {
+	case METHOD_MPUIO:
 	case METHOD_GPIO_1610:
 	case METHOD_GPIO_24XX:
 		spin_lock(&bank->lock);
-		if (enable)
+		if (enable) {
 			bank->suspend_wakeup |= (1 << gpio);
-		else
+			enable_irq_wake(bank->irq);
+		} else {
 			bank->suspend_wakeup &= ~(1 << gpio);
+			disable_irq_wake(bank->irq);
+		}
 		spin_unlock(&bank->lock);
 		return 0;
 	default:
@@ -945,6 +949,21 @@ static void gpio_unmask_irq(unsigned int
 	_set_gpio_irqenable(bank, gpio_idx, 1);
 }
 
+static struct irq_chip gpio_irq_chip = {
+	.name		= "GPIO",
+	.startup	= gpio_irq_startup,
+	.shutdown	= gpio_irq_shutdown,
+	.ack		= gpio_ack_irq,
+	.mask		= gpio_mask_irq,
+	.unmask		= gpio_unmask_irq,
+	.set_type	= gpio_irq_type,
+	.set_wake	= gpio_wake_enable,
+};
+
+/*---------------------------------------------------------------------*/
+
+#ifndef	CONFIG_ARCH_OMAP24XX
+
 static void mpuio_ack_irq(unsigned int irq)
 {
 	/* The ISR is reset automatically, so do nothing here. */
@@ -966,24 +985,46 @@ static void mpuio_unmask_irq(unsigned in
 	_set_gpio_irqenable(bank, gpio, 1);
 }
 
-static struct irq_chip gpio_irq_chip = {
-	.name		= "GPIO",
-	.startup	= gpio_irq_startup,
-	.shutdown	= gpio_irq_shutdown,
-	.ack		= gpio_ack_irq,
-	.mask		= gpio_mask_irq,
-	.unmask		= gpio_unmask_irq,
-	.set_type	= gpio_irq_type,
+static struct irq_chip mpuio_irq_chip = {
+	.name		= "MPUIO",
+	.ack		= mpuio_ack_irq,
+	.mask		= mpuio_mask_irq,
+	.unmask		= mpuio_unmask_irq,
 	.set_wake	= gpio_wake_enable,
 };
 
-static struct irq_chip mpuio_irq_chip = {
-	.name	= "MPUIO",
-	.ack	= mpuio_ack_irq,
-	.mask	= mpuio_mask_irq,
-	.unmask	= mpuio_unmask_irq
+static int omap_mpuio_suspend(struct sys_device *dev, pm_message_t mesg)
+{
+	void __iomem	*reg = gpio_bank[0].base + OMAP_MPUIO_GPIO_MASKIT;
+
+	gpio_bank[0].saved_wakeup = __raw_readw(reg);
+	__raw_writew(~gpio_bank[0].suspend_wakeup, reg);
+	return 0;
+}
+
+static int omap_mpuio_resume(struct sys_device *dev)
+{
+	void __iomem	*reg = gpio_bank[0].base + OMAP_MPUIO_GPIO_MASKIT;
+
+	__raw_writew(gpio_bank[0].saved_wakeup, reg);
+	return 0;
+}
+
+static struct sysdev_class omap_mpuio_sysclass = {
+	set_kset_name("mpuio"),
+	.suspend	= omap_mpuio_suspend,
+	.resume		= omap_mpuio_resume,
+};
+
+static struct sys_device omap_mpuio_device = {
+	.id		= 0,
+	.cls		= &omap_mpuio_sysclass,
 };
 
+#endif
+
+/*---------------------------------------------------------------------*/
+
 static int initialized;
 static struct clk * gpio_ick;
 static struct clk * gpio_fck;
@@ -1215,6 +1256,14 @@ static int __init omap_gpio_sysinit(void
 	if (!initialized)
 		ret = _omap_gpio_init();
 
+#ifndef	CONFIG_ARCH_OMAP24XX
+	if (ret == 0) {
+		ret = sysdev_class_register(&omap_mpuio_sysclass);
+		if (ret == 0)
+			ret = sysdev_register(&omap_mpuio_device);
+	}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX)
 	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (ret == 0) {
Index: osk2/arch/arm/mach-omap1/irq.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/irq.c	2006-08-29 09:02:27.000000000 -0700
+++ osk2/arch/arm/mach-omap1/irq.c	2006-08-29 09:08:38.000000000 -0700
@@ -118,6 +118,39 @@ static int omap_wake_irq(unsigned int ir
 	return 0;
 }
 
+#ifdef	CONFIG_PM
+
+/* enable_irq_wake() calls from drivers will normally be configured
+ * based on /sys/devices/.../power/wakeup settings, for drivers that
+ * that support wakeup events.
+ */
+void omap_pm_wakeup_setup(void)
+{
+	/* MPU level 1 controller ... take driver settings, plus
+	 * L1->L2 cascade ... GPIO and MPUIO handled via sysdev
+	 */
+	omap_writel(~irq_banks[0].wake_enable, OMAP_IH1_MIR);
+
+	/* MPU level 2 controller ... take driver settings, plus for
+	 * omap730 and omap16xx peripheral wakeup (enabled by irq setup)
+	 */
+	omap_writel(~irq_banks[1].wake_enable, OMAP_IH2_0_MIR);
+
+	if (cpu_is_omap730()) {
+		omap_writel(~irq_banks[1].wake_enable, OMAP_IH2_1_MIR);
+	}
+	if (cpu_is_omap16xx()) {
+		omap_writel(~irq_banks[1].wake_enable, OMAP_IH2_1_MIR);
+		omap_writel(~irq_banks[3].wake_enable, OMAP_IH2_2_MIR);
+		omap_writel(~irq_banks[4].wake_enable, OMAP_IH2_3_MIR);
+	}
+
+	/* New IRQ agreement, recalculate in cascade order */
+	omap_writel(1, OMAP_IH2_CONTROL);
+	omap_writel(1, OMAP_IH1_CONTROL);
+}
+
+#endif	/* PM */
 
 /*
  * Allows tuning the IRQ type and priority
@@ -184,12 +217,17 @@ void __init omap_init_irq(void)
 	if (cpu_is_omap730()) {
 		irq_banks = omap730_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap730_irq_banks);
+
+		omap_wake_irq(INT_730_IH2_IRQ, 1);
+		omap_wake_irq(INT_730_WAKE_UP_REQ, 1);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		irq_banks = omap1510_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1510_irq_banks);
+
+		omap_wake_irq(INT_1510_IH2_IRQ, 1);
 	}
 	if (cpu_is_omap310()) {
 		irq_banks = omap310_irq_banks;
@@ -200,6 +238,9 @@ void __init omap_init_irq(void)
 	if (cpu_is_omap16xx()) {
 		irq_banks = omap1610_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1610_irq_banks);
+
+		omap_wake_irq(INT_1610_IH2_IRQ, 1);
+		omap_wake_irq(INT_1610_WAKE_UP_REQ, 1);
 	}
 #endif
 	printk("Total of %i interrupts in %i interrupt banks\n",
Index: osk2/arch/arm/mach-omap1/pm.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/pm.c	2006-08-29 09:02:27.000000000 -0700
+++ osk2/arch/arm/mach-omap1/pm.c	2006-08-29 09:08:38.000000000 -0700
@@ -187,57 +187,8 @@ void omap_pm_idle(void)
 	local_irq_enable();
 }
 
-/*
- * Configuration of the wakeup event is board specific. For the
- * moment we put it into this helper function. Later it may move
- * to board specific files.
- */
-static void omap_pm_wakeup_setup(void)
-{
-	u32 level1_wake = 0;
-	u32 level2_wake = OMAP_IRQ_BIT(INT_UART2);
-
-	/*
-	 * Turn off all interrupts except GPIO bank 1, L1-2nd level cascade,
-	 * and the L2 wakeup interrupts: keypad and UART2. Note that the
-	 * drivers must still separately call omap_set_gpio_wakeup() to
-	 * wake up to a GPIO interrupt.
-	 */
-	if (cpu_is_omap730())
-		level1_wake = OMAP_IRQ_BIT(INT_730_GPIO_BANK1) |
-			OMAP_IRQ_BIT(INT_730_IH2_IRQ);
-	else if (cpu_is_omap15xx())
-		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
-			OMAP_IRQ_BIT(INT_1510_IH2_IRQ);
-	else if (cpu_is_omap16xx())
-		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
-			OMAP_IRQ_BIT(INT_1610_IH2_IRQ);
-
-	omap_writel(~level1_wake, OMAP_IH1_MIR);
-
-	if (cpu_is_omap730()) {
-		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
-		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
-				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
-				OMAP_IH2_1_MIR);
-	} else if (cpu_is_omap15xx()) {
-		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
-		omap_writel(~level2_wake,  OMAP_IH2_MIR);
-	} else if (cpu_is_omap16xx()) {
-		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
-		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
-
-		/* INT_1610_WAKE_UP_REQ is needed for GPIO wakeup... */
-		omap_writel(~OMAP_IRQ_BIT(INT_1610_WAKE_UP_REQ),
-			    OMAP_IH2_1_MIR);
-		omap_writel(~0x0, OMAP_IH2_2_MIR);
-		omap_writel(~0x0, OMAP_IH2_3_MIR);
-	}
+extern void omap_pm_wakeup_setup(void);
 
-	/*  New IRQ agreement, recalculate in cascade order */
-	omap_writel(1, OMAP_IH2_CONTROL);
-	omap_writel(1, OMAP_IH1_CONTROL);
-}
 
 #define EN_DSPCK	13	/* ARM_CKCTL */
 #define EN_APICK	6	/* ARM_IDLECT2 */

--Boundary-00=_2qU9EhOJoLtyVpH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_2qU9EhOJoLtyVpH--
