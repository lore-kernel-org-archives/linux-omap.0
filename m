From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache maintenance ops
Date: Thu, 13 Sep 2012 11:20:46 +0100
Message-ID: <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47678 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694Ab2IMKVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:21:09 -0400
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

ARM v7 architecture introduced the concept of cache levels and related
coherency requirements. New processors like A7 and A15 embed an
L2 unified cache controller that becomes part of the cache level
hierarchy. Some operations in the kernel like cpu_suspend and __cpu_disable
does not require a flush of the entire cache hierarchy to DRAM but just the
cache levels belonging to the Level of Unification Inner Shareable (LoUIS),
which in most of ARM v7 systems correspond to L1.

The current cache flushing API used in cpu_suspend and __cpu_disable,
flush_cache_all(), ends up flushing the whole cache hierarchy since for
v7 it cleans and invalidates all cache levels up to Level of Coherency
(LoC) which cripples system performance when used in hot paths like hotplug
and cpuidle.

Therefore a new kernel cache maintenance API must be added to the
cpu_cache_fns structure of pointers to cope with latest ARM system requirem=
ents.
This patch adds flush_cache_louis() to the ARM kernel cache maintenance API=
.

This function cleans and invalidates all data cache levels up to the
level of unification inner shareable (LoUIS) and invalidates the instructio=
n
cache.

The cpu_cache_fns struct reflects this change by adding a new function poin=
ter
that is initialized by arch specific assembly files.

By default, all existing ARM archs do not instantiate any cache LoUIS funct=
ion
pointer, and flush_dcache_louis just falls back to flush_kern_all.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/cacheflush.h | 17 +++++++++++++++++
 arch/arm/mm/proc-macros.S         |  7 ++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cache=
flush.h
index c6e2ed9..7683316 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -50,6 +50,13 @@
  *
  *=09=09Unconditionally clean and invalidate the entire cache.
  *
+ *     flush_kern_cache_louis()
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
+=09void (*flush_kern_cache_louis)(void);
 =09void (*flush_user_all)(void);
 =09void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
=20
@@ -200,6 +208,15 @@ extern void copy_to_user_page(struct vm_area_struct *,=
 struct page *,
 #define __flush_icache_preferred=09__flush_icache_all_generic
 #endif
=20
+/*
+ * Flush caches up to Level of Unification Inner Shareable
+ */
+#ifdef MULTI_CACHE
+#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
+#else
+#define flush_cache_louis()   __cpuc_flush_kern_all()
+#endif
+
 static inline void __flush_icache_all(void)
 {
 =09__flush_icache_preferred();
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..28e91f8 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -293,12 +293,17 @@ ENTRY(\name\()_processor_functions)
 =09.size=09\name\()_processor_functions, . - \name\()_processor_functions
 .endm
=20
-.macro define_cache_functions name:req
+.macro define_cache_functions name:req, cachelouis=3D0
 =09.align 2
 =09.type=09\name\()_cache_fns, #object
 ENTRY(\name\()_cache_fns)
 =09.long=09\name\()_flush_icache_all
 =09.long=09\name\()_flush_kern_cache_all
+=09.if \cachelouis
+=09.long   \name\()_flush_kern_cache_louis
+=09.else
+=09.long   \name\()_flush_kern_cache_all
+=09.endif
 =09.long=09\name\()_flush_user_cache_all
 =09.long=09\name\()_flush_user_cache_range
 =09.long=09\name\()_coherent_kern_range
--=20
1.7.12


