From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Initialise the static pads.
Date: Thu, 3 Mar 2011 18:28:32 -0800
Message-ID: <20110304022832.GR20560@atomide.com>
References: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758917Ab1CDC2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 21:28:39 -0500
Content-Disposition: inline
In-Reply-To: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pswan.com, santosh.shilimkar@ti.com

Hi,

Sorry for the delay on replying to this one, some comments below.

* sricharan <r.sricharan@ti.com> [110301 10:13]:
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -352,15 +352,12 @@ err1:
>  void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  {
>  	int i;
> -
>  	/* Runtime idling of dynamic pads */
>  	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
>  		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
> -			struct omap_device_pad *pad = &hmux->pads[i];
> +			struct omap_device_pad *pad = hmux->pads_dynamic[i];
>  			int val = -EINVAL;

Heh good catch :) I guess I got lucky that I had both be the same in my
test case..
  
> -			pad->flags &= ~OMAP_DEVICE_PAD_ENABLED;
> -			pad->flags |= OMAP_DEVICE_PAD_IDLE;
>  			val = pad->idle;
>  			omap_mux_write(pad->partition, val,
>  					pad->mux->reg_offset);

Hmm I guess OMAP_DEVICE_PAD_ENABLED state tracking we can leave out.
But the OMAP_DEVICE_PAD_IDLE state tracking we need to keep as otherwise
omap_hwmod_mux function won't know if we need to enable all pads initially,
or just the runtime idled pads.

> @@ -370,28 +367,25 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  	}
>  
>  	/* Runtime enabling of dynamic pads */
> -	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic) {
> -		int idled = 0;
> -
> +	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
> +					&& hmux->enabled) {
>  		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
> -			struct omap_device_pad *pad = &hmux->pads[i];
> +			struct omap_device_pad *pad = hmux->pads_dynamic[i];
>  			int val = -EINVAL;
>  
> -			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
> -				continue;
> -
> -			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
> -			pad->flags |= OMAP_DEVICE_PAD_ENABLED;
>  			val = pad->enable;
>  			omap_mux_write(pad->partition, val,
>  					pad->mux->reg_offset);
> -			idled++;
>  		}
>  
> -		if (idled)
> -			return;
> +		return;
>  	}

The same goes also for the idled flag, that's used to figure out that
we don't need to mux all the pins as we may have both dynamic and static
pins.
  
> +	/* When there are only static pads which are initialised, return */
> +	if ((state == _HWMOD_STATE_ENABLED) && (!(hmux->pads_dynamic))
> +						&& (hmux->enabled))
> +		return;
> +

It seems this would fail for the case where there are both static
and dynamic pins.

>  	/* Enabling, disabling or idling of all pads */
>  	for (i = 0; i < hmux->nr_pads; i++) {
>  		struct omap_device_pad *pad = &hmux->pads[i];
> @@ -408,16 +402,7 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  			pr_debug("%s: Enabling %s %x\n", __func__,
>  					pad->name, val);
>  			break;
> -		case _HWMOD_STATE_IDLE:
> -			if (!(flags & OMAP_DEVICE_PAD_REMUX))
> -				break;
> -			flags &= ~OMAP_DEVICE_PAD_ENABLED;
> -			val = pad->idle;
> -			pr_debug("%s: Idling %s %x\n", __func__,
> -					pad->name, val);
> -			break;
>  		case _HWMOD_STATE_DISABLED:
> -		default:
>  			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
>  			if (flags & OMAP_DEVICE_PAD_REMUX)
>  				val = pad->off;

OK _HWMOD_STATE_IDLE can be left out. But the default handling we should keep.

> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1230,9 +1230,8 @@ static int _enable(struct omap_hwmod *oh)
>  		_deassert_hardreset(oh, oh->rst_lines[0].name);
>  
>  	/* Mux pins for device runtime if populated */
> -	if (oh->mux && ((oh->_state == _HWMOD_STATE_DISABLED) ||
> -		((oh->_state == _HWMOD_STATE_IDLE) && oh->mux->pads_dynamic)))
> -			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
> +	if (oh->mux)
> +		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>  

Here we want to avoid calling the omap_hwmod_mux function unless we
have dynamic pins.

Anyways, updated fix below. Also folded it into the original patch
in devel-mmc branch, can you please give it a try with your test
cases?

Regards,

Tony

omap: mux: Fix muxing for dynamic pads and static pads

Fix muxing for dynamic pads and static pads. Based on an
earlier patch by sricharan <r.sricharan@ti.com>.
 
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -356,10 +356,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 	/* Runtime idling of dynamic pads */
 	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
 		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
-			struct omap_device_pad *pad = &hmux->pads[i];
+			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
-			pad->flags &= ~OMAP_DEVICE_PAD_ENABLED;
 			pad->flags |= OMAP_DEVICE_PAD_IDLE;
 			val = pad->idle;
 			omap_mux_write(pad->partition, val,
@@ -374,14 +373,13 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 		int idled = 0;
 
 		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
-			struct omap_device_pad *pad = &hmux->pads[i];
+			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
 			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
 				continue;
 
 			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
-			pad->flags |= OMAP_DEVICE_PAD_ENABLED;
 			val = pad->enable;
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
@@ -392,7 +390,7 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 			return;
 	}
 
-	/* Enabling, disabling or idling of all pads */
+	/* Enabling or disabling of all pads */
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
 		int flags, val = -EINVAL;
@@ -401,21 +399,10 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 
 		switch (state) {
 		case _HWMOD_STATE_ENABLED:
-			if (flags & OMAP_DEVICE_PAD_ENABLED)
-				break;
-			flags |= OMAP_DEVICE_PAD_ENABLED;
 			val = pad->enable;
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
 		default:
 			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
@@ -423,7 +410,6 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 				val = pad->off;
 			else
 				val = OMAP_MUX_MODE7;
-			flags &= ~OMAP_DEVICE_PAD_ENABLED;
 			pr_debug("%s: Disabling %s %x\n", __func__,
 					pad->name, val);
 		};
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 8f6e326..1d5bf42 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -160,7 +160,6 @@ struct omap_board_mux {
 };
 
 #define OMAP_DEVICE_PAD_IDLE		BIT(7)	/* Not needed for board-*.c */
-#define OMAP_DEVICE_PAD_ENABLED		BIT(6)	/* Not needed for board-*.c */
 #define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad,
 						   needs enable, idle and off
 						   values */
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 028efda..e07b9ab 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1225,9 +1225,10 @@ static int _enable(struct omap_hwmod *oh)
 		_deassert_hardreset(oh, oh->rst_lines[0].name);
 
 	/* Mux pins for device runtime if populated */
-	if (oh->mux && ((oh->_state == _HWMOD_STATE_DISABLED) ||
-		((oh->_state == _HWMOD_STATE_IDLE) && oh->mux->pads_dynamic)))
-			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+	if (oh->mux && (!oh->mux->enabled ||
+			((oh->_state == _HWMOD_STATE_IDLE) &&
+			 oh->mux->pads_dynamic)))
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
