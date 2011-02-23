From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/8] OMAP2+: hwmod: find MPU initiator hwmod during in
	_register()
Date: Wed, 23 Feb 2011 00:11:50 -0700
Message-ID: <20110223071146.5874.15334.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58763 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab1BWHNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:08 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Move the code that looks for the MPU initiator hwmod to run during
the individual hwmod _register() function.  (Previously, it ran after
all hwmods were registered in the omap_hwmod_late_init() function.)

This is done so code can late-initialize a few individual hwmods --
for example, for the system timer -- before the entire set of hwmods is
initialized later in boot via omap_hwmod_late_init().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 9e89a58..41f548e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1455,7 +1455,7 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
  */
 static int __init _register(struct omap_hwmod *oh)
 {
-	int ret, ms_id;
+	int ms_id;
=20
 	if (!oh || !oh->name || !oh->class || !oh->class->name ||
 	    (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
@@ -1478,9 +1478,14 @@ static int __init _register(struct omap_hwmod *o=
h)
=20
 	oh->_state =3D _HWMOD_STATE_REGISTERED;
=20
-	ret =3D 0;
+	/*
+	 * XXX Rather than doing a strcmp(), this should test a flag
+	 * set in the hwmod data, inserted by the autogenerator code.
+	 */
+	if (!strcmp(oh->name, MPU_INITIATOR_NAME))
+		mpu_oh =3D oh;
=20
-	return ret;
+	return 0;
 }
=20
=20
@@ -1644,22 +1649,24 @@ static int __init _populate_mpu_rt_base(struct =
omap_hwmod *oh, void *data)
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
  * to struct clk pointers for each registered omap_hwmod.  Also calls
- * _setup() on each hwmod.  Returns 0.
+ * _setup() on each hwmod.  Returns 0 upon success or -EINVAL upon err=
or.
  */
 static int __init omap_hwmod_late_init(void)
 {
 	int r;
=20
+	if (!mpu_oh) {
+		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n"=
,
+		       __func__, MPU_INITIATOR_NAME);
+		return -EINVAL;
+	}
+
 	r =3D omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
=20
 	/* XXX check return value */
 	r =3D omap_hwmod_for_each(_init_clocks, NULL);
 	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
=20
-	mpu_oh =3D omap_hwmod_lookup(MPU_INITIATOR_NAME);
-	WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
-	     MPU_INITIATOR_NAME);
-
 	omap_hwmod_for_each(_setup, NULL);
=20
 	return 0;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
