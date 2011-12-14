From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
Date: Tue, 13 Dec 2011 19:34:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131928330.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52622 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab1LNCeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 21:34:24 -0500
In-Reply-To: <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi

so I've updated this patch to change the SCM PADCTRL registers if the 
hwmod is currently idle, and _set_idle_ioring_wakeup() is called.  
Otherwise calling _set_idle_ioring_wakeup() would be useless under those 
conditions, since the new I/O ring wakeup values wouldn't be written back 
to the hardware until the hwmod had gone through an idle->enabled and 
enabled->idle transition.  

Please try to consider the function's appropriate behavior under which 
these functions can be called...

Updated patch below.  Will update internally once I get Tero's 
Signed-off-by:.


- Paul

From: Govindraj R <govindraj.raja@ti.com>
Date: Tue, 13 Dec 2011 13:50:23 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup

Add API to enable IO pad wakeup capability based on mux pad and
wake_up enable flag available from hwmod_mux initialization.

Use the wakeup_enable flag and enable wakeup capability for the given
pads. Wakeup capability will be enabled/disabled during hwmod idle
transition based on whether wakeup_flag is set or cleared.  If the
hwmod is currently idled, and any mux values were changed by
_set_idle_ioring_wakeup(), the SCM PADCTRL registers will be updated.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
XXX Tero's sign-off?
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
-- 
1.7.7.3

