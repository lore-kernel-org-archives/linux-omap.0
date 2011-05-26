From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAP: Add (omap_device|omap_hwmod)_can_ever_lose_context functions
Date: Thu, 26 May 2011 19:45:07 +0300
Message-ID: <1306428307-1360-4-git-send-email-tomi.valkeinen@ti.com>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46688 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932212Ab1EZQpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 12:45:31 -0400
Received: by eyg7 with SMTP id 7so746909eyg.27
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 09:45:29 -0700 (PDT)
In-Reply-To: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add hwmod and omap_device versions of can_ever_lose_context functions
so that drivers are able to use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c              |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap_device.c              |   23 +++++++++++++++++++++++
 4 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4f0d554..210280e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2369,3 +2369,25 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_can_ever_lose_context - can this hwmod ever lose context?
+ * @oh: struct omap_hwmod *
+ *
+ * Finds the powerdomain associated with the given hwmod, and calls
+ * pwrdm_can_ever_lose_context for the powerdomain.
+ *
+ * Returns the return value from pwrdm_can_ever_lose_context, or true if no
+ * powerdomain is associated with the hwmod.
+ */
+bool omap_hwmod_can_ever_lose_context(struct omap_hwmod *oh)
+{
+	struct powerdomain *pwrdm;
+	int ret = true;
+
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	if (pwrdm)
+		ret = pwrdm_can_ever_lose_context(pwrdm);
+
+	return ret;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index bcf1b35..640c2eb 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -109,6 +109,7 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
 int omap_device_get_context_loss_count(struct platform_device *pdev);
 int omap_device_reset(struct platform_device *pdev);
+bool omap_device_can_ever_lose_context(struct platform_device *pdev);
 
 /* Other */
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8658e2d..0d7435e 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -601,6 +601,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
+bool omap_hwmod_can_ever_lose_context(struct omap_hwmod *oh);
 
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 4e6fc1b..bcee8d3 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -347,6 +347,29 @@ int omap_device_reset(struct platform_device *pdev)
 }
 
 /**
+ * omap_device_can_ever_lose_context - can this device ever lose context?
+ * @pdev: struct platform_device *
+ *
+ * Calls omap_hwmod_can_ever_lose_context for all hwmods associated with the
+ * given device, and returns true if one of the hwmods returns true. Otherwise
+ * returns false.
+ */
+bool omap_device_can_ever_lose_context(struct platform_device *pdev)
+{
+	struct omap_device *od;
+	int i;
+
+	od = _find_by_pdev(pdev);
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		if (omap_hwmod_can_ever_lose_context(od->hwmods[i]))
+			return true;
+	}
+
+	return false;
+}
+
+/**
  * omap_device_count_resources - count number of struct resource entries needed
  * @od: struct omap_device *
  *
-- 
1.7.4.1

