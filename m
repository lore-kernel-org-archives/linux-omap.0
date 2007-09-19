From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: DMA fix bug in omap_get_dma_dst_pos
Date: Wed, 19 Sep 2007 11:22:35 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804708B6C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

omap_get_dma_dst_pos() should return the current destination address.
The CDSA register contains the destination start address.
CDAC register should be used instead.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---

 linux-omap/arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/plat-omap/dma.c	2007-09-18
16:17:21.000000000 +0530
+++ linux-omap/arch/arm/plat-omap/dma.c	2007-09-18 16:21:59.000000000
+0530
@@ -776,7 +776,7 @@
 				       (OMAP1_DMA_CDSA_U_REG(lch) <<
16));
=20
 	if (cpu_is_omap24xx())
-		offset =3D OMAP2_DMA_CDSA_REG(lch);
+		offset =3D OMAP2_DMA_CDAC_REG(lch);
=20
 	return offset;
 }
