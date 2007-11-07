From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: [PATCH] ARM: OMAP: VMALLOC Size
Date: Wed, 7 Nov 2007 19:42:12 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4011254B5@dbde01.ent.ti.com>
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

Hi,=20

This patch increases the size of VMALLOC to accommodate the bigger DDR =
and=20
NOR flashes being used now. Since SRAM is allocated at the end of =
VMALLOC=20
area, moving the SRAM virtual address also.

Regards,
Rohit

Signed-off-by: Rohit Choraria <rohitkc@ti.com>
---
 arch/arm/plat-omap/sram.c           |    6 +++---
 include/asm-arm/arch-omap/vmalloc.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/vmalloc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/include/asm-arm/arch-omap/vmalloc.h	2007-11-07 =
06:34:19.062643728 -0500
+++ linux-omap/include/asm-arm/arch-omap/vmalloc.h	2007-11-07 =
06:34:58.255685480 -0500
@@ -17,5 +17,5 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
  */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END	  (PAGE_OFFSET + 0x17000000)
=20
Index: linux-omap/arch/arm/plat-omap/sram.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-07 =
06:34:19.062643728 -0500
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-07 09:58:34.914471048 =
-0500
@@ -25,11 +25,11 @@
 #include <asm/arch/board.h>
=20
 #define OMAP1_SRAM_PA		0x20000000
-#define OMAP1_SRAM_VA		0xd0000000
+#define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		0xd0000000
-#define OMAP2_SRAM_PUB_VA	0xd0000800
+#define OMAP2_SRAM_VA		VMALLOC_END
+#define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
=20
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
