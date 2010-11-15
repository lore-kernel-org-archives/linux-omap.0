From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] omap4: enable L2 prefetching
Date: Mon, 15 Nov 2010 10:20:44 -0600
Message-ID: <1289838044-32016-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab0KOQU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 11:20:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Mans Rullgard <mans@mansr.com>

From: Mans Rullgard <mans@mansr.com>

Enabling L2 prefetching improves performance as shown on Panda
ES2.1 board with mem test, and it has measurable impact on
performances. I think we should consider it, even though it damages
"writes" a bit. (rebased to k.org)
Usually the prefetch is used at both levels together L1 + L2, however,
to enable the CP15 prefetch engines, these are under security, and on
GP devices, we cannot enable it(e.g. on PandaBoard). However, just
enabling PL310 prefetch seems to provide performance improvement,
as shown in the data below (from Ubuntu) and would be a great thing
to pull in.

Measurement Data:
==
STOCK 10.10 WITHOUT PATCH
========================
~# ./memspeed
size    8388608 8192k 8M
offset  8388608, 0
buffers 0x2aaad000 0x2b2ad000
copy  libc          133 MB/s
copy  Android v5    273 MB/s
copy  Android NEON  235 MB/s
copy  INT32         116 MB/s
copy  ASM ARM       187 MB/s
copy  ASM VLDM 64   204 MB/s
copy  ASM VLDM 128  173 MB/s
copy  ASM VLD1      216 MB/s
read  ASM ARM       286 MB/s
read  ASM VLDM      242 MB/s
read  ASM VLD1      286 MB/s
write libc         1947 MB/s
write ASM ARM      1943 MB/s
write ASM VSTM     1942 MB/s
write ASM VST1     1935 MB/s

10.10 + PATCH
=============
~# ./memspeed
size    8388608 8192k 8M
offset  8388608, 0
buffers 0x2ab17000 0x2b317000
copy  libc          129 MB/s
copy  Android v5    256 MB/s
copy  Android NEON  356 MB/s
copy  INT32         127 MB/s
copy  ASM ARM       321 MB/s
copy  ASM VLDM 64   337 MB/s
copy  ASM VLDM 128  321 MB/s
copy  ASM VLD1      350 MB/s
read  ASM ARM       496 MB/s
read  ASM VLDM      470 MB/s
read  ASM VLD1      488 MB/s
write libc         1701 MB/s
write ASM ARM      1682 MB/s
write ASM VSTM     1693 MB/s
write ASM VST1     1681 MB/s

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Original:
http://git.mansr.com/?p=linux-panda;a=commit;h=450b17993ba7c36cea3f2c746ae26c268563ee59
http://git.tif.ti.com/vstehle/kernel-ubuntu.git?a=shortlog;h=refs/heads/vincent/mans-patches

 arch/arm/mach-omap2/omap4-common.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2f89555..a5e6126 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -64,6 +64,10 @@ static int __init omap_l2_cache_init(void)
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
 	BUG_ON(!l2cache_base);
 
+	if (omap_rev() != OMAP4430_REV_ES1_0)
+		omap_smc1(0x109, 0x7e470000);
+
+
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
 
@@ -75,7 +79,7 @@ static int __init omap_l2_cache_init(void)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
 	else
-		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
+		l2x0_init(l2cache_base, 0x7e470000, 0xc0000fff);
 
 	/*
 	 * Override default outer_cache.disable with a OMAP4
-- 
1.6.3.3

