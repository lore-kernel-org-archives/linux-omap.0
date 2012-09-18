From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH v2 1/5] ARM: mm: implement LoUIS API for cache maintenance ops
Date: Tue, 18 Sep 2012 17:35:31 +0100
Message-ID: <1347986135-17979-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39485 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2IRQgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 12:36:00 -0400
In-Reply-To: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

ARM v7 architecture introduced the concept of cache levels and related
control registers. New processors like A7 and A15 embed an L2 unified cache
controller that becomes part of the cache level hierarchy. Some operations =
in
the kernel like cpu_suspend and __cpu_disable do not require a flush of the
entire cache hierarchy to DRAM but just the cache levels belonging to the
Level of Unification Inner Shareable (LoUIS), which in most of ARM v7 syste=
ms
correspond to L1.

The current cache flushing API used in cpu_suspend and __cpu_disable,
flush_cache_all(), ends up flushing the whole cache hierarchy since for
v7 it cleans and invalidates all cache levels up to Level of Coherency
(LoC) which cripples system performance when used in hot paths like hotplug
and cpuidle.

Therefore a new kernel cache maintenance API must be added to cope with
latest ARM system requirements.

This patch adds flush_cache_louis() to the ARM kernel cache maintenance API=
.

This function cleans and invalidates all data cache levels up to the
Level of Unification Inner Shareable (LoUIS) and invalidates the instructio=
n
cache for processors that support it (> v7).

This patch also creates an alias of the cache LoUIS function to flush_kern_=
all
for all processor versions prior to v7, so that the current cache flushing
behaviour is unchanged for those processors.

v7 cache maintenance code implements a cache LoUIS function that cleans and
invalidates the D-cache up to LoUIS and invalidates the I-cache, according
to the new API.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/cacheflush.h | 15 +++++++++++++++
 arch/arm/include/asm/glue-cache.h |  1 +
 arch/arm/mm/cache-fa.S            |  3 +++
 arch/arm/mm/cache-v3.S            |  3 +++
 arch/arm/mm/cache-v4.S            |  3 +++
 arch/arm/mm/cache-v4wb.S          |  3 +++
 arch/arm/mm/cache-v4wt.S          |  3 +++
 arch/arm/mm/cache-v6.S            |  3 +++
 arch/arm/mm/cache-v7.S            | 36 +++++++++++++++++++++++++++++++++++=
+
 arch/arm/mm/proc-arm1020.S        |  3 +++
 arch/arm/mm/proc-arm1020e.S       |  3 +++
 arch/arm/mm/proc-arm1022.S        |  3 +++
 arch/arm/mm/proc-arm1026.S        |  3 +++
 arch/arm/mm/proc-arm920.S         |  3 +++
 arch/arm/mm/proc-arm922.S         |  3 +++
 arch/arm/mm/proc-arm925.S         |  3 +++
 arch/arm/mm/proc-arm926.S         |  3 +++
 arch/arm/mm/proc-arm940.S         |  3 +++
 arch/arm/mm/proc-arm946.S         |  3 +++
 arch/arm/mm/proc-feroceon.S       |  3 +++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  3 +++
 24 files changed, 113 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cache=
flush.h
index c6e2ed9..4e8217b 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -50,6 +50,13 @@
  *
  *=09=09Unconditionally clean and invalidate the entire cache.
  *
+ *     flush_kern_louis()
+ *
+ *             Flush data cache levels up to the level of unification
+ *             inner shareable and invalidate the I-cache.
+ *             Only needed from v7 onwards, falls back to flush_cache_all(=
)
+ *             for all other processor versions.
+ *
  *=09flush_user_all()
  *
  *=09=09Clean and invalidate all user space cache entries
