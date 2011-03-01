From: sricharan <r.sricharan@ti.com>
Subject: [PATCH] omap2+: mux: Initialise the static pads.
Date: Tue,  1 Mar 2011 23:46:00 +0530
Message-ID: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44310 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1CASO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 13:14:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, paul@pswan.com, santosh.shilimkar@ti.com

commit 7d5b199a seperates the pads as dynamic and
static and avoids unessecary iteration. But the static
pads are not getting initialised after this.

Adding the changes for initialisation of static pads.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
Tested this on 4430sdp for both static and dynamic pads
on top of linux-omap-2.6 master branch

 arch/arm/mach-omap2/mux.c        |   42 ++++++++++++++-----------------------
 arch/arm/mach-omap2/omap_hwmod.c |    5 +--
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index b2d097a..dd9ee58 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -352,15 +352,12 @@ err1:
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 	int i;
-
 	/* Runtime idling of dynamic pads */
 	if (state == _HWMOD_STATE_IDLE && hmux->enabled) {
 		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
-			struct omap_device_pad *pad = &hmux->pads[i];
+			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
-			pad->flags &= ~OMAP_DEVICE_PAD_ENABLED;
-			pad->flags |= OMAP_DEVICE_PAD_IDLE;
 			val = pad->idle;
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
@@ -370,28 +367,25 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 	}
 
 	/* Runtime enabling of dynamic pads */
-	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic) {
-		int idled = 0;
-
+	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
+					&& hmux->enabled) {
 		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
-			struct omap_device_pad *pad = &hmux->pads[i];
+			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
-			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
-				continue;
-
-			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
-			pad->flags |= OMAP_DEVICE_PAD_ENABLED;
 			val = pad->enable;
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
-			idled++;
 		}
 
-		if (idled)
-			return;
+		return;
 	}
 
+	/* When there are only static pads which are initialised, return */
+	if ((state == _HWMOD_STATE_ENABLED) && (!(hmux->pads_dynamic))
+						&& (hmux->enabled))
+		return;
+
 	/* Enabling, disabling or idling of all pads */
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
@@ -408,16 +402,7 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
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
@@ -426,7 +411,12 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 			flags &= ~OMAP_DEVICE_PAD_ENABLED;
 			pr_debug("%s: Disabling %s %x\n", __func__,
 					pad->name, val);
-		};
+
+			break;
+		default:
+			/* Nothing to be done */
+			break;
+		}
 
 		if (val >= 0) {
 			omap_mux_write(pad->partition, val,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a86ed82..56f3c78 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1230,9 +1230,8 @@ static int _enable(struct omap_hwmod *oh)
 		_deassert_hardreset(oh, oh->rst_lines[0].name);
 
 	/* Mux pins for device runtime if populated */
-	if (oh->mux && ((oh->_state == _HWMOD_STATE_DISABLED) ||
-		((oh->_state == _HWMOD_STATE_IDLE) && oh->mux->pads_dynamic)))
-			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+	if (oh->mux)
+		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
-- 
1.7.0.4

