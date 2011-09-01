From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 05/11] ARM: pm: force non-zero return value from
 __cpu_suspend when aborting
Date: Thu, 01 Sep 2011 13:49:59 +0100
Message-ID: <E1Qz6iV-00078R-9z@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57089 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571Ab1IAOCd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:33 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

Ensure that the return value from __cpu_suspend is non-zero when
aborting.  Zero indicates a successful suspend occurred.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index dc902f2..46a9f46 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -61,6 +61,8 @@ ENDPROC(__cpu_suspend)
 
 cpu_suspend_abort:
 	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
+	teq	r0, #0
+	moveq	r0, #1			@ force non-zero value
 	mov	sp, r2
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_suspend_abort)
-- 
1.7.4.4

