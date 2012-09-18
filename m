From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH v2 2/5] ARM: mm: rename jump labels in v7_flush_dcache_all function
Date: Tue, 18 Sep 2012 17:35:32 +0100
Message-ID: <1347986135-17979-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39656 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2IRQgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 12:36:00 -0400
In-Reply-To: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

This patch renames jump labels in v7_flush_dcache_all in order to define
a specific flush cache levels entry point.

TODO: factor out the level flushing loop if considered worthwhile and
      define the input registers requirements.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d1fa2f6..140b294 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -48,7 +48,7 @@ ENTRY(v7_flush_dcache_louis)
 =09mov=09r3, r3, lsr #20=09=09=09@ r3 =3D LoUIS * 2
 =09moveq=09pc, lr=09=09=09=09@ return if level =3D=3D 0
 =09mov=09r10, #0=09=09=09=09@ r10 (starting level) =3D 0
-=09b=09loop1=09=09=09=09@ start flushing cache levels
+=09b=09flush_levels=09=09=09@ start flushing cache levels
 ENDPROC(v7_flush_dcache_louis)
=20
 /*
@@ -67,7 +67,7 @@ ENTRY(v7_flush_dcache_all)
 =09mov=09r3, r3, lsr #23=09=09=09@ left align loc bit field
 =09beq=09finished=09=09=09@ if loc is 0, then no need to clean
 =09mov=09r10, #0=09=09=09=09@ start clean at cache level 0
-loop1:
+flush_levels:
 =09add=09r2, r10, r10, lsr #1=09=09@ work out 3x current cache level
 =09mov=09r1, r0, lsr r2=09=09=09@ extract cache type bits from clidr
 =09and=09r1, r1, #7=09=09=09@ mask of the bits for current cache only
@@ -89,9 +89,9 @@ loop1:
 =09clz=09r5, r4=09=09=09=09@ find bit position of way size increment
 =09ldr=09r7, =3D0x7fff
 =09ands=09r7, r7, r1, lsr #13=09=09@ extract max number of the index size
-loop2:
+loop1:
 =09mov=09r9, r4=09=09=09=09@ create working copy of max way size
-loop3:
+loop2:
  ARM(=09orr=09r11, r10, r9, lsl r5=09)=09@ factor way and cache number int=
o r11
  THUMB(=09lsl=09r6, r9, r5=09=09)
  THUMB(=09orr=09r11, r10, r6=09=09)=09@ factor way and cache number into r=
11
@@ -100,13 +100,13 @@ loop3:
  THUMB(=09orr=09r11, r11, r6=09=09)=09@ factor index number into r11
 =09mcr=09p15, 0, r11, c7, c14, 2=09=09@ clean & invalidate by set/way
 =09subs=09r9, r9, #1=09=09=09@ decrement the way
-=09bge=09loop3
-=09subs=09r7, r7, #1=09=09=09@ decrement the index
 =09bge=09loop2
+=09subs=09r7, r7, #1=09=09=09@ decrement the index
+=09bge=09loop1
 skip:
 =09add=09r10, r10, #2=09=09=09@ increment cache number
 =09cmp=09r3, r10
-=09bgt=09loop1
+=09bgt=09flush_levels
 finished:
 =09mov=09r10, #0=09=09=09=09@ swith back to cache level 0
 =09mcr=09p15, 2, r10, c0, c0, 0=09=09@ select current cache level in cssr
--=20
1.7.12


