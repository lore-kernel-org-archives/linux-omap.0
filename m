From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 06/19] ARM: OMAP3+: SmartReflex: Fix status masking in ERRCONFIG register
Date: Tue, 31 Jan 2012 10:58:19 +0100
Message-ID: <1328003912-11709-7-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36265 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2AaJ7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:06 -0500
Received: by wgbgn7 with SMTP id gn7so4683262wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:05 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

ERRCONFIG register has status bits that were intended not to
be destroyed by bad modification. We cleanup and simplify the
handling the status in the modify path.

Reported-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f384c19..ba6ad09 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -74,10 +74,6 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 					u32 value)
 {
 	u32 reg_val;
-	u32 errconfig_offs = 0, errconfig_mask = 0;
-
-	reg_val = __raw_readl(sr->base + offset);
-	reg_val &= ~mask;
 
 	/*
 	 * Smartreflex error config register is special as it contains
@@ -88,16 +84,15 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 	 * if they are currently set, but does allow the caller to write
 	 * those bits.
 	 */
-	if (sr->ip_type == SR_TYPE_V1) {
-		errconfig_offs = ERRCONFIG_V1;
-		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
-	} else if (sr->ip_type == SR_TYPE_V2) {
-		errconfig_offs = ERRCONFIG_V2;
-		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
-	}
+	if (sr->ip_type == SR_TYPE_V1 && offset == ERRCONFIG_V1)
+		mask |= ERRCONFIG_STATUS_V1_MASK;
+	else if (sr->ip_type == SR_TYPE_V2 && offset == ERRCONFIG_V2)
+		mask |= ERRCONFIG_VPBOUNDINTST_V2;
+
+	reg_val = __raw_readl(sr->base + offset);
+	reg_val &= ~mask;
 
-	if (offset == errconfig_offs)
-		reg_val &= ~errconfig_mask;
+	value &= mask;
 
 	reg_val |= value;
 
-- 
1.7.5.4

