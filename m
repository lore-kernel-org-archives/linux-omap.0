From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as static
 and dynamic.
Date: Fri, 25 Feb 2011 18:51:47 +0530
Message-ID: <fb7598aa6d67149ce5a7329a5a6620b4@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-2-git-send-email-r.sricharan@ti.com> <20110223184924.GV15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36809 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab1BYNVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:21:51 -0500
Received: by mail-vw0-f45.google.com with SMTP id 19so1487541vws.4
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 05:21:50 -0800 (PST)
In-Reply-To: <20110223184924.GV15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, paul@pwsan.com

Hi Tony,
>From: Tony Lindgren <tony@atomide.com>
>Date: Tue, 22 Feb 2011 16:05:15 -0800
>Subject: [PATCH] omap2+: Add separate list for dynamic pads to mux
>
>This avoids going through the list unnecessarily when
>idling devices for runtime PM.
>
>Based on an earlier patch by sricharan <r.sricharan@ti.com>.
>
yes, this looks simpler actually.

>Signed-off-by: Tony Lindgren <tony@atomide.com>
>
>--- a/arch/arm/mach-omap2/mux.c
>+++ b/arch/arm/mach-omap2/mux.c
>@@ -258,7 +258,7 @@ struct omap_hwmod_mux_info * __init
> omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
> {
> 	struct omap_hwmod_mux_info *hmux;
>-	int i;
>+	int i, nr_pads_dynamic = 0;
>
> 	if (!bpads || nr_pads < 1)
> 		return NULL;
>@@ -302,9 +302,40 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads,
int
>nr_pads)
> 		pad->enable = bpad->enable;
> 		pad->idle = bpad->idle;
> 		pad->off = bpad->off;
>+
>+		if (pad->flags & OMAP_DEVICE_PAD_REMUX)
>+			nr_pads_dynamic++;
>+
> 		pr_debug("%s: Initialized %s\n", __func__, pad->name);
> 	}
>
>+	if (!nr_pads_dynamic)
>+		return hmux;
>+
>+	/*
>+	 * Add pads that need dynamic muxing into a separate list
>+	 */
>+
>+	hmux->nr_pads_dynamic = nr_pads_dynamic;
>+	hmux->pads_dynamic = kzalloc(sizeof(struct omap_device_pad *) *
>+					nr_pads_dynamic, GFP_KERNEL);
>+	if (!hmux->pads_dynamic) {
>+		pr_err("%s: Could not allocate dynamic pads\n", __func__);
>+		return hmux;
>+	}
>+
>+	nr_pads_dynamic = 0;
>+	for (i = 0; i < hmux->nr_pads; i++) {
>+		struct omap_device_pad *pad = &hmux->pads[i];
>+
>+		if (pad->flags & OMAP_DEVICE_PAD_REMUX) {
>+			pr_debug("%s: pad %s tagged dynamic\n",
>+					__func__, pad->name);
>+			hmux->pads_dynamic[nr_pads_dynamic] = pad;
>+			nr_pads_dynamic++;
>+		}
>+	}
>+
> 	return hmux;
>
> err3:
>@@ -322,6 +353,46 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info
*hmux,
>u8 state)
> {
> 	int i;
>
>+	/* Runtime idling of dynamic pads */
>+	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
>+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
>+			struct omap_device_pad *pad = &hmux->pads[i];
>+			int val = -EINVAL;
>+
>+			pad->flags &= ~OMAP_DEVICE_PAD_ENABLED;
>+			pad->flags |= OMAP_DEVICE_PAD_IDLE;
>+			val = pad->idle;
>+			omap_mux_write(pad->partition, val,
>+					pad->mux->reg_offset);
>+		}
>+
>+		return;
>+	}
>+
>+	/* Runtime enabling of dynamic pads */
>+	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic) {
>+		int idled = 0;
>+
>+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
>+			struct omap_device_pad *pad = &hmux->pads[i];
>+			int val = -EINVAL;
>+
>+			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
>+				continue;
>+
>+			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
>+			pad->flags |= OMAP_DEVICE_PAD_ENABLED;
>+			val = pad->enable;
>+			omap_mux_write(pad->partition, val,
>+					pad->mux->reg_offset);
>+			idled++;
>+		}
>+
>+		if (idled)
>+			return;
>+	}
>+
>+	/* Enabling, disabling or idling of all pads */
> 	for (i = 0; i < hmux->nr_pads; i++) {
> 		struct omap_device_pad *pad = &hmux->pads[i];
> 		int flags, val = -EINVAL;
>@@ -363,6 +434,11 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info
*hmux,
>u8 state)
> 			pad->flags = flags;
> 		}
> 	}
>+
>+	if (state == _HWMOD_STATE_ENABLED)
>+		hmux->enabled = true;
>+	else
>+		hmux->enabled = false;
> }
>
> #ifdef CONFIG_DEBUG_FS
>--- a/arch/arm/mach-omap2/mux.h
>+++ b/arch/arm/mach-omap2/mux.h
>@@ -159,7 +159,8 @@ struct omap_board_mux {
> 	u16	value;
> };
>
>-#define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Not needed for
>board-*.c */
>+#define OMAP_DEVICE_PAD_IDLE		BIT(7)	/* Not needed for
board-*.c
>*/
>+#define OMAP_DEVICE_PAD_ENABLED		BIT(6)	/* Not needed for
>board-*.c */
> #define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux
>a pad,
> 						   needs enable, idle and
off
> 						   values */
>--- a/arch/arm/mach-omap2/omap_hwmod.c
>+++ b/arch/arm/mach-omap2/omap_hwmod.c
>@@ -1230,8 +1230,9 @@ static int _enable(struct omap_hwmod *oh)
> 		_deassert_hardreset(oh, oh->rst_lines[0].name);
>
> 	/* Mux pins for device runtime if populated */
>-	if (oh->mux)
>-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>+	if (oh->mux && ((oh->_state == _HWMOD_STATE_DISABLED) ||
>+		((oh->_state == _HWMOD_STATE_IDLE) &&
oh->mux->pads_dynamic)))
>+			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>

