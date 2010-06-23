From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/13] OMAP: hwmod: add non-locking versions of enable and idle functions
Date: Wed, 23 Jun 2010 16:42:36 -0700
Message-ID: <1277336563-24988-7-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54392 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0FWXm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:42:56 -0400
Received: by pvg2 with SMTP id 2so111388pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:42:56 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
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
 arch/arm/mach-omap2/omap_hwmod.c             |   32 ++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3d11523..8b2b44a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1287,6 +1287,18 @@ int omap_hwmod_unregister(struct omap_hwmod *oh)
 }
 
 /**
+ * __omap_hwmod_enable - enable an omap_hwmod (non-locking version)
+ * @oh: struct omap_hwmod *
+ *
+ * Enable an omap_hwomd @oh.  Intended to be called in rare cases
+ * where usage is required in atomic context.
+ */
+int __omap_hwmod_enable(struct omap_hwmod *oh)
+{
+	return _enable(oh);
+}
+
+/**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1301,12 +1313,26 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 		return -EINVAL;
 
 	mutex_lock(&omap_hwmod_mutex);
-	r = _enable(oh);
+	r = __omap_hwmod_enable(oh);
 	mutex_unlock(&omap_hwmod_mutex);
 
 	return r;
 }
 
+
+/**
+ * __omap_hwmod_idle - idle an omap_hwmod (non-locking)
+ * @oh: struct omap_hwmod *
+ *
+ * Idle an omap_hwomd @oh.  Intended to be called in rare instances where
+ * used in atomic context.
+ */
+int __omap_hwmod_idle(struct omap_hwmod *oh)
+{
+	_idle(oh);
+	return 0;
+}
+
 /**
  * omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
@@ -1319,9 +1345,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	mutex_lock(&omap_hwmod_mutex);
-	_idle(oh);
-	mutex_unlock(&omap_hwmod_mutex);
+	__omap_hwmod_idle(oh);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0eccc09..9a3f4dc 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -486,7 +486,9 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh));
 int omap_hwmod_late_init(void);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
+int __omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
+int __omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
-- 
1.7.0.2

