From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/11] OMAP hwmod: add hwmod class support
Date: Mon, 22 Feb 2010 21:50:50 -0700
Message-ID: <20100223045048.18888.52038.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60260 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0BWE5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:39 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add support for categorizing and iterating over hardware IP blocks by
the "class" of the IP block.  The class is the type of the IP block:
e.g., "timer", "timer1ms", etc.  Move the OCP_SYSCONFIG/SYSSTATUS data
from the struct omap_hwmod into the struct omap_hwmod_class, since
it's expected to stay consistent for each class.  While here, fix some
comments.

The hwmod_class structures in this patch were designed and proposed by
Beno=C3=AEt Cousson <b-cousson@ti.com> and were refined in a discussion
between Thara Gopinath <thara@ti.com>, Kevin Hilman
<khilman@deeprootsystems.com>, and myself.

This patch uses WARN() lines that are longer than 80 characters, as
Kevin noted a broader lkml consensus to increase greppability by
keeping the messages all on one line.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile                 |    7 -
 arch/arm/mach-omap2/omap_hwmod.c             |  222 ++++++++++++++++--=
--------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    7 +
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   24 +++
 arch/arm/mach-omap2/omap_hwmod_common_data.h |   24 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   37 +++-
 8 files changed, 234 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 4aa621d..162294e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,15 +5,16 @@
 # Common support
 obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-g=
p.o
=20
-omap-2-3-common				=3D irq.o sdrc.o omap_hwmod.o \
+omap-2-3-common				=3D irq.o sdrc.o
+hwmod-common				=3D omap_hwmod.o \
 					  omap_hwmod_common_data.o
 prcm-common				=3D prcm.o powerdomain.o
 clock-common				=3D clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
