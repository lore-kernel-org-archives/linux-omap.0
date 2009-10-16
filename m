From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/14] omap: Remap L3, L4 to get more kernel io address space
Date: Fri, 16 Oct 2009 16:42:13 -0700
Message-ID: <20091016234213.2463.61298.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61416 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZJPXmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:42:10 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch remap L3 and L4 io space to get more kernel address space.
With this patch, 512 MB of IO space is reclaimed.
Some more combinations are possible but to make it uniform across
OMAP24XX, OMAP34XX and OMAP4430, these io combinations are chosen

Once this is reviewed and tested sufficiently, a documentation entry can
be created to ease up reading and debugging.
Like "Documentation/arm/omap/io_map.txt"

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/io.h      |   97 ++++++++++++++++++-----------
 arch/arm/plat-omap/include/mach/vmalloc.h |    2 -
 2 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index c475be7..a8f931a 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -66,8 +66,18 @@
 #define OMAP2_L3_IO_OFFSET	0x90000000
 #define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
-#define OMAP2_L4_IO_OFFSET	0x90000000
+#define OMAP4_L3_IO_OFFSET	0xb4000000
+#define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */
+
+#define OMAP4_GPMC_IO_OFFSET		0xa9000000
+#define OMAP4_GPMC_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_GPMC_IO_OFFSET)
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
 #define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
+
+#define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
+#define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
+
 /*
  * ----------------------------------------------------------------------------
  * Omap1 specific IO mapping
@@ -85,24 +95,27 @@
  */
 
 /* We map both L3 and L4 on OMAP2 */
-#define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 */
-#define L3_24XX_VIRT	0xf8000000
+#define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 --> 0xf8000000*/
+#define L3_24XX_VIRT	(L3_24XX_PHYS + OMAP2_L3_IO_OFFSET)
 #define L3_24XX_SIZE	SZ_1M		/* 44kB of 128MB used, want 1MB sect */
-#define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 */
-#define L4_24XX_VIRT	0xd8000000
+#define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 --> 0xfa000000 */
+#define L4_24XX_VIRT	(L4_24XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
 
-#define L4_WK_243X_PHYS		L4_WK_243X_BASE		/* 0x49000000 */
-#define L4_WK_243X_VIRT		0xd9000000
+#define L4_WK_243X_PHYS		L4_WK_243X_BASE	/* 0x49000000 --> 0xfb000000 */
+#define L4_WK_243X_VIRT		(L4_WK_243X_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_WK_243X_SIZE		SZ_1M
-#define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE	/* 0x49000000 */
-#define OMAP243X_GPMC_VIRT	0xFE000000
+#define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE
+#define OMAP243X_GPMC_VIRT	(OMAP243X_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
+						/* 0x6e000000 --> 0xfe000000 */
 #define OMAP243X_GPMC_SIZE	SZ_1M
 #define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
-#define OMAP243X_SDRC_VIRT	0xFD000000
+						/* 0x6D000000 --> 0xfd000000 */
+#define OMAP243X_SDRC_VIRT	(OMAP243X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP243X_SDRC_SIZE	SZ_1M
 #define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
-#define OMAP243X_SMS_VIRT	0xFC000000
+						/* 0x6c000000 --> 0xfc000000 */
+#define OMAP243X_SMS_VIRT	(OMAP243X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP243X_SMS_SIZE	SZ_1M
 
 /* DSP */
@@ -123,12 +136,12 @@
  */
 
 /* We map both L3 and L4 on OMAP3 */
-#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
-#define L3_34XX_VIRT		0xf8000000
+#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 --> 0xf8000000 */
+#define L3_34XX_VIRT		(L3_34XX_PHYS + OMAP2_L3_IO_OFFSET)
 #define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
 
-#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 */
-#define L4_34XX_VIRT		0xd8000000
+#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 --> 0xfa000000 */
+#define L4_34XX_VIRT		(L4_34XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
 
 /*
@@ -136,28 +149,33 @@
  * VPOM3430 was not working for Int controller
  */
 
-#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE /* 0x48300000 */
-#define L4_WK_34XX_VIRT		0xd8300000
+#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE	/* 0x48300000 --> 0xfa300000 */
+#define L4_WK_34XX_VIRT		(L4_WK_34XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_WK_34XX_SIZE		SZ_1M
 
