From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 15/16] ARM: OMAP4: omap4panda: Don't enable USB PHY clock from board
Date: Thu, 15 Nov 2012 16:34:13 +0200
Message-ID: <1352990054-14680-16-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Instead of enabling the USB PHY clock in the board file we
provide the PHY clock details to the driver via board platform
data so that driver code can manage the clock.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-omap4panda.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..b942abe 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -151,7 +151,9 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.phy_reset  = false,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
+	.reset_gpio_port[2]  = -EINVAL,
+	.clk[0] = "auxclk3_ck", /* FREF_CLK3 provides 19.2 MHz clock to PHY */
+	.clkrate[0] = 19200000,
 };
 
 static struct gpio panda_ehci_gpios[] __initdata = {
@@ -162,16 +164,6 @@ static struct gpio panda_ehci_gpios[] __initdata = {
 static void __init omap4_ehci_init(void)
 {
 	int ret;
-	struct clk *phy_ref_clk;
