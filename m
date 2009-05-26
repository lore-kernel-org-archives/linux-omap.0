From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] OMAP3 clock: remove wait for DPLL3 M2 clock to stabilize
Date: Tue, 26 May 2009 16:12:28 -0600
Message-ID: <20090526221226.25381.8156.stgit@localhost.localdomain>
References: <20090526220517.25381.75976.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33546 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758678AbZEZWWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 18:22:25 -0400
In-Reply-To: <20090526220517.25381.75976.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

The original CDP kernel that this code comes from waited for 0x800
loops after switching the CORE DPLL M2 divider.  This does not appear
to be necessary.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index c080c82..84781a6 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -102,9 +102,6 @@ configure_core_dpll:
 	orr	r12, r12, r3, lsl #0x1B	@ r3 contains the M2 val
 	str	r12, [r11]
 	ldr	r12, [r11]		@ posted-write barrier for CM
-	mov 	r12, #0x800		@ wait for the clock to stabilise
-	cmp	r3, #2
-	bne	wait_clk_stable
 	bx	lr
 wait_clk_stable:
 	subs 	r12, r12, #1


