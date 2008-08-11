From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM TLB: add v7wbi_{possible,always}_flags to
 {possible,always}_tlb_flags
Date: Mon, 11 Aug 2008 14:03:10 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49398 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYHKUDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 16:03:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: catalin.marinas@arm.com, buytenh@wantstofly.org


Commit 2ccdd1e77da52ad494e9af46bf272d816830cb28 doesn't add 
v7wbi_possible_flags and v7wbi_always_flags to possible_tlb_flags and 
always_tlb_flags.  This causes the L2 cache flush in clean_pmd_entry() 
(intended for Feroceon only) to execute on ARMv7, and the CPU hangs.

This patch is required for OMAP3 boards to boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: <catalin.marinas@arm.com>
Cc: <buytenh@wantstofly.org>
---

 arch/arm/include/asm/tlbflush.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 0d0d40f..b543a05 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -54,6 +54,7 @@
  *	  v4wbi - ARMv4 with write buffer with I TLB flush entry instruction
  *	  fr    - Feroceon (v4wbi with non-outer-cacheable page table walks)
  *	  v6wbi - ARMv6 with write buffer with I TLB flush entry instruction
+ *	  v7wbi - identical to v6wbi
  */
 #undef _TLB
 #undef MULTI_TLB
@@ -266,14 +267,16 @@ extern struct cpu_tlb_fns cpu_tlb;
 				 v4wbi_possible_flags | \
 				 fr_possible_flags | \
 				 v4wb_possible_flags | \
-				 v6wbi_possible_flags)
+				 v6wbi_possible_flags | \
+				 v7wbi_possible_flags)
 
 #define always_tlb_flags	(v3_always_flags & \
 				 v4_always_flags & \
 				 v4wbi_always_flags & \
 				 fr_always_flags & \
 				 v4wb_always_flags & \
-				 v6wbi_always_flags)
+				 v6wbi_always_flags & \
+				 v7wbi_always_flags)
 
 #define tlb_flag(f)	((always_tlb_flags & (f)) || (__tlb_flag & possible_tlb_flags & (f)))
 
