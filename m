From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 11/11] ARM: pm: add L2 cache cleaning for suspend
Date: Thu, 01 Sep 2011 13:51:59 +0100
Message-ID: <E1Qz6kR-00078p-Vs@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34119 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420Ab1IAOAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:00:04 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

We need to ensure that state is pushed out from the L2 cache when
suspending so that the resume paths can access their data before the
MMU and caches have been re-initialized.  Add the necessary calls to
__cpu_suspend_save().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index c78a88f..4c95410 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -28,6 +28,9 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 	cpu_do_suspend(ptr);
 
 	flush_cache_all();
+	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
+	outer_clean_range(virt_to_phys(save_ptr),
+			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
 }
 
 /*
-- 
1.7.4.4

