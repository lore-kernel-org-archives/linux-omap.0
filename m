From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] OMAP2+: hwmod: ignore attempts to re-late-init a hwmod
Date: Wed, 23 Feb 2011 00:11:52 -0700
Message-ID: <20110223071151.5874.69839.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1BWHNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:09 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Previously, if a hwmod had already been late-initialized, and the code
attempted to late-initialize the hwmod again, an error would be
returned.  This is not really useful behavior if we wish to allow the
OMAP core code to late-init the hwmods needed for the Linux
clocksources and clockevents _before_ the rest of the hwmods are
late-inited.  So, instead of generating errors, just ignore the attempt
to re-late-initialize the hwmod.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 86eacaf..1b6eb1f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -902,17 +902,15 @@ static struct omap_hwmod *_lookup(const char *nam=
e)
  * @data: not used; pass NULL
  *
  * Called by omap_hwmod_late_init() (after omap2_clk_init()).
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
@@ -1624,6 +1624,9 @@ int __init omap_hwmod_init(struct omap_hwmod **oh=
s)
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
