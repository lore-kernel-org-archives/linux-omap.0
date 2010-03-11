From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/19] omap3: pandora: add missing i2c3 board_info
Date: Thu, 11 Mar 2010 15:48:39 -0800
Message-ID: <20100311234839.4500.21147.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52719 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:16 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

This will allow BQ27500 fuel gauge to function.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 51a5315..395d049 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -459,12 +459,20 @@ static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("bq27500", 0x55),
+		.flags = I2C_CLIENT_WAKE,
+	},
+};
+
 static int __init omap3pandora_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
 	/* i2c2 pins are not connected */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, omap3pandora_i2c3_boardinfo,
+			ARRAY_SIZE(omap3pandora_i2c3_boardinfo));
 	return 0;
 }
 

