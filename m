From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/12] ARM: OMAP2+: hwmod: consolidate finding the MPU port
 index and storing it
Date: Wed, 07 Mar 2012 19:38:25 -0700
Message-ID: <20120308023824.8205.11522.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2CHCmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:09 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

An IP block's MPU interface port only needs to be found once.  The resu=
lt
can be cached to speed further lookups.  This patch consolidates these
two steps into a single function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   39 +++++++++++++++---------------=
--------
 1 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 96a03d7..3c733a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1044,37 +1044,34 @@ static int _get_addr_space_by_name(struct omap_=
hwmod *oh, const char *name,
 }
=20
 /**
- * _find_mpu_port_index - find hwmod OCP slave port ID intended for MP=
U use
+ * _save_mpu_port_index - find and save the index to @oh's MPU port
  * @oh: struct omap_hwmod *
  *
- * Returns the array index of the OCP slave port that the MPU
- * addresses the device on, or -EINVAL upon error or not found.
+ * Determines the array index of the OCP slave port that the MPU uses
+ * to address the device, and saves it into the struct omap_hwmod.
+ * Intended to be called during hwmod registration only. No return
+ * value.
  */
-static int __init _find_mpu_port_index(struct omap_hwmod *oh)
+static void __init _save_mpu_port_index(struct omap_hwmod *oh)
 {
-	struct omap_hwmod_ocp_if *os;
+	struct omap_hwmod_ocp_if *os =3D NULL;
 	int i =3D 0;
-	int found =3D 0;
=20
 	if (!oh)
-		return -EINVAL;
+		return;
+
+	oh->_int_flags |=3D _HWMOD_NO_MPU_PORT;
=20
 	while (i < oh->slaves_cnt) {
 		os =3D _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		if (os->user & OCP_USER_MPU) {
-			found =3D 1;
+			oh->_mpu_port_index =3D i - 1;
+			oh->_int_flags &=3D ~_HWMOD_NO_MPU_PORT;
 			break;
 		}
 	}
=20
-	if (found)
-		pr_debug("omap_hwmod: %s: MPU OCP slave port ID  %d\n",
-			 oh->name, i - 1);
-	else
-		pr_debug("omap_hwmod: %s: no MPU OCP slave port found\n",
-			 oh->name);
-
-	return (found) ? (i - 1) : -EINVAL;
+	return;
 }
=20
 /**
@@ -1112,7 +1109,7 @@ static struct omap_hwmod_addr_space * __init _fin=
d_mpu_rt_addr_space(struct omap
 	int found =3D 0, i =3D 0;
=20
 	os =3D _find_mpu_rt_port(oh);
-	if (!os->addr)
+	if (!os || !os->addr)
 		return NULL;
=20
 	do {
@@ -2175,8 +2172,6 @@ static int __init _setup(struct omap_hwmod *oh, v=
oid *n)
  */
 static int __init _register(struct omap_hwmod *oh)
 {
-	int ms_id;
-
 	if (!oh || !oh->name || !oh->class || !oh->class->name ||
 	    (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
 		return -EINVAL;
@@ -2186,11 +2181,7 @@ static int __init _register(struct omap_hwmod *o=
h)
 	if (_lookup(oh->name))
 		return -EEXIST;
=20
-	ms_id =3D _find_mpu_port_index(oh);
-	if (!IS_ERR_VALUE(ms_id))
-		oh->_mpu_port_index =3D ms_id;
-	else
-		oh->_int_flags |=3D _HWMOD_NO_MPU_PORT;
+	_save_mpu_port_index(oh);
=20
 	list_add_tail(&oh->node, &omap_hwmod_list);
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
