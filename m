From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc3-omap] gpio object shrinkage, cleanup
Date: Thu, 26 Oct 2006 21:45:05 -0700
Message-ID: <200610262145.05672.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

More GPIO/IRQ cleanup:

  - compile-time removal of much useless code
      * mpuio support on non-OMAP1.
      * 15xx/730/24xx gpio support on 1610
      * 15xx/730/16xx gpio support on 24xx
      * etc

  - remove all BUG() calls, which are always bad news ... replaced some
    with normal fault reports for that call, others with WARN_ON(1).

  - small mpuio bugfix:  add missing set_type() method

Oh, and fix a minor merge issue: inode->u.generic_ip is now gone.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

-----
... yeah, this is all incidental to some eventual wakeup fixes that
should among other things let MPUIO pins be wake sources, but until
OSK boots in the OMAP tree again, I can't test any of that!!

Index: h4/arch/arm/plat-omap/gpio.c
===================================================================
--- h4.orig/arch/arm/plat-omap/gpio.c	2006-10-25 21:50:50.000000000 -0700
+++ h4/arch/arm/plat-omap/gpio.c	2006-10-26 21:34:58.000000000 -0700
@@ -268,21 +268,34 @@ static void _set_gpio_direction(struct g
 	u32 l;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_IO_CNTL;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_DIR_CONTROL;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_DIRECTION;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DIR_CONTROL;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
+#endif
+	default:
+		WARN_ON(1);
+		return;
 	}
 	l = __raw_readl(reg);
 	if (is_input)
