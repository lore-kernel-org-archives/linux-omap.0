From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] ARM: OMAP: Fix compile for palmte
Date: Mon, 12 Jan 2009 16:39:43 +0200
Message-ID: <20090112143943.24205.20631.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58434 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZALOjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:39:47 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Remove old MMC platform init code accidentally
left behind.

Patches are welcome to the new style MMC init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmte.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 75e32d3..00322f4 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -195,15 +195,6 @@ static struct omap_usb_config palmte_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_mmc_config palmte_mmc_config __initdata = {
-	.mmc[0]		= {
-		.enabled 	= 1,
-		.wp_pin		= PALMTE_MMC_WP_GPIO,
-		.power_pin	= PALMTE_MMC_POWER_GPIO,
-		.switch_pin	= PALMTE_MMC_SWITCH_GPIO,
-	},
-};
-
 static struct omap_lcd_config palmte_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };

