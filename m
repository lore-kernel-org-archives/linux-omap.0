From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/7] ARM: pm: force non-zero return value from __cpu_suspend
 when aborting
Date: Mon, 19 Sep 2011 17:38:43 +0100
Message-ID: <E1R5grj-0004xn-RB@rmk-PC.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47025 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab1ISQir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 12:38:47 -0400
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.org

Ensure that the return value from __cpu_suspend is non-zero when
aborting.  Zero indicates a successful suspend occurred.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
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

