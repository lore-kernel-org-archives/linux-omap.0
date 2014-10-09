From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 1/6] ARM: OMAP2+: hwmod: add parent_hwmod support
Date: Thu, 9 Oct 2014 17:03:14 +0300
Message-ID: <1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbaJIODd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2014 10:03:33 -0400
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add parent_hwmod pointer to omap_hwmod. This can be set to point to a
"parent" hwmod that needs to be enabled for the "child" hwmod to work.

This is used at hwmod setup time: when doing the initial setup and
reset, first enable the parent hwmod, and after setup and reset is done,
restore the parent hwmod to postsetup_state.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e91a4e7519a..6e0cac89bcfe 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2719,11 +2719,33 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return 0;
 
+	if (oh->parent_hwmod) {
+		int r;
+
+		r = _enable(oh->parent_hwmod);
+		WARN(r, "hwmod: %s: setup: failed to enable parent hwmod %s\n",
+			oh->name, oh->parent_hwmod->name);
+	}
+
 	_setup_iclk_autoidle(oh);
 
 	if (!_setup_reset(oh))
 		_setup_postsetup(oh);
 
+	if (oh->parent_hwmod) {
+		u8 postsetup_state;
+
+		postsetup_state = oh->parent_hwmod->_postsetup_state;
+
+		if (postsetup_state == _HWMOD_STATE_IDLE)
+			_idle(oh->parent_hwmod);
+		else if (postsetup_state == _HWMOD_STATE_DISABLED)
+			_shutdown(oh->parent_hwmod);
+		else if (postsetup_state != _HWMOD_STATE_ENABLED)
+			WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
+			     oh->parent_hwmod->name, postsetup_state);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d635ff90..7bd2b59857c2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -676,6 +676,7 @@ struct omap_hwmod {
 	u8				_int_flags;
 	u8				_state;
 	u8				_postsetup_state;
+	struct omap_hwmod		*parent_hwmod;
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
2.1.1

