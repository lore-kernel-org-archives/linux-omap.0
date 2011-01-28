From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as static and dynamic.
Date: Fri, 28 Jan 2011 10:38:14 +0530
Message-ID: <1296191298-17545-2-git-send-email-r.sricharan@ti.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1A1FGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 00:06:09 -0500
In-Reply-To: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r.sricharan@ti.com, linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com

1) All the pads of a hwmod for the device are classified
   as static/dynamic. If a pad requires remuxing during
   the device transitions between enable/idle transitions
   then it is added to the dynamic list, static otherwise.

2) Both the static/dynamic pads of a hwmod are initialised
   when the device gets enabled. When the device transitions
   between enable/idle the dynamic pads are remuxed and
   static pads are skipped.

3) When the driver gets removed both the static and the
   dynamic pads are muxed to safe mode as default.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |  219 +++++++++++++++++++++-----
 arch/arm/mach-omap2/mux.h                    |   33 ++++-
 arch/arm/mach-omap2/omap_hwmod.c             |    6 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +-
 4 files changed, 212 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 17bd639..50ac117 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -258,7 +258,7 @@ struct omap_hwmod_mux_info * __init
 omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 {
 	struct omap_hwmod_mux_info *hmux;
-	int i;
+	int i, pads_static = 0, pads_dynamic = 0;
 
 	if (!bpads || nr_pads < 1)
 		return NULL;
@@ -267,18 +267,48 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 	if (!hmux)
 		goto err1;
 
-	hmux->nr_pads = nr_pads;
+	hmux->nr_pads_static = 0;
+	hmux->nr_pads_dynamic = 0;
+	hmux->static_pads_initialised = 0;
+
+	for (i = 0; i < nr_pads; i++) {
+		struct omap_device_pad *bpad = &bpads[i];
+
+		/*
+		 * only pads for which a remux is required during the
+		 * device state transitions between idle/enable are
+		 * added to dynamic list
+		 */
+
+		if ((bpad->flags) & (OMAP_DEVICE_PAD_REMUX_IDLE))
+			hmux->nr_pads_dynamic++;
+		else
+			hmux->nr_pads_static++;
 
-	hmux->pads = kzalloc(sizeof(struct omap_device_pad) *
-				nr_pads, GFP_KERNEL);
-	if (!hmux->pads)
+	}
+
+	hmux->pads_static = kzalloc(sizeof(struct omap_device_pad) *
+				hmux->nr_pads_static, GFP_KERNEL);
+	hmux->pads_dynamic = kzalloc(sizeof(struct omap_device_pad) *
+				hmux->nr_pads_dynamic, GFP_KERNEL);
+
+	if ((!hmux->pads_static) || (!hmux->pads_dynamic))
 		goto err2;
 
-	for (i = 0; i < hmux->nr_pads; i++) {
+	for (i = 0; i < nr_pads; i++) {
 		struct omap_mux_partition *partition;
-		struct omap_device_pad *bpad = &bpads[i], *pad = &hmux->pads[i];
+		struct omap_device_pad *bpad = &bpads[i], *pad;
 		struct omap_mux *mux;
 		int mux_mode;
+		int pad_dynamic = 0;
+
+		if ((bpad->flags) & (OMAP_DEVICE_PAD_REMUX_IDLE)) {
+			pad = &hmux->pads_dynamic[pads_dynamic++];
+			pad_dynamic = 1;
+		} else {
+			pad = &hmux->pads_static[pads_static++];
+			pad_dynamic = 0;
+		}
 
 		mux_mode = omap_mux_get_by_name(bpad->name, &partition, &mux);
 		if (mux_mode < 0)
@@ -290,10 +320,28 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 
 		pad->name = kzalloc(strlen(bpad->name) + 1, GFP_KERNEL);
 		if (!pad->name) {
-			int j;
+			int j, k;
+
+			/*
+			 * pads_dynamic or pads_static has the count of the
+			 * next pad in the list. So current pad is 1 less
+			 * than the index. Since current pad is unallocated
+			 * start deleting from 2 less than the index
+			 */
+
+			if (pad_dynamic) {
+				j = pads_dynamic - 2;
+				k = pads_static - 1;
+			} else {
+				j = pads_static - 2;
+				k = pads_dynamic - 1;
+			}
+
+			for (; j >= 0; j--)
+				kfree(hmux->pads_dynamic[j].name);
+			for (; k >= 0; k--)
+				kfree(hmux->pads_static[k].name);
 
-			for (j = i - 1; j >= 0; j--)
-				kfree(hmux->pads[j].name);
 			goto err3;
 		}
 		strcpy(pad->name, bpad->name);
@@ -308,7 +356,8 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 	return hmux;
 
 err3:
-	kfree(hmux->pads);
+	kfree(hmux->pads_static);
+	kfree(hmux->pads_dynamic);
 err2:
 	kfree(hmux);
 err1:
@@ -318,53 +367,137 @@ err1:
 }
 
 /* Assumes the calling function takes care of locking */
-void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
+void omap_hwmod_mux_enable(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 	int i;
 
-	for (i = 0; i < hmux->nr_pads; i++) {
-		struct omap_device_pad *pad = &hmux->pads[i];
-		int flags, val = -EINVAL;
+	if (!hmux->static_pads_initialised) {
+		hmux->static_pads_initialised = 1;
 
-		flags = pad->flags;
+		for (i = 0; i < hmux->nr_pads_static; i++) {
+			struct omap_device_pad *pad = &hmux->pads_static[i];
+			int val = -EINVAL;
 
-		switch (state) {
-		case _HWMOD_STATE_ENABLED:
-			if (flags & OMAP_DEVICE_PAD_ENABLED)
-				break;
-			flags |= OMAP_DEVICE_PAD_ENABLED;
 			val = pad->enable;
 			pr_debug("%s: Enabling %s %x\n", __func__,
-					pad->name, val);
-			break;
-		case _HWMOD_STATE_IDLE:
-			if (!(flags & OMAP_DEVICE_PAD_REMUX))
-				break;
-			flags &= ~OMAP_DEVICE_PAD_ENABLED;
-			val = pad->idle;
-			pr_debug("%s: Idling %s %x\n", __func__,
-					pad->name, val);
-			break;
-		case _HWMOD_STATE_DISABLED:
-		default:
-			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
-			if (flags & OMAP_DEVICE_PAD_REMUX)
-				val = pad->off;
-			else
-				val = OMAP_MUX_MODE7;
-			flags &= ~OMAP_DEVICE_PAD_ENABLED;
-			pr_debug("%s: Disabling %s %x\n", __func__,
-					pad->name, val);
-		};
+				pad->name, val);
+
+			if (val >= 0) {
+				omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+			}
+		}
+	}
+
+	for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+		struct omap_device_pad *pad = &hmux->pads_dynamic[i];
+		int flags, val = -EINVAL;
+
+		flags = pad->flags;
+
+		if (flags & OMAP_DEVICE_PAD_ENABLED)
+			continue;
+
+		flags |= OMAP_DEVICE_PAD_ENABLED;
+		val = pad->enable;
+		pr_debug("%s: Enabling %s %x\n", __func__,
+			pad->name, val);
 
 		if (val >= 0) {
 			omap_mux_write(pad->partition, val,
-					pad->mux->reg_offset);
+				pad->mux->reg_offset);
 			pad->flags = flags;
 		}
 	}
 }
 
