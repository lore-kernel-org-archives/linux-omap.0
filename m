From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 09/14] MMC: OMAP: Modifications at N800 MMC board specific
 file to work MMC multislot support
Date: Thu, 20 Sep 2007 11:03:44 -0400
Message-ID: <46F28BD0.3090709@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Modifications at board-n800-mmc.c file to work with MMC multislot support.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap2/board-n800-mmc.c |   55 +++++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index b87c121..fc5d068 100644
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
 
@@ -255,12 +274,6 @@ void __init n800_mmc_init(void)
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
-- 1.5.3.GIT
