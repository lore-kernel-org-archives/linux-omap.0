From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use cache LoUIS operations
Date: Tue, 18 Sep 2012 17:35:33 +0100
Message-ID: <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39954 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab2IRQgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 12:36:01 -0400
In-Reply-To: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

In processors like A15/A7 L2 cache is unified and integrated within the
processor cache hierarchy, so that it is not considered an outer cache
anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
all cache levels up to Level of Coherency (LoC) that includes
the L2 unified cache.

When a single CPU is suspended (CPU idle) a complete L2 clean is not
required, so generic cpu_suspend code must clean the data cache using the
newly introduced cache LoUIS function.

The context and stack pointer (context pointer) are cleaned to main memory
using cache area functions that operate on MVA and guarantee that the data
is written back to main memory (perform cache cleaning up to the Point of
Coherency - PoC) so that the processor can fetch the context when the MMU
is off in the cpu_resume code path.

outer_cache management remains unchanged.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/suspend.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 1794cc3..358bca3 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -17,6 +17,8 @@ extern void cpu_resume_mmu(void);
  */
 void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 {
+=09u32 *ctx =3D ptr;
+
 =09*save_ptr =3D virt_to_phys(ptr);
=20
 =09/* This must correspond to the LDM in cpu_resume() assembly */
@@ -26,7 +28,20 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32=
 *save_ptr)
=20
 =09cpu_do_suspend(ptr);
=20
-=09flush_cache_all();
+=09flush_cache_louis();
+
+=09/*
+=09 * flush_cache_louis does not guarantee that
+=09 * save_ptr and ptr are cleaned to main memory,
+=09 * just up to the Level of Unification Inner Shareable.
+=09 * Since the context pointer and context itself
+=09 * are to be retrieved with the MMU off that
+=09 * data must be cleaned from all cache levels
+=09 * to main memory using "area" cache primitives.
+=09*/
+=09__cpuc_flush_dcache_area(ctx, ptrsz);
+=09__cpuc_flush_dcache_area(save_ptr, sizeof(*save_ptr));
+
 =09outer_clean_range(*save_ptr, *save_ptr + ptrsz);
 =09outer_clean_range(virt_to_phys(save_ptr),
 =09=09=09  virt_to_phys(save_ptr) + sizeof(*save_ptr));
--=20
1.7.12


