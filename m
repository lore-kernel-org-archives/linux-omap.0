From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 07/14] ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
Date: Wed,  8 Feb 2012 18:43:52 +0100
Message-ID: <1328723039-15952-8-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2BHRof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:35 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so853447wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:34 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

The VPBOUNDINTST field of the ERRCONFIG register has an additional
functional meaning of force clearing the SR internal signal with VP
(sr_interruptz).
This can result in scenarios where the VP->SR protocol is violated
because the SR internal signal with VP is already high and VP will
never clear the vpirqclr signal.
Therefore during the next force update to reset to nominal voltage,
VP cannot pulse vpirqclr, so the PRCM HW cannot generate the tranxdone
IRQ and the situation is not recoverable until a cold reset is invoked.

To prevent this situation, check if status is set before clearing it
as this needs to be done only on a need basis.

Reported-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f2f2f2a..64d3ca7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,6 +289,8 @@ error:
 static void sr_v1_disable(struct omap_sr *sr)
 {
 	int timeout = 0;
+	int errconf_val = ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
+			ERRCONFIG_MCUBOUNDINTST;
 
 	/* Enable MCUDisableAcknowledge interrupt */
 	sr_modify_reg(sr, ERRCONFIG_V1,
@@ -297,13 +299,13 @@ static void sr_v1_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
 
-	/* Disable all other SR interrupts and clear the status */
+	/* Disable all other SR interrupts and clear the status as needed */
+	if (sr_read_reg(sr, ERRCONFIG_V1) & ERRCONFIG_VPBOUNDINTST_V1)
+		errconf_val |= ERRCONFIG_VPBOUNDINTST_V1;
 	sr_modify_reg(sr, ERRCONFIG_V1,
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
 			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
-			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
-			ERRCONFIG_MCUBOUNDINTST |
-			ERRCONFIG_VPBOUNDINTST_V1));
+			errconf_val);
 
 	/*
 	 * Wait for SR to be disabled.
@@ -332,9 +334,17 @@ static void sr_v2_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
 
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+	/*
+	 * Disable all other SR interrupts and clear the status
+	 * write to status register ONLY on need basis - only if status
+	 * is set.
+	 */
+	if (sr_read_reg(sr, ERRCONFIG_V2) & ERRCONFIG_VPBOUNDINTST_V2)
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
 			ERRCONFIG_VPBOUNDINTST_V2);
+	else
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+				0x0);
 	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
 			IRQENABLE_MCUVALIDINT |
 			IRQENABLE_MCUBOUNDSINT));
-- 
1.7.5.4

