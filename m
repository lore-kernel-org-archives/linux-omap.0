From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/13] omap4: Board changes for 4430sdp tmp105 temperature
	sensor
Date: Wed, 07 Jul 2010 12:44:42 +0300
Message-ID: <20100707094442.2562.53424.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60103 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0GGJoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:44 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>

Adding board configuration for the tmp105
temperature sensor. The interface to the sensor
is I2C.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 216870b..eb1775e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -357,6 +357,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
 		.platform_data = &sdp4430_twldata,
 	},
 };
+static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("tmp105", 0x48),
+	},
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -366,7 +371,8 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
 			ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }

