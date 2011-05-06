From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/2] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Fri, 6 May 2011 15:39:17 +0530
Message-ID: <1304676557-15613-3-git-send-email-govindraj.raja@ti.com>
References: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755980Ab1EFKOD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 06:14:03 -0400
In-Reply-To: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Add API to determine IO-PAD wakeup event status for a given
hwmod dynamic_mux pad.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |   28 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                    |   13 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   14 +++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 4 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index a4ab1e3..b40aebe 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -348,6 +348,34 @@ err1:
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
+		val = omap_mux_read(pad->partition,
+					pad->mux->reg_offset);
+		if (val & OMAP_WAKEUP_EVENT) {
+			ret = true;
+			break;
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
index 137f321..86a0051 100644
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
index 97d3302..6891c4f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2404,3 +2404,17 @@ int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
 
 	return ret;
 }
+
+/**
+ * omap_hwmod_pad_get_wakeup_status - get pad wakeup status if mux is available.
+ * @oh: struct omap_hwmod *
+ *
+ * Returns the wake_up status bit of available pad mux pin.
+ * return error if no mux pads are available.
+ */
+int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh)
+{
+	if (oh->mux)
+		return omap_hwmod_mux_get_wake_status(oh->mux);
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index b7f8d1b..b0535b7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -603,6 +603,7 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable);
 
+int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh);
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.1