+/* Assumes the calling function takes care of locking */
+void omap_hwmod_mux_disable(struct omap_hwmod_mux_info *hmux, u8 state)
+{
+	int i;
+
+	/*
+	 * All the static pads are uninitialised because of driver
+	 * being removed. They have to be initialised again by Enable
+	 */
+	hmux->static_pads_initialised = 0;
+
+	for (i = 0; i < hmux->nr_pads_static; i++) {
+		struct omap_device_pad *pad = &hmux->pads_static[i];
+		int flags, val = -EINVAL;
+
+		flags = pad->flags;
+
+		/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
+		if (flags & OMAP_DEVICE_PAD_REMUX_DISABLE)
+			val = pad->off;
+		else
+			val = OMAP_MUX_MODE7;
+
+		pr_debug("%s: Disabling static %s %x\n", __func__,
+						pad->name, val);
+		if (val >= 0) {
+			omap_mux_write(pad->partition, val,
+				pad->mux->reg_offset);
+		}
+	}
+
+	/*
+	 * All the dynamic pads should also be remuxed. So this
+	 * functions remuxes all the pads of a hwmod
+	 */
+
+	for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+		struct omap_device_pad *pad = &hmux->pads_dynamic[i];
+		int flags, val = -EINVAL;
+
+		flags = pad->flags;
+
+		/* Use safe mode unless OMAP_DEVICE_PAD_REMUX_DISABLE */
+		if (flags & OMAP_DEVICE_PAD_REMUX_DISABLE)
+			val = pad->off;
+		else
+			val = OMAP_MUX_MODE7;
+
+		flags &= ~OMAP_DEVICE_PAD_ENABLED;
+
+		pr_debug("%s: Disabling dynamic %s %x\n", __func__,
+						pad->name, val);
+		if (val >= 0) {
+			omap_mux_write(pad->partition, val,
+				pad->mux->reg_offset);
+			pad->flags = flags;
+		}
+	}
+}
+
+/* Assumes the calling function takes care of locking */
+void omap_hwmod_mux_idle(struct omap_hwmod_mux_info *hmux, u8 state)
+{
+	int i;
+
+	for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+		struct omap_device_pad *pad = &hmux->pads_dynamic[i];
+		int flags, val = -EINVAL;
+
+		flags = pad->flags;
+
+		/* Use the pad idle mode remux value */
+		val = pad->idle;
+
+		flags &= ~OMAP_DEVICE_PAD_ENABLED;
+
+		pr_debug("%s: Disabling %s %x\n", __func__,
+						pad->name, val);
+		if (val >= 0) {
+			omap_mux_write(pad->partition, val,
+				pad->mux->reg_offset);
+			pad->flags = flags;
+		}
+	}
+}
+
+
 #ifdef CONFIG_DEBUG_FS
 
 #define OMAP_MUX_MAX_NR_FLAGS	10
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a4ab17a..909d9b5 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -160,9 +160,13 @@ struct omap_board_mux {
 };
 
 #define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Not needed for board-*.c */
