From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP: AM3517EVM: remove check for
 CONFIG_PANEL_SHARP_LQ043T1DG01
Date: Thu, 15 May 2014 21:54:52 +0200
Message-ID: <1400183692.11786.23.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Kconfig symbol PANEL_SHARP_LQ043T1DG01 was removed in v2.6.38. The
check for CONFIG_PANEL_SHARP_LQ043T1DG01 and its MODULE variant has
evaluated to false ever since. Remove that check.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested, again.

 arch/arm/mach-omap2/board-am3517evm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 543d9a882de3..4f9383cecf76 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -262,12 +262,7 @@ static struct usbhs_phy_data phy_data[] __initdata = {
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
-		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
-	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
-#else
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-#endif
 };
 
 #ifdef CONFIG_OMAP_MUX
-- 
1.9.0
