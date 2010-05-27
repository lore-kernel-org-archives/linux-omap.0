From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/5] OMAP: hwmod: add option for no locking in idle/enable paths
Date: Thu, 27 May 2010 14:13:34 -0700
Message-ID: <1274994816-30335-4-git-send-email-khilman@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45584 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab0E0VNp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:45 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so248809pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:44 -0700 (PDT)
In-Reply-To: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Some hwmods may be idled/enabled directly from within the core
idle/suspend path.  Since interrupts are already disabled here,
the mutex-based locking in hwmod can sleep and will cause
potential deadlocks.

To fix, add a hwmod flag HWMOD_NO_IDLE_LOCKING which indicates to the
hwmod core that no locking should be done during the idle/enable
paths for this hwmod.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   16 ++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 77fef90..1ee2fb2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1304,9 +1304,13 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	if (!(oh->flags & HWMOD_NO_IDLE_LOCKING))
+		mutex_lock(&omap_hwmod_mutex);
+
 	r = _enable(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+
+	if (!(oh->flags & HWMOD_NO_IDLE_LOCKING))
+		mutex_unlock(&omap_hwmod_mutex);
 
 	return r;
 }
@@ -1323,9 +1327,13 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	if (!(oh->flags & HWMOD_NO_IDLE_LOCKING))
+		mutex_lock(&omap_hwmod_mutex);
+
 	_idle(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+
+	if (!(oh->flags & HWMOD_NO_IDLE_LOCKING))
+		mutex_unlock(&omap_hwmod_mutex);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0eccc09..cc3f9a7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -360,6 +360,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_OCP_AUTOIDLE			(1 << 4)
 #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 #define HWMOD_NO_IDLEST				(1 << 6)
+#define HWMOD_NO_IDLE_LOCKING       (1 << 7)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.7.0.2

