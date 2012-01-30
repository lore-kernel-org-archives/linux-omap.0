From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] ARM: OMAP2+: hwmod: provide a function to return the
 address space of the MPU RT
Date: Mon, 30 Jan 2012 03:18:16 -0700
Message-ID: <20120130101815.10450.39272.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42203 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2A3KSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:18:44 -0500
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

A subsequent patch will need to know the struct omap_hwmod_addr_space
record corresponding to the module's register target, used by the MPU.
So, convert _find_mpu_rt_base() into _find_mpu_rt_addr_space().  Then
modify its sole current user, _populate_mpu_rt_base(), to extract the
MPU RT base address itself from the struct omap_hwmod_addr_space record=
=2E

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   57 ++++++++++++++++++++++--------=
--------
 1 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index c991bd7..4e8d332 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -917,24 +917,22 @@ static int __init _find_mpu_port_index(struct oma=
p_hwmod *oh)
 }
=20
 /**
- * _find_mpu_rt_base - find hwmod register target base addr accessible=
 by MPU
+ * _find_mpu_rt_addr_space - return MPU register target address space =
for @oh
  * @oh: struct omap_hwmod *
  *
- * Return the virtual address of the base of the register target of
- * device @oh, or NULL on error.
+ * Returns a pointer to the struct omap_hwmod_addr_space record repres=
enting
+ * the register target MPU address space; or returns NULL upon error.
  */
-static void __iomem * __init _find_mpu_rt_base(struct omap_hwmod *oh, =
u8 index)
+static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(s=
truct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct omap_hwmod_addr_space *mem;
-	int i =3D 0, found =3D 0;
-	void __iomem *va_start;
+	int found =3D 0, i =3D 0;
=20
-	if (!oh || oh->slaves_cnt =3D=3D 0)
+	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt =3D=3D=
 0)
 		return NULL;
=20
-	os =3D oh->slaves[index];
-
+	os =3D oh->slaves[oh->_mpu_port_index];
 	if (!os->addr)
 		return NULL;
=20
@@ -944,20 +942,7 @@ static void __iomem * __init _find_mpu_rt_base(str=
uct omap_hwmod *oh, u8 index)
 			found =3D 1;
 	} while (!found && mem->pa_start !=3D mem->pa_end);
=20
-	if (found) {
-		va_start =3D ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
-		if (!va_start) {
-			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
-			return NULL;
-		}
-		pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
-			 oh->name, va_start);
-	} else {
-		pr_debug("omap_hwmod: %s: no MPU register target found\n",
-			 oh->name);
-	}
-
-	return (found) ? va_start : NULL;
+	return (found) ? mem : NULL;
 }
=20
 /**
@@ -2031,19 +2016,43 @@ int __init omap_hwmod_register(struct omap_hwmo=
d **ohs)
=20
 /*
  * _populate_mpu_rt_base - populate the virtual address for a hwmod
+ * @oh: struct omap_hwmod *
+ * @data: (unused)
  *
  * Must be called only from omap_hwmod_setup_*() so ioremap works prop=
erly.
  * Assumes the caller takes care of locking if needed.
  */
 static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *d=
ata)
 {
+	struct omap_hwmod_addr_space *mem;
+	void __iomem *va_start;
+
+	if (!oh)
+		return 0;
+
 	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
 		return 0;
=20
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return 0;
=20
-	oh->_mpu_rt_va =3D _find_mpu_rt_base(oh, oh->_mpu_port_index);
+	mem =3D _find_mpu_rt_addr_space(oh);
+	if (!mem) {
+		pr_debug("omap_hwmod: %s: no MPU register target found\n",
+			 oh->name);
+		return 0;
+	}
+
+	va_start =3D ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	if (!va_start) {
+		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+		return 0;
+	}
+
+	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
+		 oh->name, va_start);
+
+	oh->_mpu_rt_va =3D va_start;
=20
 	return 0;
 }


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
