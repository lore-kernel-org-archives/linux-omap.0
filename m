From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/2] arm:omap2:board-generic: Add DT support for AM33xx devices
Date: Wed, 18 Jan 2012 12:43:58 +0530
Message-ID: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38898 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab2ARHO1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 02:14:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

Although we consider am33xx device under omap34xx family of devices,
there is indeed difference between them, for example,

      - Initial required mapping (->map_io)
      - Early init (->init_early)
	Here, the whole sequence/data is different than omap3,
	For example, clock/hwmod/power/voltage data.
      - clock event/source timer (name and instances)

So, this patch adds seperate machine descriptor for AM33XX family
of devices in board-generic.c file.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
CC: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>
---
Tested it on AM335x-EVM, AM37xEVM and AM3517EVM.

 arch/arm/mach-omap2/board-generic.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index f7b4b24..2faecc8 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -106,6 +106,25 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 MACHINE_END
 #endif

+#if defined(CONFIG_SOC_OMAPAM33XX)
+static const char *am33xx_boards_compat[] __initdata = {
+	"ti,am33xx",
+	NULL,
+};
+
+DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= am33xx_map_io,
+	.init_early	= am33xx_init_early,
+	.init_irq	= omap_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap3_am33xx_timer,
+	.dt_compat	= am33xx_boards_compat,
+MACHINE_END
+#endif
+
 #if defined(CONFIG_ARCH_OMAP4)
 static const char *omap4_boards_compat[] __initdata = {
 	"ti,omap4",
--
1.7.0.4

