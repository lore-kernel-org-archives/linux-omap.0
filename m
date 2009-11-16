From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Mon, 16 Nov 2009 06:36:55 -0700
Message-ID: <20091116133654.14128.175.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49343 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbZKPNh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 08:37:56 -0500
In-Reply-To: <20091116133237.14128.39687.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Juha =?utf-8?b?TGVwcMOkbmVu?= <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org

=46ix loop bailout off-by-one bugs reported by Juha Lepp=C3=A4nen
<juha_motorsportcom@luukku.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Lepp=C3=A4nen <juha_motorsportcom@luukku.com>
---
 arch/arm/mach-omap2/cm.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |   12 +++++-------
 arch/arm/mach-omap2/prcm.c       |    4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 8eb2dab..0766e52 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -65,6 +65,6 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idles=
t_id, u8 idlest_shift)
 	       (i++ < MAX_MODULE_READY_TIME))
 		udelay(1);
=20
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	return (i <=3D MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 633b216..a4a9518 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -759,14 +759,12 @@ static int _reset(struct omap_hwmod *oh)
 	_write_sysconfig(v, oh);
=20
 	c =3D 0;
-	while (c < MAX_MODULE_RESET_WAIT &&
-	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-		 SYSS_RESETDONE_MASK)) {
+	while (!(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+		 SYSS_RESETDONE_MASK) &&
+	       (c++ < MAX_MODULE_RESET_WAIT))
 		udelay(1);
-		c++;
-	}
=20
-	if (c =3D=3D MAX_MODULE_RESET_WAIT)
+	if (c > MAX_MODULE_RESET_WAIT)
 		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
 		     oh->name, MAX_MODULE_RESET_WAIT);
 	else
@@ -777,7 +775,7 @@ static int _reset(struct omap_hwmod *oh)
 	 * _wait_target_ready() or _reset()
 	 */
=20
-	return (c =3D=3D MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
+	return (c > MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
 }
=20
 /**
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 029d376..d486709 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -251,14 +251,14 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 m=
ask, const char *name)
 	       (i++ < MAX_MODULE_ENABLE_WAIT))
 		udelay(1);
=20
-	if (i < MAX_MODULE_ENABLE_WAIT)
+	if (i <=3D MAX_MODULE_ENABLE_WAIT)
 		pr_debug("cm: Module associated with clock %s ready after %d "
 			 "loops\n", name, i);
 	else
 		pr_err("cm: Module associated with clock %s didn't enable in "
 		       "%d tries\n", name, MAX_MODULE_ENABLE_WAIT);
=20
-	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
+	return (i <=3D MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
 };
=20
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
