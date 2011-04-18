From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] cbus: tahvo: Fix build breakage caused by deprecated initializer removal
Date: Mon, 18 Apr 2011 22:21:30 +0300
Message-ID: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61034 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab1DRTVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 15:21:44 -0400
Received: by ewy4 with SMTP id 4so1481820ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 12:21:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Use DEFINE_SPINLOCK() for static spinlock initialization as the commit
d04fa5a "locking: Remove deprecated lock initializers" removes the
deprecated SPIN_LOCK_UNLOCKED. Since tahvo_lock is not used elsewhere than
tahvo.c it can be removed from tahvo.h too.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 drivers/cbus/tahvo.c |    2 +-
 drivers/cbus/tahvo.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 8e2e669..45318d9 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -53,7 +53,7 @@ static int tahvo_initialized;
 static int tahvo_is_betty;
 
 static struct tasklet_struct tahvo_tasklet;
-spinlock_t tahvo_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(tahvo_lock);
 
 struct tahvo_irq_handler_desc {
 	int (*func)(unsigned long);
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index 6cb6600..e5ed990 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -63,6 +63,4 @@ int tahvo_get_backlight_level(void);
 int tahvo_get_max_backlight_level(void);
 void tahvo_set_backlight_level(int level);
 
-extern spinlock_t tahvo_lock;
-
 #endif /* __DRIVERS_CBUS_TAHVO_H */
-- 
1.7.0.4

