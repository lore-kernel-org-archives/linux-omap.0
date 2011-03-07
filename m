From: sricharan <r.sricharan@ti.com>
Subject: [PATCH] omap2+: mux: Remove the use of IDLE flag.
Date: Mon,  7 Mar 2011 10:05:52 +0530
Message-ID: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab1CGEfU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 Mar 2011 23:35:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, santosh.shilimkar@ti.com, paul@pswan.com

Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
dynamically. This can be simplified by using the enabled
state variable of each pad. This also fixes the issue of
the static pads not getting muxed after idling and
disable/enable state transitions.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/mux.c |   19 +++++++------------
 arch/arm/mach-omap2/mux.h |    1 -
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 8717370..bb043cb 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -359,7 +359,6 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
-			pad->flags |= OMAP_DEVICE_PAD_IDLE;
 			val = pad->idle;
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
@@ -369,25 +368,18 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 	}
 
 	/* Runtime enabling of dynamic pads */
-	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic) {
-		int idled = 0;
-
+	if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
+					&& hmux->enabled) {
 		for (i = 0; i < hmux->nr_pads_dynamic; i++) {
 			struct omap_device_pad *pad = hmux->pads_dynamic[i];
 			int val = -EINVAL;
 
-			if (!(pad->flags & OMAP_DEVICE_PAD_IDLE))
-				continue;
-
-			pad->flags &= ~OMAP_DEVICE_PAD_IDLE;
 			val = pad->enable;
 			omap_mux_write(pad->partition, val,
 					pad->mux->reg_offset);
-			idled++;
 		}
 
-		if (idled)
-			return;
+		return;
 	}
 
 	/* Enabling or disabling of all pads */
@@ -404,7 +396,6 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 					pad->name, val);
 			break;
 		case _HWMOD_STATE_DISABLED:
-		default:
 			/* Use safe mode unless OMAP_DEVICE_PAD_REMUX */
 			if (flags & OMAP_DEVICE_PAD_REMUX)
 				val = pad->off;
@@ -412,6 +403,10 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 				val = OMAP_MUX_MODE7;
 			pr_debug("%s: Disabling %s %x\n", __func__,
 					pad->name, val);
+			break;
+		default:
+			/* Nothing to be done */
+			break;
 		};
 
 		if (val >= 0) {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 1d5bf42..8920fa4 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -159,7 +159,6 @@ struct omap_board_mux {
 	u16	value;
 };
 
-#define OMAP_DEVICE_PAD_IDLE		BIT(7)	/* Not needed for board-*.c */
 #define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad,
 						   needs enable, idle and off
 						   values */
-- 
1.7.0.4