This will avoid the static pads initialization.
I have made few modications to your patch, so that static pads
Initialization is taken care and iteration does not happen unnessecarily.
I have given the patch below.i have tested the patch on 3430sdp
with by enabling dynamic pads for test purpose.


-----------------------------------------

arch/arm/mach-omap2/mux.c                    |   86
++++++++++++++++++++++---
 arch/arm/mach-omap2/mux.h                    |    3 +-
 arch/arm/mach-omap2/omap_hwmod.c             |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
 4 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6c84659..e2a535b 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -258,7 +258,7 @@ struct omap_hwmod_mux_info * __init
 omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 {
 	struct omap_hwmod_mux_info *hmux;
-	int i;
+	int i, nr_pads_dynamic = 0;

 	if (!bpads || nr_pads < 1)
 		return NULL;
@@ -302,9 +302,40 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads,
int nr_pads)
 		pad->enable = bpad->enable;
 		pad->idle = bpad->idle;
 		pad->off = bpad->off;
+
+		if (pad->flags & OMAP_DEVICE_PAD_REMUX)
+			nr_pads_dynamic++;
+
 		pr_debug("%s: Initialized %s\n", __func__, pad->name);
 	}

+	if (!nr_pads_dynamic)
+		return hmux;
+
+	/*
+	 * Add pads that need dynamic muxing into a separate list
+	 */
+
+	hmux->nr_pads_dynamic = nr_pads_dynamic;
+	hmux->pads_dynamic = kzalloc(sizeof(struct omap_device_pad *) *
+					nr_pads_dynamic, GFP_KERNEL);
+	if (!hmux->pads_dynamic) {
+		pr_err("%s: Could not allocate dynamic pads\n", __func__);
+		return hmux;
+	}
+
+	nr_pads_dynamic = 0;
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+
+		if (pad->flags & OMAP_DEVICE_PAD_REMUX) {
+			pr_err("%s: pad %s tagged dynamic\n",
+					__func__, pad->name);
+			hmux->pads_dynamic[nr_pads_dynamic] = pad;
+			nr_pads_dynamic++;
+		}
+	}
+
 	return hmux;

 err3:
