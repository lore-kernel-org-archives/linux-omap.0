From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/14] omap: Use ioremap in gpio.c
Date: Sun, 18 Oct 2009 17:19:12 -0700
Message-ID: <20091019001911.GL12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost> <20091016234104.2463.54276.stgit@localhost> <20091017081004.GA648@n2100.arm.linux.org.uk> <20091017161347.GJ12576@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57908 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZJSATY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Oct 2009 20:19:24 -0400
Content-Disposition: inline
In-Reply-To: <20091017161347.GJ12576@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091017 09:14]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [091017 01:10]:
> > On Fri, Oct 16, 2009 at 04:41:04PM -0700, Tony Lindgren wrote:
> > > +	{ OMAP1_MPUIO_VBASE, 0, INT_MPUIO, IH_MPUIO_BASE,
> > 
> > That 0 should be NULL - it's a pointer.
> 
> Right, thanks, will update.

Here's this one updated.

Tony

--jq0ap7NbKX2Kqbes
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpio-ioremap-v2.patch"

>From db6d20507b61d75534a9a36d34b41356c1de710c Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 16 Oct 2009 15:55:09 -0700
Subject: [PATCH] omap: Use ioremap in gpio.c

Use ioremap in gpio.c

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b0c7361..7c753c3 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -45,10 +45,10 @@
 /*
  * OMAP1610 specific GPIO registers
  */
-#define OMAP1610_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbe400)
-#define OMAP1610_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbec00)
-#define OMAP1610_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbb400)
-#define OMAP1610_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbbc00)
+#define OMAP1610_GPIO1_BASE		0xfffbe400
+#define OMAP1610_GPIO2_BASE		0xfffbec00
+#define OMAP1610_GPIO3_BASE		0xfffbb400
+#define OMAP1610_GPIO4_BASE		0xfffbbc00
 #define OMAP1610_GPIO_REVISION		0x0000
 #define OMAP1610_GPIO_SYSCONFIG		0x0010
 #define OMAP1610_GPIO_SYSSTATUS		0x0014
@@ -70,12 +70,12 @@
 /*
  * OMAP7XX specific GPIO registers
  */
-#define OMAP7XX_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
-#define OMAP7XX_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
-#define OMAP7XX_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
-#define OMAP7XX_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
-#define OMAP7XX_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
-#define OMAP7XX_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
+#define OMAP7XX_GPIO1_BASE		0xfffbc000
+#define OMAP7XX_GPIO2_BASE		0xfffbc800
+#define OMAP7XX_GPIO3_BASE		0xfffbd000
+#define OMAP7XX_GPIO4_BASE		0xfffbd800
+#define OMAP7XX_GPIO5_BASE		0xfffbe000
+#define OMAP7XX_GPIO6_BASE		0xfffbe800
 #define OMAP7XX_GPIO_DATA_INPUT		0x00
 #define OMAP7XX_GPIO_DATA_OUTPUT	0x04
 #define OMAP7XX_GPIO_DIR_CONTROL	0x08
@@ -83,21 +83,21 @@
 #define OMAP7XX_GPIO_INT_MASK		0x10
 #define OMAP7XX_GPIO_INT_STATUS		0x14
 
-#define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE)
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 
 /*
  * omap24xx specific GPIO registers
  */
-#define OMAP242X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48018000)
-#define OMAP242X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4801a000)
-#define OMAP242X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x4801c000)
-#define OMAP242X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x4801e000)
+#define OMAP242X_GPIO1_BASE		0x48018000
+#define OMAP242X_GPIO2_BASE		0x4801a000
+#define OMAP242X_GPIO3_BASE		0x4801c000
+#define OMAP242X_GPIO4_BASE		0x4801e000
 
-#define OMAP243X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x4900C000)
-#define OMAP243X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4900E000)
-#define OMAP243X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49010000)
-#define OMAP243X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49012000)
-#define OMAP243X_GPIO5_BASE		OMAP2_IO_ADDRESS(0x480B6000)
+#define OMAP243X_GPIO1_BASE		0x4900C000
+#define OMAP243X_GPIO2_BASE		0x4900E000
+#define OMAP243X_GPIO3_BASE		0x49010000
+#define OMAP243X_GPIO4_BASE		0x49012000
+#define OMAP243X_GPIO5_BASE		0x480B6000
 
 #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
@@ -154,24 +154,25 @@
  * omap34xx specific GPIO registers
  */
 
-#define OMAP34XX_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48310000)
-#define OMAP34XX_GPIO2_BASE		OMAP2_IO_ADDRESS(0x49050000)
-#define OMAP34XX_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49052000)
-#define OMAP34XX_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49054000)
-#define OMAP34XX_GPIO5_BASE		OMAP2_IO_ADDRESS(0x49056000)
-#define OMAP34XX_GPIO6_BASE		OMAP2_IO_ADDRESS(0x49058000)
+#define OMAP34XX_GPIO1_BASE		0x48310000
+#define OMAP34XX_GPIO2_BASE		0x49050000
+#define OMAP34XX_GPIO3_BASE		0x49052000
+#define OMAP34XX_GPIO4_BASE		0x49054000
+#define OMAP34XX_GPIO5_BASE		0x49056000
+#define OMAP34XX_GPIO6_BASE		0x49058000
 
 /*
  * OMAP44XX  specific GPIO registers
  */
-#define OMAP44XX_GPIO1_BASE             OMAP2_IO_ADDRESS(0x4a310000)
-#define OMAP44XX_GPIO2_BASE             OMAP2_IO_ADDRESS(0x48055000)
-#define OMAP44XX_GPIO3_BASE             OMAP2_IO_ADDRESS(0x48057000)
-#define OMAP44XX_GPIO4_BASE             OMAP2_IO_ADDRESS(0x48059000)
-#define OMAP44XX_GPIO5_BASE             OMAP2_IO_ADDRESS(0x4805B000)
-#define OMAP44XX_GPIO6_BASE             OMAP2_IO_ADDRESS(0x4805D000)
+#define OMAP44XX_GPIO1_BASE             0x4a310000
+#define OMAP44XX_GPIO2_BASE             0x48055000
+#define OMAP44XX_GPIO3_BASE             0x48057000
+#define OMAP44XX_GPIO4_BASE             0x48059000
+#define OMAP44XX_GPIO5_BASE             0x4805B000
+#define OMAP44XX_GPIO6_BASE             0x4805D000
 
 struct gpio_bank {
+	unsigned long pbase;
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
@@ -204,77 +205,106 @@ struct gpio_bank {
 
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
-	{ OMAP1_MPUIO_VBASE,    INT_MPUIO,	    IH_MPUIO_BASE,     METHOD_MPUIO},
-	{ OMAP1610_GPIO1_BASE, INT_GPIO_BANK1,	    IH_GPIO_BASE,      METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO2_BASE, INT_1610_GPIO_BANK2, IH_GPIO_BASE + 16, METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO3_BASE, INT_1610_GPIO_BANK3, IH_GPIO_BASE + 32, METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO4_BASE, INT_1610_GPIO_BANK4, IH_GPIO_BASE + 48, METHOD_GPIO_1610 },
+	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP1610_GPIO1_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO2_BASE, NULL, INT_1610_GPIO_BANK2, IH_GPIO_BASE + 16,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO3_BASE, NULL, INT_1610_GPIO_BANK3, IH_GPIO_BASE + 32,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO4_BASE, NULL, INT_1610_GPIO_BANK4, IH_GPIO_BASE + 48,
+		METHOD_GPIO_1610 },
 };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct gpio_bank gpio_bank_1510[2] = {
-	{ OMAP1_MPUIO_VBASE,   INT_MPUIO,      IH_MPUIO_BASE, METHOD_MPUIO },
-	{ OMAP1510_GPIO_BASE, INT_GPIO_BANK1, IH_GPIO_BASE,  METHOD_GPIO_1510 }
+	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP1510_GPIO_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_1510 }
 };
 #endif
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 static struct gpio_bank gpio_bank_7xx[7] = {
-	{ OMAP1_MPUIO_VBASE,    INT_7XX_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
-	{ OMAP7XX_GPIO1_BASE,  INT_7XX_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO2_BASE,  INT_7XX_GPIO_BANK2,  IH_GPIO_BASE + 32,	METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO3_BASE,  INT_7XX_GPIO_BANK3,  IH_GPIO_BASE + 64,	METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO4_BASE,  INT_7XX_GPIO_BANK4,  IH_GPIO_BASE + 96,	METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO5_BASE,  INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128, METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO6_BASE,  INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160, METHOD_GPIO_7XX },
+	{ OMAP1_MPUIO_VBASE, NULL, INT_7XX_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP7XX_GPIO1_BASE, NULL, INT_7XX_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO2_BASE, NULL, INT_7XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO3_BASE, NULL, INT_7XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO4_BASE, NULL, INT_7XX_GPIO_BANK4,  IH_GPIO_BASE + 96,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO5_BASE, NULL, INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO6_BASE, NULL, INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
+		METHOD_GPIO_7XX },
 };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP24XX
 
 static struct gpio_bank gpio_bank_242x[4] = {
-	{ OMAP242X_GPIO1_BASE, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,	METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO2_BASE, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,	METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO3_BASE, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,	METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO4_BASE, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,	METHOD_GPIO_24XX },
+	{ OMAP242X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_24XX },
+	{ OMAP242X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+		METHOD_GPIO_24XX },
+	{ OMAP242X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+		METHOD_GPIO_24XX },
+	{ OMAP242X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,
+		METHOD_GPIO_24XX },
 };
 
 static struct gpio_bank gpio_bank_243x[5] = {
-	{ OMAP243X_GPIO1_BASE, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,	METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO2_BASE, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,	METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO3_BASE, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,	METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO4_BASE, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,	METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO5_BASE, INT_24XX_GPIO_BANK5, IH_GPIO_BASE + 128, METHOD_GPIO_24XX },
+	{ OMAP243X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_24XX },
+	{ OMAP243X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+		METHOD_GPIO_24XX },
+	{ OMAP243X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+		METHOD_GPIO_24XX },
+	{ OMAP243X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,
+		METHOD_GPIO_24XX },
+	{ OMAP243X_GPIO5_BASE, NULL, INT_24XX_GPIO_BANK5, IH_GPIO_BASE + 128,
+		METHOD_GPIO_24XX },
 };
 
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
 static struct gpio_bank gpio_bank_34xx[6] = {
-	{ OMAP34XX_GPIO1_BASE, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,	METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO2_BASE, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,	METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO3_BASE, INT_34XX_GPIO_BANK3, IH_GPIO_BASE + 64,	METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO4_BASE, INT_34XX_GPIO_BANK4, IH_GPIO_BASE + 96,	METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO5_BASE, INT_34XX_GPIO_BANK5, IH_GPIO_BASE + 128, METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO6_BASE, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160, METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO2_BASE, NULL, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+		METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO3_BASE, NULL, INT_34XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+		METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO4_BASE, NULL, INT_34XX_GPIO_BANK4, IH_GPIO_BASE + 96,
+		METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO5_BASE, NULL, INT_34XX_GPIO_BANK5, IH_GPIO_BASE + 128,
+		METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO6_BASE, NULL, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160,
+		METHOD_GPIO_24XX },
 };
 
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct gpio_bank gpio_bank_44xx[6] = {
-	{ OMAP44XX_GPIO1_BASE, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,	\
+	{ OMAP44XX_GPIO1_BASE, NULL, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,
 		METHOD_GPIO_24XX },
-	{ OMAP44XX_GPIO2_BASE, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,	\
+	{ OMAP44XX_GPIO2_BASE, NULL, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,
 		METHOD_GPIO_24XX },
-	{ OMAP44XX_GPIO3_BASE, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,	\
+	{ OMAP44XX_GPIO3_BASE, NULL, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,
 		METHOD_GPIO_24XX },
-	{ OMAP44XX_GPIO4_BASE, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,	\
+	{ OMAP44XX_GPIO4_BASE, NULL, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,
 		METHOD_GPIO_24XX },
-	{ OMAP44XX_GPIO5_BASE, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128, \
+	{ OMAP44XX_GPIO5_BASE, NULL, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128,
 		METHOD_GPIO_24XX },
-	{ OMAP44XX_GPIO6_BASE, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160, \
+	{ OMAP44XX_GPIO6_BASE, NULL, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160,
 		METHOD_GPIO_24XX },
 };
 
@@ -1511,6 +1541,23 @@ static struct clk * gpio5_fck;
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
+static void __init omap_gpio_show_rev(void)
+{
+	u32 rev;
+
+	if (cpu_is_omap16xx())
+		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
+	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+	else if (cpu_is_omap44xx())
+		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
+	else
+		return;
+
+	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
+		(rev >> 4) & 0x0f, rev & 0x0f);
+}
+
 /* This lock class tells lockdep that GPIO irqs are in a different
  * category than their parents, so it won't report false recursion.
  */
@@ -1521,6 +1568,7 @@ static int __init _omap_gpio_init(void)
 	int i;
 	int gpio = 0;
 	struct gpio_bank *bank;
+	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
 	char clk_name[11];
 
 	initialized = 1;
@@ -1583,69 +1631,45 @@ static int __init _omap_gpio_init(void)
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
-		printk(KERN_INFO "OMAP1510 GPIO hardware\n");
 		gpio_bank_count = 2;
 		gpio_bank = gpio_bank_1510;
+		bank_size = SZ_2K;
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	if (cpu_is_omap16xx()) {
-		u32 rev;
-
 		gpio_bank_count = 5;
 		gpio_bank = gpio_bank_1610;
-		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
-		printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
-		       (rev >> 4) & 0x0f, rev & 0x0f);
+		bank_size = SZ_2K;
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
-		printk(KERN_INFO "OMAP7XX GPIO hardware\n");
 		gpio_bank_count = 7;
 		gpio_bank = gpio_bank_7xx;
+		bank_size = SZ_2K;
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
 	if (cpu_is_omap242x()) {
-		int rev;
-
 		gpio_bank_count = 4;
 		gpio_bank = gpio_bank_242x;
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
-		printk(KERN_INFO "OMAP242x GPIO hardware version %d.%d\n",
-			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 	if (cpu_is_omap243x()) {
-		int rev;
-
 		gpio_bank_count = 5;
 		gpio_bank = gpio_bank_243x;
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
-		printk(KERN_INFO "OMAP243x GPIO hardware version %d.%d\n",
-			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP34XX
 	if (cpu_is_omap34xx()) {
-		int rev;
-
 		gpio_bank_count = OMAP34XX_NR_GPIOS;
 		gpio_bank = gpio_bank_34xx;
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
-		printk(KERN_INFO "OMAP34xx GPIO hardware version %d.%d\n",
-			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	if (cpu_is_omap44xx()) {
-		int rev;
-
 		gpio_bank_count = OMAP34XX_NR_GPIOS;
 		gpio_bank = gpio_bank_44xx;
-		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
-		printk(KERN_INFO "OMAP44xx GPIO hardware version %d.%d\n",
-			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
 	for (i = 0; i < gpio_bank_count; i++) {
@@ -1653,6 +1677,14 @@ static int __init _omap_gpio_init(void)
 
 		bank = &gpio_bank[i];
 		spin_lock_init(&bank->lock);
+
+		/* Static mapping, never released */
+		bank->base = ioremap(bank->pbase, bank_size);
+		if (!bank->base) {
+			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
+			continue;
+		}
+
 		if (bank_is_mpuio(bank))
 			__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
 		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
@@ -1758,6 +1790,8 @@ static int __init _omap_gpio_init(void)
 	if (cpu_is_omap34xx())
 		omap_writel(1 << 0, 0x48306814);
 
+	omap_gpio_show_rev();
+
 	return 0;
 }
 

--jq0ap7NbKX2Kqbes--
