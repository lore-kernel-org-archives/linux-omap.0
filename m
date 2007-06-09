From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 1/12] Add support for the HTC Typhoon, Hurricane and Tornado
 smartphone
Date: Sat, 09 Jun 2007 19:04:57 +0200
Message-ID: <466ADDB9.60708@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This patch adds support for the HTC smartphone boards based on the 
OMAP730 and
OMAP850 platform. Phone model is detected at runtime.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>


---
 arch/arm/mach-omap1/Kconfig               |    7 +
 arch/arm/mach-omap1/Makefile              |    1 +
 arch/arm/mach-omap1/board-typhoon.c       |  301 
+++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-typhoon.h |   62 ++++++
 4 files changed, 371 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-typhoon.c
 create mode 100644 include/asm-arm/arch-omap/board-typhoon.h

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 79f0b1f..eb12ca5 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -125,6 +125,13 @@ config MACH_NOKIA770
       Support for the Nokia 770 Internet Tablet. Say Y here if you
       have such a device.
 
+config MACH_TYPHOON
+    bool "HTC Typhoon"
+    depends on ARCH_OMAP1 && ARCH_OMAP730
+    help
+      Support for the HTC Typhoon/Tornado smartphone. Say Y here if you
+      have such a phone.
+
 config MACH_AMS_DELTA
     bool "Amstrad E3 (Delta)"
     depends on ARCH_OMAP1 && ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 8377665..9f6bcbb 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_MACH_OMAP_PALMTE)        += board-palmte.o
 obj-$(CONFIG_MACH_OMAP_PALMZ71)        += board-palmz71.o
 obj-$(CONFIG_MACH_OMAP_PALMTT)        += board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)        += board-nokia770.o
+obj-$(CONFIG_MACH_TYPHOON)        += board-typhoon.o
 obj-$(CONFIG_MACH_AMS_DELTA)        += board-ams-delta.o
 obj-$(CONFIG_MACH_SX1)            += board-sx1.o
 
