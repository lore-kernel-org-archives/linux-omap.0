From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: Fix chain_a_transfer return value
Date: Fri, 14 Dec 2007 18:20:28 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A0880506667C@dbde01.ent.ti.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

This patch changes the return value of omap_dma_chain_a_transfer
to 0 on success instead of the flag 'start_dma', which wasn't really =
useful
for anything.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Index: linux-omap-dec10/arch/arm/plat-omap/dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/arch/arm/plat-omap/dma.c	2007-12-10 =
11:01:38.000000000 +0530
+++ linux-omap-dec10/arch/arm/plat-omap/dma.c	2007-12-13 =
16:54:25.378626162 +0530
@@ -1254,7 +1254,7 @@
  * @param frame_count
  * @param callbk_data - channel callback parameter data.
  *
- * @return  - Success : start_dma status
+ * @return  - Success : 0
  * 	      Failure: -EINVAL/-EBUSY
  */
 int omap_dma_chain_a_transfer(int chain_id, int src_start, int =
dest_start,
@@ -1375,7 +1375,7 @@
 			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
 		}
 	}
-	return start_dma;
+	return 0;
 }
 EXPORT_SYMBOL(omap_dma_chain_a_transfer);
=20
