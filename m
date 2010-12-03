From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] omap2+: Allow hwmod state changes to mux pads based on
	the state changes
Date: Thu, 02 Dec 2010 16:45:24 -0800
Message-ID: <20101203004524.31687.48250.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19800 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0LCApc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:32 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Allow hwmod state changes to mux pads based on the state changes.

By default, only enable and disable the pads. In some rare cases
dynamic remuxing for the idles states is needed, this can be done
by passing the enable, idle, and off pads from board-*.c file along
with OMAP_DEVICE_PAD_REMUX flag.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c        |   48 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h        |   15 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c |   14 +++++++++--
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 4008814..b1a593f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -319,6 +319,54 @@ err1:
 	return NULL;
 }
 
+/* Assumes the calling function takes care of locking */
+void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
+{
+	int i;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+		int flags, val = -EINVAL;
+
+		flags = pad->flags;
+
+		switch (state) {
+		case _HWMOD_STATE_ENABLED:
+			if (flags & OMAP_DEVICE_PAD_ENABLED)
+				break;
+			flags |= OMAP_DEVICE_PAD_ENABLED;
+			val = pad->enable;
+			pr_debug("%s: Enabling %s %x\n", __func__,
+					pad->name, val);
+			break;
+		case _HWMOD_STATE_IDLE:
+			if (!(flags & OMAP_DEVICE_PAD_REMUX))
+				break;
+			flags &= ~OMAP_DEVICE_PAD_ENABLED;
+			val = pad->idle;
+			pr_debug("%s: Idling %s %x\n", __func__,
+					pad->name, val);
+			break;
+		case _HWMOD_STATE_DISABLED:
+		default:
+			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
+			if (flags & OMAP_DEVICE_PAD_REMUX)
+				val = pad->off;
+			else
+				val = OMAP_MUX_MODE7;
+			flags &= ~OMAP_DEVICE_PAD_ENABLED;
+			pr_debug("%s: Disabling %s %x\n", __func__,
+					pad->name, val);
+		};
+
+		if (val >= 0) {
+			omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+			pad->flags = flags;
+		}
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 #define OMAP_MUX_MAX_NR_FLAGS	10
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 8c78bed..c4b4f27 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -185,6 +185,17 @@ int omap_mux_init_gpio(int gpio, int val);
  */
 int omap_mux_init_signal(const char *muxname, int val);
 
+struct omap_hwmod_mux_info;
+
+/**
+ * omap_hwmod_mux - omap hwmod specific pin muxing
+ * @hmux:		Pads for a hwmod
+ * @state:		Desired _HWMOD_STATE
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
+
 #else
 
 static inline int omap_mux_init_gpio(int gpio, int val)
@@ -196,6 +207,10 @@ static inline int omap_mux_init_signal(char *muxname, int val)
 	return 0;
 }
 
+}
+
+static inline void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
+{
 #endif
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..cd787a2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -116,7 +116,6 @@
  * - Open Core Protocol Specification 2.2
  *
  * To do:
- * - pin mux handling
  * - handle IO mapping
  * - bus throughput & module latency measurement code
  *
@@ -146,6 +145,7 @@
 
 #include "cm.h"
 #include "prm.h"
+#include "mux.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -1197,7 +1197,9 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
 		_deassert_hardreset(oh, oh->rst_lines[0].name);
 
-	/* XXX mux balls */
+	/* Mux pins for device runtime if populated */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
@@ -1245,6 +1247,10 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
 
+	/* Mux pins for device idle if populated */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+
 	oh->_state = _HWMOD_STATE_IDLE;
 
 	return 0;
@@ -1288,7 +1294,9 @@ static int _shutdown(struct omap_hwmod *oh)
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-	/* XXX mux any associated balls to safe mode */
+	/* Mux pins to safe mode or use populated off mode values */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
 
 	oh->_state = _HWMOD_STATE_DISABLED;
 

