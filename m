From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/18] omap2: Add I2C bus 1 initialisation for 2430sdp
Date: Wed, 05 May 2010 12:32:43 -0700
Message-ID: <20100505193243.21568.16796.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65513 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267Ab0EETcn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:32:43 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viral Mehta <viral.mehta@lntinfotech.com>, linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Initialize isp1301 FS USB transceiver and
add I2C bus1 initialization code for OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..85f5f33 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -174,9 +174,18 @@ static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2D),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = OMAP_GPIO_IRQ(78),
+	},
+};
+
 static int __init omap2430_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
+			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
 	omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c_boardinfo));
 	return 0;

