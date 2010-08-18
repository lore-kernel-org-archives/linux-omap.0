From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/8 v2] OMAP: Hwmod api changes
Date: Wed, 18 Aug 2010 19:40:52 +0530
Message-ID: <1282140652-29837-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP USBOTG modules has a requirement to set the auto idle bit only after
setting smart idle bit. Modified the _sys_enable api to set the smart idle
first and then the autoidle bit. Setting this will not have any impact on the
other modules.

Added 2 wrapper APIs in the omap device layer for wakeup enable/disable
and sidle/mstandby settings.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>

Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   43 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9bd99ad..55507a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -654,12 +654,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
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
@@ -672,6 +666,18 @@ static void _sysc_enable(struct omap_hwmod *oh)
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
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 25cd9ac..c3eb07e 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_enable_wakeup(struct platform_device *pdev);
+int omap_device_disable_wakeup(struct platform_device *pdev);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..10182b1 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -757,3 +757,46 @@ int omap_device_enable_clocks(struct omap_device *od)
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
+int omap_device_enable_wakeup(struct platform_device *pdev)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od = _find_by_pdev(pdev);
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
+int omap_device_disable_wakeup(struct platform_device *pdev)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od = _find_by_pdev(pdev);
+	int i;
+
+	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_disable_wakeup(oh);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
+
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
