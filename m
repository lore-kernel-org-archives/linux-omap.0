From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take a word-aligned pointer
Date: Mon, 17 Jan 2011 19:21:20 +0000
Message-ID: <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51081 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1AQTVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:21:42 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Add additional instructions to our assembly bitops functions to ensure
that they only operate on word-aligned pointers.  This will be necessary
when we switch these operations to use the word-based exclusive
operations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/lib/bitops.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index d422529..910d599 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,6 +1,8 @@
 
 #if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
 	.macro	bitop, instr
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	mov	r2, #1
 	and	r3, r0, #7		@ Get bit offset
 	add	r1, r1, r0, lsr #3	@ Get byte offset
@@ -14,6 +16,8 @@
 	.endm
 
 	.macro	testop, instr, store
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	and	r3, r0, #7		@ Get bit offset
 	mov	r2, #1
 	add	r1, r1, r0, lsr #3	@ Get byte offset
@@ -32,6 +36,8 @@
 	.endm
 #else
 	.macro	bitop, instr
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	and	r2, r0, #7
 	mov	r3, #1
 	mov	r3, r3, lsl r2
@@ -52,6 +58,8 @@
  * to avoid dirtying the data cache.
  */
 	.macro	testop, instr, store
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	add	r1, r1, r0, lsr #3
 	and	r3, r0, #7
 	mov	r0, #1
-- 
1.6.2.5

