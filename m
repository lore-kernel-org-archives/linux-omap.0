From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] omap: n8x0: Cleanup i2c1 and menelaus registration
Date: Thu, 23 Sep 2010 18:50:49 -0700
Message-ID: <20100924015049.10325.71798.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49624 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0IXBut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:49 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

- Move n8x0_i2c_board_info_1 out from #ifdef CONFIG_MENELAUS block,
  register i2c1 in n8x0_init_machine and do a few clean-ups around these.
  Code looks better if board infos are grouped together
- Mark n8x0_i2c_board_info_1 and n8x0_menelaus_platform_data with __initdata

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index a3e2b49..313ce5e 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -614,30 +614,25 @@ static int n8x0_menelaus_late_init(struct device *dev)
 	return 0;
 }
 
-static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] = {
+#else
+static int n8x0_menelaus_late_init(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
+	.late_init = n8x0_menelaus_late_init,
+};
+
+static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] __initdata = {
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
 		.irq = INT_24XX_SYS_NIRQ,
+		.platform_data = &n8x0_menelaus_platform_data,
 	},
 };
 
-static struct menelaus_platform_data n8x0_menelaus_platform_data = {
-	.late_init = n8x0_menelaus_late_init,
-};
-
-static void __init n8x0_menelaus_init(void)
-{
-	n8x0_i2c_board_info_1[0].platform_data = &n8x0_menelaus_platform_data;
-	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
-			      ARRAY_SIZE(n8x0_i2c_board_info_1));
-}
-
-#else
-static inline void __init n8x0_menelaus_init(void)
-{
-}
-#endif
-
 static void __init n8x0_map_io(void)
 {
 	omap2_set_globals_242x();
@@ -665,9 +660,10 @@ static void __init n8x0_init_machine(void)
 	/* FIXME: add n810 spi devices */
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
+	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
+			      ARRAY_SIZE(n8x0_i2c_board_info_1));
 
 	omap_serial_init();
-	n8x0_menelaus_init();
 	n8x0_onenand_init();
 	n8x0_mmc_init();
 	n8x0_usb_init();

