From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual hwmods
Date: Wed, 23 Feb 2011 00:11:53 -0700
Message-ID: <20110223071152.5874.54222.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58775 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1BWHNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:09 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add omap_hwmod_late_init_one(), which is intended for use early in
boot to selectively init the hwmods needed for system clocksources
and clockevents, and any other hwmod that is needed in early boot.
omap_hwmod_late_init() can then be called later in the boot process.
The point is to minimize the amount of code that needs to be run early
in the boot process.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   53 ++++++++++++++++++=
+++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 1b6eb1f..83ca219 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1639,6 +1639,55 @@ static int __init _populate_mpu_rt_base(struct o=
map_hwmod *oh, void *data)
 }
=20
 /**
+ * omap_hwmod_late_init_one - XXX
+ *
+ * XXX Fix this documentation
+ *
+ * Must be called after omap2_clk_init().  Resolves the struct clk
+ * names to struct clk pointers for each registered omap_hwmod.  Also
+ * calls _setup() on each hwmod.  Returns -EINVAL upon error or 0 upon
+ * success.
+ */
+int __init omap_hwmod_late_init_one(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+	int r;
+
+	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
+
+	if (!mpu_oh) {
+		pr_err("omap_hwmod: %s: cannot late_init_one: MPU initiator hwmod %s=
 not yet registered\n",
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
+		omap_hwmod_late_init_one(MPU_INITIATOR_NAME);
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
  * omap_hwmod_late_init - do some post-clock framework initialization
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
@@ -1657,9 +1706,9 @@ static int __init omap_hwmod_late_init(void)
=20
 	r =3D omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
=20
-	/* XXX check return value */
 	r =3D omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
+	WARN(IS_ERR_VALUE(r),
+	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
=20
 	omap_hwmod_for_each(_setup, NULL);
=20
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index fedd829..48b8dd3 100644
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
@@ -540,6 +541,8 @@ struct omap_hwmod *omap_hwmod_lookup(const char *na=
me);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
=20
+int __init omap_hwmod_late_init_one(const char *name);
+
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