-#define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad,
-						   needs enable, idle and off
-						   values */
+#define OMAP_DEVICE_PAD_REMUX_DISABLE	BIT(2)  /* Dynamic remux needed
+						   when pad would be
+						   disabled. Say when
+						   the driver is removed */
+#define OMAP_DEVICE_PAD_REMUX_IDLE	BIT(1)	/* Dynamic remux needed
+						   for pad, during power
+						   state transitions. */
 #define OMAP_DEVICE_PAD_WAKEUP		BIT(0)	/* Pad is wake-up capable */
 
 /**
@@ -212,13 +216,32 @@ extern struct omap_hwmod_mux_info *
 omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
 
 /**
- * omap_hwmod_mux - omap hwmod specific pin muxing
+ * omap_hwmod_mux_enable - omap hwmod specific pin muxing
  * @hmux:		Pads for a hwmod
  * @state:		Desired _HWMOD_STATE
  *
  * Called only from omap_hwmod.c, do not use.
  */
-void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
+void omap_hwmod_mux_enable(struct omap_hwmod_mux_info *hmux, u8 state);
+
+/**
+ * omap_hwmod_mux_idle - omap hwmod specific pin muxing
+ * @hmux:		Pads for a hwmod
+ * @state:		Desired _HWMOD_STATE
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+void omap_hwmod_mux_idle(struct omap_hwmod_mux_info *hmux, u8 state);
+
+/**
+ * omap_hwmod_mux_disable - omap hwmod specific pin muxing
+ * @hmux:		Pads for a hwmod
+ * @state:		Desired _HWMOD_STATE
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+void omap_hwmod_mux_disable(struct omap_hwmod_mux_info *hmux, u8 state);
+
 
 #else
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..49ed741 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1231,7 +1231,7 @@ static int _enable(struct omap_hwmod *oh)
 
 	/* Mux pins for device runtime if populated */
 	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+		omap_hwmod_mux_enable(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
@@ -1280,7 +1280,7 @@ static int _idle(struct omap_hwmod *oh)
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+		omap_hwmod_mux_idle(oh->mux, _HWMOD_STATE_IDLE);
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
@@ -1342,7 +1342,7 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	/* Mux pins to safe mode or use populated off mode values */
 	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
+		omap_hwmod_mux_disable(oh->mux, _HWMOD_STATE_DISABLED);
 
 	oh->_state = _HWMOD_STATE_DISABLED;
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6864a99..cdb329d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -88,8 +88,11 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
  * Note that this is currently built during init as needed.
  */
 struct omap_hwmod_mux_info {
-	int				nr_pads;
-	struct omap_device_pad		*pads;
+	int				nr_pads_static;
+	struct omap_device_pad		*pads_static;
+	int				nr_pads_dynamic;
+	struct omap_device_pad		*pads_dynamic;
+	int				static_pads_initialised;
 };
 
 /**
-- 
1.7.0.4