=20
-obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common)
-obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(hwmo=
d-common)
+obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(hwmo=
d-common)
 obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 501660a..c664947 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -84,17 +84,16 @@ static u8 inited;
  */
 static int _update_sysc_cache(struct omap_hwmod *oh)
 {
-	if (!oh->sysconfig) {
-		WARN(!oh->sysconfig, "omap_hwmod: %s: cannot read "
-		     "OCP_SYSCONFIG: not defined on hwmod\n", oh->name);
+	if (!oh->class->sysc) {
+		WARN(1, "omap_hwmod: %s: cannot read OCP_SYSCONFIG: not defined on h=
wmod's class\n", oh->name);
 		return -EINVAL;
 	}
=20
 	/* XXX ensure module interface clock is up */
=20
-	oh->_sysc_cache =3D omap_hwmod_readl(oh, oh->sysconfig->sysc_offs);
+	oh->_sysc_cache =3D omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
=20
-	if (!(oh->sysconfig->sysc_flags & SYSC_NO_CACHE))
+	if (!(oh->class->sysc->sysc_flags & SYSC_NO_CACHE))
 		oh->_int_flags |=3D _HWMOD_SYSCONFIG_LOADED;
=20
 	return 0;
@@ -105,14 +104,13 @@ static int _update_sysc_cache(struct omap_hwmod *=
oh)
  * @v: OCP_SYSCONFIG value to write
  * @oh: struct omap_hwmod *
  *
- * Write @v into the module OCP_SYSCONFIG register, if it has one.  No
- * return value.
+ * Write @v into the module class' OCP_SYSCONFIG register, if it has
+ * one.  No return value.
  */
 static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 {
-	if (!oh->sysconfig) {
-		WARN(!oh->sysconfig, "omap_hwmod: %s: cannot write "
-		     "OCP_SYSCONFIG: not defined on hwmod\n", oh->name);
+	if (!oh->class->sysc) {
+		WARN(1, "omap_hwmod: %s: cannot write OCP_SYSCONFIG: not defined on =
hwmod's class\n", oh->name);
 		return;
 	}
=20
@@ -120,7 +118,7 @@ static void _write_sysconfig(u32 v, struct omap_hwm=
od *oh)
=20
 	if (oh->_sysc_cache !=3D v) {
 		oh->_sysc_cache =3D v;
-		omap_hwmod_writel(v, oh, oh->sysconfig->sysc_offs);
+		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
 	}
 }
=20
@@ -140,17 +138,16 @@ static int _set_master_standbymode(struct omap_hw=
mod *oh, u8 standbymode,
 	u32 mstandby_mask;
 	u8 mstandby_shift;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_MIDLEMODE))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	mstandby_shift =3D oh->sysconfig->sysc_fields->midle_shift;
+	mstandby_shift =3D oh->class->sysc->sysc_fields->midle_shift;
 	mstandby_mask =3D (0x3 << mstandby_shift);
=20
 	*v &=3D ~mstandby_mask;
@@ -174,17 +171,16 @@ static int _set_slave_idlemode(struct omap_hwmod =
*oh, u8 idlemode, u32 *v)
 	u32 sidle_mask;
 	u8 sidle_shift;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SIDLEMODE))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	sidle_shift =3D oh->sysconfig->sysc_fields->sidle_shift;
+	sidle_shift =3D oh->class->sysc->sysc_fields->sidle_shift;
 	sidle_mask =3D (0x3 << sidle_shift);
=20
 	*v &=3D ~sidle_mask;
@@ -209,17 +205,16 @@ static int _set_clockactivity(struct omap_hwmod *=
oh, u8 clockact, u32 *v)
 	u32 clkact_mask;
 	u8  clkact_shift;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	clkact_shift =3D oh->sysconfig->sysc_fields->clkact_shift;
+	clkact_shift =3D oh->class->sysc->sysc_fields->clkact_shift;
 	clkact_mask =3D (0x3 << clkact_shift);
=20
 	*v &=3D ~clkact_mask;
@@ -240,17 +235,16 @@ static int _set_softreset(struct omap_hwmod *oh, =
u32 *v)
 {
 	u32 softrst_mask;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	softrst_mask =3D (0x1 << oh->sysconfig->sysc_fields->srst_shift);
+	softrst_mask =3D (0x1 << oh->class->sysc->sysc_fields->srst_shift);
=20
 	*v |=3D softrst_mask;
=20
@@ -276,17 +270,16 @@ static int _set_module_autoidle(struct omap_hwmod=
 *oh, u8 autoidle,
 	u32 autoidle_mask;
 	u8 autoidle_shift;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_AUTOIDLE))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	autoidle_shift =3D oh->sysconfig->sysc_fields->autoidle_shift;
+	autoidle_shift =3D oh->class->sysc->sysc_fields->autoidle_shift;
 	autoidle_mask =3D (0x3 << autoidle_shift);
=20
 	*v &=3D ~autoidle_mask;
@@ -306,17 +299,16 @@ static int _enable_wakeup(struct omap_hwmod *oh)
 {
 	u32 v, wakeup_mask;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	wakeup_mask =3D (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+	wakeup_mask =3D (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
=20
 	v =3D oh->_sysc_cache;
 	v |=3D wakeup_mask;
@@ -340,17 +332,16 @@ static int _disable_wakeup(struct omap_hwmod *oh)
 {
 	u32 v, wakeup_mask;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
-	if (!oh->sysconfig->sysc_fields) {
-		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
-			"sysconfig not provided!\n");
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in=
 class\n", oh->name);
 		return -EINVAL;
 	}
=20
-	wakeup_mask =3D (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+	wakeup_mask =3D (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
=20
 	v =3D oh->_sysc_cache;
 	v &=3D ~wakeup_mask;
@@ -638,27 +629,28 @@ static void __iomem *_find_mpu_rt_base(struct oma=
p_hwmod *oh, u8 index)
  */
 static void _sysc_enable(struct omap_hwmod *oh)
 {
-	u8 idlemode;
+	u8 idlemode, sf;
 	u32 v;
=20
-	if (!oh->sysconfig)
+	if (!oh->class->sysc)
 		return;
=20
 	v =3D oh->_sysc_cache;
+	sf =3D oh->class->sysc->sysc_flags;
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE) {
+	if (sf & SYSC_HAS_SIDLEMODE) {
 		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
 			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE) {
+	if (sf & SYSC_HAS_MIDLEMODE) {
 		idlemode =3D (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
 			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
 		_set_master_standbymode(oh, idlemode, &v);
 	}
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE) {
+	if (sf & SYSC_HAS_AUTOIDLE) {
 		idlemode =3D (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
 			0 : 1;
 		_set_module_autoidle(oh, idlemode, &v);
@@ -671,9 +663,9 @@ static void _sysc_enable(struct omap_hwmod *oh)
 	 * calling into this code.  But this must wait until the
 	 * clock structures are tagged with omap_hwmod entries
 	 */
-	if (oh->flags & HWMOD_SET_DEFAULT_CLOCKACT &&
-	    oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY)
-		_set_clockactivity(oh, oh->sysconfig->clockact, &v);
+	if ((oh->flags & HWMOD_SET_DEFAULT_CLOCKACT) &&
+	    (sf & SYSC_HAS_CLOCKACTIVITY))
+		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
=20
 	_write_sysconfig(v, oh);
 }
@@ -689,21 +681,22 @@ static void _sysc_enable(struct omap_hwmod *oh)
  */
 static void _sysc_idle(struct omap_hwmod *oh)
 {
-	u8 idlemode;
+	u8 idlemode, sf;
 	u32 v;
=20
-	if (!oh->sysconfig)
+	if (!oh->class->sysc)
 		return;
=20
 	v =3D oh->_sysc_cache;
+	sf =3D oh->class->sysc->sysc_flags;
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE) {
+	if (sf & SYSC_HAS_SIDLEMODE) {
 		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
 			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE) {
+	if (sf & SYSC_HAS_MIDLEMODE) {
 		idlemode =3D (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
 			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
 		_set_master_standbymode(oh, idlemode, &v);
@@ -722,19 +715,21 @@ static void _sysc_idle(struct omap_hwmod *oh)
 static void _sysc_shutdown(struct omap_hwmod *oh)
 {
 	u32 v;
+	u8 sf;
=20
-	if (!oh->sysconfig)
+	if (!oh->class->sysc)
 		return;
=20
 	v =3D oh->_sysc_cache;
+	sf =3D oh->class->sysc->sysc_flags;
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE)
+	if (sf & SYSC_HAS_SIDLEMODE)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_FORCE, &v);
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE)
+	if (sf & SYSC_HAS_MIDLEMODE)
 		_set_master_standbymode(oh, HWMOD_IDLEMODE_FORCE, &v);
=20
-	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE)
+	if (sf & SYSC_HAS_AUTOIDLE)
 		_set_module_autoidle(oh, 1, &v);
=20
 	_write_sysconfig(v, oh);
@@ -851,9 +846,9 @@ static int _reset(struct omap_hwmod *oh)
 	u32 r, v;
 	int c =3D 0;
=20
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET) ||
-	    (oh->sysconfig->sysc_flags & SYSS_MISSING))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET) ||
+	    (oh->class->sysc->sysc_flags & SYSS_MISSING))
 		return -EINVAL;
=20
 	/* clocks must be on for this operation */
@@ -871,7 +866,7 @@ static int _reset(struct omap_hwmod *oh)
 		return r;
 	_write_sysconfig(v, oh);
=20
-	omap_test_timeout((omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+	omap_test_timeout((omap_hwmod_readl(oh, oh->class->sysc->syss_offs) &
 			   SYSS_RESETDONE_MASK),
 			  MAX_MODULE_RESET_WAIT, c);
=20
@@ -917,7 +912,7 @@ static int _enable(struct omap_hwmod *oh)
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
=20
-	if (oh->sysconfig) {
+	if (oh->class->sysc) {
 		if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
 			_update_sysc_cache(oh);
 		_sysc_enable(oh);
@@ -948,7 +943,7 @@ static int _idle(struct omap_hwmod *oh)
=20
 	pr_debug("omap_hwmod: %s: idling\n", oh->name);
=20
-	if (oh->sysconfig)
+	if (oh->class->sysc)
 		_sysc_idle(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
@@ -978,7 +973,7 @@ static int _shutdown(struct omap_hwmod *oh)
=20
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
=20
-	if (oh->sysconfig)
+	if (oh->class->sysc)
 		_sysc_shutdown(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	/* XXX what about the other system initiators here? DMA, tesla, d2d *=
/
@@ -1038,7 +1033,7 @@ static int _setup(struct omap_hwmod *oh)
 		 * _enable() function should be split to avoid the
 		 * rewrite of the OCP_SYSCONFIG register.
 		 */
-		if (oh->sysconfig) {
+		if (oh->class->sysc) {
 			_update_sysc_cache(oh);
 			_sysc_enable(oh);
 		}
@@ -1085,9 +1080,12 @@ int omap_hwmod_set_slave_idlemode(struct omap_hw=
mod *oh, u8 idlemode)
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Registers the omap_hwmod @oh.  Returns -EEXIST if an omap_hwmod alr=
eady
- * has been registered by the same name; -EINVAL if the omap_hwmod is =
in the
- * wrong state, or 0 on success.
+ * Registers the omap_hwmod @oh.  Returns -EEXIST if an omap_hwmod
+ * already has been registered by the same name; -EINVAL if the
+ * omap_hwmod is in the wrong state, if @oh is NULL, if the
+ * omap_hwmod's class field is NULL; if the omap_hwmod is missing a
+ * name, or if the omap_hwmod's class is missing a name; or 0 upon
+ * success.
  *
  * XXX The data should be copied into bootmem, so the original data
  * should be marked __initdata and freed after init.  This would allow
@@ -1099,7 +1097,8 @@ int omap_hwmod_register(struct omap_hwmod *oh)
 {
 	int ret, ms_id;
=20
-	if (!oh || (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
+	if (!oh || !oh->name || !oh->class || !oh->class->name ||
+	    (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
 		return -EINVAL;
=20
 	mutex_lock(&omap_hwmod_mutex);
@@ -1372,7 +1371,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh=
)
 {
 	BUG_ON(!oh);
=20
-	if (!oh->sysconfig || !oh->sysconfig->sysc_flags) {
+	if (!oh->class->sysc || !oh->class->sysc->sysc_flags) {
 		WARN(1, "omap_device: %s: OCP barrier impossible due to "
 		      "device configuration\n", oh->name);
 		return;
@@ -1382,7 +1381,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh=
)
 	 * Forces posted writes to complete on the OCP thread handling
 	 * register writes
 	 */
-	omap_hwmod_readl(oh, oh->sysconfig->sysc_offs);
+	omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
 }
=20
 /**
@@ -1575,8 +1574,8 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmo=
d *oh,
  */
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 {
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
 	mutex_lock(&omap_hwmod_mutex);
@@ -1600,8 +1599,8 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *o=
h)
  */
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 {
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
 	mutex_lock(&omap_hwmod_mutex);
@@ -1610,3 +1609,52 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod =
*oh)
=20
 	return 0;
 }
+
+/**
+ * omap_hwmod_for_each_by_class - call @fn for each hwmod of class @cl=
assname
+ * @classname: struct omap_hwmod_class name to search for
+ * @fn: callback function pointer to call for each hwmod in class @cla=
ssname
+ * @user: arbitrary context data to pass to the callback function
+ *
+ * For each omap_hwmod of class @classname, call @fn.  Takes
+ * omap_hwmod_mutex to prevent the hwmod list from changing during the
+ * iteration.  If the callback function returns something other than
+ * zero, the iterator is terminated, and the callback function's retur=
n
+ * value is passed back to the caller.  Returns 0 upon success, -EINVA=
L
+ * if @classname or @fn are NULL, or passes back the error code from @=
fn.
+ */
+int omap_hwmod_for_each_by_class(const char *classname,
+				 int (*fn)(struct omap_hwmod *oh,
+					   void *user),
+				 void *user)
+{
+	struct omap_hwmod *temp_oh;
+	int ret =3D 0;
+
+	if (!classname || !fn)
+		return -EINVAL;
+
+	pr_debug("omap_hwmod: %s: looking for modules of class %s\n",
+		 __func__, classname);
+
+	mutex_lock(&omap_hwmod_mutex);
+
+	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
+		if (!strcmp(temp_oh->class->name, classname)) {
+			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
+				 __func__, temp_oh->name);
+			ret =3D (*fn)(temp_oh, user);
+			if (ret)
+				break;
+		}
+	}
+
+	mutex_unlock(&omap_hwmod_mutex);
+
+	if (ret)
+		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
+			 __func__, ret);
+
+	return ret;
+}
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index a1c5839..eb7ee24 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,6 +16,8 @@
 #include <plat/cpu.h>
 #include <plat/dma.h>
=20
+#include "omap_hwmod_common_data.h"
+
 #include "prm-regbits-24xx.h"
=20
 /*
@@ -58,6 +60,7 @@ static struct omap_hwmod_ocp_if *omap2420_l3_masters[=
] =3D {
 /* L3 */
 static struct omap_hwmod omap2420_l3_hwmod =3D {
 	.name		=3D "l3_hwmod",
+	.class		=3D &l3_hwmod_class,
 	.masters	=3D omap2420_l3_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2420_l3_masters),
 	.slaves		=3D omap2420_l3_slaves,
@@ -87,6 +90,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_mas=
ters[] =3D {
 /* L4 CORE */
 static struct omap_hwmod omap2420_l4_core_hwmod =3D {
 	.name		=3D "l4_core_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap2420_l4_core_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2420_l4_core_masters),
 	.slaves		=3D omap2420_l4_core_slaves,
@@ -106,6 +110,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_wkup_m=
asters[] =3D {
 /* L4 WKUP */
 static struct omap_hwmod omap2420_l4_wkup_hwmod =3D {
 	.name		=3D "l4_wkup_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap2420_l4_wkup_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2420_l4_wkup_masters),
 	.slaves		=3D omap2420_l4_wkup_slaves,
@@ -121,6 +126,7 @@ static struct omap_hwmod_ocp_if *omap2420_mpu_maste=
rs[] =3D {
 /* MPU */
 static struct omap_hwmod omap2420_mpu_hwmod =3D {
 	.name		=3D "mpu_hwmod",
+	.class		=3D &mpu_hwmod_class,
 	.main_clk	=3D "mpu_ck",
 	.masters	=3D omap2420_mpu_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2420_mpu_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index ed2de79..241bd82 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -16,6 +16,8 @@
 #include <plat/cpu.h>
 #include <plat/dma.h>
=20
+#include "omap_hwmod_common_data.h"
+
 #include "prm-regbits-24xx.h"
=20
 /*
@@ -58,6 +60,7 @@ static struct omap_hwmod_ocp_if *omap2430_l3_masters[=
] =3D {
 /* L3 */
 static struct omap_hwmod omap2430_l3_hwmod =3D {
 	.name		=3D "l3_hwmod",
+	.class		=3D &l3_hwmod_class,
 	.masters	=3D omap2430_l3_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2430_l3_masters),
 	.slaves		=3D omap2430_l3_slaves,
@@ -89,6 +92,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_mas=
ters[] =3D {
 /* L4 CORE */
 static struct omap_hwmod omap2430_l4_core_hwmod =3D {
 	.name		=3D "l4_core_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap2430_l4_core_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2430_l4_core_masters),
 	.slaves		=3D omap2430_l4_core_slaves,
@@ -108,6 +112,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_m=
asters[] =3D {
 /* L4 WKUP */
 static struct omap_hwmod omap2430_l4_wkup_hwmod =3D {
 	.name		=3D "l4_wkup_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap2430_l4_wkup_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2430_l4_wkup_masters),
 	.slaves		=3D omap2430_l4_wkup_slaves,
@@ -123,6 +128,7 @@ static struct omap_hwmod_ocp_if *omap2430_mpu_maste=
rs[] =3D {
 /* MPU */
 static struct omap_hwmod omap2430_mpu_hwmod =3D {
 	.name		=3D "mpu_hwmod",
+	.class		=3D &mpu_hwmod_class,
 	.main_clk	=3D "mpu_ck",
 	.masters	=3D omap2430_mpu_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap2430_mpu_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index 8d4b686..ed60840 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -18,6 +18,8 @@
 #include <plat/cpu.h>
 #include <plat/dma.h>
=20
+#include "omap_hwmod_common_data.h"
+
 #include "prm-regbits-34xx.h"
=20
 /*
@@ -69,6 +71,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[=
] =3D {
 /* L3 */
 static struct omap_hwmod omap3xxx_l3_hwmod =3D {
 	.name		=3D "l3_hwmod",
+	.class		=3D &l3_hwmod_class,
 	.masters	=3D omap3xxx_l3_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l3_masters),
 	.slaves		=3D omap3xxx_l3_slaves,
@@ -98,6 +101,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_ma=
sters[] =3D {
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
 	.name		=3D "l4_core_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap3xxx_l4_core_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_core_masters),
 	.slaves		=3D omap3xxx_l4_core_slaves,
@@ -117,6 +121,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_ma=
sters[] =3D {
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
 	.name		=3D "l4_per_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap3xxx_l4_per_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_per_masters),
 	.slaves		=3D omap3xxx_l4_per_slaves,
@@ -136,6 +141,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_m=
asters[] =3D {
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
 	.name		=3D "l4_wkup_hwmod",
+	.class		=3D &l4_hwmod_class,
 	.masters	=3D omap3xxx_l4_wkup_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
 	.slaves		=3D omap3xxx_l4_wkup_slaves,
@@ -151,6 +157,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mpu_maste=
rs[] =3D {
 /* MPU */
 static struct omap_hwmod omap3xxx_mpu_hwmod =3D {
 	.name		=3D "mpu_hwmod",
+	.class		=3D &mpu_hwmod_class,
 	.main_clk	=3D "arm_fck",
 	.masters	=3D omap3xxx_mpu_masters,
 	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_mpu_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.c
index 2567c6e..1e80b91 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -3,6 +3,10 @@
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
  * Thara Gopinath <thara@ti.com>
+ * Beno=C3=AEt Cousson
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +18,8 @@
=20
 #include <plat/omap_hwmod.h>
=20
+#include "omap_hwmod_common_data.h"
+
 /**
  * struct omap_hwmod_sysc_type1 - TYPE1 sysconfig scheme.
  *
@@ -42,3 +48,21 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 =
=3D {
 	.sidle_shift	=3D SYSC_TYPE2_SIDLEMODE_SHIFT,
 	.srst_shift	=3D SYSC_TYPE2_SOFTRESET_SHIFT,
 };
+
+
+/*
+ * omap_hwmod class data
+ */
+
+struct omap_hwmod_class l3_hwmod_class =3D {
+	.name =3D "l3"
+};
+
+struct omap_hwmod_class l4_hwmod_class =3D {
+	.name =3D "l4"
+};
+
+struct omap_hwmod_class mpu_hwmod_class =3D {
+	.name =3D "mpu"
+};
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.h
new file mode 100644
index 0000000..3645a28
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -0,0 +1,24 @@
+/*
+ * omap_hwmod_common_data.h - OMAP hwmod common macros and declaration=
s
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Beno=C3=AEt Cousson
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_OMAP_HWMOD_COMMON_DATA_H
+#define __ARCH_ARM_MACH_OMAP2_OMAP_HWMOD_COMMON_DATA_H
+
+#include <plat/omap_hwmod.h>
+
+/* OMAP hwmod classes - forward declarations */
+extern struct omap_hwmod_class l3_hwmod_class;
+extern struct omap_hwmod_class l4_hwmod_class;
+extern struct omap_hwmod_class mpu_hwmod_class;
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index d2241fc..440b416 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2009 Nokia Corporation
  * Paul Walmsley
  *
- * Created in collaboration with (alphabetical order): Benoit Cousson,
+ * Created in collaboration with (alphabetical order): Beno=C3=AEt Cou=
sson,
  * Kevin Hilman, Tony Lindgren, Rajendra Nayak, Vikram Pandita, Sakari
  * Poussa, Anand Sawant, Santosh Shilimkar, Richard Woodruff
  *
@@ -254,7 +254,7 @@ struct omap_hwmod_ocp_if {
  * @sidle_shift: Offset of the sidle bit
  * @enwkup_shift: Offset of the enawakeup bit
  * @srst_shift: Offset of the softreset bit
- * @autoidle_shift: Offset of the autoidle bit.
+ * @autoidle_shift: Offset of the autoidle bit
  */
 struct omap_hwmod_sysc_fields {
 	u8 midle_shift;
@@ -266,7 +266,7 @@ struct omap_hwmod_sysc_fields {
 };
=20
 /**
- * struct omap_hwmod_sysconfig - hwmod OCP_SYSCONFIG/OCP_SYSSTATUS dat=
a
+ * struct omap_hwmod_class_sysconfig - hwmod class OCP_SYS* data
  * @rev_offs: IP block revision register offset (from module base addr=
)
  * @sysc_offs: OCP_SYSCONFIG register offset (from module base addr)
  * @syss_offs: OCP_SYSSTATUS register offset (from module base addr)
@@ -282,16 +282,15 @@ struct omap_hwmod_sysc_fields {
  * been associated with the clocks marked in @clockact.  This field is
  * only used if HWMOD_SET_DEFAULT_CLOCKACT is set (see below)
  *
- *
  * @sysc_fields: structure containing the offset positions of various =
bits in
  * SYSCONFIG register. This can be populated using omap_hwmod_sysc_typ=
e1 or
  * omap_hwmod_sysc_type2 defined in omap_hwmod_common_data.c depending=
 on
  * whether the device ip is compliant with the original PRCM protocol
- * defined for OMAP2420 or the new  PRCM protocol for new OMAP4 IPs.
- * If the device follows a differnt scheme for the sysconfig register =
,
+ * defined for OMAP2420 or the new PRCM protocol for new OMAP4 IPs.
+ * If the device follows a different scheme for the sysconfig register=
 ,
  * then this field has to be populated with the correct offset structu=
re.
  */
-struct omap_hwmod_sysconfig {
+struct omap_hwmod_class_sysconfig {
 	u16 rev_offs;
 	u16 sysc_offs;
 	u16 syss_offs;
@@ -391,8 +390,24 @@ struct omap_hwmod_omap4_prcm {
 #define _HWMOD_STATE_DISABLED			6
=20
 /**
+ * struct omap_hwmod_class - the type of an IP block
+ * @name: name of the hwmod_class
+ * @sysc: device SYSCONFIG/SYSSTATUS register data
+ * @rev: revision of the IP class
+ *
+ * Represent the class of a OMAP hardware "modules" (e.g. timer,
+ * smartreflex, gpio, uart...)
+ */
+struct omap_hwmod_class {
+	const char				*name;
+	struct omap_hwmod_class_sysconfig	*sysc;
+	u32					rev;
+};
+
+/**
  * struct omap_hwmod - integration data for OMAP hardware "modules" (I=
P blocks)
  * @name: name of the hwmod
+ * @class: struct omap_hwmod_class * to the class of this hwmod
  * @od: struct omap_device currently associated with this hwmod (inter=
nal use)
  * @mpu_irqs: ptr to an array of MPU IRQs (see also mpu_irqs_cnt)
  * @sdma_chs: ptr to an array of SDMA channel IDs (see also sdma_chs_c=
nt)
@@ -402,7 +417,6 @@ struct omap_hwmod_omap4_prcm {
  * @opt_clks: other device clocks that drivers can request (0..*)
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
- * @sysconfig: device SYSCONFIG/SYSSTATUS register data
  * @dev_attr: arbitrary device attributes that can be passed to the dr=
iver
  * @_sysc_cache: internal-use hwmod flags
  * @_rt_va: cached register target start address (internal use)
@@ -431,6 +445,7 @@ struct omap_hwmod_omap4_prcm {
  */
 struct omap_hwmod {
 	const char			*name;
+	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
 	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_chs;
@@ -443,7 +458,6 @@ struct omap_hwmod {
 	struct omap_hwmod_opt_clk	*opt_clks;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
-	struct omap_hwmod_sysconfig	*sysconfig;
 	void				*dev_attr;
 	u32				_sysc_cache;
 	void __iomem			*_rt_va;
@@ -504,6 +518,11 @@ int omap_hwmod_set_clockact_none(struct omap_hwmod=
 *oh);
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
=20
+int omap_hwmod_for_each_by_class(const char *classname,
+				 int (*fn)(struct omap_hwmod *oh,
+					   void *user),
+				 void *user);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
