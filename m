From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: hwmod: separate list locking and hwmod hardware locking
Date: Wed, 11 Aug 2010 17:24:45 -0700
Message-ID: <1281572685-13964-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55750 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759566Ab0HLAYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 20:24:48 -0400
Received: by pvg2 with SMTP id 2so254061pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 17:24:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: b-cousson@ti.com

From: Kevin Hilman <khilman@ti.com>

Currently omap_hwmod_mutex is being used to protect both the list
access/modification and concurrent access to hwmod functions.  This
patch separates these two types of locking.

First, omap_hwmod_mutex is used only to protect access and
modification of omap_hwmod_list.  Also cleaned up some comments
referring to this mutex that are no longer needed.

Then, for protecting concurrent access to hwmod functions, use a
per-hwmod mutex.  This protects concurrent access to a single hwmod,
but would allow concurrent access to different hwmods.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   62 ++++++++++++-------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 100115f..832c2c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -767,10 +767,10 @@ static struct omap_hwmod *_lookup(const char *name)
  * @data: not used; pass NULL
  *
  * Called by omap_hwmod_late_init() (after omap2_clk_init()).
- * Resolves all clock names embedded in the hwmod.  Must be called
- * with omap_hwmod_mutex held.  Returns -EINVAL if the omap_hwmod
- * has not yet been registered or if the clocks have already been
- * initialized, 0 on success, or a non-zero error on failure.
+ * Resolves all clock names embedded in the hwmod.  Returns -EINVAL if
+ * the omap_hwmod has not yet been registered or if the clocks have
+ * already been initialized, 0 on success, or a non-zero error on
+ * failure.
  */
 static int _init_clocks(struct omap_hwmod *oh, void *data)
 {
@@ -838,10 +838,9 @@ static int _wait_target_ready(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Resets an omap_hwmod @oh via the OCP_SYSCONFIG bit.  hwmod must be
- * enabled for this to work.  Must be called with omap_hwmod_mutex
- * held.  Returns -EINVAL if the hwmod cannot be reset this way or if
- * the hwmod is in the wrong state, -ETIMEDOUT if the module did not
- * reset in time, or 0 upon success.
+ * enabled for this to work.  Returns -EINVAL if the hwmod cannot be
+ * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
+ * the module did not reset in time, or 0 upon success.
  */
 static int _reset(struct omap_hwmod *oh)
 {
@@ -891,9 +890,8 @@ static int _reset(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Enables an omap_hwmod @oh such that the MPU can access the hwmod's
- * register target.  Must be called with omap_hwmod_mutex held.
- * Returns -EINVAL if the hwmod is in the wrong state or passes along
- * the return value of _wait_target_ready().
+ * register target.  Returns -EINVAL if the hwmod is in the wrong
+ * state or passes along the return value of _wait_target_ready().
  */
 int _omap_hwmod_enable(struct omap_hwmod *oh)
 {
@@ -1004,11 +1002,10 @@ static int _shutdown(struct omap_hwmod *oh)
  * @skip_setup_idle_p: do not idle hwmods at the end of the fn if 1
  *
  * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Must be called with omap_hwmod_mutex held.
- * @skip_setup_idle is intended to be used on a system that will not
- * call omap_hwmod_enable() to enable devices (e.g., a system without
- * PM runtime).  Returns -EINVAL if the hwmod is in the wrong state or
- * returns 0.
+ * OCP_SYSCONFIG register.  @skip_setup_idle is intended to be used on
+ * a system that will not call omap_hwmod_enable() to enable devices
+ * (e.g., a system without PM runtime).  Returns -EINVAL if the hwmod
+ * is in the wrong state or returns 0.
  */
 static int _setup(struct omap_hwmod *oh, void *data)
 {
@@ -1038,6 +1035,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		}
 	}
 
+	mutex_init(&oh->mutex);
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	r = _omap_hwmod_enable(oh);
@@ -1323,9 +1321,9 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	r = _omap_hwmod_enable(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return r;
 }
@@ -1343,9 +1341,9 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_omap_hwmod_idle(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
@@ -1363,9 +1361,9 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_shutdown(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
@@ -1378,9 +1376,9 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
  */
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh)
 {
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_enable_clocks(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
@@ -1393,9 +1391,9 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh)
  */
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh)
 {
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_disable_clocks(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
@@ -1443,9 +1441,9 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	r = _reset(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return r;
 }
@@ -1646,9 +1644,9 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_enable_wakeup(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
@@ -1671,9 +1669,9 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&oh->mutex);
 	_disable_wakeup(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&oh->mutex);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 5506d80..cf0cef6 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
+#include <linux/mutex.h>
 #include <plat/cpu.h>
 
 struct omap_device;
@@ -461,6 +462,7 @@ struct omap_hwmod {
 	void				*dev_attr;
 	u32				_sysc_cache;
 	void __iomem			*_mpu_rt_va;
+	struct mutex                    mutex;
 	struct list_head		node;
 	u16				flags;
 	u8				_mpu_port_index;
-- 
1.7.2.1

