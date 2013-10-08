From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY clock"
Date: Tue, 8 Oct 2013 13:06:38 +0300
Message-ID: <1381226799-29158-6-git-send-email-rogerq@ti.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381226799-29158-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.

The proper clock reference is provided in device tree so we
no longer need this.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-generic.c |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index cd85b36..da4e9b2 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,7 +15,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
-#include <linux/clk.h>
 
 #include <asm/mach/arch.h>
 
@@ -36,21 +35,6 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };
 
-/*
- * Create alias for USB host PHY clock.
- * Remove this when clock phandle can be provided via DT
- */
-static void __init legacy_init_ehci_clk(char *clkname)
-{
-	int ret;
-
-	ret = clk_add_alias("main_clk", NULL, clkname, NULL);
-	if (ret) {
-		pr_err("%s:Failed to add main_clk alias to %s :%d\n",
-						__func__, clkname, ret);
-	}
-}
-
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);
@@ -61,15 +45,10 @@ static void __init omap_generic_init(void)
 	 * HACK: call display setup code for selected boards to enable omapdss.
 	 * This will be removed when omapdss supports DT.
 	 */
-	if (of_machine_is_compatible("ti,omap4-panda")) {
+	if (of_machine_is_compatible("ti,omap4-panda"))
 		omap4_panda_display_init_of();
-		legacy_init_ehci_clk("auxclk3_ck");
