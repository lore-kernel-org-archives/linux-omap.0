From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 4/6] MUSB Charger Type Detection: Fix DCP detect during boot.
Date: Thu, 15 Sep 2011 19:50:01 +0530
Message-ID: <1316096403-6013-5-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316096403-6013-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Viswanath Puttagunta <vishp-l0cyMroinI0@public.gmane.org>

The charger detection module is getting
disabled during boot up if a DCP (Dedicated charging port)
is connected before device is powered on (Bit 30 of CONTROL_USB2PHYCORE
is set). This patch enables charger type detection each time the charger type
wants to be detected.

Signed-off-by: Viswanath Puttagunta <vishp-l0cyMroinI0@public.gmane.org>
Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index e5a6701..55918ea 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -49,6 +49,7 @@
 #define CHARGER_TYPE_HOST		0x5
 #define CHARGER_TYPE_PC			0x6
 #define USB2PHY_CHGDETECTED		BIT(13)
+#define USB2PHY_DISCHGDET		BIT(30)
 
 static struct clk *phyclk, *clk48m, *clk32k;
 static void __iomem *ctrl_base;
@@ -124,6 +125,10 @@ int omap4_charger_detect(void)
 
 	omap4430_phy_power(NULL, 0, 1);
 
+	usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
+	usb2phycore &= ~USB2PHY_DISCHGDET;
+	omap4_ctrl_pad_writel(usb2phycore, CONTROL_USB2PHYCORE);
+
 	timeout = jiffies + msecs_to_jiffies(500);
 	do {
 		usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
