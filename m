From: Damodar Santhapuri <damodar.santhapuri@ti.com>
Subject: [PATCH  v3 1/3] arm: omap: hwmod: add new memory resource for usb phy control
Date: Thu, 12 Jul 2012 15:40:35 +0530
Message-ID: <1342087837-32161-1-git-send-email-damodar.santhapuri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51966 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759108Ab2GLKMR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 06:12:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>, Damodar Santhapuri <damodar.santhapuri@ti.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added usb_ctrl0 and usb_ctrl1 base address as new memory resources
which will be used at am335x musb driver glue layer to turn on or
off builin PHY untill we have a separate system control module
driver.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Damodar Santhapuri <damodar.santhapuri@ti.com>
---
Changes from v1:
Reordered the layout based on Kishon's comment on not using
 platform_get_resources_by_name.

Changes from v2:
Corrected the pa_end address of usb_cntrl registers based on
Sergei Shtylyov comment.
	
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index df888fe..6df4c4d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -3269,11 +3269,23 @@ static struct omap_hwmod_addr_space am33xx_usbss_addr_space[] = {
 		.flags		= ADDR_TYPE_RT
 	},
 	{
+		.name		= "usb_ctrl0",
+		.pa_start	= 0x44E10620,
+		.pa_end		= 0x44E10620 + SZ_4 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
 		.name		= "musb1",
 		.pa_start	= 0x47401800,
 		.pa_end		= 0x47401800 + SZ_2K - 1,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.name		= "usb_ctrl1",
+		.pa_start	= 0x44E10628,
+		.pa_end		= 0x44E10628 + SZ_4 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
-- 
1.7.0.4

