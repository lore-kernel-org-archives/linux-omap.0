From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] OMAP3: musb: add neednop flag to fix nop modular issue
Date: Thu, 27 May 2010 12:34:46 +0530
Message-ID: <1274943888-17615-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NOP transceiver is getting registered in board files of OMAP3EVM
and OMAP4430 SDP as they use ISP150x and internal transceivers.

This registration in board file forces NOP transceiver to be
built into the kernel.

Fixing this by adding new flag '.neednop' within board_data
structure which would be used to register/unregister NOP
tranceiver in omap platform file within musb driver.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch set created against today's linus's tree.

 arch/arm/mach-omap2/board-4430sdp.c   |    4 +---
 arch/arm/mach-omap2/board-omap3evm.c  |    5 +----
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..fb29837 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/usb/otg.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
@@ -138,6 +137,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_PERIPHERAL,
 	.power			= 100,
+	.neednop		= 1,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -374,8 +374,6 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 81bba19..609f021 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,7 +27,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl.h>
-#include <linux/usb/otg.h>
 #include <linux/smsc911x.h>
 
 #include <linux/regulator/machine.h>
@@ -666,6 +665,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
 	.mode			= MUSB_OTG,
 	.power			= 100,
+	.neednop		= 1,
 };
 
 static void __init omap3_evm_init(void)
@@ -682,9 +682,6 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 
-	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
-	usb_nop_xceiv_register();
