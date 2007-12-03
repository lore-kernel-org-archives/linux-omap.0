From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP: User GPLv2 for MMU, make checkpatch.pl
	happier
Date: Mon, 3 Dec 2007 14:26:52 -0800
Message-ID: <20071203222651.GE4105@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <lethal@linux-sh.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul, Toshihiro & Hiroshi,

I'm preparing the MMU patches for submission to arm-linux mailing
list, and Paul Mundt requested changing the MMU license to be
GPLv2. Can you please take a look at the attached patch and ack?

Regards,

Tony

--gKMricLos+KVdGMg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mmu-gplv2.patch"

>From 35fee383a8d4d1e335f471cf12518d9b7ec2c9d1 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 3 Dec 2007 10:57:01 -0800
Subject: [PATCH] ARM: OMAP: User GPLv2 for MMU, make checkpatch.pl happier

This patch changes MMU code to use GPLv2 as requested by
Paul Mundt. It also does some minor formatting to make
checkpatch.pl mostly happy, and removes dummy release
function.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 2d05708..3bb3efe 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -9,18 +9,8 @@
  *        and Paul Mundt <paul.mundt@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <linux/types.h>
 #include <linux/init.h>
@@ -286,7 +276,7 @@ static void omap1_mmu_interrupt(struct omap_mmu *mmu)
 
 	/* if the fault is masked, nothing to do */
 	if ((status & MMUFAULT_MASK) == 0) {
-		pr_debug( "MMU interrupt, but ignoring.\n");
+		pr_debug("MMU interrupt, but ignoring.\n");
 		/*
 		 * note: in OMAP1710,
 		 * when CACHE + DMA domain gets out of idle in DSP,
@@ -294,16 +284,16 @@ static void omap1_mmu_interrupt(struct omap_mmu *mmu)
 		 * in this case, we just ignore the interrupt.
 		 */
 		if (status) {
-			pr_debug( "%s%s%s%s\n",
-				  (status & OMAP_MMU_FAULT_ST_PREF)?
-				  "  (prefetch err)" : "",
-				  (status & OMAP_MMU_FAULT_ST_PERM)?
-				  "  (permission fault)" : "",
-				  (status & OMAP_MMU_FAULT_ST_TLB_MISS)?
-				  "  (TLB miss)" : "",
-				  (status & OMAP_MMU_FAULT_ST_TRANS) ?
-				  "  (translation fault)": "");
-			pr_debug( "fault address = %#08lx\n", va);
+			pr_debug("%s%s%s%s\n",
+				 (status & OMAP_MMU_FAULT_ST_PREF)?
+				 "  (prefetch err)" : "",
+				 (status & OMAP_MMU_FAULT_ST_PERM)?
+				 "  (permission fault)" : "",
+				 (status & OMAP_MMU_FAULT_ST_TLB_MISS)?
+				 "  (TLB miss)" : "",
+				 (status & OMAP_MMU_FAULT_ST_TRANS) ?
+				 "  (translation fault)": "");
+			pr_debug("fault address = %#08lx\n", va);
 		}
 		enable_irq(mmu->irq);
 		return;
diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 521c3bf..918688e 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -76,7 +76,7 @@
 
 #define OMAP_MMU_LD_TLB_RD		0x0002
 
-#define INIT_TLB_ENTRY(ent,v,p,ps)			\
+#define INIT_TLB_ENTRY(ent, v, p, ps)			\
 do {							\
 	(ent)->va	= (v);				\
 	(ent)->pa	= (p);				\
@@ -86,7 +86,7 @@ do {							\
 	(ent)->tlb	= 1;				\
 } while (0)
 
-#define INIT_TLB_ENTRY_4KB_PRESERVED(ent,v,p)		\
+#define INIT_TLB_ENTRY_4KB_PRESERVED(ent, v, p)	\
 do {							\
 	(ent)->va	= (v);				\
 	(ent)->pa	= (p);				\
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index d5c1583..f8bb6df 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -11,18 +11,8 @@
  * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <linux/types.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 818ea8c..bae9db7 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -59,7 +59,7 @@
 
 #define IOMAP_VAL	0x3f
 
-#define INIT_TLB_ENTRY(ent,v,p,ps)				\
+#define INIT_TLB_ENTRY(ent, v, p, ps)				\
 do {								\
 	(ent)->va	= (v);					\
 	(ent)->pa	= (p);					\
@@ -71,7 +71,7 @@ do {								\
 	(ent)->tlb	= 1;					\
 } while (0)
 
-#define INIT_TLB_ENTRY_4KB_PRESERVED(ent,v,p) \
+#define INIT_TLB_ENTRY_4KB_PRESERVED(ent, v, p)		\
 do {								\
 	(ent)->va	= (v);					\
 	(ent)->pa	= (p);					\
@@ -82,7 +82,7 @@ do {								\
 	(ent)->mixed	= 0;					\
 } while (0)
 
-#define INIT_TLB_ENTRY_4KB_ES32_PRESERVED(ent,v,p)		\
+#define INIT_TLB_ENTRY_4KB_ES32_PRESERVED(ent, v, p)		\
 do {								\
 	(ent)->va	= (v);					\
 	(ent)->pa	= (p);					\
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 5c0a9ef..b7ae3d2 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -11,18 +11,8 @@
  * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 #include <linux/module.h>
 #include <linux/mempool.h>
@@ -1466,13 +1456,8 @@ static ssize_t mempool_show(struct class *class, char *buf)
 
 static CLASS_ATTR(mempool, S_IRUGO, mempool_show, NULL);
 
-static void omap_mmu_class_dev_release(struct device *dev)
-{
-}
-
 static struct class omap_mmu_class = {
 	.name		= "mmu",
-	.dev_release	= omap_mmu_class_dev_release,
 };
 
 int omap_mmu_register(struct omap_mmu *mmu)
diff --git a/include/asm-arm/arch-omap/dsp_common.h b/include/asm-arm/arch-omap/dsp_common.h
index c52b6c6..fa8f3a6 100644
--- a/include/asm-arm/arch-omap/dsp_common.h
+++ b/include/asm-arm/arch-omap/dsp_common.h
@@ -5,20 +5,9 @@
  *
  * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #ifndef ASM_ARCH_DSP_COMMON_H

--gKMricLos+KVdGMg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--gKMricLos+KVdGMg--
