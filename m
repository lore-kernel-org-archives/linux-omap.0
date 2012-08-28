From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/9] ARM: OMAP: cleanup struct omap_board_config_kernel
Date: Wed, 29 Aug 2012 02:18:49 +0300
Message-ID: <1346195937-6383-2-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

struct omap_board_config_kernel defined in the board files
is always empty and does not bring any added value.
Remove the struct omap_board_config_kernel instances from the board
files.
Also remove the omap_get_nr_config() macro and the omap_get_var_config()
function as both are not used for quite a long time (if ever).

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap1/board-generic.c      |    5 -----
 arch/arm/mach-omap1/board-voiceblue.c    |    5 -----
 arch/arm/mach-omap2/board-3430sdp.c      |    6 ------
 arch/arm/mach-omap2/board-3630sdp.c      |    6 ------
 arch/arm/mach-omap2/board-am3517crane.c  |    9 ---------
 arch/arm/mach-omap2/board-am3517evm.c    |    6 ------
 arch/arm/mach-omap2/board-cm-t35.c       |    6 ------
 arch/arm/mach-omap2/board-cm-t3517.c     |    6 ------
 arch/arm/mach-omap2/board-omap3evm.c     |    7 -------
 arch/arm/mach-omap2/board-omap3stalker.c |    6 ------
 arch/arm/mach-omap2/board-ti8168evm.c    |    6 ------
 arch/arm/plat-omap/common.c              |    5 -----
 arch/arm/plat-omap/include/plat/board.h  |    4 ----
 13 files changed, 0 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 6ec385e..d032734 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -52,9 +52,6 @@ static struct omap_usb_config generic1610_usb_config __initdata = {
 };
 #endif
 
-static struct omap_board_config_kernel generic_config[] __initdata = {
-};
-
 static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -76,8 +73,6 @@ static void __init omap_generic_init(void)
 	}
 #endif
 
-	omap_board_config = generic_config;
-	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 3497769..11e1ff3 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -155,9 +155,6 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_board_config_kernel voiceblue_config[] = {
-};
-
 #define MACHINE_PANICED		1
 #define MACHINE_REBOOTING	2
 #define MACHINE_REBOOT		4
@@ -275,8 +272,6 @@ static void __init voiceblue_init(void)
 	voiceblue_smc91x_resources[1].start = gpio_to_irq(8);
 	voiceblue_smc91x_resources[1].end = gpio_to_irq(8);
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
-	omap_board_config = voiceblue_config;
-	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
 	omap1_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a98c688..0f78cdb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -31,7 +31,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
-#include <plat/board.h>
 #include <plat/usb.h>
 #include "common.h"
 #include <plat/dma.h>
@@ -191,9 +190,6 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };
 
