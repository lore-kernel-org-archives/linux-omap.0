From: Damodar Santhapuri <x0132156-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] arm: omap: hwmod: add new memory resource for usb phy cont
Date: Mon, 9 Jul 2012 19:18:08 +0530
Message-ID: <1341841690-23899-1-git-send-email-x0132156@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Damodar Santhapuri <x0132156-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Added usb_ctrl0 and usb_ctrl1 base address as new memory resources
which will be used at am335x musb driver glue layer to turn on or
off builin PHY. This is needed untill we have a separate system
control module driver.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Damodar Santhapuri <x0132156-l0cyMroinI0@public.gmane.org>
---
This patch set applies to 'xceiv' branch on Felipe's tree.

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index df888fe..7dfb61e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -3274,6 +3274,18 @@ static struct omap_hwmod_addr_space am33xx_usbss_addr_space[] = {
 		.pa_end		= 0x47401800 + SZ_2K - 1,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.name		= "usb_ctrl0",
+		.pa_start	= 0x44E10620,
+		.pa_end		= 0x44E10624,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "usb_ctrl1",
+		.pa_start	= 0x44E10628,
+		.pa_end		= 0x44E1062c,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
