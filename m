From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] hmc5843: Digital compass board file
Date: Fri, 24 Sep 2010 17:27:02 -0700
Message-ID: <20100925002702.24551.27123.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61072 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0IYA1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:27:03 -0400
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>

The  board file changes for the digital compass hmc5843.
The interface to the device is i2c.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..5b6a48d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -412,6 +412,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 		I2C_BOARD_INFO("tmp105", 0x48),
 	},
 };
+static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("hmc5843", 0x1e),
+	},
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -423,7 +428,8 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
-	omap_register_i2c_bus(4, 400, NULL, 0);
+	omap_register_i2c_bus(4, 400, sdp4430_i2c_4_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_4_boardinfo));
 	return 0;
 }
 static void __init omap_4430sdp_init(void)