diff --git a/arch/arm/mach-omap1/board-typhoon.c 
b/arch/arm/mach-omap1/board-typhoon.c
new file mode 100644
index 0000000..814cf3f
--- /dev/null
+++ b/arch/arm/mach-omap1/board-typhoon.c
@@ -0,0 +1,301 @@
+/*
+ * linux/arch/arm/mach-omap1/board-typhoon.c
+ *
+ * Modified from board-perseus2.c
+ *
+ * Copyright 2005 Vivien Chappelier <vivien.chappelier@free.fr>
+ * Original OMAP730 support by Jean Pihet <j-pihet@ti.com>
+ * Updated for 2.6 by Kevin Hilman <kjh@hilman.org>
+ *
+ * MMC and watchdog reinitialization by Nicolas Schichan
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/input.h>
+#include <linux/bootmem.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/fpga.h>
+#include <asm/arch/common.h>
+
+#include <asm/arch/board.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/board-typhoon.h>
+
+/* LCD device */
+static struct platform_device lcd_device = {
+    .name        = "lcd_typhoon",
+    .id        = -1,
+};
+
+/* GSM device */
+#define TYPHOON_GSM_PHYS_START        0x11d80000 /* end of RAM */
+#define TYPHOON_GSM_PHYS_SIZE        0x00280000 /* 2.5 MB code/data/fifo */
+
+#define TORNADO_GSM_PHYS_START        0x13c00000 /* end of RAM */
+#define TORNADO_GSM_PHYS_SIZE        0x00400000 /* 4.0 MB code/data/fifo */
+
+static struct resource gsm_resources[] = {
+    {    /* GSM DSP MMU */
+        .start        = IO_ADDRESS(OMAP730_DSP_MMU_BASE),
+        .end        = IO_ADDRESS(OMAP730_DSP_MMU_BASE) + 0x54,
+        .flags        = IORESOURCE_MEM,
+    },
+    {    /* GSM software interrupt */
+        .start        = INT_730_ICR,
+        .flags        = IORESOURCE_IRQ,
+    },
+    {       /* GSM radio interrupt */
+        .start        = INT_730_DBB_RF_EN,
+        .flags        = IORESOURCE_IRQ,
+    },
+};
+
+static struct platform_device gsm_device = {
+        .name           = "typhoon-gsm",
+        .id             = 1,
+    .num_resources    = ARRAY_SIZE(gsm_resources),
+    .resource    = gsm_resources,
+};
+
+/* Devices */
+static struct platform_device *devices[] __initdata = {
+    &lcd_device,
+    &gsm_device,
+};
+
+/* USB configuration */
+static struct omap_usb_config typhoon_usb_config __initdata = {
+    .register_dev   = 1,
+    .register_host  = 0,
+    .otg        = 0,
+    .hmc_mode    = 4,
+    .pins[0]        = 2,
+    .pins[1]        = 0,
+    .pins[2]        = 0,
+};
+
+/* MMC configuration */
+static struct omap_mmc_config typhoon_mmc_config __initdata = {
+    .mmc [0] = {
+        .enabled     = 1,
+        .wire4        = 0, /* for now */
+        .wp_pin        = -1,
+        .power_pin    = -1,
+        .switch_pin    = -1,
+    },
+};
+
+/* UART configuration */
+static struct omap_uart_config typhoon_uart_config __initdata = {
+    .enabled_uarts = ((1 << 0) | (1 << 1)),
+};
+
+/* LCD configuration */
+static struct omap_lcd_config typhoon_lcd_config __initdata = {
+    .ctrl_name    = "internal",
+};
+
+/* Additional tags */
+static struct omap_board_config_kernel typhoon_config[] __initdata = {
+    { OMAP_TAG_USB,         &typhoon_usb_config },
+    { OMAP_TAG_MMC,     &typhoon_mmc_config },
+    { OMAP_TAG_UART,     &typhoon_uart_config },
+    { OMAP_TAG_LCD,     &typhoon_lcd_config },
+};
+
+#define OMAP32_ID_0        0xfffed400
+#define OMAP32_ID_1        0xfffed404
+
+struct model_id {
+    enum typhoon_model model;
+    unsigned int id_0;
+    unsigned int id_1;
+};
+
+static struct model_id omap_typhoon_model[] = {
+    { TYPHOON_MODEL_TYPHOON, 0x03320300, 0x1b55f02f },
+    { TYPHOON_MODEL_TORNADO, 0x03320500, 0x1b62c02f },
+};
+
+unsigned int typhoon_model;
+EXPORT_SYMBOL(typhoon_model);
+
+static void __init omap_typhoon_identify(void)
+{
+    /* Determine the phone model by reading the OMAP version */
+    unsigned int omap32_id_0 = omap_readl(OMAP32_ID_0);
+    unsigned int omap32_id_1 = omap_readl(OMAP32_ID_1);
+
+    int i;
+
+    typhoon_model = TYPHOON_MODEL_UNKNOWN;
+    for (i = 0; i < ARRAY_SIZE(omap_typhoon_model); i++) {
+        if (omap32_id_0 == omap_typhoon_model[i].id_0 &&
+            omap32_id_1 == omap_typhoon_model[i].id_1) {
+            typhoon_model = omap_typhoon_model[i].model;
+            break;
+        }
+    }
+}
+
+static void __init omap_typhoon_disable_watchdog(void)
+{
+    if (omap_readl(OMAP_WDT_TIMER_MODE) & 0x8000) {
+               /*
+                * disable a potentially running watchdog timer before
+                * it kills us.
+                */
+        omap_writel(0xf5, OMAP_WDT_TIMER_MODE);
+        omap_writel(0xa0, OMAP_WDT_TIMER_MODE);
+    }
+}
+
+static void __init omap_typhoon_mmc_init(void)
+{
+       unsigned int tries;
+
+# define       OMAP_MMC_REG_SYSC       (0xfffb7800 + 0x32)
+# define       OMAP_MMC_REG_SYSS       (0xfffb7800 + 0x34)
+# define       OMAP_MMC_REG_CTO        (0xfffb7800 + 0x0e)
+# define       OMAP_MMC_REG_DTO        (0xfffb7800 + 0x1c)
+
+       /* put mmc host into reset ... */
+       omap_writew(1, OMAP_MMC_REG_SYSC);
+
+       tries = 100;
+       while (omap_readw(OMAP_MMC_REG_SYSS) == 0 && tries) {
+               mdelay(50);
+               --tries;
+       }
+       printk("MMC host reset done: remaining tries: %i\n", tries);
+
+       /* force mode 0 for D_SMC_DAT3, D_SMC_DAT2, D_SMC, no pull up 
enable */
+       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 8), 
OMAP730_IO_CONF_2);
+       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 12), 
OMAP730_IO_CONF_2);
+       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 16), 
OMAP730_IO_CONF_2);
+}
+
+static void omap_typhoon_lcd_init(void)
+{
+    u32 reg;
+
+# define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
+# define       OMAP_LCDC_STATUS                (0xfffec000 + 0x10)
+# define       OMAP_DMA_LCD_CCR                (0xfffee300 + 0xc2)
+# define       OMAP_DMA_LCD_CTRL               (0xfffee300 + 0xc4)
+# define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
+# define       OMAP_LCDC_STAT_DONE             (1 << 0)
+
+    /* disable controller if active */
+    reg = omap_readl(OMAP_LCDC_CONTROL);
+    if (reg & OMAP_LCDC_CTRL_LCD_EN) {
+        reg &= ~OMAP_LCDC_CTRL_LCD_EN;
+        omap_writel(reg, OMAP_LCDC_CONTROL);
+
+        /* wait for end of frame */
+        while(!(omap_readl(OMAP_LCDC_STATUS) & OMAP_LCDC_STAT_DONE));
+
+        /* turn off DMA */
+        reg = omap_readw(OMAP_DMA_LCD_CCR);
+        reg &= ~(1 << 7);
+        omap_writew(reg, OMAP_DMA_LCD_CCR);
+
+        reg = omap_readw(OMAP_DMA_LCD_CTRL);
+        reg &= ~(1 << 8);
+        omap_writew(reg, OMAP_DMA_LCD_CTRL);
+    }
+}
+
+static void omap_typhoon_udc_init(void)
+{
+    /* disable all interrupts */
+    omap_writel(0, UDC_BASE + 0x28);
+    omap_writel(0, UDC_BASE + 0x2c);
+    omap_writel(0, UDC_BASE + 0x30);
+}
+
+static void __init omap_typhoon_init(void)
+{
+    platform_add_devices(devices, ARRAY_SIZE(devices));
+
+    omap_board_config = typhoon_config;
+    omap_board_config_size = ARRAY_SIZE(typhoon_config);
+
+    /* disable watchdog timer */
+    omap_typhoon_disable_watchdog();
+
+    /* initialize the serial ports */
+    omap_serial_init();
+
+    /* initialize the MMC */
+    omap_typhoon_mmc_init();
+
+    /* initialize the USB gadget */
+    omap_typhoon_udc_init();
+}
+
+static void __init omap_typhoon_init_irq(void)
+{
+    omap1_init_common_hw();
+    omap_init_irq();
+    omap_gpio_init();
+}
+
+static void __init omap_typhoon_map_io(void)
+{
+    omap1_map_common_io();
+
+    /* Early, board-dependent init */
+    omap_typhoon_identify();
+
+    /* Make sure LCD is off */
+    omap_typhoon_lcd_init();
+
+    /* Reserve GSM memory */
+    switch (typhoon_model) {
+    case TYPHOON_MODEL_TYPHOON:
+        reserve_bootmem(TYPHOON_GSM_PHYS_START, TYPHOON_GSM_PHYS_SIZE);
+        break;
+    case TYPHOON_MODEL_TORNADO:
+        reserve_bootmem(TORNADO_GSM_PHYS_START, TORNADO_GSM_PHYS_SIZE);
+        break;
+    }
+
+    /*
+     * Hold GSM Reset until needed
+     */
+    omap_writew(omap_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
+
+    /*
+     * UARTs -> done automagically by 8250 driver
+     */
+}
+
+MACHINE_START(TYPHOON, "HTC Typhoon")
+    /* Maintainer: Vivien Chappelier <vivien.chappelier@free.fr> */
+    .phys_io    = 0xfff00000,
+    .io_pg_offst    = ((0xfef00000) >> 18) & 0xfffc,
+    .boot_params    = 0x10000100,
+    .map_io        = omap_typhoon_map_io,
+    .init_irq    = omap_typhoon_init_irq,
+    .init_machine    = omap_typhoon_init,
+    .timer        = &omap_timer,
+MACHINE_END
diff --git a/include/asm-arm/arch-omap/board-typhoon.h 
b/include/asm-arm/arch-omap/board-typhoon.h
new file mode 100644
index 0000000..d985504
--- /dev/null
+++ b/include/asm-arm/arch-omap/board-typhoon.h
@@ -0,0 +1,62 @@
+/*
+ *  linux/include/asm-arm/arch-omap/board-typhoon.h
+ *
+ *  Copyright 2005 Vivien Chappelier <vivien.chappelier@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_ARCH_OMAP_TYPHOON_H
+#define __ASM_ARCH_OMAP_TYPHOON_H
+
+/* GPIO */
+#define TYPHOON_GPIO_LCD_BACKLIGHT_ON        126 /* LCD backlight */
+#define TYPHOON_GPIO_LCD_BACKLIGHT_INTENSITY  72
+#define TYPHOON_GPIO_KEYPAD_LIGHT             74 /* Keypad backlight */
+#define TYPHOON_GPIO_VIBRATOR                 34 /* Vibrator */
+#define TYPHOON_GPIO_DM                       35 /* USB D- */
+#define TYPHOON_GPIO_DP                       36 /* USB D+ */
+#define TYPHOON_GPIO_PANEL_ID0                69 /* LCD Panel 
identification */
+#define TYPHOON_GPIO_PANEL_ID1                70
+#define TYPHOON_GPIO_PANEL_POWER             121 /* LCD Panel power */
+#define TYPHOON_GPIO_PANEL_RESET              15 /* LCD Panel reset */
+#define TYPHOON_GPIO_PANEL_CLOCK             127 /* LCD Panel clock */
+#define TYPHOON_GPIO_PANEL_DATA              124 /* LCD Panel data */
+#define TYPHOON_GPIO_PANEL_OUT_ENABLE         77 /* LCD Panel output 
enable */
+#define TYPHOON_GPIO_LED_GREEN                79 /* Green led */
+#define TYPHOON_GPIO_LED_RED                 128 /* Red led */
+#define TYPHOON_GPIO_LIGHT_SENSOR            116 /* Light sensor */
+#define TYPHOON_GPIO_HEADPHONE_SENSOR        137 /* Headphone */
+#define TYPHOON_GPIO_POWER_BUTTON            139 /* Power button */
+#define TYPHOON_GPIO_LED_BLUE                140 /* Blue led */
+
+#define TORNADO_GPIO_LCD_BACKLIGHT_INTENSITY 124 /* really? */
+
+
+enum typhoon_model {
+    TYPHOON_MODEL_UNKNOWN,
+    TYPHOON_MODEL_TYPHOON,
+    TYPHOON_MODEL_TORNADO,
+};
+
+/* The phone model we're running on */
+extern unsigned int typhoon_model;
+
+#endif
-- 
1.5.1.3
