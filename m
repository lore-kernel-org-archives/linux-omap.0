From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 6/6] ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API
Date: Thu, 13 Sep 2012 11:20:51 +0100
Message-ID: <1347531651-28218-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48008 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab2IMKVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:21:12 -0400
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

The ARMv7 processor setup function __v7_setup() cleans and invalidates the
CPU cache before enabling MMU to start the CPU with a clean CPU local cache=
.

But on ARMv7 architectures like Cortex-[A15/A8], this code will end
up flushing the L2 caches(up to level of Coherency) which is undesirable
and expensive. The setup functions are used in the CPU hotplug scenario too
and hence flushing all cache levels should be avoided.

This patch replaces the cache flushing call with the newly introduced
v7 dcache LoUIS API where only cache levels up to LoUIS are cleaned and
invalidated when a processors executes __v7_setup which is the expected
behavior.

For processors like A9 and A5 where the L2 cache is an outer one the
behavior should be unchanged.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/proc-v7.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index c2e2b66..846d279 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -172,7 +172,7 @@ __v7_ca15mp_setup:
 __v7_setup:
 =09adr=09r12, __v7_setup_stack=09=09@ the local stack
 =09stmia=09r12, {r0-r5, r7, r9, r11, lr}
-=09bl=09v7_flush_dcache_all
+=09bl      v7_flush_dcache_louis
 =09ldmia=09r12, {r0-r5, r7, r9, r11, lr}
=20
 =09mrc=09p15, 0, r0, c0, c0, 0=09=09@ read main ID register
--=20
1.7.12