-static struct omap_board_config_kernel sdp3430_config[] __initdata = {
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -576,8 +572,6 @@ static void __init omap_3430sdp_init(void)
 	int gpio_pendown;
 
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = sdp3430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap_hsmmc_init(mmc);
 	omap3430_i2c_init();
 	omap_display_init(&sdp3430_dss_data);
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 2dc9ba5..8518b13 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -17,7 +17,6 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include <plat/board.h>
 #include <plat/gpmc-smc91x.h>
 #include <plat/usb.h>
 
@@ -67,9 +66,6 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static struct omap_board_config_kernel sdp_config[] __initdata = {
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -197,8 +193,6 @@ static struct flash_partitions sdp_flash_partitions[] = {
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	omap_board_config = sdp_config;
-	omap_board_config_size = ARRAY_SIZE(sdp_config);
 	zoom_peripherals_init();
 	omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
 				  h8mbx00u0mer0em_sdrc_params);
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 92432c2..de92b08 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -26,7 +26,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 
@@ -37,11 +36,6 @@
 #define GPIO_USB_POWER		35
 #define GPIO_USB_NRESET		38
 
-
-/* Board initialization */
-static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -67,9 +61,6 @@ static void __init am3517_crane_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 
-	omap_board_config = am3517_crane_config;
-	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
-
 	/* Configure GPIO for EHCI port */
 	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
 		pr_err("Can not configure mux for GPIO_USB_NRESET %d\n",
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 18f6010..00abda1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -32,7 +32,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 #include <video/omapdss.h>
@@ -324,9 +323,6 @@ static void am3517_evm_hecc_init(struct ti_hecc_platform_data *pdata)
 	platform_device_register(&am3517_hecc_device);
 }
 
-static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -346,8 +342,6 @@ static struct omap2_hsmmc_info mmc[] = {
 
 static void __init am3517_evm_init(void)
 {
-	omap_board_config = am3517_evm_config;
-	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	am3517_evm_i2c_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 97d7190..d94a640 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -37,7 +37,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/nand.h>
 #include <plat/gpmc.h>
@@ -714,13 +713,8 @@ static inline void cm_t35_init_mux(void) {}
 static inline void cm_t3730_init_mux(void) {}
 #endif
 
-static struct omap_board_config_kernel cm_t35_config[] __initdata = {
-};
-
 static void __init cm_t3x_common_init(void)
 {
-	omap_board_config = cm_t35_config;
-	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index a33ad46..57204f8 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -38,7 +38,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/nand.h>
@@ -249,9 +248,6 @@ static void __init cm_t3517_init_nand(void)
 static inline void cm_t3517_init_nand(void) {}
 #endif
 
-static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* GPIO186 - Green LED */
@@ -285,8 +281,6 @@ static void __init cm_t3517_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap_board_config = cm_t3517_config;
-	omap_board_config_size = ARRAY_SIZE(cm_t3517_config);
 	cm_t3517_init_leds();
 	cm_t3517_init_nand();
 	cm_t3517_init_rtc();
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ef230a0..5be082b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -45,7 +45,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include "common.h"
@@ -525,9 +524,6 @@ static int __init omap3_evm_i2c_init(void)
 	return 0;
 }
 
-static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
-};
-
 static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 
 	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -687,9 +683,6 @@ static void __init omap3_evm_init(void)
 	obm = (cpu_is_omap3630()) ? omap36x_board_mux : omap35x_board_mux;
 	omap3_mux_init(obm, OMAP_PACKAGE_CBB);
 
-	omap_board_config = omap3_evm_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
-
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index b318f56..421fb8e 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -35,7 +35,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
@@ -362,9 +361,6 @@ static int __init omap3_stalker_i2c_init(void)
 
 #define OMAP3_STALKER_TS_GPIO	175
 
-static struct omap_board_config_kernel omap3_stalker_config[] __initdata = {
-};
-
 static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
 };
@@ -399,8 +395,6 @@ static void __init omap3_stalker_init(void)
 {
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-	omap_board_config = omap3_stalker_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 
 	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index d4c8392..da4679d 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -21,7 +21,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/irqs.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 
@@ -32,15 +31,10 @@ static struct omap_musb_board_data musb_board_data = {
 	.power		= 500,
 };
 
-static struct omap_board_config_kernel ti81xx_evm_config[] __initdata = {
-};
-
 static void __init ti81xx_evm_init(void)
 {
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap_board_config = ti81xx_evm_config;
-	omap_board_config_size = ARRAY_SIZE(ti81xx_evm_config);
 	usb_musb_init(&musb_board_data);
 }
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 89a3723..af98971 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -58,11 +58,6 @@ const void *__init __omap_get_config(u16 tag, size_t len, int nr)
         return get_config(tag, len, nr, NULL);
 }
 
-const void *__init omap_get_var_config(u16 tag, size_t *len)
-{
-        return get_config(tag, NO_LENGTH_CHECK, 0, len);
-}
-
 void __init omap_reserve(void)
 {
 	omap_vram_reserve_sdram_memblock();
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index e62f20a..e6a8d79 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -117,10 +117,6 @@ extern const void *__init __omap_get_config(u16 tag, size_t len, int nr);
 
 #define omap_get_config(tag, type) \
 	((const type *) __omap_get_config((tag), sizeof(type), 0))
-#define omap_get_nr_config(tag, type, nr) \
-	((const type *) __omap_get_config((tag), sizeof(type), (nr)))
-
-extern const void *__init omap_get_var_config(u16 tag, size_t *len);
 
 extern struct omap_board_config_kernel *omap_board_config;
 extern int omap_board_config_size;
-- 
1.7.8.6
