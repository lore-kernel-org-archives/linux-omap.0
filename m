From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 5/6] ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API
Date: Thu, 13 Sep 2012 11:20:50 +0100
Message-ID: <1347531651-28218-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47852 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340Ab2IMKVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:21:10 -0400
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

When a CPU is hotplugged out caches that reside in its power domain
lose their contents and so must be cleaned to the next memory level.

Currently, __cpu_disable calls flush_cache_all() that for new generation
processor like A15/A7 ends up cleaning and invalidating all cache levels
up to Level of Coherency, which includes the unified L2.

This ends up being a waste of cycles since the L2 cache contents are not
lost on power down.

This patch updates __cpu_disable to use the new LoUIS API cache operations.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d3eb222..f44e9cd 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -136,8 +136,11 @@ int __cpu_disable(void)
 =09/*
 =09 * Flush user cache and TLB mappings, and then remove this CPU
 =09 * from the vm mask set of all processes.
+=09 *
+=09 * Caches are flushed to the Level of Unification Inner Shareable
+=09 * to write-back dirty lines to unified caches shared by all CPUs.
 =09 */
-=09flush_cache_all();
+=09flush_cache_louis();
 =09local_flush_tlb_all();
=20
 =09clear_tasks_mm_cpumask(cpu);
--=20
1.7.12


