From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] OMAP2+: hwmod: upgrade per-hwmod mutex to a spinlock
Date: Tue, 16 Nov 2010 03:18:10 -0700
Message-ID: <20101116101809.22777.92945.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51541 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934208Ab0KPKTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:15 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Change the per-hwmod mutex to a spinlock.  (The per-hwmod lock
serializes most post-initialization hwmod operations such as enable,
idle, and shutdown.)  Spinlocks are needed, because in some cases,
hwmods must be enabled from timer interrupt disabled-context, such as
an ISR.  The current use-case that is driving this is the OMAP GPIO
block ISR: it can trigger interrupts even with its clocks disabled,
but these clocks are needed for register accesses in the ISR to succeed=
=2E

This patch also effectively reverts commit
848240223c35fcc71c424ad51a8e8aef42d3879c - this patch makes
_omap_hwmod_enable() and _omap_hwmod_init() static, renames them back
to _enable() and _idle(), and changes their callers to call the
spinlocking versions.  Previously, since omap_hwmod_{enable,init}()
attempted to take mutexes, these functions could not be called while
the timer interrupt was disabled; but now that the functions use
spinlocks and save and restore the IRQ state, it is appropriate to
call them directly.

Kevin Hilman <khilman@deeprootsystems.com> originally proposed this
patch - thanks Kevin.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  105 +++++++++++++++---=
--------
 arch/arm/mach-omap2/serial.c                 |    9 --
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +
 3 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 0e85278..589c282 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -135,6 +135,7 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
=20
 #include <plat/common.h>
 #include <plat/cpu.h>
@@ -1193,17 +1194,14 @@ static int _reset(struct omap_hwmod *oh)
 }
=20
 /**
- * _omap_hwmod_enable - enable an omap_hwmod
+ * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Enables an omap_hwmod @oh such that the MPU can access the hwmod's
- * register target.  (This function has a full name --
- * _omap_hwmod_enable() rather than simply _enable() -- because it is
- * currently required by the pm34xx.c idle loop.)  Returns -EINVAL if
- * the hwmod is in the wrong state or passes along the return value of
- * _wait_target_ready().
+ * register target.  Returns -EINVAL if the hwmod is in the wrong
+ * state or passes along the return value of _wait_target_ready().
  */
-int _omap_hwmod_enable(struct omap_hwmod *oh)
+static int _enable(struct omap_hwmod *oh)
 {
 	int r;
=20
@@ -1250,16 +1248,14 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 }
=20
 /**
- * _omap_hwmod_idle - idle an omap_hwmod
+ * _idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Idles an omap_hwmod @oh.  This should be called once the hwmod has
- * no further work.  (This function has a full name --
- * _omap_hwmod_idle() rather than simply _idle() -- because it is
- * currently required by the pm34xx.c idle loop.)  Returns -EINVAL if
- * the hwmod is in the wrong state or returns 0.
+ * no further work.  Returns -EINVAL if the hwmod is in the wrong
+ * state or returns 0.
  */