@@ -98,6 +105,7 @@
 struct cpu_cache_fns {
 =09void (*flush_icache_all)(void);
 =09void (*flush_kern_all)(void);
+=09void (*flush_kern_louis)(void);
 =09void (*flush_user_all)(void);
 =09void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
=20
@@ -120,6 +128,7 @@ extern struct cpu_cache_fns cpu_cache;
=20
 #define __cpuc_flush_icache_all=09=09cpu_cache.flush_icache_all
 #define __cpuc_flush_kern_all=09=09cpu_cache.flush_kern_all
+#define __cpuc_flush_kern_louis=09=09cpu_cache.flush_kern_louis
 #define __cpuc_flush_user_all=09=09cpu_cache.flush_user_all
 #define __cpuc_flush_user_range=09=09cpu_cache.flush_user_range
 #define __cpuc_coherent_kern_range=09cpu_cache.coherent_kern_range
@@ -140,6 +149,7 @@ extern struct cpu_cache_fns cpu_cache;
=20
 extern void __cpuc_flush_icache_all(void);
 extern void __cpuc_flush_kern_all(void);
+extern void __cpuc_flush_kern_louis(void);
 extern void __cpuc_flush_user_all(void);
 extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned=
 int);
 extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
@@ -205,6 +215,11 @@ static inline void __flush_icache_all(void)
 =09__flush_icache_preferred();
 }
=20
+/*
+ * Flush caches up to Level of Unification Inner Shareable
+ */
+#define flush_cache_louis()=09=09__cpuc_flush_kern_louis()
+
 #define flush_cache_all()=09=09__cpuc_flush_kern_all()
=20
 static inline void vivt_flush_cache_mm(struct mm_struct *mm)
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-=
cache.h
index 7e30874..2d6a7de 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -132,6 +132,7 @@
 #ifndef MULTI_CACHE
 #define __cpuc_flush_icache_all=09=09__glue(_CACHE,_flush_icache_all)
 #define __cpuc_flush_kern_all=09=09__glue(_CACHE,_flush_kern_cache_all)
