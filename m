From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 04/10] OMAP: mach-omap2: Fix miscellaneous sparse warnings
Date: Tue, 21 Sep 2010 15:31:14 +0530
Message-ID: <1285063280-4057-5-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757293Ab0IUKB5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 06:01:57 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

This patch fixes miscellaneous sparse warnings in mach-omap2.

arch/arm/mach-omap2/board-am3517evm.c:141:17: warning: Initializer entry defined twice
arch/arm/mach-omap2/board-am3517evm.c:142:18:   also defined here

arch/arm/mach-omap2/irq.c:50:35: warning: Using plain integer as NULL pointer


Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    1 -
 arch/arm/mach-omap2/irq.c             |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

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
index 26aeef5..32eeabe 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -47,7 +47,6 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
 		/* MPU INTC */
-		.base_reg	= 0,
 		.nr_irqs	= 96,
 	},
 };
-- 
1.7.0.4

