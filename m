From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] omap4: l2x0: enable instruction and data prefetching
Date: Fri, 19 Nov 2010 23:01:04 +0530
Message-ID: <1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55805 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab0KSRb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 12:31:27 -0500
In-Reply-To: <1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

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

What prefetch does is enable automatic next line prefetching. With this
enabled, whenever the PL310 receives a cachable read request, it
automatically prefetches the following cache line as well.

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

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index c814604..b3cea78 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -66,9 +66,6 @@ static int __init omap_l2_cache_init(void)
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
 	BUG_ON(!l2cache_base);
 
-	/* Enable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x1);
-
 	/*
 	 * 16-way associativity, parity disabled
 	 * Way size - 32KB (es1.0)
@@ -79,10 +76,18 @@ static int __init omap_l2_cache_init(void)
 			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
 			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT));
 
-	if (omap_rev() == OMAP4430_REV_ES1_0)
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
-	else
-		aux_ctrl |= 0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
+	} else {
+		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT));
+	}
+	if (omap_rev() != OMAP4430_REV_ES1_0)
+		omap_smc1(0x109, aux_ctrl);
+
+	/* Enable PL310 L2 Cache controller */
+	omap_smc1(0x102, 0x1);
 
 	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
 
-- 
1.6.0.4

