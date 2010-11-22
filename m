From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/4] OMAP: hwmod: Remove omap_hwmod_mutex
Date: Mon, 22 Nov 2010 09:50:59 +0100
Message-ID: <1290415860-15632-4-git-send-email-b-cousson@ti.com>
References: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab0KVIvS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:51:18 -0500
In-Reply-To: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The hwmod list will be built are init time and never
modified at runtime. There is no need anymore to protect
the list from concurrent access using the mutex.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   26 ++++----------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8e47006..f221587 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -156,8 +156,6 @@
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
 
-static DEFINE_MUTEX(omap_hwmod_mutex);
-
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
@@ -874,7 +872,6 @@ static void _shutdown_sysc(struct omap_hwmod *oh)
  * @name: find an omap_hwmod by name
  *
  * Return a pointer to an omap_hwmod by name, or NULL if not found.
- * Caller must hold omap_hwmod_mutex.
  */
 static struct omap_hwmod *_lookup(const char *name)
 {
@@ -1399,14 +1396,10 @@ static int __init _register(struct omap_hwmod *oh)
 	    (oh->_state != _HWMOD_STATE_UNKNOWN))
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
-
 	pr_debug("omap_hwmod: %s: registering\n", oh->name);
 
-	if (_lookup(oh->name)) {
-		ret = -EEXIST;
-		goto ohr_unlock;
-	}
+	if (_lookup(oh->name))
+		return -EEXIST;
 
 	ms_id = _find_mpu_port_index(oh);
 	if (!IS_ERR_VALUE(ms_id)) {
@@ -1422,8 +1415,6 @@ static int __init _register(struct omap_hwmod *oh)
 
 	ret = 0;
 
-ohr_unlock:
-	mutex_unlock(&omap_hwmod_mutex);
 	return ret;
 }
 
@@ -1492,9 +1483,7 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name)
 	if (!name)
 		return NULL;
 
-	mutex_lock(&omap_hwmod_mutex);
 	oh = _lookup(name);
-	mutex_unlock(&omap_hwmod_mutex);
 
 	return oh;
 }
@@ -1520,13 +1509,11 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 	if (!fn)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
 		ret = (*fn)(temp_oh, data);
 		if (ret)
 			break;
 	}
-	mutex_unlock(&omap_hwmod_mutex);
 
 	return ret;
 }
@@ -2048,9 +2035,8 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
  * @fn: callback function pointer to call for each hwmod in class @classname
  * @user: arbitrary context data to pass to the callback function
  *
- * For each omap_hwmod of class @classname, call @fn.  Takes
- * omap_hwmod_mutex to prevent the hwmod list from changing during the
- * iteration.  If the callback function returns something other than
+ * For each omap_hwmod of class @classname, call @fn.
+ * If the callback function returns something other than
  * zero, the iterator is terminated, and the callback function's return
  * value is passed back to the caller.  Returns 0 upon success, -EINVAL
  * if @classname or @fn are NULL, or passes back the error code from @fn.
@@ -2069,8 +2055,6 @@ int omap_hwmod_for_each_by_class(const char *classname,
 	pr_debug("omap_hwmod: %s: looking for modules of class %s\n",
 		 __func__, classname);
 
-	mutex_lock(&omap_hwmod_mutex);
-
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
 		if (!strcmp(temp_oh->class->name, classname)) {
 			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
@@ -2081,8 +2065,6 @@ int omap_hwmod_for_each_by_class(const char *classname,
 		}
 	}
 
-	mutex_unlock(&omap_hwmod_mutex);
-
 	if (ret)
 		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
 			 __func__, ret);
-- 
1.7.0.4

