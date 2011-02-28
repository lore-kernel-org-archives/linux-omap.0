From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 7/9] OMAP2+: hwmod: ignore attempts to re-setup a hwmod
Date: Mon, 28 Feb 2011 14:12:28 -0700
Message-ID: <20110228211224.15286.27149.stgit@twilight.localdomain>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab1B1VOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 16:14:21 -0500
In-Reply-To: <20110228210858.15286.3200.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Previously, if a hwmod had already been set up, and the code attempted
to set up the hwmod again, an error would be returned.  This is not
really useful behavior if we wish to allow the OMAP core code to setup
the hwmods needed for the Linux clocksources and clockevents before
the rest of the hwmods are setup.  So, instead of generating errors,
just ignore the attempt to re-setup the hwmod.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index e4c934b..43aa894 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -902,17 +902,15 @@ static struct omap_hwmod *_lookup(const char *nam=
e)
  * @data: not used; pass NULL
  *
  * Called by omap_hwmod_setup_all() (after omap2_clk_init()).
- * Resolves all clock names embedded in the hwmod.  Returns -EINVAL if
- * the omap_hwmod has not yet been registered or if the clocks have
- * already been initialized, 0 on success, or a non-zero error on
- * failure.
+ * Resolves all clock names embedded in the hwmod.  Returns 0 on
+ * success, or a negative error code on failure.
  */
 static int _init_clocks(struct omap_hwmod *oh, void *data)
 {
 	int ret =3D 0;
=20
-	if (!oh || (oh->_state !=3D _HWMOD_STATE_REGISTERED))
-		return -EINVAL;
+	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
+		return 0;
=20
 	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
=20
@@ -1351,14 +1349,16 @@ static int _shutdown(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Returns -EINVAL if the hwmod is in the
- * wrong state or returns 0.
+ * OCP_SYSCONFIG register.  Returns 0.
  */
 static int _setup(struct omap_hwmod *oh, void *data)
 {
 	int i, r;
 	u8 postsetup_state;
=20
+	if (oh->_state !=3D _HWMOD_STATE_CLKS_INITED)
+		return 0;
+
 	/* Set iclk autoidle mode */
 	if (oh->slaves_cnt > 0) {
 		for (i =3D 0; i < oh->slaves_cnt; i++) {
@@ -1621,6 +1621,9 @@ int __init omap_hwmod_register(struct omap_hwmod =
**ohs)
  */
 static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *d=
ata)
 {
+	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
+		return 0;
+
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return 0;
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
