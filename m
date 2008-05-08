From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH try #2] powerdomain: convert pwrdm_mutex to rwsem
Date: Wed, 7 May 2008 18:53:21 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805071850580.8498@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1190579928-1210208001=:8498"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52308 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbYEHAxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 20:53:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1190579928-1210208001=:8498
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi,=20

that last patch escaped with some trailing whitespace.  Here's a fixed=20
copy.

- Paul

---


Convert pwrdm_mutex to pwrdm_rwsem to avoid trying to relock mutex in the
event that the pwrdm_for_each() callback function calls something that
triggers a pwrdm_lookup().  Problem found by Jouni H=F6gander
<jouni.hogander@nokia.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---

 arch/arm/mach-omap2/powerdomain.c |   61 ++++++++++++++++++++-------------=
----
 1 files changed, 33 insertions(+), 28 deletions(-)


diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerd=
omain.c
index dd9f40e..939efe4 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -37,8 +37,12 @@
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
=20
-/* pwrdm_mutex protects pwrdm_list add and del ops */
-static DEFINE_MUTEX(pwrdm_mutex);
+/*
+ * pwrdm_rwsem protects pwrdm_list add and del ops - also reused to
+ * protect pwrdm_clkdms[] during clkdm add/del ops
+ */
+static DECLARE_RWSEM(pwrdm_rwsem);
+
=20
 /* Private functions */
=20
@@ -135,7 +139,7 @@ int pwrdm_register(struct powerdomain *pwrdm)
 =09if (!omap_chip_is(pwrdm->omap_chip))
 =09=09return -EINVAL;
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_write(&pwrdm_rwsem);
 =09if (_pwrdm_lookup(pwrdm->name)) {
 =09=09ret =3D -EEXIST;
 =09=09goto pr_unlock;
@@ -147,7 +151,7 @@ int pwrdm_register(struct powerdomain *pwrdm)
 =09ret =3D 0;
=20
 pr_unlock:
-=09mutex_unlock(&pwrdm_mutex);
+=09up_write(&pwrdm_rwsem);
=20
 =09return ret;
 }
@@ -164,9 +168,9 @@ int pwrdm_unregister(struct powerdomain *pwrdm)
 =09if (!pwrdm)
 =09=09return -EINVAL;
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_write(&pwrdm_rwsem);
 =09list_del(&pwrdm->node);
-=09mutex_unlock(&pwrdm_mutex);
+=09up_write(&pwrdm_rwsem);
=20
 =09pr_debug("powerdomain: unregistered %s\n", pwrdm->name);
=20
@@ -187,9 +191,9 @@ struct powerdomain *pwrdm_lookup(const char *name)
 =09if (!name)
 =09=09return NULL;
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_read(&pwrdm_rwsem);
 =09pwrdm =3D _pwrdm_lookup(name);
-=09mutex_unlock(&pwrdm_mutex);
+=09up_read(&pwrdm_rwsem);
=20
 =09return pwrdm;
 }
@@ -198,15 +202,15 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * pwrdm_for_each - call function on each registered clockdomain
  * @fn: callback function *
  *
- * Call the supplied function for each registered powerdomain.
- * The callback function can return anything but 0 to bail
- * out early from the iterator.=09 The callback function is called with
- * the pwrdm_mutex held, so no powerdomain structure manipulation
+ * Call the supplied function for each registered powerdomain.  The
+ * callback function can return anything but 0 to bail out early from
+ * the iterator.  The callback function is called with the pwrdm_rwsem
+ * held for reading, so no powerdomain structure manipulation
  * functions should be called from the callback, although hardware
  * powerdomain control functions are fine.  Returns the last return
  * value of the callback function, which should be 0 for success or
- * anything else to indicate failure; or -EINVAL if the function pointer
- * is null.
+ * anything else to indicate failure; or -EINVAL if the function
+ * pointer is null.
  */
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
 {
@@ -216,13 +220,13 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrd=
m))
 =09if (!fn)
 =09=09return -EINVAL;
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_read(&pwrdm_rwsem);
 =09list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
 =09=09ret =3D (*fn)(temp_pwrdm);
 =09=09if (ret)
 =09=09=09break;
 =09}
-=09mutex_unlock(&pwrdm_mutex);
+=09up_read(&pwrdm_rwsem);
=20
 =09return ret;
 }
@@ -247,7 +251,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct c=
lockdomain *clkdm)
=20
 =09pr_debug("powerdomain: associating clockdomain %s with powerdomain "
 =09=09 "%s\n", clkdm->name, pwrdm->name);
-=09mutex_lock(&pwrdm_mutex);
+
+=09down_write(&pwrdm_rwsem);
=20
 =09for (i =3D 0; i < PWRDM_MAX_CLKDMS; i++) {
 =09=09if (!pwrdm->pwrdm_clkdms[i])
@@ -273,13 +278,13 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct=
 clockdomain *clkdm)
 =09ret =3D 0;
=20
 pac_exit:
-=09mutex_unlock(&pwrdm_mutex);
+=09up_write(&pwrdm_rwsem);
=20
 =09return ret;
 }
=20
 /**
- * pwrdm_del_clkdm - remove a clockdomain to a powerdomain
+ * pwrdm_del_clkdm - remove a clockdomain from a powerdomain
  * @pwrdm: struct powerdomain * to add the clockdomain to
  * @clkdm: struct clockdomain * to associate with a powerdomain
  *
@@ -299,7 +304,7 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct c=
lockdomain *clkdm)
 =09pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
 =09=09 "%s\n", clkdm->name, pwrdm->name);
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_write(&pwrdm_rwsem);
=20
 =09for (i =3D 0; i < PWRDM_MAX_CLKDMS; i++)
 =09=09if (pwrdm->pwrdm_clkdms[i] =3D=3D clkdm)
@@ -317,7 +322,7 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct c=
lockdomain *clkdm)
 =09ret =3D 0;
=20
 pdc_exit:
-=09mutex_unlock(&pwrdm_mutex);
+=09up_write(&pwrdm_rwsem);
=20
 =09return ret;
 }
@@ -330,10 +335,10 @@ pdc_exit:
  * Call the supplied function for each clockdomain in the powerdomain
  * 'pwrdm'.  The callback function can return anything but 0 to bail
  * out early from the iterator.  The callback function is called with
- * the pwrdm_mutex held, so no powerdomain structure manipulation
- * functions should be called from the callback, although hardware
- * powerdomain control functions are fine.  Returns -EINVAL if
- * presented with invalid pointers; or passes along the last return
+ * the pwrdm_rwsem held for reading, so no powerdomain structure
+ * manipulation functions should be called from the callback, although
+ * hardware powerdomain control functions are fine.  Returns -EINVAL
+ * if presented with invalid pointers; or passes along the last return
  * value of the callback function, which should be 0 for success or
  * anything else to indicate failure.
  */
@@ -347,12 +352,12 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 =09if (!fn)
 =09=09return -EINVAL;
=20
-=09mutex_lock(&pwrdm_mutex);
+=09down_read(&pwrdm_rwsem);
=20
 =09for (i =3D 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
 =09=09ret =3D (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
=20
-=09mutex_unlock(&pwrdm_mutex);
+=09up_read(&pwrdm_rwsem);
=20
 =09return ret;
 }
--155748971-1190579928-1210208001=:8498--
