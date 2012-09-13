From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 3/6] ARM: mm: add v7 dcache level API
Date: Thu, 13 Sep 2012 11:20:48 +0100
Message-ID: <1347531651-28218-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47771 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab2IMKVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:21:09 -0400
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On ARMv7 based SOC with an integrated L2 cache, there is a need
to have a flush API to operate on each cache level. In few low
power modes, L2 cache is retained whereas L1 is lost. The current
v7_flush_dcache_all(), flushes all the levels and it would be quite
expensive in cases where only one of the level needs to be flushed.

So this patch introduces v7_flush_dcache_level() API which takes a
parameter (cache level), and flush only that level.
This API is useful for the power management code where depending on CPU
and CPU cluster low power state, a specific cache level can be cleaned
instead of cleaning all the cache levels with existing flush_dcache_all().

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 74aec79..d0fbe5c 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -51,6 +51,26 @@ ENTRY(v7_flush_dcache_louis)
 =09b=09__flush_level
 ENDPROC(v7_flush_dcache_louis)
=20
+ /*
+ *     v7_flush_dcache_level(level)
+ *
+ *     Flush the D-cache the specified level passed as input parameter.
+ *
+ *     r0 - cache level
+ *
+ *     Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+
+ENTRY(v7_flush_dcache_level)
+=09dmb=09=09=09=09=09@ ensure ordering with previous memory accesses
+=09sub=09r10, r0, #1
+=09mov=09r10, r10, lsl #1
+=09movs=09r3, r0, lsl #1=09=09=09@ level * 2
+=09mrc=09p15, 1, r0, c0, c0, 1=09=09@ read clidr
+=09moveq=09pc, lr=09=09=09=09@ return if level =3D=3D 0
+=09b=09__flush_level
+ENDPROC(v7_flush_dcache_level)
+
 /*
  *=09v7_flush_dcache_all()
  *
--=20
1.7.12


