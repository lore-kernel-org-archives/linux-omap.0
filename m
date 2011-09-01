From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to ensure
 correctness
Date: Thu, 01 Sep 2011 13:49:19 +0100
Message-ID: <E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57092 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab1IAOCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:55 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

Add a dsb after the isb to ensure that the previous writes to the
CP15 registers take effect before we enable the MMU.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index dec72ee..a773f4e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
 	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
 	isb
+	dsb
 	mov	r0, r9			@ control register
 	mov	r2, r7, lsr #14		@ get TTB0 base
 	mov	r2, r2, lsl #14
-- 
1.7.4.4

