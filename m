From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 8/9] OMAP2+: hwmod: add ability to setup individual hwmods
Date: Mon, 28 Feb 2011 14:12:31 -0700
Message-ID: <20110228211228.15286.72071.stgit@twilight.localdomain>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50116 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab1B1VOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 16:14:23 -0500
In-Reply-To: <20110228210858.15286.3200.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add omap_hwmod_setup_one(), which is intended for use early in boot to
selectively setup the hwmods needed for system clocksources and
clockevents, and any other hwmod that is needed in early boot.
omap_hwmod_setup_all() can then be called later in the boot process.
The point is to minimize the amount of code that needs to be run
early.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   62 ++++++++++++++++++=
+++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 43aa894..f76f133 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -901,7 +901,7 @@ static struct omap_hwmod *_lookup(const char *name)
  * @oh: struct omap_hwmod *
  * @data: not used; pass NULL
  *
- * Called by omap_hwmod_setup_all() (after omap2_clk_init()).
+ * Called by omap_hwmod_setup_*() (after omap2_clk_init()).
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
@@ -1616,7 +1616,7 @@ int __init omap_hwmod_register(struct omap_hwmod =
**ohs)
 /*
  * _populate_mpu_rt_base - populate the virtual address for a hwmod
  *
- * Must be called only from omap_hwmod_setup_all() so ioremap works pr=
operly.
+ * Must be called only from omap_hwmod_setup_*() so ioremap works prop=
erly.
  * Assumes the caller takes care of locking if needed.
  */
 static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *d=
ata)
@@ -1636,11 +1636,59 @@ static int __init _populate_mpu_rt_base(struct =
omap_hwmod *oh, void *data)
 }
=20
 /**
+ * omap_hwmod_setup_one - set up a single hwmod
+ * @oh_name: const char * name of the already-registered hwmod to set =
up
+ *
+ * Must be called after omap2_clk_init().  Resolves the struct clk
+ * names to struct clk pointers for each registered omap_hwmod.  Also
+ * calls _setup() on each hwmod.  Returns -EINVAL upon error or 0 upon
+ * success.
+ */
+int __init omap_hwmod_setup_one(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+	int r;
+
+	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
+
+	if (!mpu_oh) {
+		pr_err("omap_hwmod: %s: cannot setup_one: MPU initiator hwmod %s not=
 yet registered\n",
+		       oh_name, MPU_INITIATOR_NAME);
+		return -EINVAL;
+	}
+
+	oh =3D _lookup(oh_name);
+	if (!oh) {
+		WARN(1, "omap_hwmod: %s: hwmod not yet registered\n", oh_name);
+		return -EINVAL;
+	}
+
+	if (mpu_oh->_state =3D=3D _HWMOD_STATE_REGISTERED && oh !=3D mpu_oh)
+		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
+
+	r =3D _populate_mpu_rt_base(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't set mpu_rt_base\n", oh_name);
+		return -EINVAL;
+	}
+
+	r =3D _init_clocks(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh_name);
+		return -EINVAL;
+	}
+
+	_setup(oh, NULL);
+
+	return 0;
+}
+
+/**
  * omap_hwmod_setup - do some post-clock framework initialization
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
  * to struct clk pointers for each registered omap_hwmod.  Also calls
- * _setup() on each hwmod.  Returns 0 upon success or -EINVAL upon err=
or.
+ * _setup() on each hwmod.  Returns 0 upon success.
  */
 static int __init omap_hwmod_setup_all(void)
 {
@@ -1654,9 +1702,9 @@ static int __init omap_hwmod_setup_all(void)
=20
 	r =3D omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
=20
-	/* XXX check return value */
 	r =3D omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(r, "omap_hwmod: %s: _init_clocks failed\n", __func__);
+	WARN(IS_ERR_VALUE(r),
+	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
=20
 	omap_hwmod_for_each(_setup, NULL);
=20
@@ -2182,8 +2230,8 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
  * @state: state that _setup() should leave the hwmod in
  *
  * Sets the hwmod state that @oh will enter at the end of _setup()
- * (called by omap_hwmod_setup_all()).  Only valid to call between
- * calling omap_hwmod_register() and omap_hwmod_setup_all().  Returns
+ * (called by omap_hwmod_setup_*()).  Only valid to call between
+ * calling omap_hwmod_register() and omap_hwmod_setup_*().  Returns
  * 0 upon success or -EINVAL if there is a problem with the arguments
  * or if the hwmod is in the wrong state.
  */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index afdf197..f96e72e 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -30,6 +30,7 @@
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD_H
=20
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
@@ -542,6 +543,8 @@ struct omap_hwmod *omap_hwmod_lookup(const char *na=
me);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
=20
+int __init omap_hwmod_setup_one(const char *name);
+
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
