From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] omap3: Fix EHCI port for IGEP v2 board.
Date: Mon,  1 Mar 2010 12:18:07 +0100
Message-ID: <1267442288-3106-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38453 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0CCRht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 12:37:49 -0500
Received: by bwz1 with SMTP id 1so114868bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 09:37:47 -0800 (PST)
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
index 9958987..26f65ca 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -443,13 +443,13 @@ static struct omap_musb_board_data musb_board_data = {
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
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

