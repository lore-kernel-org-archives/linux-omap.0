From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Tue,  3 Dec 2013 09:33:09 +0100
Message-ID: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, hns@goldelico.com, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: linux-omap@vger.kernel.org

Without this change when booting omap3 device (gta04) with board file
leads to follwing errors:

[    1.203308] musb-hdrc musb-hdrc.0.auto: unable to find phy
[    1.209075] HS USB OTG: no transceiver configured
[    1.214019] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

and usb isn't working.

This is probably regression caused by commit: 6c27f939

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index b0d54da..3640ce0 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -92,7 +92,7 @@ void __init omap_pmic_late_init(void)
 
 #if defined(CONFIG_ARCH_OMAP3)
 struct phy_consumer consumers[] = {
-	PHY_CONSUMER("musb-hdrc.0", "usb"),
+	PHY_CONSUMER("musb-hdrc.0.auto", "usb"),
 };
 
 struct phy_init_data init_data = {
-- 
1.7.9.5
