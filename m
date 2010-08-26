From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 04/11] OMAP: mach-omap2: Fix miscellaneous sparse warnings
Date: Fri, 27 Aug 2010 02:26:42 +0530
Message-ID: <1282856209-15645-5-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45107 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab0HZU6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 16:58:02 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

This patch fixes miscellaneous sparse warnings in mach-omap2.

arch/arm/mach-omap2/board-am3517evm.c:141:17: warning: Initializer entry defined twice
arch/arm/mach-omap2/board-am3517evm.c:142:18:   also defined here

arch/arm/mach-omap2/irq.c:50:35: warning: Using plain integer as NULL pointer

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    1 -
 arch/arm/mach-omap2/irq.c             |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ae22ea8..b091741 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -139,7 +139,6 @@ static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("s35390a", 0x30),
-		.type		= "s35390a",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 26aeef5..02fd942 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -47,7 +47,7 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
 		/* MPU INTC */
-		.base_reg	= 0,
+		.base_reg	= (void __iomem *)0,
 		.nr_irqs	= 96,
 	},
 };
-- 
1.7.0.4

