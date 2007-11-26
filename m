From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 09/17] MMC: OMAP: Modifications at N800 MMC board specific
 file to work MMC multislot support
Date: Mon, 26 Nov 2007 12:01:38 -0400
Message-ID: <474AEDE2.6080908@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Modifications at board-n800-mmc.c and board-n800.c files to work with MMC multislot support.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap2/board-n800-mmc.c |   57 ++++++++++++++++++++-------------
 arch/arm/mach-omap2/board-n800.c     |   11 ++++++
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index b87c121..b1219d1 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -13,13 +13,14 @@
 #include <asm/arch/menelaus.h>
 #include <asm/arch/gpio.h>
 
+#include <asm/mach-types.h>
+#include <linux/delay.h>
+
 #ifdef CONFIG_MMC_OMAP
 
 static const int slot_switch_gpio = 96;
-static const int slot1_wp_gpio = 23;
-static const int slot2_wp_gpio = 8;
-static int slot1_cover_closed;
-static int slot2_cover_closed;
+static int slot1_cover_open;
+static int slot2_cover_open;
 static struct device *mmc_device;
 
 /*
@@ -158,18 +159,27 @@ static int n800_mmc_get_cover_state(struct device *dev, int slot)
 	slot++;
 	BUG_ON(slot != 1 && slot != 2);
 	if (slot == 1)
-		return slot1_cover_closed;
+		return slot1_cover_open;
 	else
-		return slot2_cover_closed;
+		return slot2_cover_open;
 }
 
 static void n800_mmc_callback(void *data, u8 card_mask)
 {
-	if (card_mask & (1 << 1))
-		slot2_cover_closed = 0;
+	int bit, *openp, index;
+
+	if (machine_is_nokia_n800()) {
+		bit = 1 << 1;
+		openp = &slot2_cover_open;
+		index = 1;
+	}
+
+	if (card_mask & bit)
+		*openp = 1;
 	else
-		slot2_cover_closed = 1;
-        omap_mmc_notify_cover_event(mmc_device, 1, slot2_cover_closed);
+		*openp = 0;
+
+	omap_mmc_notify_cover_event(mmc_device, index, *openp);
 }
 
 void n800_mmc_slot1_cover_handler(void *arg, int state)
@@ -177,13 +187,13 @@ void n800_mmc_slot1_cover_handler(void *arg, int state)
 	if (mmc_device == NULL)
 		return;
 
-	slot1_cover_closed = state;
+	slot1_cover_open = !state;
 	omap_mmc_notify_cover_event(mmc_device, 0, state);
 }
 
 static int n800_mmc_late_init(struct device *dev)
 {
-	int r;
+	int r, bit, *openp;
 
 	mmc_device = dev;
 
@@ -202,10 +212,19 @@ static int n800_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
 
-	if (r & (1 << 1))
-		slot2_cover_closed = 1;
+	if (machine_is_nokia_n800()) {
+		bit = 1 << 1;
+		openp = &slot2_cover_open;
+	}
+
+	/* All slot pin bits seem to be inversed until first swith change */
+	if (r == 0xf || r == (0xf & ~bit))
+		r = ~r;
+
+	if (r & bit)
+		*openp = 1;
 	else
-		slot2_cover_closed = 0;
+		*openp = 0;
 
 	r = menelaus_register_mmc_callback(n800_mmc_callback, NULL);
 
@@ -218,9 +237,7 @@ static void n800_mmc_cleanup(struct device *dev)
 }
 
 static struct omap_mmc_platform_data n800_mmc_data = {
-	.enabled		= 1,
 	.nr_slots		= 2,
-	.wire4			= 1,
 	.switch_slot		= n800_mmc_switch_slot,
 	.init			= n800_mmc_late_init,
 	.cleanup		= n800_mmc_cleanup,
@@ -255,12 +272,6 @@ void __init n800_mmc_init(void)
 		BUG();
 	omap_set_gpio_dataout(slot_switch_gpio, 0);
 	omap_set_gpio_direction(slot_switch_gpio, 0);
-	if (omap_request_gpio(slot1_wp_gpio) < 0)
-		BUG();
-	if (omap_request_gpio(slot2_wp_gpio) < 0)
-		BUG();
-	omap_set_gpio_direction(slot1_wp_gpio, 1);
-	omap_set_gpio_direction(slot2_wp_gpio, 1);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 4473fd5..4271d93 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -191,6 +191,14 @@ static void __init blizzard_dev_init(void)
 	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
 }
 
+static struct omap_mmc_config n800_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled		= 1,
+		.wire4			= 1,
+	},
+};
+
+extern struct omap_mmc_platform_data n800_mmc_data;
 
 static struct omap_board_config_kernel n800_config[] __initdata = {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
@@ -198,6 +206,7 @@ static struct omap_board_config_kernel n800_config[] __initdata = {
 	{ OMAP_TAG_FBMEM,			&n800_fbmem1_config },
 	{ OMAP_TAG_FBMEM,			&n800_fbmem2_config },
 	{ OMAP_TAG_TMP105,			&n800_tmp105_config },
+	{ OMAP_TAG_MMC,				&n800_mmc_config },
 };
 
 
@@ -448,6 +457,8 @@ static struct i2c_board_info __initdata n800_i2c_board_info_2[] = {
 #endif
 };
 
+extern void __init n800_mmc_init(void);
+
 static void __init nokia_n800_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
-- 1.5.3.GIT
