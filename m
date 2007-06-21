From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Adding dmtimer support for OMAP3
Date: Wed, 20 Jun 2007 22:14:33 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5134@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

DM timer support for OMAP3. This patch should be applied on top of =
dmtimer pre-patch

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/plat-omap/dmtimer.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lin_for_mmc/arch/arm/plat-omap/dmtimer.c	2007-06-20 =
19:29:54.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/dmtimer.c	2007-06-20 =
19:51:44.000000000 -0500
@@ -70,7 +70,7 @@
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
@@ -78,7 +78,7 @@ struct omap_dm_timer {
 	unsigned enabled:1;
 };
=20
-#ifdef CONFIG_ARCH_OMAP1
+#if defined(CONFIG_ARCH_OMAP1)
=20
 #define omap_dm_clk_enable(x)
 #define omap_dm_clk_disable(x)
@@ -100,6 +100,10 @@ static struct omap_dm_timer omap2_dm_tim
 static const char *omap2_dm_source_names[]	=3D {};
 static struct clk omap2_dm_source_clocks[1];
=20
+static struct clk omap3_dm_source_clocks[1];
+static struct omap_dm_timer omap3_dm_timers[]	=3D {};
+static const char *omap3_dm_source_names[]	=3D {};
+
 #elif defined(CONFIG_ARCH_OMAP2)
=20
 #define omap_dm_clk_enable(x) clk_enable(x)
@@ -129,9 +133,50 @@ static const char *omap2_dm_source_names
 };
=20
 static struct clk *omap2_dm_source_clocks[3];
+
+static struct clk *omap3_dm_source_clocks[1];
+static struct omap_dm_timer omap3_dm_timers[]	=3D {};
+static const char *omap3_dm_source_names[]	=3D {};
+
 static const int dm_timer_count =3D ARRAY_SIZE(omap2_dm_timers);
 static const int dm_source_names_count =3D =
ARRAY_SIZE(omap2_dm_source_names);
=20
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define omap_dm_clk_enable(x) clk_enable(x)
+#define omap_dm_clk_disable(x) clk_disable(x)
+
+static struct clk *omap2_dm_source_clocks[1];
+static struct omap_dm_timer omap1_dm_timers[]	=3D {};
+static struct omap_dm_timer omap2_dm_timers[]	=3D {};
+static const char *omap2_dm_source_names[]	=3D {};
+
+static struct omap_dm_timer omap3_dm_timers[] =3D {
+	{ .phys_base	=3D 0x48318000, .irq	=3D INT_24XX_GPTIMER1 },
+	{ .phys_base	=3D 0x49032000, .irq	=3D INT_24XX_GPTIMER2 },
+	{ .phys_base	=3D 0x49034000, .irq	=3D INT_24XX_GPTIMER3 },
+	{ .phys_base	=3D 0x49036000, .irq	=3D INT_24XX_GPTIMER4 },
+	{ .phys_base	=3D 0x49038000, .irq	=3D INT_24XX_GPTIMER5 },
+	{ .phys_base	=3D 0x4903A000, .irq	=3D INT_24XX_GPTIMER6 },
+	{ .phys_base	=3D 0x4903C000, .irq	=3D INT_24XX_GPTIMER7 },
+	{ .phys_base	=3D 0x4903E000, .irq	=3D INT_24XX_GPTIMER8 },
+	{ .phys_base	=3D 0x49040000, .irq	=3D INT_24XX_GPTIMER9 },
+	{ .phys_base	=3D 0x48086000, .irq	=3D INT_24XX_GPTIMER10 },
+	{ .phys_base	=3D 0x48088000, .irq	=3D INT_24XX_GPTIMER11 },
+	{ .phys_base	=3D 0x48304000, .irq	=3D INT_24XX_GPTIMER12 },
+};
+
+static const char *omap3_dm_source_names[] =3D {
+	"sys_ck",
+	"func_32k_ck",
+	"alt_ck"
+};
+
+static struct clk *omap3_dm_source_clocks[3];
+
+static const int dm_timer_count =3D ARRAY_SIZE(omap3_dm_timers);
+static const int dm_source_names_count =3D =
ARRAY_SIZE(omap3_dm_source_names);
+
 #else
=20
 #error OMAP architecture not supported!
@@ -235,7 +280,6 @@ struct omap_dm_timer *omap_dm_timer_requ
 		dump_stack();
 		return NULL;
 	}
-
 	timer =3D &dm_timers[id-1];
 	timer->reserved =3D 1;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
@@ -312,7 +356,7 @@ __u32 omap_dm_timer_modify_idlect_mask(_
 	return inputmask;
 }
=20
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
=20
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -504,7 +548,7 @@ int omap_dm_timer_init(void)
 	struct omap_dm_timer *timer;
 	int i;
=20
-	if (!(cpu_is_omap16xx() || cpu_is_omap24xx()))
+	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
 		return -ENODEV;
=20
 	spin_lock_init(&dm_timer_lock);
@@ -515,9 +559,13 @@ int omap_dm_timer_init(void)
 		dm_timers =3D omap2_dm_timers;
 		dm_source_names  =3D (unsigned long *) omap2_dm_source_names;
 		dm_source_clocks =3D (unsigned long *) omap2_dm_source_clocks;
+	} else if (cpu_is_omap34xx()) {
+		dm_timers =3D omap3_dm_timers;
+		dm_source_names  =3D (unsigned long *) omap3_dm_source_names;
+		dm_source_clocks =3D (unsigned long *) omap3_dm_source_clocks;
 	}
=20
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	for (i =3D 0; i < dm_source_names_count; i++) {
 		dm_source_clocks[i] =3D (unsigned long)
 			clk_get(NULL, (unsigned char *)dm_source_names[i]);
@@ -528,13 +576,13 @@ int omap_dm_timer_init(void)
 		dm_timers[0].phys_base =3D 0x49018000;
=20
 	for (i =3D 0; i < dm_timer_count; i++) {
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		char clk_name[16];
 #endif
=20
 		timer =3D &dm_timers[i];
 		timer->io_base =3D (void __iomem *) io_p2v(timer->phys_base);
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		sprintf(clk_name, "gpt%d_ick", i + 1);
 		timer->iclk =3D clk_get(NULL, clk_name);
 		sprintf(clk_name, "gpt%d_fck", i + 1);
