From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: hwmod: allow board files to prevent devices from
 being reset upon init
Date: Wed, 9 Mar 2011 18:06:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091805560.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1938463464-1299719206=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1CJBGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 20:06:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Buesch <mb@bu3sch.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1938463464-1299719206=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Some boards can't tolerate IP blocks being reset when they are initialized.
Michael B=FCsch cites a case with the Nokia N810:

    http://www.spinics.net/lists/linux-omap/msg47277.html

To allow such boards to continue working normally, allow board file
maintainers to mark IP blocks to prevent them from being reset upon
init.  This is done via a hwmod function, omap_hwmod_no_setup_reset().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Michael Buesch <mb@bu3sch.de>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index e282e35..816aeb9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2218,3 +2218,29 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hw=
mod *oh)
=20
 =09return ret;
 }
+
+/**
+ * omap_hwmod_no_setup_reset - prevent a hwmod from being reset upon setup
+ * @oh: struct omap_hwmod *
+ *
+ * Prevent the hwmod @oh from being reset during the setup process.
+ * Intended for use by board-*.c files on boards with devices that
+ * cannot tolerate being reset.  Must be called before the hwmod has
+ * been set up.  Returns 0 upon success or negative error code upon
+ * failure.
+ */
+int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
+{
+=09if (!oh)
+=09=09return -EINVAL;
+
+=09if (oh->_state !=3D _HWMOD_STATE_REGISTERED) {
+=09=09pr_err("omap_hwmod: %s: cannot prevent setup reset; in wrong state\n=
",
+=09=09=09oh->name);
+=09=09return -EINVAL;
+=09}
+
+=09oh->flags |=3D HWMOD_INIT_NO_RESET;
+
+=09return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index 1eee85a..bba2343 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -589,6 +589,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
=20
+int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
--=20
1.7.2.3

--155748971-1938463464-1299719206=:15132--
