From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] usb: musb: OMAP4430: Remove a redundant omap4430_phy_init
 call in usb_musb_init
Date: Tue, 20 Sep 2011 16:50:29 +0800
Message-ID: <1316508629.14514.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Current code calls omap4430_phy_init() twice in usb_musb_init().
Calling omap4430_phy_init() once is enough.
This patch removes the first omap4430_phy_init() call, which using an
uninitialized pointer as parameter.

This patch elimates below build warning:
arch/arm/mach-omap2/usb-musb.c: In function 'usb_musb_init':
arch/arm/mach-omap2/usb-musb.c:141: warning: 'dev' may be used uninitialized in this function

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a65145b..19e4dac 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -137,9 +137,6 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap44xx())
-		omap4430_phy_init(dev);
-
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
-- 
1.7.4.1
