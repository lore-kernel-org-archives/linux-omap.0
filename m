From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 27/27] ARM: OMAP: add vdds_sdi supply for sdi.0
Date: Thu, 30 May 2013 12:36:20 +0300
Message-ID: <1369906580-27585-28-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030463Ab3E3JhZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:37:25 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

SDI driver gets currently the vdds_sdi regulator via omapdss device.
This is not correct, and we'll change the SDI driver to get the
regulator directly.

This patch changes the rx51 board file to add vdds_dsi supply for sdi.0
device.

Note that the vdds_sdi supply for omapdss device is still left there, as
the current display driver uses it. When both the board files and the
display driver has been changed, we can remove the unused supply.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e35e0b6..c3270c0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -565,6 +565,7 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss_sdi.0"),
 	/* Si4713 supply */
 	REGULATOR_SUPPLY("vdd", "2-0063"),
 	/* lis3lv02d */
-- 
1.8.1.2

