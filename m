From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/4] OMAP: hwmod: Make omap_hwmod_register private and remove omap_hwmod_unregister
Date: Mon, 22 Nov 2010 09:50:57 +0100
Message-ID: <1290415860-15632-2-git-send-email-b-cousson@ti.com>
References: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40132 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab0KVIvK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:51:10 -0500
In-Reply-To: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Do not allow omap_hwmod_register to be used outside the core
hwmod code. An omap_hwmod should be register only at init time.
Remove the omap_hwmod_unregister that is not used today since the
hwmod list will be build once at init time and never be modified
at runtime.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  135 ++++++++++---------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 2 files changed, 54 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..9cedea0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1374,6 +1374,58 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	return 0;
 }
 
+/**
+ * _register - register a struct omap_hwmod
+ * @oh: struct omap_hwmod *
+ *
+ * Registers the omap_hwmod @oh.  Returns -EEXIST if an omap_hwmod
+ * already has been registered by the same name; -EINVAL if the
+ * omap_hwmod is in the wrong state, if @oh is NULL, if the
+ * omap_hwmod's class field is NULL; if the omap_hwmod is missing a
+ * name, or if the omap_hwmod's class is missing a name; or 0 upon
+ * success.
+ *
+ * XXX The data should be copied into bootmem, so the original data
+ * should be marked __initdata and freed after init.  This would allow
+ * unneeded omap_hwmods to be freed on multi-OMAP configurations.  Note
+ * that the copy process would be relatively complex due to the large number
+ * of substructures.
+ */
+static int _register(struct omap_hwmod *oh)
+{
+	int ret, ms_id;
+
+	if (!oh || !oh->name || !oh->class || !oh->class->name ||
+	    (oh->_state != _HWMOD_STATE_UNKNOWN))
+		return -EINVAL;
+
+	mutex_lock(&omap_hwmod_mutex);
+
+	pr_debug("omap_hwmod: %s: registering\n", oh->name);
+
+	if (_lookup(oh->name)) {
+		ret = -EEXIST;
+		goto ohr_unlock;
+	}
+
+	ms_id = _find_mpu_port_index(oh);
+	if (!IS_ERR_VALUE(ms_id)) {
+		oh->_mpu_port_index = ms_id;
+		oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
+	} else {
+		oh->_int_flags |= _HWMOD_NO_MPU_PORT;
+	}
+
+	list_add_tail(&oh->node, &omap_hwmod_list);
+
+	oh->_state = _HWMOD_STATE_REGISTERED;
+
+	ret = 0;
+
+ohr_unlock:
+	mutex_unlock(&omap_hwmod_mutex);
+	return ret;
+}
 
 
 /* Public functions */
@@ -1427,59 +1479,6 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
 }
 
 /**
- * omap_hwmod_register - register a struct omap_hwmod
- * @oh: struct omap_hwmod *
- *
- * Registers the omap_hwmod @oh.  Returns -EEXIST if an omap_hwmod
- * already has been registered by the same name; -EINVAL if the
- * omap_hwmod is in the wrong state, if @oh is NULL, if the
- * omap_hwmod's class field is NULL; if the omap_hwmod is missing a
- * name, or if the omap_hwmod's class is missing a name; or 0 upon
- * success.
- *
- * XXX The data should be copied into bootmem, so the original data
- * should be marked __initdata and freed after init.  This would allow
- * unneeded omap_hwmods to be freed on multi-OMAP configurations.  Note
- * that the copy process would be relatively complex due to the large number
- * of substructures.
- */
-int omap_hwmod_register(struct omap_hwmod *oh)
-{
-	int ret, ms_id;
-
-	if (!oh || !oh->name || !oh->class || !oh->class->name ||
-	    (oh->_state != _HWMOD_STATE_UNKNOWN))
-		return -EINVAL;
-
-	mutex_lock(&omap_hwmod_mutex);
-
-	pr_debug("omap_hwmod: %s: registering\n", oh->name);
-
-	if (_lookup(oh->name)) {
-		ret = -EEXIST;
-		goto ohr_unlock;
-	}
-
-	ms_id = _find_mpu_port_index(oh);
-	if (!IS_ERR_VALUE(ms_id)) {
-		oh->_mpu_port_index = ms_id;
-		oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
-	} else {
-		oh->_int_flags |= _HWMOD_NO_MPU_PORT;
-	}
-
-	list_add_tail(&oh->node, &omap_hwmod_list);
-
-	oh->_state = _HWMOD_STATE_REGISTERED;
-
-	ret = 0;
-
-ohr_unlock:
-	mutex_unlock(&omap_hwmod_mutex);
-	return ret;
-}
-
-/**
  * omap_hwmod_lookup - look up a registered omap_hwmod by name
  * @name: name of the omap_hwmod to look up
  *
@@ -1558,8 +1557,8 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
 	oh = *ohs;
 	while (oh) {
 		if (omap_chip_is(oh->omap_chip)) {
-			r = omap_hwmod_register(oh);
-			WARN(r, "omap_hwmod: %s: omap_hwmod_register returned "
+			r = _register(oh);
+			WARN(r, "omap_hwmod: %s: _register returned "
 			     "%d\n", oh->name, r);
 		}
 		oh = *++ohs;
@@ -1597,32 +1596,6 @@ int omap_hwmod_late_init(u8 skip_setup_idle)
 }
 
 /**
- * omap_hwmod_unregister - unregister an omap_hwmod
- * @oh: struct omap_hwmod *
- *
- * Unregisters a previously-registered omap_hwmod @oh.  There's probably
- * no use case for this, so it is likely to be removed in a later version.
- *
- * XXX Free all of the bootmem-allocated structures here when that is
- * implemented.  Make it clear that core code is the only code that is
- * expected to unregister modules.
- */
-int omap_hwmod_unregister(struct omap_hwmod *oh)
-{
-	if (!oh)
-		return -EINVAL;
-
-	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
-
-	mutex_lock(&omap_hwmod_mutex);
-	iounmap(oh->_mpu_rt_va);
-	list_del(&oh->node);
-	mutex_unlock(&omap_hwmod_mutex);
-
-	return 0;
-}
-
-/**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7eaa8ed..51e86d7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -504,8 +504,6 @@ struct omap_hwmod {
 };
 
 int omap_hwmod_init(struct omap_hwmod **ohs);
-int omap_hwmod_register(struct omap_hwmod *oh);
-int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-- 
1.7.0.4

