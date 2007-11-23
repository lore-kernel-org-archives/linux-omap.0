From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: Fix typo in arch/arm/mach-omap2/clock34xx.h
Date: Fri, 23 Nov 2007 20:05:03 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804E3D34D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Fix typo in clock34xx.h

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6-NOV23/arch/arm/mach-omap2/clock34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-NOV23.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-23 =
11:36:45.841170240 -0500
+++ linux-omap-2.6-NOV23/arch/arm/mach-omap2/clock34xx.h	2007-11-23 =
11:36:55.411715296 -0500
@@ -1088,7 +1088,7 @@
 };
=20
 static struct clk hsotgusb_ick =3D {
-	.name		=3D "hsotgusb_fck",
+	.name		=3D "hsotgusb_ick",
 	.parent		=3D &core_l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_HSOTGUSB_SHIFT,