+#define __cpuc_flush_kern_louis=09=09__glue(_CACHE,_flush_kern_cache_louis=
)
 #define __cpuc_flush_user_all=09=09__glue(_CACHE,_flush_user_cache_all)
 #define __cpuc_flush_user_range=09=09__glue(_CACHE,_flush_user_cache_range=
)
 #define __cpuc_coherent_kern_range=09__glue(_CACHE,_coherent_kern_range)
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 0720163..e505bef 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -240,6 +240,9 @@ ENTRY(fa_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(fa_dma_unmap_area)
=20
+=09.globl=09fa_flush_kern_cache_louis
+=09.equ=09fa_flush_kern_cache_louis, fa_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index 52e35f3..8a3fade 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -128,6 +128,9 @@ ENTRY(v3_dma_map_area)
 ENDPROC(v3_dma_unmap_area)
 ENDPROC(v3_dma_map_area)
=20
+=09.globl=09v3_flush_kern_cache_louis
+=09.equ=09v3_flush_kern_cache_louis, v3_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 022135d..43e5d77 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -140,6 +140,9 @@ ENTRY(v4_dma_map_area)
 ENDPROC(v4_dma_unmap_area)
 ENDPROC(v4_dma_map_area)
=20
+=09.globl=09v4_flush_kern_cache_louis
+=09.equ=09v4_flush_kern_cache_louis, v4_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 8f1eeae..cd49453 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -251,6 +251,9 @@ ENTRY(v4wb_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(v4wb_dma_unmap_area)
=20
+=09.globl=09v4wb_flush_kern_cache_louis
+=09.equ=09v4wb_flush_kern_cache_louis, v4wb_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index b34a5f9..11e5e58 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -196,6 +196,9 @@ ENTRY(v4wt_dma_map_area)
 ENDPROC(v4wt_dma_unmap_area)
 ENDPROC(v4wt_dma_map_area)
=20
+=09.globl=09v4wt_flush_kern_cache_louis
+=09.equ=09v4wt_flush_kern_cache_louis, v4wt_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index f4e6027..7a3d3d8 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -343,6 +343,9 @@ ENTRY(v6_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(v6_dma_unmap_area)
=20
+=09.globl=09v6_flush_kern_cache_louis
+=09.equ=09v6_flush_kern_cache_louis, v6_flush_kern_cache_all
+
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 39e3fb3..d1fa2f6 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -33,6 +33,24 @@ ENTRY(v7_flush_icache_all)
 =09mov=09pc, lr
 ENDPROC(v7_flush_icache_all)
=20
+ /*
+ *     v7_flush_dcache_louis()
+ *
+ *     Flush the D-cache up to the Level of Unification Inner Shareable
+ *
+ *     Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+
+ENTRY(v7_flush_dcache_louis)
+=09dmb=09=09=09=09=09@ ensure ordering with previous memory accesses
+=09mrc=09p15, 1, r0, c0, c0, 1=09=09@ read clidr, r0 =3D clidr
+=09ands=09r3, r0, #0xe00000=09=09@ extract LoUIS from clidr
+=09mov=09r3, r3, lsr #20=09=09=09@ r3 =3D LoUIS * 2
+=09moveq=09pc, lr=09=09=09=09@ return if level =3D=3D 0
+=09mov=09r10, #0=09=09=09=09@ r10 (starting level) =3D 0
+=09b=09loop1=09=09=09=09@ start flushing cache levels
+ENDPROC(v7_flush_dcache_louis)
+
 /*
  *=09v7_flush_dcache_all()
  *
@@ -120,6 +138,24 @@ ENTRY(v7_flush_kern_cache_all)
 =09mov=09pc, lr
 ENDPROC(v7_flush_kern_cache_all)
=20
+ /*
+ *     v7_flush_kern_cache_louis(void)
+ *
+ *     Flush the data cache up to Level of Unification Inner Shareable.
+ *     Invalidate the I-cache to the point of unification.
+ */
+ENTRY(v7_flush_kern_cache_louis)
+ ARM(=09stmfd=09sp!, {r4-r5, r7, r9-r11, lr}=09)
+ THUMB(=09stmfd=09sp!, {r4-r7, r9-r11, lr}=09)
+=09bl=09v7_flush_dcache_louis
+=09mov=09r0, #0
+=09ALT_SMP(mcr=09p15, 0, r0, c7, c1, 0)=09@ invalidate I-cache inner share=
able
+=09ALT_UP(mcr=09p15, 0, r0, c7, c5, 0)=09@ I+BTB cache invalidate
+ ARM(=09ldmfd=09sp!, {r4-r5, r7, r9-r11, lr}=09)
+ THUMB(=09ldmfd=09sp!, {r4-r7, r9-r11, lr}=09)
+=09mov=09pc, lr
+ENDPROC(v7_flush_kern_cache_louis)
+
 /*
  *=09v7_flush_cache_all()
  *
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 0650bb8..2bb61e7 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -368,6 +368,9 @@ ENTRY(arm1020_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm1020_dma_unmap_area)
=20
+=09.globl=09arm1020_flush_kern_cache_louis
+=09.equ=09arm1020_flush_kern_cache_louis, arm1020_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm1020
=20
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 4188478..8f96aa4 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -354,6 +354,9 @@ ENTRY(arm1020e_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm1020e_dma_unmap_area)
=20
+=09.globl=09arm1020e_flush_kern_cache_louis
+=09.equ=09arm1020e_flush_kern_cache_louis, arm1020e_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm1020e
=20
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 33c6882..8ebe4a4 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -343,6 +343,9 @@ ENTRY(arm1022_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm1022_dma_unmap_area)
=20
+=09.globl=09arm1022_flush_kern_cache_louis
+=09.equ=09arm1022_flush_kern_cache_louis, arm1022_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm1022
=20
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index fbc1d5f..093fc7e 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -337,6 +337,9 @@ ENTRY(arm1026_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm1026_dma_unmap_area)
=20
+=09.globl=09arm1026_flush_kern_cache_louis
+=09.equ=09arm1026_flush_kern_cache_louis, arm1026_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm1026
=20
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 1a8c138..2c3b942 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -319,6 +319,9 @@ ENTRY(arm920_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm920_dma_unmap_area)
=20
+=09.globl=09arm920_flush_kern_cache_louis
+=09.equ=09arm920_flush_kern_cache_louis, arm920_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm920
 #endif
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 4c44d7e..4464c49 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -321,6 +321,9 @@ ENTRY(arm922_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm922_dma_unmap_area)
=20
+=09.globl=09arm922_flush_kern_cache_louis
+=09.equ=09arm922_flush_kern_cache_louis, arm922_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm922
 #endif
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index ec5b118..281eb9b 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -376,6 +376,9 @@ ENTRY(arm925_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm925_dma_unmap_area)
=20
+=09.globl=09arm925_flush_kern_cache_louis
+=09.equ=09arm925_flush_kern_cache_louis, arm925_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm925
=20
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index c31e62c..f1803f7 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -339,6 +339,9 @@ ENTRY(arm926_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm926_dma_unmap_area)
=20
+=09.globl=09arm926_flush_kern_cache_louis
+=09.equ=09arm926_flush_kern_cache_louis, arm926_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm926
=20
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index a613a7d..8da189d 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -267,6 +267,9 @@ ENTRY(arm940_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm940_dma_unmap_area)
=20
+=09.globl=09arm940_flush_kern_cache_louis
+=09.equ=09arm940_flush_kern_cache_louis, arm940_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm940
=20
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 9f4f299..f666cf3 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -310,6 +310,9 @@ ENTRY(arm946_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(arm946_dma_unmap_area)
=20
+=09.globl=09arm946_flush_kern_cache_louis
+=09.equ=09arm946_flush_kern_cache_louis, arm946_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions arm946
=20
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 23a8e4c..85e5e3b 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -415,6 +415,9 @@ ENTRY(feroceon_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(feroceon_dma_unmap_area)
=20
+=09.globl=09feroceon_flush_kern_cache_louis
+=09.equ=09feroceon_flush_kern_cache_louis, feroceon_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions feroceon
=20
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..b29a226 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -299,6 +299,7 @@ ENTRY(\name\()_processor_functions)
 ENTRY(\name\()_cache_fns)
 =09.long=09\name\()_flush_icache_all
 =09.long=09\name\()_flush_kern_cache_all
+=09.long   \name\()_flush_kern_cache_louis
 =09.long=09\name\()_flush_user_cache_all
 =09.long=09\name\()_flush_user_cache_range
 =09.long=09\name\()_coherent_kern_range
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index fbb2124..82f9cdc 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -303,6 +303,9 @@ ENTRY(mohawk_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(mohawk_dma_unmap_area)
=20
+=09.globl=09mohawk_flush_kern_cache_louis
+=09.equ=09mohawk_flush_kern_cache_louis, mohawk_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions mohawk
=20
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index b0d5786..eb93d64 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -337,6 +337,9 @@ ENTRY(xsc3_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(xsc3_dma_unmap_area)
=20
+=09.globl=09xsc3_flush_kern_cache_louis
+=09.equ=09xsc3_flush_kern_cache_louis, xsc3_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions xsc3
=20
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 4ffebaa..b5ea31d 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -410,6 +410,9 @@ ENTRY(xscale_dma_unmap_area)
 =09mov=09pc, lr
 ENDPROC(xscale_dma_unmap_area)
=20
+=09.globl=09xscale_flush_kern_cache_louis
+=09.equ=09xscale_flush_kern_cache_louis, xscale_flush_kern_cache_all
+
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
 =09define_cache_functions xscale
=20
--=20
1.7.12


