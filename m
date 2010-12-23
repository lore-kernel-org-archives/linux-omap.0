From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] omap2+: Allow hwmod state changes to mux pads
 based on the state changes
Date: Wed, 22 Dec 2010 18:48:28 -0800
Message-ID: <20101223024827.GH7771@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <20101203004524.31687.48250.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55688 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0LWCsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 21:48:30 -0500
Content-Disposition: inline
In-Reply-To: <20101203004524.31687.48250.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101202 16:35]:
> Allow hwmod state changes to mux pads based on the state changes.
> 
> By default, only enable and disable the pads. In some rare cases
> dynamic remuxing for the idles states is needed, this can be done
> by passing the enable, idle, and off pads from board-*.c file along
> with OMAP_DEVICE_PAD_REMUX flag.

Here's this one updated mostly to build if CONFIG_OMAP_MUX is not
set.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Dec 2010 18:42:35 -0800
Subject: [PATCH] omap2+: Allow hwmod state changes to mux pads based on the state changes

Allow hwmod state changes to mux pads based on the state changes.

By default, only enable and disable the pads. In some rare cases
dynamic remuxing for the idles states is needed, this can be done
by passing the enable, idle, and off pads from board-*.c file along
with OMAP_DEVICE_PAD_REMUX flag.

Thanks to Paul Walmsley <paul@booyaka.com> for the comments on the
hwmod related changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 27eb51a..17bd639 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -317,6 +317,54 @@ err1:
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
index 9c48b9d..c9ec50d 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -171,6 +171,8 @@ struct omap_device_pad {
 	struct omap_mux			*mux;
 };
 
+struct omap_hwmod_mux_info;
+
 #if defined(CONFIG_OMAP_MUX)
 
 /**
@@ -195,6 +197,15 @@ int omap_mux_init_signal(const char *muxname, int val);
 extern struct omap_hwmod_mux_info *
 omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
 
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
@@ -212,6 +223,10 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 	return NULL;
 }
 
+static inline void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
+{
+}
+
 static struct omap_board_mux *board_mux __initdata __maybe_unused;
 
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 77a8be6..e282e35 100644
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
@@ -149,6 +148,7 @@
 #include "cm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "mux.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -1229,7 +1229,9 @@ static int _enable(struct omap_hwmod *oh)
 	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
 		_deassert_hardreset(oh, oh->rst_lines[0].name);
 
-	/* XXX mux balls */
+	/* Mux pins for device runtime if populated */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
@@ -1276,6 +1278,10 @@ static int _idle(struct omap_hwmod *oh)
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
 
+	/* Mux pins for device idle if populated */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+
 	oh->_state = _HWMOD_STATE_IDLE;
 
 	return 0;
@@ -1334,7 +1340,9 @@ static int _shutdown(struct omap_hwmod *oh)
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-	/* XXX mux any associated balls to safe mode */
+	/* Mux pins to safe mode or use populated off mode values */
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
 
 	oh->_state = _HWMOD_STATE_DISABLED;
 
