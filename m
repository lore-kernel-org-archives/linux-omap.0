From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/28] omap: Devkit8000: Fix wrong usb port on Devkit8000
Date: Fri, 23 Apr 2010 16:11:29 -0700
Message-ID: <20100423231129.31953.42867.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61620 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab0DWXL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:29 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Thomas Weber <weber@corscience.de>

Disable the nonexistent ehci port on Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..db4c093 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -639,12 +639,12 @@ static struct omap_musb_board_data musb_board_data = {
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 147,
+	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
 };
 

