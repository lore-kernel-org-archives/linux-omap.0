From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 9/9] OMAP clock/hwmod: fix off-by-one errors
Date: Thu, 03 Dec 2009 06:45:46 -0700
Message-ID: <20091203134544.16229.26195.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48977 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbZLCNwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:24 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Juha =?utf-8?b?TGVwcMOkbmVu?= <juha_motorsportcom@luukku.com>, Russell King <linux@arm.linux.org.uk>

=46ix loop bailout off-by-one bugs reported by Juha Lepp=C3=A4nen
<juha_motorsportcom@luukku.com>.

This second version incorporates comments from Russell King
<linux@arm.linux.org.uk>.  A new macro, 'omap_test_timeout', has
been created, with cleaner code, and existing code has been converted
to use it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Lepp=C3=A4nen <juha_motorsportcom@luukku.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/cm.c                 |    7 ++++---
 arch/arm/mach-omap2/omap_hwmod.c         |   13 +++++--------
 arch/arm/mach-omap2/prcm.c               |    5 ++---
 arch/arm/plat-omap/include/plat/common.h |   20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 8eb2dab..58e4a1c 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -21,6 +21,8 @@
=20
 #include <asm/atomic.h>
=20
+#include <plat/common.h>
+
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
@@ -61,9 +63,8 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idles=
t_id, u8 idlest_shift)
 	mask =3D 1 << idlest_shift;
=20
 	/* XXX should be OMAP2 CM */
-	while (((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) !=3D ena) &=
&
-	       (i++ < MAX_MODULE_READY_TIME))
-		udelay(1);
+	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) =
=3D=3D ena),
+			  MAX_MODULE_READY_TIME, i);
=20
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 633b216..7aaf5f1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -45,6 +45,7 @@
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
=20
+#include <plat/common.h>
 #include <plat/cpu.h>
 #include <plat/clockdomain.h>
 #include <plat/powerdomain.h>
@@ -736,7 +737,7 @@ static int _wait_target_ready(struct omap_hwmod *oh=
)
 static int _reset(struct omap_hwmod *oh)
 {
 	u32 r, v;
-	int c;
+	int c =3D 0;
=20
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET) ||
@@ -758,13 +759,9 @@ static int _reset(struct omap_hwmod *oh)
 		return r;
 	_write_sysconfig(v, oh);
=20
-	c =3D 0;
-	while (c < MAX_MODULE_RESET_WAIT &&
-	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-		 SYSS_RESETDONE_MASK)) {
-		udelay(1);
-		c++;
-	}
+	omap_test_timeout((omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+			   SYSS_RESETDONE_MASK),
+			  MAX_MODULE_RESET_WAIT, c);
=20
 	if (c =3D=3D MAX_MODULE_RESET_WAIT)
 		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 9208b6e..79637c2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -241,9 +241,8 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mas=
k, const char *name)
 		BUG();
=20
 	/* Wait for lock */
-	while (((__raw_readl(reg) & mask) !=3D ena) &&
-	       (i++ < MAX_MODULE_ENABLE_WAIT))
-		udelay(1);
+	omap_test_timeout(((__raw_readl(reg) & mask) =3D=3D ena),
+			  MAX_MODULE_ENABLE_WAIT, i);
=20
 	if (i < MAX_MODULE_ENABLE_WAIT)
 		pr_debug("cm: Module associated with clock %s ready after %d "
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-o=
map/include/plat/common.h
index 064f173..e977967 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -71,4 +71,24 @@ void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
=20
+/**
+ * omap_test_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until at least @timeout
+ * microseconds have passed.  To use, define some integer @index in th=
e
+ * calling code.  After running, if @index =3D=3D @timeout, then the l=
oop has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)			\
+({								\
+	for (index =3D 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
