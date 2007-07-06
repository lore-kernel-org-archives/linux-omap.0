From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 5/11] Clock updates for OMAP3430
Date: Thu, 5 Jul 2007 23:39:38 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142E61C@dlee13.ent.ti.com>
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

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/clock.c
 arch/arm/mach-omap2/clock.h
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/clock.c =
val_3430_GIT/arch/arm/mach-omap2/clock.c
--- linux-omap/arch/arm/mach-omap2/clock.c	2007-06-21 08:19:03.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/clock.c	2007-07-05 =
18:03:11.000000000 -0500
@@ -58,11 +58,15 @@ static u8 cpu_mask;
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk * clk)
 {
-	u32 div =3D prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
-	/* Test if ext clk divided by 1 or 2 */
-	div &=3D (0x3 << OMAP_SYSCLKDIV_SHIFT);
-	div >>=3D clk->rate_offset;
-	clk->rate =3D (clk->parent->rate / div);
+	u32 div;
+
+	if (!cpu_is_omap34xx()) {
+		div =3D prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+		/* Test if ext clk divided by 1 or 2 */
+		div &=3D (0x3 << OMAP_SYSCLKDIV_SHIFT);
+		div >>=3D clk->rate_offset;
+		clk->rate =3D (clk->parent->rate / div);
+	}
 	propagate_rate(clk);
 }
=20
@@ -1181,7 +1185,7 @@ int __init omap2_clk_init(void)
 			continue;
 		}
=20
-		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
+		if ((*clkp)->flags & CLOCK_IN_OMAP243X && (cpu_is_omap2430() || =
cpu_is_omap34xx())) {
 			clk_register(*clkp);
 			continue;
 		}
diff -purN linux-omap/arch/arm/mach-omap2/clock.h =
val_3430_GIT/arch/arm/mach-omap2/clock.h
--- linux-omap/arch/arm/mach-omap2/clock.h	2007-06-21 08:19:04.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/clock.h	2007-07-05 =
17:09:49.000000000 -0500
@@ -39,6 +39,7 @@ static u32 omap2_clksel_get_divisor(stru
=20
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
+#define RATE_IN_343X	(1 << 2)
=20
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are =
mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
