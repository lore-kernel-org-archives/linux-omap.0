From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] BUILD FIX:hwspinlock: do not return any value from void funtion
Date: Mon, 7 Nov 2011 18:28:06 +0530
Message-ID: <1320670686-29286-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab1KGM6S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 07:58:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, ohad@wizery.com, Vaibhav Hiremath <hvaibhav@ti.com>

Fixes below compilation error -

  CC      arch/arm/mach-omap2/hwspinlock.o
  cc1: warnings being treated as errors
  In file included from arch/arm/mach-omap2/hwspinlock.c:22:0:
  include/linux/hwspinlock.h: In function '__hwspin_unlock':
  include/linux/hwspinlock.h:121:2: error: 'return' with a value, in function
  returning void
  make[1]: *** [arch/arm/mach-omap2/hwspinlock.o] Error 1
  make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 include/linux/hwspinlock.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 08a2fee..192710a 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -118,7 +118,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 static inline
 void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
-	return 0;
+	return;
 }

 static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
--
1.7.0.4

