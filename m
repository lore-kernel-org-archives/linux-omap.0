From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: mm: Flush only CPU local cache instead of all cache levels.
Date: Thu, 12 Apr 2012 16:59:47 +0530
Message-ID: <1334230187-21553-3-git-send-email-santosh.shilimkar@ti.com>
References: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760801Ab2DLLaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 07:30:13 -0400
In-Reply-To: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

The ARMv7 processor setup functions clean and invalidates the
cpu cache before enabling MMU. The intention here is to start
with clean CPU local cache.

But on architectures like Cortex-[A15/A8], this code will end
up flushing the L2 cache as well which undesirable and incorrect.
The setup functions are used in CPU hotplug scenario's too and
hence flushing all cache levels should be avoided.

Fix this code by restricting the cache flush to local cpu
cache or L1.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index f1c8486..96cfc31 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -172,7 +172,8 @@ __v7_ca15mp_setup:
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
-	bl	v7_flush_dcache_all
+	mov	r0, #0x1
+	bl	v7_flush_dcache_by_level
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
 
 	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
-- 
1.7.5.4

