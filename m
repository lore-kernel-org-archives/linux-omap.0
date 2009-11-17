From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Tue, 17 Nov 2009 10:39:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
References: <20091116133237.14128.39687.stgit@localhost.localdomain> <20091116133654.14128.175.stgit@localhost.localdomain> <20091116140830.GA31522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1797888376-1258479564=:27682"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38283 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZKQRjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 12:39:19 -0500
In-Reply-To: <20091116140830.GA31522@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Juha_Lepp=E4nen?= <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1797888376-1258479564=:27682
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Russell,

On Mon, 16 Nov 2009, Russell King - ARM Linux wrote:

> On Mon, Nov 16, 2009 at 06:36:55AM -0700, Paul Walmsley wrote:
> > Fix loop bailout off-by-one bugs reported by Juha Lepp=E4nen
> > <juha_motorsportcom@luukku.com>.
>=20
> I'm not sure the new code is any easier to read than the old code.
> And what with some checks post-loop being <=3D and others being >, it's
> a recipe for cut'n'paste errors happening.

=2E..

> How about:
>=20
> =09for (c =3D 0; c <=3D MAX_MODULE_RESET_WAIT; c++) {
> =09=09if (omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
> =09=09    SYSS_RESETDONE_MASK) {
> =09=09=09pr_debug("omap_hwmod: %s: reset in %d usec\n",
> =09=09=09=09oh->name, c);
> =09=09=09return 0;
> =09=09}
> =09}
>=20
> =09WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
>                      oh->name, c - 1);
> =09return -ETIMEDOUT;
>=20
> ?
>=20
> Even better would be to turn this into a helper much like wait_event(),
> which would stop silly mistakes happening.

Agreed.  How about this? =20

arch/arm/plat-omap/include/plat/common.h probably isn't the right place=20
for it, since it's not OMAP-specific...


- Paul


From=20972b3bbf2c210086b862aedb35587484bcefe998 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 16 Nov 2009 06:13:15 -0700
Subject: [PATCH] OMAP clock/hwmod: fix off-by-one errors
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Fix loop bailout off-by-one bugs reported by Juha Lepp=E4nen
<juha_motorsportcom@luukku.com>.

This second version incorporates comments from Russell King
<rmk+kernel@arm.linux.org.uk>.  A new macro, 'omap_test_timeout', has
been created, with cleaner code, and existing code has been converted
to use it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Lepp=E4nen <juha_motorsportcom@luukku.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
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
@@ -61,9 +63,8 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id=
, u8 idlest_shift)
 =09mask =3D 1 << idlest_shift;
=20
 =09/* XXX should be OMAP2 CM */
-=09while (((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) !=3D ena) &&
-=09       (i++ < MAX_MODULE_READY_TIME))
-=09=09udelay(1);
+=09omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) =
=3D=3D ena),
+=09=09=09  MAX_MODULE_READY_TIME, i);
=20
 =09return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
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
@@ -736,7 +737,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 static int _reset(struct omap_hwmod *oh)
 {
 =09u32 r, v;
-=09int c;
+=09int c =3D 0;
=20
 =09if (!oh->sysconfig ||
 =09    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET) ||
@@ -758,13 +759,9 @@ static int _reset(struct omap_hwmod *oh)
 =09=09return r;
 =09_write_sysconfig(v, oh);
=20
-=09c =3D 0;
-=09while (c < MAX_MODULE_RESET_WAIT &&
-=09       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-=09=09 SYSS_RESETDONE_MASK)) {
-=09=09udelay(1);
-=09=09c++;
-=09}
+=09omap_test_timeout((omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+=09=09=09   SYSS_RESETDONE_MASK),
+=09=09=09  MAX_MODULE_RESET_WAIT, c);
=20
 =09if (c =3D=3D MAX_MODULE_RESET_WAIT)
 =09=09WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 029d376..7acd03d 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -247,9 +247,8 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, c=
onst char *name)
 =09=09BUG();
=20
 =09/* Wait for lock */
-=09while (((__raw_readl(reg) & mask) !=3D ena) &&
-=09       (i++ < MAX_MODULE_ENABLE_WAIT))
-=09=09udelay(1);
+=09omap_test_timeout(((__raw_readl(reg) & mask) =3D=3D ena),
+=09=09=09  MAX_MODULE_ENABLE_WAIT, i);
=20
 =09if (i < MAX_MODULE_ENABLE_WAIT)
 =09=09pr_debug("cm: Module associated with clock %s ready after %d "
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/=
include/plat/common.h
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
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index =3D=3D @timeout, then the loop =
has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)=09=09=09\
+({=09=09=09=09=09=09=09=09\
+=09for (index =3D 0; index < timeout; index++) {=09=09\
+=09=09if (cond)=09=09=09=09=09\
+=09=09=09break;=09=09=09=09=09\
+=09=09udelay(1);=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09\
+})
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
--=20
1.6.5.GIT

--155748971-1797888376-1258479564=:27682--
