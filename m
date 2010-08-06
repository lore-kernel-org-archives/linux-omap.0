From: Hema HK <hemahk@ti.com>
Subject: [PATCH 7/8] : Hwmod api changes
Date: Fri,  6 Aug 2010 22:58:08 +0530
Message-ID: <1281115688-1429-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60522 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab0HFR2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 13:28:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

Omap USBOTG modules has a requirement to set the auto idle bit only after
setting smart idle bit. Modified the _sys_enable api to set the smart idle 
first and then the autoidle bit. Setting this will not have any impact on the 
other modules.

Added 2 wrapper APIs in the omap device layer for wakeup enable/disable 
and sidle/mstandby settings. 

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

---
 arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++----
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   42 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c	2010-08-06 08:59:03.641863815 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c	2010-08-06 09:02:00.021864999 -0400
@@ -653,12 +653,6 @@
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	if (sf & SYSC_HAS_AUTOIDLE) {
-		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
-			0 : 1;
-		_set_module_autoidle(oh, idlemode, &v);
-	}
-
 	/* XXX OCP ENAWAKEUP bit? */
 
 	/*
@@ -671,6 +665,18 @@
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
 	_write_sysconfig(v, oh);
+
+	/* Set the auto idle bit only after setting the smartidle bit
+	 * as this is requirement for some modules like USBOTG
+	 * setting this will not have any impact on the other modues.
+	 */
+
+	if (sf & SYSC_HAS_AUTOIDLE) {
+		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
+			0 : 1;
+		_set_module_autoidle(oh, idlemode, &v);
+	}
+	_write_sysconfig(v, oh);
 }
 
 /**
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/omap_device.h	2010-08-06 08:59:03.661863725 -0400
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h	2010-08-06 09:02:00.021864999 -0400
@@ -116,6 +116,8 @@
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_enable_wakeup(struct omap_device *od);
+int omap_device_disable_wakeup(struct omap_device *od);
 
 /*
  * Entries should be kept in latency order ascending
Index: linux-omap-pm/arch/arm/plat-omap/omap_device.c
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/omap_device.c	2010-08-06 08:59:03.661863725 -0400
+++ linux-omap-pm/arch/arm/plat-omap/omap_device.c	2010-08-06 09:02:00.021864999 -0400
@@ -757,3 +757,45 @@
 	/* XXX pass along return value here? */
 	return 0;
 }
+
+/**
+ * omap_device_enable_wakeup - Enable the wakeup bit
+ * @od: struct omap_device *od
+ *
+ * Enable the wakup bit for omap_hwmods associated
+ * with the omap_device.  Returns 0.
+ */
+
+int omap_device_enable_wakeup(struct omap_device *od)
+{
+	struct omap_hwmod *oh;
+	int i;
+
+	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_enable_wakeup(oh);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
+
+/**
+ * omap_device_disable_wakeup -Disable the wakeup bit
+ * @od: struct omap_device *od
+ *
+ * Disable the wakup bit for omap_hwmods associated
+ * with the omap_device.  Returns 0.
+ */
+
+
+int omap_device_disable_wakeup(struct omap_device *od)
+{
+	struct omap_hwmod *oh;
+	int i;
+
+	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_disable_wakeup(oh);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
+