-int _omap_hwmod_idle(struct omap_hwmod *oh)
+static int _idle(struct omap_hwmod *oh)
 {
 	if (oh->_state !=3D _HWMOD_STATE_ENABLED) {
 		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
@@ -1305,11 +1301,11 @@ static int _shutdown(struct omap_hwmod *oh)
 	if (oh->class->pre_shutdown) {
 		prev_state =3D oh->_state;
 		if (oh->_state =3D=3D _HWMOD_STATE_IDLE)
-			_omap_hwmod_enable(oh);
+			_enable(oh);
 		ret =3D oh->class->pre_shutdown(oh);
 		if (ret) {
 			if (prev_state =3D=3D _HWMOD_STATE_IDLE)
-				_omap_hwmod_idle(oh);
+				_idle(oh);
 			return ret;
 		}
 	}
@@ -1382,7 +1378,7 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
 	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt =3D=3D 1)
 		return 0;
=20
-	r =3D _omap_hwmod_enable(oh);
+	r =3D _enable(oh);
 	if (r) {
 		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
 			   oh->name, oh->_state);
@@ -1394,7 +1390,7 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
=20
 		/*
 		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
-		 * The _omap_hwmod_enable() function should be split to
+		 * The _enable() function should be split to
 		 * avoid the rewrite of the OCP_SYSCONFIG register.
 		 */
 		if (oh->class->sysc) {
@@ -1416,7 +1412,7 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
 		postsetup_state =3D _HWMOD_STATE_ENABLED;
=20
 	if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
-		_omap_hwmod_idle(oh);
+		_idle(oh);
 	else if (postsetup_state =3D=3D _HWMOD_STATE_DISABLED)
 		_shutdown(oh);
 	else if (postsetup_state !=3D _HWMOD_STATE_ENABLED)
@@ -1522,7 +1518,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
=20
 	list_add_tail(&oh->node, &omap_hwmod_list);
=20
-	mutex_init(&oh->_mutex);
+	spin_lock_init(&oh->_lock);
=20
 	oh->_state =3D _HWMOD_STATE_REGISTERED;
=20
@@ -1682,18 +1678,18 @@ int omap_hwmod_unregister(struct omap_hwmod *oh=
)
 int omap_hwmod_enable(struct omap_hwmod *oh)
 {
 	int r;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
-	r =3D _omap_hwmod_enable(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
+	r =3D _enable(oh);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return r;
 }
=20
-
 /**
  * omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
@@ -1703,12 +1699,14 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
  */
 int omap_hwmod_idle(struct omap_hwmod *oh)
 {
+	unsigned long flags;
+
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
-	_omap_hwmod_idle(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
+	_idle(oh);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -1723,12 +1721,14 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
  */
 int omap_hwmod_shutdown(struct omap_hwmod *oh)
 {
+	unsigned long flags;
+
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	_shutdown(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -1741,9 +1741,11 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
  */
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh)
 {
-	mutex_lock(&oh->_mutex);
+	unsigned long flags;
+
+	spin_lock_irqsave(&oh->_lock, flags);
 	_enable_clocks(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -1756,9 +1758,11 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *=
oh)
  */
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh)
 {
-	mutex_lock(&oh->_mutex);
+	unsigned long flags;
+
+	spin_lock_irqsave(&oh->_lock, flags);
 	_disable_clocks(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -1802,13 +1806,14 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *=
oh)
 int omap_hwmod_reset(struct omap_hwmod *oh)
 {
 	int r;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	r =3D _reset(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return r;
 }
@@ -2005,13 +2010,15 @@ int omap_hwmod_del_initiator_dep(struct omap_hw=
mod *oh,
  */
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 {
+	unsigned long flags;
+
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	_enable_wakeup(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -2030,13 +2037,15 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod =
*oh)
  */
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 {
+	unsigned long flags;
+
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	_disable_wakeup(oh);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return 0;
 }
@@ -2056,13 +2065,14 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod=
 *oh)
 int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *nam=
e)
 {
 	int ret;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	ret =3D _assert_hardreset(oh, name);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return ret;
 }
@@ -2082,13 +2092,14 @@ int omap_hwmod_assert_hardreset(struct omap_hwm=
od *oh, const char *name)
 int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *n=
ame)
 {
 	int ret;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	ret =3D _deassert_hardreset(oh, name);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return ret;
 }
@@ -2107,13 +2118,14 @@ int omap_hwmod_deassert_hardreset(struct omap_h=
wmod *oh, const char *name)
 int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	int ret;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
 	ret =3D _read_hardreset(oh, name);
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return ret;
 }
@@ -2181,6 +2193,7 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 {
 	int ret;
+	unsigned long flags;
=20
 	if (!oh)
 		return -EINVAL;
@@ -2190,7 +2203,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hw=
mod *oh, u8 state)
 	    state !=3D _HWMOD_STATE_IDLE)
 		return -EINVAL;
=20
-	mutex_lock(&oh->_mutex);
+	spin_lock_irqsave(&oh->_lock, flags);
=20
 	if (oh->_state !=3D _HWMOD_STATE_REGISTERED) {
 		ret =3D -EINVAL;
@@ -2201,7 +2214,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hw=
mod *oh, u8 state)
 	ret =3D 0;
=20
 ohsps_unlock:
-	mutex_unlock(&oh->_mutex);
+	spin_unlock_irqrestore(&oh->_lock, flags);
=20
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index becf0e3..1be0031 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -105,21 +105,16 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
=20
-/*
- * Since these idle/enable hooks are used in the idle path itself
- * which has interrupts disabled, use the non-locking versions of
- * the hwmod enable/disable functions.
- */
 static int uart_idle_hwmod(struct omap_device *od)
 {
-	_omap_hwmod_idle(od->hwmods[0]);
+	omap_hwmod_idle(od->hwmods[0]);
=20
 	return 0;
 }
=20
 static int uart_enable_hwmod(struct omap_device *od)
 {
-	_omap_hwmod_enable(od->hwmods[0]);
+	omap_hwmod_enable(od->hwmods[0]);
=20
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index e4c4fd4..b588f47 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -32,7 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
-#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <plat/cpu.h>
=20
 struct omap_device;
@@ -472,7 +472,7 @@ struct omap_hwmod_class {
  * @_postsetup_state: internal-use state to leave the hwmod in after _=
setup()
  * @flags: hwmod flags (documented below)
  * @omap_chip: OMAP chips this hwmod is present on
- * @_mutex: mutex serializing operations on this hwmod
+ * @_lock: spinlock serializing operations on this hwmod
  * @node: list node for hwmod list (internal use)
  *
  * @main_clk refers to this module's "main clock," which for our
@@ -502,7 +502,7 @@ struct omap_hwmod {
 	void				*dev_attr;
 	u32				_sysc_cache;
 	void __iomem			*_mpu_rt_va;
-	struct mutex			_mutex;
+	spinlock_t			_lock;
 	struct list_head		node;
 	u16				flags;
 	u8				_mpu_port_index;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
