From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [REPOST PATCH 1/2 v4] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Mon, 4 Jul 2011 10:25:15 +0530
Message-ID: <1309755315-28564-1-git-send-email-govindraj.raja@ti.com>
References: <1309603946-25395-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab1GDE4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2011 00:56:23 -0400
In-Reply-To: <1309603946-25395-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Add API to enable IO pad wakeup capability based on mux dynamic pad and
wake_up enable flag available from hwmod_mux initialization.

Use the wakeup_enable flag and enable wakeup capability
for the given pads. Wakeup capability will be enabled/disabled
during hwmod idle transition based on whether wakeup_flag is
set or cleared.

Map the enable/disable pad wakeup API's to hwmod_wakeup_enable/disable.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   59 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..3b28e0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1770,6 +1770,34 @@ static int __init omap_hwmod_setup_all(void)
 core_initcall(omap_hwmod_setup_all);
 
 /**
+ * omap_hwmod_set_ioring_wakeup - enable io pad wakeup flag.
+ * @oh: struct omap_hwmod *
+ * @set: bool value indicating to set or clear wakeup status.
+ *
+ * Set or Clear wakeup flag for the io_pad.
+ */
+static int omap_hwmod_set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	struct omap_device_pad *pad;
+	int ret = -EINVAL, j;
+
+	if (oh->mux && oh->mux->enabled) {
+		for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
+			pad = oh->mux->pads_dynamic[j];
+			if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
+				if (set_wake)
+					pad->idle |= OMAP_WAKEUP_EN;
+				else
+					pad->idle &= ~OMAP_WAKEUP_EN;
+				ret = 0;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2097,6 +2125,35 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 {
 	return _del_initiator_dep(oh, init_oh);
 }
+/**
+ * omap_hwmod_enable_ioring_wakeup - Set wakeup flag for iopad.
+ * @oh: struct omap_hwmod *
+ *
+ * Traverse through dynamic pads, if pad is enabled then
+ * set wakeup enable bit flag for the mux pin. Wakeup pad bit
+ * will be set during hwmod idle transistion.
+ * Return error if pads are not enabled or not available.
+ */
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh)
+{
+	/* Enable pad wake-up capability */
+	return omap_hwmod_set_ioring_wakeup(oh, true);
+}
+
+/**
+ * omap_hwmod_disable_ioring_wakeup - Clear wakeup flag for iopad.
+ * @oh: struct omap_hwmod *
+ *
+ * Traverse through dynamic pads, if pad is enabled then
+ * clear wakeup enable bit flag for the mux pin. Wakeup pad bit
+ * will be set during hwmod idle transistion.
+ * Return error if pads are not enabled or not available.
+ */
+int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)
+{
+	/* Disable pad wakeup capability */
+	return omap_hwmod_set_ioring_wakeup(oh, false);
+}
 
 /**
  * omap_hwmod_enable_wakeup - allow device to wake up the system
@@ -2123,6 +2180,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_enable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_hwmod_enable_ioring_wakeup(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2153,6 +2211,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_disable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_hwmod_disable_ioring_wakeup(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
1.7.4.1