-#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE /* 0x49000000 */
-#define L4_PER_34XX_VIRT	0xd9000000
+#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE
+						/* 0x49000000 --> 0xfb000000 */
+#define L4_PER_34XX_VIRT	(L4_PER_34XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_PER_34XX_SIZE	SZ_1M
 
-#define L4_EMU_34XX_PHYS	L4_EMU_34XX_BASE /* 0x54000000 */
-#define L4_EMU_34XX_VIRT	0xe4000000
-#define L4_EMU_34XX_SIZE	SZ_64M
+#define L4_EMU_34XX_PHYS	L4_EMU_34XX_BASE
+						/* 0x54000000 --> 0xfe800000 */
+#define L4_EMU_34XX_VIRT	(L4_EMU_34XX_PHYS + OMAP2_EMU_IO_OFFSET)
+#define L4_EMU_34XX_SIZE	SZ_8M
 
-#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE /* 0x6E000000 */
-#define OMAP34XX_GPMC_VIRT	0xFE000000
+#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE
+						/* 0x6e000000 --> 0xfe000000 */
+#define OMAP34XX_GPMC_VIRT	(OMAP34XX_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP34XX_GPMC_SIZE	SZ_1M
 
-#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE /* 0x6C000000 */
-#define OMAP343X_SMS_VIRT	0xFC000000
+#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE
+						/* 0x6c000000 --> 0xfc000000 */
+#define OMAP343X_SMS_VIRT	(OMAP343X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP343X_SMS_SIZE	SZ_1M
 
-#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE /* 0x6D000000 */
-#define OMAP343X_SDRC_VIRT	0xFD000000
+#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE
+						/* 0x6D000000 --> 0xfd000000 */
+#define OMAP343X_SDRC_VIRT	(OMAP343X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
 #define OMAP343X_SDRC_SIZE	SZ_1M
 
 /* DSP */
@@ -178,29 +196,32 @@
  */
 
 /* We map both L3 and L4 on OMAP4 */
-#define L3_44XX_PHYS		L3_44XX_BASE
-#define L3_44XX_VIRT		0xd4000000
+#define L3_44XX_PHYS		L3_44XX_BASE	/* 0x44000000 --> 0xf8000000 */
+#define L3_44XX_VIRT		(L3_44XX_PHYS + OMAP4_L3_IO_OFFSET)
 #define L3_44XX_SIZE		SZ_1M
 
-#define L4_44XX_PHYS		L4_44XX_BASE
-#define L4_44XX_VIRT		0xda000000
+#define L4_44XX_PHYS		L4_44XX_BASE	/* 0x4a000000 --> 0xfc000000 */
+#define L4_44XX_VIRT		(L4_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_44XX_SIZE		SZ_4M
 
 
-#define L4_WK_44XX_PHYS		L4_WK_44XX_BASE
-#define L4_WK_44XX_VIRT		0xda300000
+#define L4_WK_44XX_PHYS		L4_WK_44XX_BASE	/* 0x4a300000 --> 0xfc300000 */
+#define L4_WK_44XX_VIRT		(L4_WK_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_WK_44XX_SIZE		SZ_1M
 
 #define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
-#define L4_PER_44XX_VIRT	0xd8000000
+						/* 0x48000000 --> 0xfa000000 */
+#define L4_PER_44XX_VIRT	(L4_PER_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_PER_44XX_SIZE	SZ_4M
 
 #define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
-#define L4_EMU_44XX_VIRT	0xe4000000
-#define L4_EMU_44XX_SIZE	SZ_64M
+						/* 0x54000000 --> 0xfe800000 */
+#define L4_EMU_44XX_VIRT	(L4_EMU_44XX_PHYS + OMAP2_EMU_IO_OFFSET)
+#define L4_EMU_44XX_SIZE	SZ_8M
 
 #define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
-#define OMAP44XX_GPMC_VIRT	0xe0000000
+						/* 0x50000000 --> 0xf9000000 */
+#define OMAP44XX_GPMC_VIRT	(OMAP44XX_GPMC_PHYS + OMAP4_GPMC_IO_OFFSET)
 #define OMAP44XX_GPMC_SIZE	SZ_1M
 
 
diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
index b97dfaf..9eebf62 100644
--- a/arch/arm/plat-omap/include/mach/vmalloc.h
+++ b/arch/arm/plat-omap/include/mach/vmalloc.h
@@ -17,5 +17,5 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
+#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
 

