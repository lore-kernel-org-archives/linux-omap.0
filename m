From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/8] OMAP2+: hwmod: rename omap_hwmod_mutex to
	_hwmod_list_mutex
Date: Tue, 16 Nov 2010 03:18:09 -0700
Message-ID: <20101116101808.22777.52852.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51532 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934172Ab0KPKTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:15 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

This trivial patch renames omap_hwmod_mutex to _hwmod_list_mutex to ind=
icate
clearly that it is only used for hwmod list manipulation operations.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 12a0b9a..0e85278 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -156,7 +156,8 @@
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
=20
-static DEFINE_MUTEX(omap_hwmod_mutex);
+/* _hwmod_list_mutex protects the list of registered hwmods */
+static DEFINE_MUTEX(_hwmod_list_mutex);
=20
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
@@ -874,7 +875,7 @@ static void _shutdown_sysc(struct omap_hwmod *oh)
  * @name: find an omap_hwmod by name
  *
  * Return a pointer to an omap_hwmod by name, or NULL if not found.
- * Caller must hold omap_hwmod_mutex.
+ * Caller must hold _hwmod_list_mutex.
  */
 static struct omap_hwmod *_lookup(const char *name)
 {
@@ -1502,7 +1503,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
 	    (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
 		return -EINVAL;
=20
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&_hwmod_list_mutex);
=20
 	pr_debug("omap_hwmod: %s: registering\n", oh->name);
=20
@@ -1528,7 +1529,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
 	ret =3D 0;
=20
 ohr_unlock:
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&_hwmod_list_mutex);
 	return ret;
 }
=20
@@ -1546,9 +1547,9 @@ struct omap_hwmod *omap_hwmod_lookup(const char *=
name)
 	if (!name)
 		return NULL;
=20
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&_hwmod_list_mutex);
 	oh =3D _lookup(name);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&_hwmod_list_mutex);
=20
 	return oh;
 }
@@ -1574,13 +1575,13 @@ int omap_hwmod_for_each(int (*fn)(struct omap_h=
wmod *oh, void *data),
 	if (!fn)
 		return -EINVAL;
=20
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&_hwmod_list_mutex);
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
 		ret =3D (*fn)(temp_oh, data);
 		if (ret)
 			break;
 	}
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&_hwmod_list_mutex);
=20
 	return ret;
 }
@@ -1663,10 +1664,10 @@ int omap_hwmod_unregister(struct omap_hwmod *oh=
)
=20
 	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
=20
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&_hwmod_list_mutex);
 	iounmap(oh->_mpu_rt_va);
 	list_del(&oh->node);
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&_hwmod_list_mutex);
=20
 	return 0;
 }
@@ -2125,7 +2126,7 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *=
oh, const char *name)
  * @user: arbitrary context data to pass to the callback function
  *
  * For each omap_hwmod of class @classname, call @fn.  Takes
- * omap_hwmod_mutex to prevent the hwmod list from changing during the
+ * _hwmod_list_mutex to prevent the hwmod list from changing during th=
e
  * iteration.  If the callback function returns something other than
  * zero, the iterator is terminated, and the callback function's retur=
n
  * value is passed back to the caller.  Returns 0 upon success, -EINVA=
L
@@ -2145,7 +2146,7 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
 	pr_debug("omap_hwmod: %s: looking for modules of class %s\n",
 		 __func__, classname);
=20
-	mutex_lock(&omap_hwmod_mutex);
+	mutex_lock(&_hwmod_list_mutex);
=20
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
 		if (!strcmp(temp_oh->class->name, classname)) {
@@ -2157,7 +2158,7 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
 		}
 	}
=20
-	mutex_unlock(&omap_hwmod_mutex);
+	mutex_unlock(&_hwmod_list_mutex);
=20
 	if (ret)
 		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