@@ -322,6 +353,39 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux,
u8 state)
 {
 	int i;

+	/* Runtime idling of dynamic pads */
+	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+			struct omap_device_pad *pad =
hmux->pads_dynamic[i];
+			int val = -EINVAL;
+
+			val = pad->idle;
+			omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+		}
+		return;
+	}
+
+	/* Runtime enabling of dynamic pads */
+	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
+						&& hmux->enabled) {
+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+			struct omap_device_pad *pad =
hmux->pads_dynamic[i];
+			int val = -EINVAL;
+
+			val = pad->enable;
+			omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+		}
+		return;
+	}
+
+	/* When there are only static pads which are initialised, return
*/
+	if((state == _HWMOD_STATE_ENABLED) && (!(hmux->pads_dynamic))
+						&& (hmux->enabled))
+		return;
+
+	/* Enabling, disabling or idling of all pads */
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
 		int flags, val = -EINVAL;
@@ -337,16 +401,7 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux,
u8 state)
 			pr_debug("%s: Enabling %s %x\n", __func__,
 					pad->name, val);
 			break;
-		case _HWMOD_STATE_IDLE:
-			if (!(flags & OMAP_DEVICE_PAD_REMUX))
-				break;
-			flags &= ~OMAP_DEVICE_PAD_ENABLED;
-			val = pad->idle;
-			pr_debug("%s: Idling %s %x\n", __func__,
-					pad->name, val);
-			break;
 		case _HWMOD_STATE_DISABLED:
-		default:
 			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
 			if (flags & OMAP_DEVICE_PAD_REMUX)
 				val = pad->off;
@@ -355,7 +410,11 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux,
u8 state)
 			flags &= ~OMAP_DEVICE_PAD_ENABLED;
 			pr_debug("%s: Disabling %s %x\n", __func__,
 					pad->name, val);
-		};
+			break;
+		default:
+			/* Nothing to be done */
+			break;
+		}

 		if (val >= 0) {
 			omap_mux_write(pad->partition, val,
@@ -363,6 +422,11 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux,
u8 state)
 			pad->flags = flags;
 		}
 	}
+
+	if (state == _HWMOD_STATE_ENABLED)
+		hmux->enabled = true;
+	else
+		hmux->enabled = false;
 }

 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a4ab17a..8f6e326 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -159,7 +159,8 @@ struct omap_board_mux {
 	u16	value;
 };

-#define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Not needed for
board-*.c */
+#define OMAP_DEVICE_PAD_IDLE		BIT(7)	/* Not needed for
board-*.c */
+#define OMAP_DEVICE_PAD_ENABLED		BIT(6)	/* Not needed for
board-*.c */
 #define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a
pad,
 						   needs enable, idle and
off
 						   values */
diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..5f7aaf7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1279,7 +1279,7 @@ static int _idle(struct omap_hwmod *oh)
 	_disable_clocks(oh);

 	/* Mux pins for device idle if populated */
-	if (oh->mux)
+	if (oh->mux && oh->mux->pads_dynamic)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);

 	oh->_state = _HWMOD_STATE_IDLE;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..11efa2d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -90,6 +90,9 @@ extern struct omap_hwmod_sysc_fields
omap_hwmod_sysc_type2;
 struct omap_hwmod_mux_info {
 	int				nr_pads;
 	struct omap_device_pad		*pads;
+	int				nr_pads_dynamic;
+	struct omap_device_pad		**pads_dynamic;
+	bool				enabled;
 };
