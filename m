From: "Luke-Jr" <luke@dashjr.org>
Subject: [PATCHv2] omap: rx51: Add bq27200 battery platform data
Date: Mon, 16 Aug 2010 08:57:19 -0500
Message-ID: <201008160857.25075.luke@dashjr.org>
References: <201008150112.30128.luke@dashjr.org> <20100816111029.a4c003e0.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zinan.dashjr.org ([173.242.112.54]:38274 "EHLO zinan.dashjr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab0HPN5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 09:57:31 -0400
In-Reply-To: <20100816111029.a4c003e0.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-
rx51-peripherals.c
index 9a5eb87..2c694d4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -739,6 +739,11 @@ static struct i2c_board_info __initdata 
rx51_peripherals_i2c_board_info_2[] = {
 		.platform_data = &rx51_tsl2563_platform_data,
 	},
 #endif
+#if defined(CONFIG_BATTERY_BQ27x00) || defined(CONFIG_BATTERY_BQ27x00_MODULE)
+	{
+		I2C_BOARD_INFO("bq27200", 0x55),
+	},
+#endif
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,
-- 
1.7.1
