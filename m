From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level wakeup events
Date: Mon, 16 Apr 2012 18:10:53 +0530
Message-ID: <1334580053-17242-3-git-send-email-govindraj.raja@ti.com>
References: <1334580053-17242-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab2DPMlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 08:41:06 -0400
In-Reply-To: <1334580053-17242-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs.

Add api to control the module level wakeup mechanism from info provided from
hwmod data. If module level wakeups are available from hwmod data then they
have to be enabled/disabled as per driver request.

omap_hwmod_enable/disable_wakeup is used from serial.c which should
act on those registers to enable or disable the module level wakeup

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..05576ae 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -382,6 +382,35 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 }
 
 /**
+ * _enable_module_level_wakeup - enable/disable module level wakeup on hwmod.
+ * @oh: struct omap_hwmod *
+ * @set_wake: bool value indicating to set (true) or clear (false) module level
+ *		wakeup enable
+ *
+ * Set or clear the  module level wakeup capability the
+ * hwmod @oh. This function configures th PM_WKEN reg bits if they
+ * are available from hwmod. No return value
+ */
+static void _enable_module_level_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	u32 v;
+
+	if (oh->prcm.omap2.module_wakeup_offs &&
+			oh->prcm.omap2.module_wakeup_bit) {
+		v = omap2_prm_read_mod_reg(oh->prcm.omap2.module_offs,
+				oh->prcm.omap2.module_wakeup_offs);
+
+		if (set_wake)
+			v |= oh->prcm.omap2.module_wakeup_bit;
+		else
+			v &= ~oh->prcm.omap2.module_wakeup_bit;
+
+		omap2_prm_write_mod_reg(v, oh->prcm.omap2.module_offs,
+				oh->prcm.omap2.module_wakeup_offs);
+	}
+}
+
+/**
  * _set_idle_ioring_wakeup - enable/disable IO pad wakeup on hwmod idle for mux
  * @oh: struct omap_hwmod *
  * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
@@ -2471,6 +2500,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, true);
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -2504,6 +2534,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, false);
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-- 
1.7.9

