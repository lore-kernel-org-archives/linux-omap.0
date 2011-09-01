From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 04/11] ARM: pm: avoid writing the auxillary control register
 for ARMv7
Date: Thu, 01 Sep 2011 13:49:39 +0100
Message-ID: <E1Qz6iB-00078N-6O@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57090 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571Ab1IAOCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:40 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

For ARMv7 kernels running in the non-secure world, writing to the
auxillary control register causes an abort, so we must avoid directly
writing the auxillary control register.  If the ACR has already been
reinitialized by SoC code, don't try to restore it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a773f4e..9049c07 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -248,7 +248,9 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r7, c2, c0, 0	@ TTB 0
 	mcr	p15, 0, r8, c2, c0, 1	@ TTB 1
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
-	mcr	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
+	teq	r4, r10			@ Is it already set?
+	mcrne	p15, 0, r10, c1, c0, 1	@ No, so write it
 	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access control
 	ldr	r4, =PRRR		@ PRRR
 	ldr	r5, =NMRR		@ NMRR
-- 
1.7.4.4

