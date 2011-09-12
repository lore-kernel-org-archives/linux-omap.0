From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 06/10] hwspinlock/core: remove stubs for register/unregister
Date: Mon, 12 Sep 2011 19:47:01 +0300
Message-ID: <1315846025-11453-7-git-send-email-ohad@wizery.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

hwspinlock drivers must anyway select CONFIG_HWSPINLOCK,
so there's no point in having register/unregister stubs.

Removing those stubs will only make it easier for developers
to catch CONFIG_HWSPINLOCK mis-.config-urations.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 include/linux/hwspinlock.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index f85cef5..c246522 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -122,16 +122,6 @@ static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
 	return 0;
 }
 
-static inline int hwspin_lock_register(struct hwspinlock *hwlock)
-{
-	return -ENODEV;
-}
-
-static inline struct hwspinlock *hwspin_lock_unregister(unsigned int id)
-{
-	return NULL;
-}
-
 #endif /* !CONFIG_HWSPINLOCK */
 
 /**
-- 
1.7.4.1
