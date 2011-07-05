From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 03/11] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Tue, 5 Jul 2011 13:27:49 +0300
Message-ID: <1309861677-2769-4-git-send-email-t-kristo@ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43634 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089Ab1GEK2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:28:11 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p65ASBYI026621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:11 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p65ASAoc013814
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:10 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "R, Govindraj" <govindraj.raja@ti.com>

From: R, Govindraj <govindraj.raja@ti.com>

Add API to determine IO-PAD wakeup event status for a given
hwmod dynamic_mux pad.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |   30 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                    |   13 +++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |    7 ++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 4 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index c7fb22a..50ee806 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -351,6 +351,36 @@ err1:
 	return NULL;
 }
 
+/**
+ * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
+ * @hmux:		Pads for a hwmod
+ *
+ * Gets the wakeup status of given pad from omap-hwmod.
+ * Returns true if wakeup event is set for pad else false
+ * if wakeup is not occured or pads are not avialable.
+ */
+bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
+{
+	int i;
+	unsigned int val;
+	u8 ret = false;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+
+		if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
+			val = omap_mux_read(pad->partition,
+					pad->mux->reg_offset);
+			if (val & OMAP_WAKEUP_EVENT) {
+				ret = true;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 2132308..8b2150a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
 
+/**
+ * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
+ * @hmux:		Pads for a hwmod
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux);
 #else
 
+static inline bool
+omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 17fa1ab..0dd48ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2596,3 +2596,10 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
+{
+	if (oh && oh->mux)
+		return omap_hwmod_mux_get_wake_status(oh->mux);
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7df9fa2..8e5025c 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -612,6 +612,7 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
+int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

