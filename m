From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 7/7] ARM: pm: add L2 cache cleaning for suspend
Date: Mon, 19 Sep 2011 17:40:44 +0100
Message-ID: <E1R5gtg-00056O-J9@rmk-PC.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36140 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648Ab1ISRsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 13:48:47 -0400
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.org

We need to ensure that state is pushed out from the L2 cache when
suspending so that the resume paths can access their data before the
MMU and caches have been re-initialized.  Add the necessary calls to
__cpu_suspend_save().

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 2d60f19..93a22d2 100644
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

