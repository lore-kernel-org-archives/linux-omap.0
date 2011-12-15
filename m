From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/9] ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup
Date: Thu, 15 Dec 2011 14:36:15 -0700
Message-ID: <20111215213613.26632.16927.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40996 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759516Ab1LOVhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:39 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>

From: Govindraj R <govindraj.raja@ti.com>

Add API to enable IO pad wakeup capability based on mux pad and
wake_up enable flag available from hwmod_mux initialization.

Use the wakeup_enable flag and enable wakeup capability for the given
pads. Wakeup capability will be enabled/disabled during hwmod idle
transition based on whether wakeup_flag is set or cleared.  If the
hwmod is currently idled, and any mux values were changed by
_set_idle_ioring_wakeup(), the SCM PADCTRL registers will be updated.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: rearranged code to limit indentation; cleaned up
 function documentation; removed unused non-static functions; modified
 to search all hwmod pads, not just dynamic remuxing ones; modified to
 update SCM regs if hwmod is currently idle and any pads have changed]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   47 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 207a2ff..21ffd8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -381,6 +381,51 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 }
 
 /**
+ * _set_idle_ioring_wakeup - enable/disable IO pad wakeup on hwmod idle for mux
+ * @oh: struct omap_hwmod *
+ * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
+ *
+ * Set or clear the I/O pad wakeup flag in the mux entries for the
+ * hwmod @oh.  This function changes the @oh->mux->pads_dynamic array
+ * in memory.  If the hwmod is currently idled, and the new idle
+ * values don't match the previous ones, this function will also
+ * update the SCM PADCTRL registers.  Otherwise, if the hwmod is not
+ * currently idled, this function won't touch the hardware: the new
+ * mux settings are written to the SCM PADCTRL registers when the
+ * hwmod is idled.  No return value.
+ */
+static void _set_idle_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	struct omap_device_pad *pad;
+	bool change = false;
+	u16 prev_idle;
+	int j;
+
+	if (!oh->mux || !oh->mux->enabled)
+		return;
+
+	for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
+		pad = oh->mux->pads_dynamic[j];
+
+		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP))
+			continue;
+
+		prev_idle = pad->idle;
+
+		if (set_wake)
+			pad->idle |= OMAP_WAKEUP_EN;
+		else
+			pad->idle &= ~OMAP_WAKEUP_EN;
+
+		if (prev_idle != pad->idle)
+			change = true;
+	}
+
+	if (change && oh->_state == _HWMOD_STATE_IDLE)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+}
+
+/**
  * _enable_wakeup: set OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
  * @oh: struct omap_hwmod *
  *
@@ -2416,6 +2461,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_enable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2446,6 +2492,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_disable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;


