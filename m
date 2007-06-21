From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Pre-3430 patch for dmtimer.c
Date: Wed, 20 Jun 2007 22:13:33 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5132@dlee13.ent.ti.com>
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

Cleanup DM timer list for OMAP2 and OMAP1

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/plat-omap/dmtimer.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/plat-omap/dmtimer.c	2007-04-04 =
18:13:49.000000000 -0500
+++ lin_for_mmc/arch/arm/plat-omap/dmtimer.c	2007-06-20 =
19:29:54.000000000 -0500
@@ -83,7 +83,7 @@ struct omap_dm_timer {
 #define omap_dm_clk_enable(x)
 #define omap_dm_clk_disable(x)
=20
-static struct omap_dm_timer dm_timers[] =3D {
+static struct omap_dm_timer omap1_dm_timers[] =3D {
 	{ .phys_base =3D 0xfffb1400, .irq =3D INT_1610_GPTIMER1 },
 	{ .phys_base =3D 0xfffb1c00, .irq =3D INT_1610_GPTIMER2 },
 	{ .phys_base =3D 0xfffb2400, .irq =3D INT_1610_GPTIMER3 },
@@ -94,12 +94,20 @@ static struct omap_dm_timer dm_timers[]=20
 	{ .phys_base =3D 0xfffbd400, .irq =3D INT_1610_GPTIMER8 },
 };
=20
+static const int dm_timer_count =3D ARRAY_SIZE(omap1_dm_timers);
+
+static struct omap_dm_timer omap2_dm_timers[]	=3D {};
+static const char *omap2_dm_source_names[]	=3D {};
+static struct clk omap2_dm_source_clocks[1];
+
 #elif defined(CONFIG_ARCH_OMAP2)
=20
 #define omap_dm_clk_enable(x) clk_enable(x)
 #define omap_dm_clk_disable(x) clk_disable(x)
=20
-static struct omap_dm_timer dm_timers[] =3D {
+static struct omap_dm_timer omap1_dm_timers[] =3D {};
+
+static struct omap_dm_timer omap2_dm_timers[] =3D {
 	{ .phys_base =3D 0x48028000, .irq =3D INT_24XX_GPTIMER1 },
 	{ .phys_base =3D 0x4802a000, .irq =3D INT_24XX_GPTIMER2 },
 	{ .phys_base =3D 0x48078000, .irq =3D INT_24XX_GPTIMER3 },
@@ -114,13 +122,15 @@ static struct omap_dm_timer dm_timers[]=20
 	{ .phys_base =3D 0x4808a000, .irq =3D INT_24XX_GPTIMER12 },
 };
=20
-static const char *dm_source_names[] =3D {
+static const char *omap2_dm_source_names[] =3D {
 	"sys_ck",
 	"func_32k_ck",
 	"alt_ck"
 };
=20
-static struct clk *dm_source_clocks[3];
+static struct clk *omap2_dm_source_clocks[3];
+static const int dm_timer_count =3D ARRAY_SIZE(omap2_dm_timers);
+static const int dm_source_names_count =3D =
ARRAY_SIZE(omap2_dm_source_names);
=20
 #else
=20
@@ -128,7 +138,10 @@ static struct clk *dm_source_clocks[3];
=20
 #endif
=20
-static const int dm_timer_count =3D ARRAY_SIZE(dm_timers);
+static struct omap_dm_timer *dm_timers;
+static unsigned long *dm_source_names;
+static unsigned long *dm_source_clocks;
+
 static spinlock_t dm_timer_lock;
=20
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, =
int reg)
@@ -171,7 +184,7 @@ static void omap_dm_timer_reset(struct o
 	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
 	l |=3D 0x02 << 3;
=20
-	if (cpu_class_is_omap2() && timer =3D=3D &dm_timers[0]) {
+	if ((cpu_class_is_omap2()) && (timer =3D=3D &dm_timers[0])) {
 		/* Enable wake-up only for GPT1 on OMAP2 CPUs*/
 		l |=3D 1 << 2;
 		/* Non-posted mode */
@@ -362,7 +375,7 @@ void omap_dm_timer_set_source(struct oma
 		return;
=20
 	clk_disable(timer->fclk);
-	clk_set_parent(timer->fclk, dm_source_clocks[source]);
+	clk_set_parent(timer->fclk, (struct clk *)dm_source_clocks[source]);
 	clk_enable(timer->fclk);
=20
 	/* When the functional clock disappears, too quick writes seem to
@@ -495,10 +508,20 @@ int omap_dm_timer_init(void)
 		return -ENODEV;
=20
 	spin_lock_init(&dm_timer_lock);
+
+	if (cpu_class_is_omap1()) {
+		dm_timers =3D omap1_dm_timers;
+	} else if (cpu_is_omap24xx()) {
+		dm_timers =3D omap2_dm_timers;
+		dm_source_names  =3D (unsigned long *) omap2_dm_source_names;
+		dm_source_clocks =3D (unsigned long *) omap2_dm_source_clocks;
+	}
+
 #ifdef CONFIG_ARCH_OMAP2
-	for (i =3D 0; i < ARRAY_SIZE(dm_source_names); i++) {
-		dm_source_clocks[i] =3D clk_get(NULL, dm_source_names[i]);
-		BUG_ON(dm_source_clocks[i] =3D=3D NULL);
+	for (i =3D 0; i < dm_source_names_count; i++) {
+		dm_source_clocks[i] =3D (unsigned long)
+			clk_get(NULL, (unsigned char *)dm_source_names[i]);
+		BUG_ON((struct clk *)dm_source_clocks[i] =3D=3D NULL);
 	}
 #endif
 	if (cpu_is_omap243x())
