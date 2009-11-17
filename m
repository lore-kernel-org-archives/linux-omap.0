From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 4/8] musb: Update setup_usb() call for all Davinci boards
Date: Tue, 17 Nov 2009 20:39:52 +0530
Message-ID: <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbZKQPKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 10:10:31 -0500
In-Reply-To: <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

setup_usb() has been modified to pass board specific data so updating
this function call from all Davinci based boards.

Added "struct device;" to fix below compilation warning for Davinci boards.
"musb.h: struct device, defined within parameter list"

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |    9 ++++++++-
 arch/arm/mach-davinci/board-dm355-leopard.c |    9 ++++++++-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    8 +++++++-
 arch/arm/mach-davinci/board-sffsdr.c        |    9 ++++++++-
 arch/arm/mach-davinci/include/mach/common.h |    7 +++++--
 arch/arm/mach-davinci/usb.c                 |    8 ++++----
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 77e8067..31c5741 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -24,6 +24,7 @@
 #include <media/tvp514x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
+#include <linux/usb/musb.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -317,6 +318,12 @@ static struct spi_board_info dm355_evm_spi_info[] __initconst = {
 	},
 };
 
+/* musb board specific data */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 250,	/* (power in mA)/2 */
+	.potpgt = 4,	/* (potpgt in msec)/2 */
+};
+
 static __init void dm355_evm_init(void)
 {
 	struct clk *aemif;
@@ -344,7 +351,7 @@ static __init void dm355_evm_init(void)
 	gpio_request(2, "usb_id_toggle");
 	gpio_direction_output(2, USB_ID_VALUE);
 	/* irlml6401 switches over 1A in under 8 msec */
-	setup_usb(500, 8);
+	setup_usb(&musb_bdata);
 
 	davinci_setup_mmc(0, &dm355evm_mmc_config);
 	davinci_setup_mmc(1, &dm355evm_mmc_config);
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 84ad5d1..2c534f1 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
+#include <linux/usb/musb.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -243,6 +244,12 @@ static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 	},
 };
 
+/* musb board specific data */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 250,	/* (power in mA)/2 */
+	.potpgt = 4,	/* (potpgt in msec)/2 */
+};
+
 static __init void dm355_leopard_init(void)
 {
 	struct clk *aemif;
@@ -270,7 +277,7 @@ static __init void dm355_leopard_init(void)
 	gpio_request(2, "usb_id_toggle");
 	gpio_direction_output(2, USB_ID_VALUE);
 	/* irlml6401 switches over 1A in under 8 msec */
-	setup_usb(500, 8);
+	setup_usb(&musb_bdata);
 
 	davinci_setup_mmc(0, &dm355leopard_mmc_config);
 	davinci_setup_mmc(1, &dm355leopard_mmc_config);
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 1213a00..307520e 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -29,6 +29,7 @@
 #include <linux/phy.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
+#include <linux/usb/musb.h>
 
 #include <media/tvp514x.h>
 
@@ -438,6 +439,11 @@ static struct pcf857x_platform_data pcf_data_u18 = {
 	.teardown	= evm_u18_teardown,
 };
 
+/* musb board specific data */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 250,	/* (power in mA)/2 */
+	.potpgt = 4,	/* (potpgt in msec)/2 */
+};
 
 /* U35 - various I/O signals used to manage USB, CF, ATA, etc */
 
@@ -477,7 +483,7 @@ evm_u35_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
 	/* irlml6401 switches over 1A, in under 8 msec;
 	 * now it can be managed by nDRV_VBUS ...
 	 */
-	setup_usb(500, 8);
+	setup_usb(&musb_bdata);
 
 	return 0;
 }
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 7acdfd8..e61d7d7 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -38,6 +38,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
+#include <linux/usb/musb.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -149,6 +150,12 @@ static struct davinci_uart_config uart_config __initdata = {
 	.enabled_uarts = (1 << 0),
 };
 
+/* musb board specific data */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 0,	/* (power in mA)/2 */
+	.potpgt = 0,	/* (potpgt in msec)/2 */
+};
+
 static void __init davinci_sffsdr_map_io(void)
 {
 	dm644x_init();
@@ -164,7 +171,7 @@ static __init void davinci_sffsdr_init(void)
 	davinci_serial_init(&uart_config);
 	soc_info->emac_pdata->phy_mask = SFFSDR_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = SFFSDR_MDIO_FREQUENCY;
-	setup_usb(0, 0); /* We support only peripheral mode. */
+	setup_usb(&musb_bdata); /* We support only peripheral mode. */
 
 	/* mux VLYNQ pins */
 	davinci_cfg_reg(DM644X_VLYNQEN);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 1fd3917..dab784c 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -20,11 +20,14 @@ extern void davinci_irq_init(void);
 extern void __iomem *davinci_intc_base;
 extern int davinci_intc_type;
 
+struct device;
+#include <linux/usb/musb.h>
+
 /* parameters describe VBUS sourcing for host mode */
-extern void setup_usb(unsigned mA, unsigned potpgt_msec);
+extern void setup_usb(struct musb_hdrc_board_data *board_data);
 
 /* parameters describe VBUS sourcing for host mode */
-extern void setup_usb(unsigned mA, unsigned potpgt_msec);
+extern void setup_usb(struct musb_hdrc_board_data *board_data);
 
 struct davinci_timer_instance {
 	void __iomem	*base;
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 06f5593..1b164dc 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -85,10 +85,10 @@ static struct platform_device usb_dev = {
 	.num_resources  = ARRAY_SIZE(usb_resources),
 };
 
-void __init setup_usb(unsigned mA, unsigned potpgt_msec)
+void __init setup_usb(struct musb_hdrc_board_data *board_data)
 {
-	usb_data.power = mA / 2;
-	usb_data.potpgt = potpgt_msec / 2;
+	/* get board-specific data */
+	usb_data.board_data = board_data;
 
 	if (cpu_is_davinci_dm646x()) {
 		/* Override the defaults as DM6467 uses different IRQs. */
@@ -102,7 +102,7 @@ void __init setup_usb(unsigned mA, unsigned potpgt_msec)
 
 #else
 
-void __init setup_usb(unsigned mA, unsigned potpgt_msec)
+void __init setup_usb(struct musb_hdrc_board_data *board_data)
 {
 }
 
-- 
1.6.2.4

