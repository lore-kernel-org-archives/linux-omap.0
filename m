From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 2/6] ARM: mm: add v7 cache LoUIS API implementation
Date: Thu, 13 Sep 2012 11:20:47 +0100
Message-ID: <1347531651-28218-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47783 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205Ab2IMKVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:21:09 -0400
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

ARM v7 architecture introduces the concept of cache levels and registers to
probe and manage cache levels accordingly.

This patch adds v7 support for cache LoUIS (Level of Unification Inner
Shareable) operations and defines a function that allows to clean and
invalidate data caches up to LoUIS.

Power-down operations like hotplug and CPU idle require to clean/invalidate
only cache levels that are within the CPU power domain, and LoUIS reflects
this requirement properly in most of the systems.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 39e3fb3..74aec79 100644
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
+=09mrc=09p15, 1, r0, c0, c0, 1=09=09@ read clidr
+=09ands=09r3, r0, #0xe00000=09=09@ extract louis from clidr
+=09mov=09r3, r3, lsr #20=09=09=09@ left align louis bit field
+=09moveq=09pc, lr=09=09=09=09@ return if level =3D=3D 0
+=09mov=09r10, #0=09=09=09=09@ starting level =3D=3D 0
+=09b=09__flush_level
+ENDPROC(v7_flush_dcache_louis)
+
 /*
  *=09v7_flush_dcache_all()
  *
@@ -49,7 +67,7 @@ ENTRY(v7_flush_dcache_all)
 =09mov=09r3, r3, lsr #23=09=09=09@ left align loc bit field
 =09beq=09finished=09=09=09@ if loc is 0, then no need to clean
 =09mov=09r10, #0=09=09=09=09@ start clean at cache level 0
-loop1:
+__flush_level:
 =09add=09r2, r10, r10, lsr #1=09=09@ work out 3x current cache level
 =09mov=09r1, r0, lsr r2=09=09=09@ extract cache type bits from clidr
 =09and=09r1, r1, #7=09=09=09@ mask of the bits for current cache only
@@ -88,7 +106,7 @@ loop3:
 skip:
 =09add=09r10, r10, #2=09=09=09@ increment cache number
 =09cmp=09r3, r10
-=09bgt=09loop1
+=09bgt=09__flush_level
 finished:
 =09mov=09r10, #0=09=09=09=09@ swith back to cache level 0
 =09mcr=09p15, 2, r10, c0, c0, 0=09=09@ select current cache level in cssr
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
@@ -350,4 +386,4 @@ ENDPROC(v7_dma_unmap_area)
 =09__INITDATA
=20
 =09@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S=
)
-=09define_cache_functions v7
+       define_cache_functions v7, cachelouis=3D1
--=20
1.7.12


