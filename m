From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as
 static and dynamic.
Date: Wed, 23 Feb 2011 10:49:24 -0800
Message-ID: <20110223184924.GV15225@atomide.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50679 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab1BWSt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 13:49:29 -0500
Content-Disposition: inline
In-Reply-To: <1296191298-17545-2-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com

Hi,

Some comments and an alternative patch below.

* sricharan <r.sricharan@ti.com> [110127 21:05]:
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c

> +	hmux->pads_static = kzalloc(sizeof(struct omap_device_pad) *
> +				hmux->nr_pads_static, GFP_KERNEL);
> +	hmux->pads_dynamic = kzalloc(sizeof(struct omap_device_pad) *
> +				hmux->nr_pads_dynamic, GFP_KERNEL);
> +

We can just add a runtime alias list of pointers instead to keep
things simpler.

> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -160,9 +160,13 @@ struct omap_board_mux {
>  };
>  
>  #define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Not needed for board-*.c */
> -#define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad,
> -						   needs enable, idle and off
> -						   values */
> +#define OMAP_DEVICE_PAD_REMUX_DISABLE	BIT(2)  /* Dynamic remux needed
> +						   when pad would be
> +						   disabled. Say when
> +						   the driver is removed */

In this case we should just disable all the pads.

> +#define OMAP_DEVICE_PAD_REMUX_IDLE	BIT(1)	/* Dynamic remux needed
> +						   for pad, during power
> +						   state transitions. */
>  #define OMAP_DEVICE_PAD_WAKEUP		BIT(0)	/* Pad is wake-up capable */

We just need OMAP_DEVICE_PAD_ENABLED and OMAP_DEVICE_PAD_IDLE.
  
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1231,7 +1231,7 @@ static int _enable(struct omap_hwmod *oh)
>  
>  	/* Mux pins for device runtime if populated */
>  	if (oh->mux)
> -		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
> +		omap_hwmod_mux_enable(oh->mux, _HWMOD_STATE_ENABLED);
>  
>  	_add_initiator_dep(oh, mpu_oh);
>  	_enable_clocks(oh);

No need for these kind of changes.

Alternative patch below that keeps things simpler.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 22 Feb 2011 16:05:15 -0800
Subject: [PATCH] omap2+: Add separate list for dynamic pads to mux

This avoids going through the list unnecessarily when
idling devices for runtime PM.

Based on an earlier patch by sricharan <r.sricharan@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

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
@@ -302,9 +302,40 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
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
+			pr_debug("%s: pad %s tagged dynamic\n",
+					__func__, pad->name);
+			hmux->pads_dynamic[nr_pads_dynamic] = pad;
+			nr_pads_dynamic++;
+		}
+	}
+
 	return hmux;
 
 err3:
@@ -322,6 +353,46 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 	int i;
 
+	/* Runtime idling of dynamic pads */
+	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+			struct omap_device_pad *pad = &hmux->pads[i];
+			int val = -EINVAL;
+
+			pad->flags &= ~OMAP_DEVICE_PAD_ENABLED;
+			pad->flags |= OMAP_DEVICE_PAD_IDLE;
+			val = pad->idle;
+			omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+		}
+
+		return;
+	}
+
+	/* Runtime enabling of dynamic pads */
+	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic) {
+		int idled = 0;
+
+		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+			struct omap_device_pad *pad = &hmux->pads[i];
+			int val = -EINVAL;
+
+			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
+				continue;
+
+			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
+			pad->flags |= OMAP_DEVICE_PAD_ENABLED;
+			val = pad->enable;
+			omap_mux_write(pad->partition, val,
+					pad->mux->reg_offset);
+			idled++;
+		}
+
+		if (idled)
+			return;
+	}
+
+	/* Enabling, disabling or idling of all pads */
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
 		int flags, val = -EINVAL;
@@ -363,6 +434,11 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
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
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -159,7 +159,8 @@ struct omap_board_mux {
 	u16	value;
 };
 
-#define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Not needed for board-*.c */
+#define OMAP_DEVICE_PAD_IDLE		BIT(7)	/* Not needed for board-*.c */
+#define OMAP_DEVICE_PAD_ENABLED		BIT(6)	/* Not needed for board-*.c */
 #define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad,
 						   needs enable, idle and off
 						   values */
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1230,8 +1230,9 @@ static int _enable(struct omap_hwmod *oh)
 		_deassert_hardreset(oh, oh->rst_lines[0].name);
 
 	/* Mux pins for device runtime if populated */
-	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+	if (oh->mux && ((oh->_state == _HWMOD_STATE_DISABLED) ||
+		((oh->_state == _HWMOD_STATE_IDLE) && oh->mux->pads_dynamic)))
+			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
@@ -1279,7 +1280,7 @@ static int _idle(struct omap_hwmod *oh)
 	_disable_clocks(oh);
 
 	/* Mux pins for device idle if populated */
-	if (oh->mux)
+	if (oh->mux && oh->mux->pads_dynamic)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
 
 	oh->_state = _HWMOD_STATE_IDLE;
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -90,6 +90,9 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 struct omap_hwmod_mux_info {
 	int				nr_pads;
 	struct omap_device_pad		*pads;
+	int				nr_pads_dynamic;
+	struct omap_device_pad		**pads_dynamic;
+	bool				enabled;
 };
 
 /**
