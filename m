From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/6] OMAP2+: hwmod: Make omap_hwmod_register private and remove omap_hwmod_unregister
Date: Wed, 15 Dec 2010 15:49:22 +0100
Message-ID: <1292424567-25794-2-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab0LOOuD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 09:50:03 -0500
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

Do not allow omap_hwmod_register to be used outside the core
hwmod code. An omap_hwmod should be registered only at init time.
Remove the omap_hwmod_unregister that is not used today since the
hwmod list will be built once at init time and never be modified
at runtime.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  137 ++++++++++---------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 2 files changed, 55 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 81c1097..298fc3b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1418,60 +1418,8 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	return 0;
 }
 
-
-
-/* Public functions */
-
-u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
-{
-	if (oh->flags & HWMOD_16BIT_REG)
-		return __raw_readw(oh->_mpu_rt_va + reg_offs);
-	else
-		return __raw_readl(oh->_mpu_rt_va + reg_offs);
-}
-
-void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
-{
-	if (oh->flags & HWMOD_16BIT_REG)
-		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
-	else
-		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
-}
-
-/**
- * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
- * @oh: struct omap_hwmod *
- * @idlemode: SIDLEMODE field bits (shifted to bit 0)
- *
- * Sets the IP block's OCP slave idlemode in hardware, and updates our
- * local copy.  Intended to be used by drivers that have some erratum
- * that requires direct manipulation of the SIDLEMODE bits.  Returns
- * -EINVAL if @oh is null, or passes along the return value from
- * _set_slave_idlemode().
- *
- * XXX Does this function have any current users?  If not, we should
- * remove it; it is better to let the rest of the hwmod code handle this.
- * Any users of this function should be scrutinized carefully.
- */
-int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
-{
-	u32 v;
-	int retval = 0;
-
-	if (!oh)
-		return -EINVAL;
-
-	v = oh->_sysc_cache;
-
-	retval = _set_slave_idlemode(oh, idlemode, &v);
-	if (!retval)
-		_write_sysconfig(v, oh);
-
-	return retval;
-}
-
 /**
- * omap_hwmod_register - register a struct omap_hwmod
+ * _register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Registers the omap_hwmod @oh.  Returns -EEXIST if an omap_hwmod
@@ -1487,7 +1435,7 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
  * that the copy process would be relatively complex due to the large number
  * of substructures.
  */
-int omap_hwmod_register(struct omap_hwmod *oh)
+static int _register(struct omap_hwmod *oh)
 {
 	int ret, ms_id;
 
@@ -1525,6 +1473,57 @@ ohr_unlock:
 	return ret;
 }
 
+
+/* Public functions */
+
+u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
+{
+	if (oh->flags & HWMOD_16BIT_REG)
+		return __raw_readw(oh->_mpu_rt_va + reg_offs);
+	else
+		return __raw_readl(oh->_mpu_rt_va + reg_offs);
+}
+
+void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
+{
+	if (oh->flags & HWMOD_16BIT_REG)
+		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
+	else
+		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
+}
+
+/**
+ * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
+ * @oh: struct omap_hwmod *
+ * @idlemode: SIDLEMODE field bits (shifted to bit 0)
+ *
+ * Sets the IP block's OCP slave idlemode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the SIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_slave_idlemode().
+ *
+ * XXX Does this function have any current users?  If not, we should
+ * remove it; it is better to let the rest of the hwmod code handle this.
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+
+	retval = _set_slave_idlemode(oh, idlemode, &v);
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
 /**
  * omap_hwmod_lookup - look up a registered omap_hwmod by name
  * @name: name of the omap_hwmod to look up
@@ -1604,8 +1603,8 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
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
@@ -1639,32 +1638,6 @@ int omap_hwmod_late_init(void)
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
index 62bdb23..ab99b8c 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -515,8 +515,6 @@ struct omap_hwmod {
 };
 
 int omap_hwmod_init(struct omap_hwmod **ohs);
-int omap_hwmod_register(struct omap_hwmod *oh);
-int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-- 
1.7.0.4

