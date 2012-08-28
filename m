From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 5/9] ARM: OMAP: remove the omap custom tags
Date: Wed, 29 Aug 2012 02:18:53 +0300
Message-ID: <1346195937-6383-6-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:49600 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021Ab2H1XTS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:18 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

The omap custom initialization tags are not used anymore (if ever)
by the mainline kernel.
Thus remove the omap custom initialization tags.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/plat-omap/common.c             |   34 ------------
 arch/arm/plat-omap/include/plat/board.h |   84 -------------------------------
 2 files changed, 0 insertions(+), 118 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index af98971..7c04748 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -24,40 +24,6 @@
 
 #include <plat/omap-secure.h>
 
-
-#define NO_LENGTH_CHECK 0xffffffff
-
-struct omap_board_config_kernel *omap_board_config __initdata;
-int omap_board_config_size;
-
-static const void *__init get_config(u16 tag, size_t len,
-		int skip, size_t *len_out)
-{
-	struct omap_board_config_kernel *kinfo = NULL;
-	int i;
-
-	/* Try to find the config from the board-specific structures
-	 * in the kernel. */
-	for (i = 0; i < omap_board_config_size; i++) {
-		if (omap_board_config[i].tag == tag) {
-			if (skip == 0) {
-				kinfo = &omap_board_config[i];
-				break;
-			} else {
-				skip--;
-			}
-		}
-	}
-	if (kinfo == NULL)
-		return NULL;
-	return kinfo->data;
-}
-
-const void *__init __omap_get_config(u16 tag, size_t len, int nr)
-{
-        return get_config(tag, len, nr, NULL);
-}
-
 void __init omap_reserve(void)
 {
 	omap_vram_reserve_sdram_memblock();
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index db3bdc1..5938c72 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -12,39 +12,6 @@
 
 #include <linux/types.h>
 
-#include <plat/gpio-switch.h>
-
-/* Different peripheral ids */
-#define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_STI_CONSOLE	0x4f09
-#define OMAP_TAG_CAMERA_SENSOR	0x4f0a
-
-#define OMAP_TAG_BOOT_REASON    0x4f80
-#define OMAP_TAG_FLASH_PART	0x4f81
-#define OMAP_TAG_VERSION_STR	0x4f82
-
-struct omap_clock_config {
-	/* 0 for 12 MHz, 1 for 13 MHz and 2 for 19.2 MHz */
-	u8 system_clock_type;
-};
-
-struct omap_serial_console_config {
-	u8 console_uart;
-	u32 console_speed;
-};
-
-struct omap_sti_console_config {
-	unsigned enable:1;
-	u8 channel;
-};
-
-struct omap_camera_sensor_config {
-	u16 reset_gpio;
-	int (*power_on)(void * data);
-	int (*power_off)(void * data);
-};
-
 struct omap_lcd_config {
 	char panel_name[16];
 	char ctrl_name[16];
@@ -59,57 +26,6 @@ struct omap_backlight_config {
 	int (*set_power)(struct device *dev, int state);
 };
 
-struct omap_fbmem_config {
-	u32 start;
-	u32 size;
-};
-
-struct omap_pwm_led_platform_data {
-	const char *name;
-	int intensity_timer;
-	int blink_timer;
-	void (*set_power)(struct omap_pwm_led_platform_data *self, int on_off);
-};
-
-struct omap_uart_config {
-	/* Bit field of UARTs present; bit 0 --> UART1 */
-	unsigned int enabled_uarts;
-};
-
-
-struct omap_flash_part_config {
-	char part_table[0];
-};
-
-struct omap_boot_reason_config {
-	char reason_str[12];
-};
-
-struct omap_version_config {
-	char component[12];
-	char version[12];
-};
-
-struct omap_board_config_entry {
-	u16 tag;
-	u16 len;
-	u8  data[0];
-};
-
-struct omap_board_config_kernel {
-	u16 tag;
-	const void *data;
-};
-
-extern const void *__init __omap_get_config(u16 tag, size_t len, int nr);
-
-#define omap_get_config(tag, type) \
-	((const type *) __omap_get_config((tag), sizeof(type), 0))
-
-extern struct omap_board_config_kernel *omap_board_config;
-extern int omap_board_config_size;
-
-
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
-- 
1.7.8.6

