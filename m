From: "Curran, Dominic" <dcurran@ti.com>
Subject: [PATCH omapzoom tree] Fix keypad for LDP
Date: Wed, 17 Sep 2008 12:10:29 -0500
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B5010E7FD20A@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48357 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbYIQRKh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 13:10:37 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8HHAVbu015053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 12:10:36 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8HHAU0J018514
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 12:10:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Vikram,

This patch fixes the keypad for LDP on the OMAPZOOM tree.

- Adds dependency on MACH_LDP for TWL4030 KEYPAD menuconfig option.
- Adds correct keypad IRQ to LDP board file.
- Adds the struct omap_keypad to GPIO part of the T2 keypad driver.

Regards,
dom


Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c                    |    1 +
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/omap-twl4030keypad.c        |   25 ++++++++++++--------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 175668e..58f56a2 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -286,6 +286,7 @@ static struct omap_kp_platform_data ldp_kp_data = {
        .keymap         = ldp_twl4030_keymap,
        .keymapsize     = ARRAY_SIZE(ldp_twl4030_keymap),
        .rep            = 1,
+       .irq            = TWL4030_MODIRQ_KEYPAD,
        /* Use row_gpios as a way to pass the OMAP GPIO keymap pointer */
        .row_gpios      = ldp_omap_gpio_keymap,
 };
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index e4d0436..c8abf13 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP

 config KEYBOARD_TWL4030
        tristate "TI TWL4030 keypad support"
-       depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
+       depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM || MACH_OMAP_LDP)
        help
          Say Y here if you want to use the OMAP TWL4030 keypad.

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 1ca2987..87ee1dd 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -38,6 +38,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/irq.h>
+#include <mach/gpio.h>
 #include <mach/keypad.h>
 #include "twl4030-keypad.h"

@@ -241,7 +242,7 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 }

 #ifdef CONFIG_MACH_OMAP_LDP
-static void omap_gpio_kp_scan(void)
+static void omap_gpio_kp_scan(struct omap_keypad *kp)
 {
        unsigned int new_gpio;
        int idx = 0, chg = 0, key, state;
@@ -254,7 +255,7 @@ static void omap_gpio_kp_scan(void)
                if (chg) {
                        key = GET_KEY(omap_gpios[idx]);
                        state = (new_gpio == 0);
-                       input_report_key(omap_twl4030kp, key, state);
+                       input_report_key(kp->omap_twl4030kp, key, state);
                }

                if (!new_gpio)
@@ -281,10 +282,12 @@ static void omap_gpio_kp_scan(void)
 /*
  * Keypad interrupt handler for OMAP GPIO's.
  */
-static irqreturn_t do_kp_gpio_irq(int irq, void *dev_id)
+static irqreturn_t do_kp_gpio_irq(int irq, void *_kp)
 {
+       struct omap_keypad *kp = _kp;
+
        /* Scan keypad for any changes in GPIO keys. */
-       omap_gpio_kp_scan();
+       omap_gpio_kp_scan(kp);

        return IRQ_HANDLED;
 }
@@ -292,10 +295,12 @@ static irqreturn_t do_kp_gpio_irq(int irq, void *dev_id)

 static void omap_gpio_kp_timer(unsigned long arg)
 {
-       omap_gpio_kp_scan();
+       struct omap_keypad *kp = (struct omap_keypad*)arg;
+       omap_gpio_kp_scan(kp);
 }

-static int omap_gpio_kp_probe(unsigned int *gpio_keymap)
+static int
+omap_gpio_kp_probe(struct omap_keypad *kp, unsigned int *gpio_keymap)
 {
        int i, idx = 0, irq_idx = 0;

@@ -321,18 +326,18 @@ static int omap_gpio_kp_probe(unsigned int *gpio_keymap)
        while (omap_gpios[irq_idx] != 0) {
                if (request_irq(OMAP_GPIO_IRQ(GET_GPIO(omap_gpios[irq_idx])),
                                do_kp_gpio_irq, IRQF_TRIGGER_FALLING,
-                               "omap-keypad", NULL) < 0)
+                               "omap-keypad", kp) < 0)
                        goto err2;
                irq_idx++;
        }

        /* Initialize GPIO timer */
        gpio_timer.function = omap_gpio_kp_timer;
-       gpio_timer.data     = (unsigned long)NULL;
+       gpio_timer.data     = (unsigned long)kp;
        init_timer(&gpio_timer);

        /* scan current key state */
-       omap_gpio_kp_scan();
+       omap_gpio_kp_scan(kp);

        return 0;

@@ -503,7 +508,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
                goto err4;

 #ifdef CONFIG_MACH_OMAP_LDP
-       omap_gpio_kp_probe(pdata->row_gpios);
+       omap_gpio_kp_probe(kp, pdata->row_gpios);
 #endif

        return ret;
--
1.5.4.1
