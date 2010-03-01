From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH RESEND] omap3: Fix EHCI port for IGEP v2 board.
Date: Mon,  1 Mar 2010 16:02:36 +0100
Message-ID: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49746 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab0COKpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 06:45:19 -0400
Received: by bwz1 with SMTP id 1so2748686bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 03:45:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

IGEP v2 uses EHCI port 1 instead of EHCI port 2.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3c7789d..d55c57b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -458,13 +458,13 @@ static struct omap_musb_board_data musb_board_data = {
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset = true,
-	.reset_gpio_port[0] = -EINVAL,
-	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[1] = -EINVAL,
 	.reset_gpio_port[2] = -EINVAL,
 };
 
-- 
1.5.4.3