@@ -310,6 +323,7 @@ static void _set_gpio_dataout(struct gpi
 	u32 l = 0;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_OUTPUT;
 		l = __raw_readl(reg);
@@ -318,6 +332,8 @@ static void _set_gpio_dataout(struct gpi
 		else
 			l &= ~(1 << gpio);
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_DATA_OUTPUT;
 		l = __raw_readl(reg);
@@ -326,6 +342,8 @@ static void _set_gpio_dataout(struct gpi
 		else
 			l &= ~(1 << gpio);
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		if (enable)
 			reg += OMAP1610_GPIO_SET_DATAOUT;
@@ -333,6 +351,8 @@ static void _set_gpio_dataout(struct gpi
 			reg += OMAP1610_GPIO_CLEAR_DATAOUT;
 		l = 1 << gpio;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DATA_OUTPUT;
 		l = __raw_readl(reg);
@@ -341,6 +361,8 @@ static void _set_gpio_dataout(struct gpi
 		else
 			l &= ~(1 << gpio);
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -348,8 +370,9 @@ static void _set_gpio_dataout(struct gpi
 			reg += OMAP24XX_GPIO_CLEARDATAOUT;
 		l = 1 << gpio;
 		break;
+#endif
 	default:
-		BUG();
+		WARN_ON(1);
 		return;
 	}
 	__raw_writel(l, reg);
@@ -373,28 +396,37 @@ int omap_get_gpio_datain(int gpio)
 	void __iomem *reg;
 
 	if (check_gpio(gpio) < 0)
-		return -1;
+		return -EINVAL;
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_INPUT_LATCH;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_DATA_INPUT;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_DATAIN;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DATA_INPUT;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
+#endif
 	default:
-		BUG();
-		return -1;
+		return -EINVAL;
 	}
 	return (__raw_readl(reg)
 			& (1 << get_gpio_index(gpio))) != 0;
@@ -444,6 +476,7 @@ static int _set_gpio_triggering(struct g
 	u32 l = 0;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_INT_EDGE;
 		l = __raw_readl(reg);
@@ -454,6 +487,8 @@ static int _set_gpio_triggering(struct g
 		else
 			goto bad;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
@@ -464,6 +499,7 @@ static int _set_gpio_triggering(struct g
 		else
 			goto bad;
 		break;
+#endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		if (gpio & 0x08)
@@ -471,9 +507,6 @@ static int _set_gpio_triggering(struct g
 		else
 			reg += OMAP1610_GPIO_EDGE_CTRL1;
 		gpio &= 0x07;
-		/* We allow only edge triggering, i.e. two lowest bits */
-		if (trigger & (__IRQT_LOWLVL | __IRQT_HIGHLVL))
-			BUG();
 		l = __raw_readl(reg);
 		l &= ~(3 << (gpio << 1));
 		if (trigger & __IRQT_RISEDGE)
@@ -505,7 +538,6 @@ static int _set_gpio_triggering(struct g
 		break;
 #endif
 	default:
-		BUG();
 		goto bad;
 	}
 	__raw_writel(l, reg);
@@ -520,7 +552,7 @@ static int gpio_irq_type(unsigned irq, u
 	unsigned gpio;
 	int retval;
 
-	if (irq > IH_MPUIO_BASE)
+	if (!cpu_is_omap24xx() && irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
 	else
 		gpio = irq - IH_GPIO_BASE;
@@ -528,9 +560,12 @@ static int gpio_irq_type(unsigned irq, u
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
 
-	if (type & IRQT_PROBE)
+	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
-	if (!cpu_is_omap24xx() && (type & (__IRQT_LOWLVL|__IRQT_HIGHLVL)))
+
+	/* OMAP1 allows only only edge triggering */
+	if (!cpu_is_omap24xx()
+			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
 	bank = get_gpio_bank(gpio);
@@ -549,24 +584,34 @@ static void _clear_gpio_irqbank(struct g
 	void __iomem *reg = bank->base;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		/* MPUIO irqstatus is reset by reading the status register,
 		 * so do nothing here */
 		return;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_STATUS;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQSTATUS1;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_STATUS;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
+#endif
 	default:
-		BUG();
+		WARN_ON(1);
 		return;
 	}
 	__raw_writel(gpio_mask, reg);
@@ -589,31 +634,41 @@ static u32 _get_gpio_irqbank_mask(struct
 	u32 mask;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
 		mask = 0xffff;
 		inv = 1;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
 		mask = 0xffff;
 		inv = 1;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQENABLE1;
 		mask = 0xffff;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
 		mask = 0xffffffff;
 		inv = 1;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
 		break;
+#endif
 	default:
-		BUG();
+		WARN_ON(1);
 		return 0;
 	}
 
@@ -630,6 +685,7 @@ static void _enable_gpio_irqbank(struct 
 	u32 l;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
 		l = __raw_readl(reg);
@@ -638,6 +694,8 @@ static void _enable_gpio_irqbank(struct 
 		else
 			l |= gpio_mask;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
 		l = __raw_readl(reg);
@@ -646,6 +704,8 @@ static void _enable_gpio_irqbank(struct 
 		else
 			l |= gpio_mask;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		if (enable)
 			reg += OMAP1610_GPIO_SET_IRQENABLE1;
@@ -653,6 +713,8 @@ static void _enable_gpio_irqbank(struct 
 			reg += OMAP1610_GPIO_CLEAR_IRQENABLE1;
 		l = gpio_mask;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
 		l = __raw_readl(reg);
@@ -661,6 +723,8 @@ static void _enable_gpio_irqbank(struct 
 		else
 			l |= gpio_mask;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -668,8 +732,9 @@ static void _enable_gpio_irqbank(struct 
 			reg += OMAP24XX_GPIO_CLEARIRQENABLE1;
 		l = gpio_mask;
 		break;
+#endif
 	default:
-		BUG();
+		WARN_ON(1);
 		return;
 	}
 	__raw_writel(l, reg);
@@ -838,8 +903,10 @@ static void gpio_irq_handler(unsigned in
 	desc->chip->ack(irq);
 
 	bank = get_irq_data(irq);
+#ifdef CONFIG_ARCH_OMAP1
 	if (bank->method == METHOD_MPUIO)
 		isr_reg = bank->base + OMAP_MPUIO_GPIO_INT;
+#endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510)
 		isr_reg = bank->base + OMAP1510_GPIO_INT_STATUS;
@@ -985,6 +1052,22 @@ static void gpio_unmask_irq(unsigned int
 	_set_gpio_irqenable(bank, gpio_idx, 1);
 }
 
+static struct irq_chip gpio_irq_chip = {
+	.name		= "GPIO",
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
+#ifdef CONFIG_ARCH_OMAP1
+
+/* MPUIO uses the always-on 32k clock */
+
 static void mpuio_ack_irq(unsigned int irq)
 {
 	/* The ISR is reset automatically, so do nothing here. */
@@ -1006,22 +1089,26 @@ static void mpuio_unmask_irq(unsigned in
 	_set_gpio_irqenable(bank, gpio, 1);
 }
 
-static struct irq_chip gpio_irq_chip = {
-	.name		= "GPIO",
-	.shutdown	= gpio_irq_shutdown,
-	.ack		= gpio_ack_irq,
-	.mask		= gpio_mask_irq,
-	.unmask		= gpio_unmask_irq,
+static struct irq_chip mpuio_irq_chip = {
+	.name		= "MPUIO",
+	.ack		= mpuio_ack_irq,
+	.mask		= mpuio_mask_irq,
+	.unmask		= mpuio_unmask_irq
 	.set_type	= gpio_irq_type,
-	.set_wake	= gpio_wake_enable,
 };
 
-static struct irq_chip mpuio_irq_chip = {
-	.name	= "MPUIO",
-	.ack	= mpuio_ack_irq,
-	.mask	= mpuio_mask_irq,
-	.unmask	= mpuio_unmask_irq
-};
+
+#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
+
+#else
+
+extern struct irq_chip mpuio_irq_chip;
+
+#define bank_is_mpuio(bank)	0
+
+#endif
+
+/*---------------------------------------------------------------------*/
 
 static int initialized;
 static struct clk * gpio_ick;
@@ -1097,9 +1184,8 @@ static int __init _omap_gpio_init(void)
 		bank->reserved_map = 0;
 		bank->base = IO_ADDRESS(bank->base);
 		spin_lock_init(&bank->lock);
-		if (bank->method == METHOD_MPUIO) {
+		if (bank_is_mpuio(bank))
 			omap_writew(0xFFFF, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_MASKIT);
-		}
 #ifdef CONFIG_ARCH_OMAP15XX
 		if (bank->method == METHOD_GPIO_1510) {
 			__raw_writew(0xffff, bank->base + OMAP1510_GPIO_INT_MASK);
@@ -1140,7 +1226,7 @@ static int __init _omap_gpio_init(void)
 #endif
 		for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + gpio_count; j++) {
-			if (bank->method == METHOD_MPUIO)
+			if (bank_is_mpuio(bank))
 				set_irq_chip(j, &mpuio_irq_chip);
 			else
 				set_irq_chip(j, &gpio_irq_chip);
@@ -1180,16 +1266,20 @@ static int omap_gpio_suspend(struct sys_
 		void __iomem *wake_set;
 
 		switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP16XX
 		case METHOD_GPIO_1610:
 			wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
 			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
+#endif
 		default:
 			continue;
 		}
@@ -1217,14 +1307,18 @@ static int omap_gpio_resume(struct sys_d
 		void __iomem *wake_set;
 
 		switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP16XX
 		case METHOD_GPIO_1610:
 			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
+#endif
 		default:
 			continue;
 		}
@@ -1404,7 +1498,7 @@ static int dbg_gpio_show(struct seq_file
 		unsigned		bankwidth = 16;
 		u32			mask = 1;
 
-		if (!cpu_is_omap24xx() && bank->method == METHOD_MPUIO)
+		if (bank_is_mpuio(bank))
 			gpio = OMAP_MPUIO(0);
 		else if (cpu_is_omap24xx() || cpu_is_omap730())
 			bankwidth = 32;
@@ -1419,7 +1513,7 @@ static int dbg_gpio_show(struct seq_file
 			value = omap_get_gpio_datain(gpio);
 			is_in = gpio_is_input(bank, mask);
 
-			if (!cpu_is_omap24xx() && bank->method == METHOD_MPUIO)
+			if (bank_is_mpuio(bank))
 				seq_printf(s, "MPUIO %2d: ", j);
 			else
 				seq_printf(s, "GPIO %3d: ", gpio);
@@ -1460,7 +1554,7 @@ static int dbg_gpio_show(struct seq_file
 			seq_printf(s, "\n");
 		}
 
-		if (!cpu_is_omap24xx() && bank->method == METHOD_MPUIO) {
+		if (bank_is_mpuio(bank)) {
 			seq_printf(s, "\n");
 			gpio = 0;
 		}
@@ -1470,7 +1564,7 @@ static int dbg_gpio_show(struct seq_file
 
 static int dbg_gpio_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, dbg_gpio_show, inode->u.generic_ip/*i_private*/);
+	return single_open(file, dbg_gpio_show, &inode->i_private);
 }
 
 static const struct file_operations debug_fops = {
@@ -1482,7 +1576,8 @@ static const struct file_operations debu
 
 static int __init omap_gpio_debuginit(void)
 {
-	(void) debugfs_create_file("omap_gpio", S_IRUGO, NULL, NULL, &debug_fops);
+	(void) debugfs_create_file("omap_gpio", S_IRUGO,
+				   NULL, NULL, &debug_fops);
 	return 0;
 }
 late_initcall(omap_gpio_debuginit);
