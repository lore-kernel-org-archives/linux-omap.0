From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 2/3] ARM: OMAP1: ams-delta: initialize latch2 pins to safe
 values
Date: Mon, 10 Sep 2018 01:44:18 +0200
Message-ID: <20180909234419.31261-3-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Latch2 pins control a number of on-board devices, namely LCD, NAND,
MODEM and CODEC.  Those pins used to be initialized with safe values
from init_machine before that operation was:
1) moved to late_initcall in preparation for conversion of latch2 to
GPIO device - see commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
latch dependent devices later"),
2) replaced with non-atomic initialization performed by means of
gpio_request_array() - see commit 937eb4bb0058 ("ARM: OMAP1: ams-delta:
convert latches to basic_mmio_gpio"),
3) made completely asynchronous by delegation of GPIO request
operations performed on subsets of pins to respective device drivers in
subsequent commits.

One visible negative result of that disintegration was corrupt keyboard
data reported by serio driver, recently fixed by commit 41f8fee385a0
("ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin").

Moreover, initialization of LATCH2_PIN_MODEM_CODEC still performed with
ams_delta_latch2_write() wrapper from late_init() is now done on not
requested GPIO pin.

Reintroduce atomic initialization of latch2 pins at machine_init to
prevent from random values potentially corrupting NAND data or maybe
even destroing other hardware.  Also take care of MODEM/CODEC related
pins so MODEM device probe succeeds even if latch2 GPIO device or
dependent regulator is not ready and CODEC can be reached over the
MODEM even if audio driver doesn't take control over
LATCH2_PIN_MODEM_CODEC.

Once done, remove the no longer needed GPIO based implementation of
ams_delta_latch_write() and its frontend macro.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 52 +++++++++++++++++++++++------------
 arch/arm/mach-omap1/board-ams-delta.h |  7 -----
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2b90b543c030..1d451142248c 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -321,20 +321,6 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value)
-{
-	int bit = 0;
-	u16 bitpos = 1 << bit;
-
-	for (; bit < ngpio; bit++, bitpos = bitpos << 1) {
-		if (!(mask & bitpos))
-			continue;
-		else
-			gpio_set_value(base + bit, (value & bitpos) != 0);
-	}
-}
-EXPORT_SYMBOL(ams_delta_latch_write);
-
 static struct resource ams_delta_nand_resources[] = {
 	[0] = {
 		.start	= OMAP1_MPUIO_BASE,
@@ -680,6 +666,40 @@ static void __init omap_gpio_deps_init(void)
 	modem_assign_irq(chip);
 }
 
+/*
+ * Initialize latch2 pins with values which are safe for dependent on-board
+ * devices or useful for their successull initialization even before GPIO
+ * driver takes control over the latch pins:
+ * - LATCH2_PIN_LCD_VBLEN	= 0
+ * - LATCH2_PIN_LCD_NDISP	= 0	Keep LCD device powered off before its
+ *					driver takes control over it.
+ * - LATCH2_PIN_NAND_NCE	= 0
+ * - LATCH2_PIN_NAND_NWP	= 0	Keep NAND device down and write-
+ *					protected before its driver takes
+ *					control over it.
+ * - LATCH2_PIN_KEYBRD_PWR	= 0	Keep keyboard powered off before serio
+ *					driver takes control over it.
+ * - LATCH2_PIN_KEYBRD_DATAOUT	= 0	Keep low to avoid corruption of first
+ *					byte of data received from attached
+ *					keyboard when serio device is probed;
+ *					the pin is also hogged low by the latch2
+ *					GPIO driver as soon as it is ready.
+ * - LATCH2_PIN_MODEM_NRESET	= 1	Enable voice MODEM device, allowing for
+ *					its successful probe even before a
+ *					regulator it depends on, which in turn
+ *					takes control over the pin, is set up.
+ * - LATCH2_PIN_MODEM_CODEC	= 1	Attach voice MODEM CODEC data port
+ *					to the MODEM so the CODEC is under
+ *					control even if audio driver doesn't
+ *					take it over.
+ */
+static void __init ams_delta_latch2_init(void)
+{
+	u16 latch2 = 1 << LATCH2_PIN_MODEM_NRESET | 1 << LATCH2_PIN_MODEM_CODEC;
+
+	__raw_writew(latch2, LATCH2_VIRT);
+}
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -701,6 +721,7 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J18_1610_CAM_D7);
 
 	omap_gpio_deps_init();
+	ams_delta_latch2_init();
 	gpiod_add_hogs(ams_delta_gpio_hogs);
 
 	omap_serial_init();
@@ -888,9 +909,6 @@ static int __init ams_delta_modem_init(void)
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
 
-	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
-			AMS_DELTA_LATCH2_MODEM_CODEC);
-
 	err = platform_device_register(&ams_delta_modem_device);
 
 	return err;
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 1fbada29431a..a74a306d7e77 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -59,13 +59,6 @@
 #define AMS_DELTA_LATCH2_GPIO_BASE	AMS_DELTA_GPIO_PIN_LCD_VBLEN
 #define AMS_DELTA_LATCH2_NGPIO		16
 
-#ifndef __ASSEMBLY__
-void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value);
-#define ams_delta_latch2_write(mask, value) \
-	ams_delta_latch_write(AMS_DELTA_LATCH2_GPIO_BASE, \
-			AMS_DELTA_LATCH2_NGPIO, (mask), (value))
-#endif
-
 #endif /* CONFIG_MACH_AMS_DELTA */
 
 #endif /* __ASM_ARCH_OMAP_AMS_DELTA_H */
-- 
2.16.4
