From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 5/5] omap:hwspinlocks-ensure the order of registration
Date: Mon, 19 Jul 2010 11:50:21 -0500
Message-ID: <1279558221-14954-6-git-send-email-h-kanigeri2@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48454 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936439Ab0GSQjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jul 2010 12:39:35 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Ensure that the hwspinlock driver is registered prior to
I2C driver registration since I2C is dependent on hwspinlock.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/hwspinlocks.c |    2 +-
 arch/arm/plat-omap/hwspinlock.c   |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspinlocks.c
index f0f05e1..a9f85b9 100644
--- a/arch/arm/mach-omap2/hwspinlocks.c
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -67,4 +67,4 @@ int __init hwspinlocks_init(void)
 
 	return retval;
 }
-module_init(hwspinlocks_init);
+postcore_initcall(hwspinlocks_init);
diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinlock.c
index 1883add..3742b04 100644
--- a/arch/arm/plat-omap/hwspinlock.c
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -309,6 +309,7 @@ static int __init hwspinlock_init(void)
 
 	return retval;
 }
+postcore_initcall(hwspinlock_init);
 
 /* Cleanup function */
 static void __exit hwspinlock_exit(void)
@@ -325,8 +326,6 @@ static void __exit hwspinlock_exit(void)
 	if (hwspinlock_module->is_init)
 		kfree(hwspinlocks);
 }
-
-module_init(hwspinlock_init);
 module_exit(hwspinlock_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
1.7.0

