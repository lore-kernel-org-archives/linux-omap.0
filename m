From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] ARM: OMAP: Increase VMALLOC_END to allow 256MB RAM
Date: Tue, 19 May 2009 16:32:11 -0700
Message-ID: <20090519233211.12760.40699.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51037 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZESXcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:32:14 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Mans Rullgard <mans@mansr.com>

From: Mans Rullgard <mans@mansr.com>

This increases VMALLOC_END to 0x18000000, making room for 256MB
RAM with the default 128MB vmalloc region.

Note that after this patch there's no longer a hole between vmalloc
space and the beginning of IO space on omap2 as the first virtual
mapping starts at 0xd8000000.

Also fold in a related change from Paul Walmsley <paul@pwsan.com>
to change the OMAP2_SRAM addresses accordingly.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/vmalloc.h |    2 +-
 arch/arm/plat-omap/sram.c                 |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
index dc104cd..b97dfaf 100644
--- a/arch/arm/plat-omap/include/mach/vmalloc.h
+++ b/arch/arm/plat-omap/include/mach/vmalloc.h
@@ -17,5 +17,5 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
 
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e1493d8..102c9f7 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -38,8 +38,8 @@
 #define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		VMALLOC_END
-#define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
+#define OMAP2_SRAM_VA		0xe3000000
+#define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000

