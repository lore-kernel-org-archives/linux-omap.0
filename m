From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 06/13] OMAP: hwmod: add non-locking versions of enable and idle functions
Date: Thu, 24 Jun 2010 16:44:37 -0700
Message-ID: <1277423084-25528-7-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45007 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0FXXo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:44:59 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so587510pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:44:58 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Some hwmods may need to be idled/enabled in atomic context, so
non-locking versions of these functions are required.

Most users should not need these and usage of theses should be
controlled to understand why access is being done in atomic context.
For this reason, the non-locking functions are only exposed at the
hwmod level and not at the omap-device level.

The use-case that led to the need for the non-locking versions is
hwmods that are enabled/idled from within the core idle/suspend path.
Since interrupts are already disabled here, the mutex-based locking in
hwmod can sleep and will cause potential deadlocks.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   19 ++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3d11523..fa11139 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -886,7 +886,7 @@ static int _reset(struct omap_hwmod *oh)
 }
 
 /**
- * _enable - enable an omap_hwmod
+ * _omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Enables an omap_hwmod @oh such that the MPU can access the hwmod's
@@ -894,7 +894,7 @@ static int _reset(struct omap_hwmod *oh)
  * Returns -EINVAL if the hwmod is in the wrong state or passes along
  * the return value of _wait_target_ready().
  */
-static int _enable(struct omap_hwmod *oh)
+int _omap_hwmod_enable(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -939,7 +939,7 @@ static int _enable(struct omap_hwmod *oh)
  * no further work.  Returns -EINVAL if the hwmod is in the wrong
  * state or returns 0.
  */
-static int _idle(struct omap_hwmod *oh)
+int _omap_hwmod_idle(struct omap_hwmod *oh)
 {
 	/*
 	 * To idle, hwmod must be enabled, EXCEPT if hwmod was
@@ -1038,7 +1038,7 @@ static int _setup(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
-	r = _enable(oh);
+	r = _omap_hwmod_enable(oh);
 	if (r) {
 		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
 			   oh->name, oh->_state);
@@ -1050,7 +1050,7 @@ static int _setup(struct omap_hwmod *oh)
 		 * XXX Do the OCP_SYSCONFIG bits need to be
 		 * reprogrammed after a reset?  If not, then this can
 		 * be removed.  If they do, then probably the
-		 * _enable() function should be split to avoid the
+		 * _omap_hwmod_enable() function should be split to avoid the
 		 * rewrite of the OCP_SYSCONFIG register.
 		 */
 		if (oh->class->sysc) {
@@ -1060,7 +1060,7 @@ static int _setup(struct omap_hwmod *oh)
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
-		_idle(oh);
+		_omap_hwmod_idle(oh);
 
 	return 0;
 }
@@ -1301,12 +1301,13 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 		return -EINVAL;
 
 	mutex_lock(&omap_hwmod_mutex);
-	r = _enable(oh);
+	r = _omap_hwmod_enable(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return r;
 }
 
+
 /**
  * omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
@@ -1320,7 +1321,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 		return -EINVAL;
 
 	mutex_lock(&omap_hwmod_mutex);
-	_idle(oh);
+	_omap_hwmod_idle(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return 0;
@@ -1422,7 +1423,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 	mutex_lock(&omap_hwmod_mutex);
 	r = _reset(oh);
 	if (!r)
-		r = _enable(oh);
+		r = _omap_hwmod_enable(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return r;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0eccc09..253f6e5 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -486,7 +486,9 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh));
 int omap_hwmod_late_init(void);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
+int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
+int _omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
-- 
1.7.0.2

