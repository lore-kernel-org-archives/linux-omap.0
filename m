From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/12] ARM: OMAP2+: hwmod: add _find_mpu_rt_port()
Date: Wed, 07 Mar 2012 19:38:23 -0700
Message-ID: <20120308023821.8205.21191.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab2CHCmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:09 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Most IP blocks on the OMAP SoC have an interconnect link that is
intended to be used by the MPU to communicate with the IP block.
Several parts of the hwmod code need to be able to identify this link.
Currently, this is open-coded.  However, future patches will change
the way that interconnect links are represented and will make
identifying the link more complex.  So to avoid code duplication, this
patch centralizes the MPU port link identification code into a new
function, _find_mpu_rt_port().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   39 ++++++++++++++++++++++++++++--=
--------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 3462dc5..503047a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1061,6 +1061,27 @@ static int __init _find_mpu_port_index(struct om=
ap_hwmod *oh)
 }
=20
 /**
+ * _find_mpu_rt_port - return omap_hwmod_ocp_if accessible by the MPU
+ * @oh: struct omap_hwmod *
+ *
+ * Given a pointer to a struct omap_hwmod record @oh, return a pointer
+ * to the struct omap_hwmod_ocp_if record that is used by the MPU to
+ * communicate with the IP block.  This interface need not be directly
+ * connected to the MPU (and almost certainly is not), but is directly
+ * connected to the IP block represented by @oh.  Returns a pointer
+ * to the struct omap_hwmod_ocp_if * upon success, or returns NULL upo=
n
+ * error or if there does not appear to be a path from the MPU to this
+ * IP block.
+ */
+static struct omap_hwmod_ocp_if *_find_mpu_rt_port(struct omap_hwmod *=
oh)
+{
+	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt =3D=3D=
 0)
+		return NULL;
+
+	return oh->slaves[oh->_mpu_port_index];
+};
+
+/**
  * _find_mpu_rt_addr_space - return MPU register target address space =
for @oh
  * @oh: struct omap_hwmod *
  *
@@ -1073,10 +1094,7 @@ static struct omap_hwmod_addr_space * __init _fi=
nd_mpu_rt_addr_space(struct omap
 	struct omap_hwmod_addr_space *mem;
 	int found =3D 0, i =3D 0;
=20
-	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt =3D=3D=
 0)
-		return NULL;
-
-	os =3D oh->slaves[oh->_mpu_port_index];
+	os =3D _find_mpu_rt_port(oh);
 	if (!os->addr)
 		return NULL;
=20
@@ -1334,12 +1352,11 @@ static int _wait_target_ready(struct omap_hwmod=
 *oh)
 	if (!oh)
 		return -EINVAL;
=20
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
=20
-	os =3D oh->slaves[oh->_mpu_port_index];
-
-	if (oh->flags & HWMOD_NO_IDLEST)
+	os =3D _find_mpu_rt_port(oh);
+	if (!os)
 		return 0;
=20
 	/* XXX check module SIDLEMODE */
@@ -2709,6 +2726,7 @@ int omap_hwmod_get_resource_byname(struct omap_hw=
mod *oh, unsigned int type,
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
 	struct clk *c;
+	struct omap_hwmod_ocp_if *oi;
=20
 	if (!oh)
 		return NULL;
@@ -2716,9 +2734,10 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct =
omap_hwmod *oh)
 	if (oh->_clk) {
 		c =3D oh->_clk;
 	} else {
-		if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		oi =3D _find_mpu_rt_port(oh);
+		if (!oi)
 			return NULL;
-		c =3D oh->slaves[oh->_mpu_port_index]->_clk;
+		c =3D oi->_clk;
 	}
=20
 	if (!c->clkdm)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
