From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested pads
Date: Mon, 28 Feb 2011 20:09:13 +0530
Message-ID: <1298903958-6496-3-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab1B1OQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:16:02 -0500
In-Reply-To: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means they
are wakeup capable) enable the IO-daisy wakeup capability.
During re-muxing avoid direct write with val as this can disturb if any
mux done at bootloader level so read the pad then write back.

Also add a api to fetch the wake-up status bit is set for given omap-hwmod
device using available mux info which is added during omap_hwmod_mux_init.
Wakeup status bit is needed for uart_resume_idle call from sram_idle path
based on wake-up event has occurred for given uart we can enable clocks back.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                    |   13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   13 +++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 4 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 98148b6..5338b93 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -317,6 +317,24 @@ err1:
 	return NULL;
 }
 
+/* Gets the wakeup status of given pad from omap-hwmod */
+int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
+{
+	int i;
+	unsigned int val = -EINVAL;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+
+		val = omap_mux_read(pad->partition, pad->mux->reg_offset);
+	}
+
+	if (val > 0 && val & OMAP_WAKEUP_EVENT)
+		return 1;
+	else
+		return 0;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
@@ -342,6 +360,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 				break;
 			flags &= ~OMAP_DEVICE_PAD_ENABLED;
 			val = pad->idle;
+			if (flags & OMAP_DEVICE_PAD_WAKEUP)
+				val |= OMAP_WAKEUP_EN;
+
 			pr_debug("%s: Idling %s %x\n", __func__,
 					pad->name, val);
 			break;
@@ -358,6 +379,8 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 		};
 
 		if (val >= 0) {
+			val |= omap_mux_read(pad->partition,
+						pad->mux->reg_offset);
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
 			pad->flags = flags;
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a4ab17a..84a8fc2 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -220,8 +220,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
 
+
+/**
+ * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup event
+ * @hmux:		Pads for a hwmod
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
 #else
 
+static inline int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..893dae1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2239,3 +2239,16 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 
 	return ret;
 }
+
+/**
+ * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is available.
+ * @oh: struct omap_hwmod *
+ *
+ * Returns the wake_up status bit of available pad mux pin.
+ */
+int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)
+{
+	if (oh->mux)
+		return omap_hwmod_mux_wakeup(oh->mux);
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..4100be0 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -588,6 +588,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
+int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh);
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.1

