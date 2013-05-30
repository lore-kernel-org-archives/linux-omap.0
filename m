From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/27] ARM: OMAP: fix dsi regulator names
Date: Thu, 30 May 2013 12:36:18 +0300
Message-ID: <1369906580-27585-26-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030458Ab3E3JhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:37:22 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

board-cm-t35.c and board-ldp.c contain regulator supply entries for
vdds_dsi. However, the given device name is wrong.

This patch fixes the device name from omapdss_dsi1 to omapdss_dsi.0.

Note that as far as I know, DSI driver is not used on these boards, so
this should not have caused any problems.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c | 2 +-
 arch/arm/mach-omap2/board-ldp.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ee6218c..ce00968 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -293,7 +293,7 @@ static struct regulator_consumer_supply cm_t35_vsim_supply[] = {
 static struct regulator_consumer_supply cm_t35_vio_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi1.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d0d17bc..3dbc881 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -272,7 +272,7 @@ static struct regulator_init_data ldp_vaux1 = {
 
 static struct regulator_consumer_supply ldp_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data ldp_vpll2 = {
-- 
1.8.1.2

