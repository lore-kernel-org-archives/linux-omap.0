From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/20] OMAP: hwmod: add non-locking versions of enable and
 idle functions
Date: Fri, 02 Jul 2010 09:29:23 -0600
Message-ID: <20100702152921.6221.19806.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45279 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888Ab0GBPbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:04 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

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

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   19 ++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 95c9a5f..47943ec 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -883,7 +883,7 @@ static int _reset(struct omap_hwmod *oh)
 }
 
 /**
- * _enable - enable an omap_hwmod
+ * _omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Enables an omap_hwmod @oh such that the MPU can access the hwmod's
@@ -891,7 +891,7 @@ static int _reset(struct omap_hwmod *oh)
  * Returns -EINVAL if the hwmod is in the wrong state or passes along
  * the return value of _wait_target_ready().
  */
-static int _enable(struct omap_hwmod *oh)
+int _omap_hwmod_enable(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -936,7 +936,7 @@ static int _enable(struct omap_hwmod *oh)
  * no further work.  Returns -EINVAL if the hwmod is in the wrong
  * state or returns 0.
  */
-static int _idle(struct omap_hwmod *oh)
+int _omap_hwmod_idle(struct omap_hwmod *oh)
 {
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
 		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
@@ -1026,7 +1026,7 @@ static int _setup(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
-	r = _enable(oh);
+	r = _omap_hwmod_enable(oh);
 	if (r) {
 		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
 			   oh->name, oh->_state);
@@ -1038,7 +1038,7 @@ static int _setup(struct omap_hwmod *oh)
 		 * XXX Do the OCP_SYSCONFIG bits need to be
 		 * reprogrammed after a reset?  If not, then this can
 		 * be removed.  If they do, then probably the
-		 * _enable() function should be split to avoid the
+		 * _omap_hwmod_enable() function should be split to avoid the
 		 * rewrite of the OCP_SYSCONFIG register.
 		 */
 		if (oh->class->sysc) {
@@ -1048,7 +1048,7 @@ static int _setup(struct omap_hwmod *oh)
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
-		_idle(oh);
+		_omap_hwmod_idle(oh);
 
 	return 0;
 }
@@ -1289,12 +1289,13 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
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
@@ -1308,7 +1309,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 		return -EINVAL;
 
 	mutex_lock(&omap_hwmod_mutex);
-	_idle(oh);
+	_omap_hwmod_idle(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return 0;
@@ -1410,7 +1411,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
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


