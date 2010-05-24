From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: usb_nop_xceiv_register() missing when OTG built as modules
Date: Mon, 24 May 2010 12:37:37 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E61643A@dbde02.ent.ti.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com> <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com> <20100522235310.GA15859@matterhorn.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44306 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab0EXHIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 03:08:07 -0400
In-Reply-To: <20100522235310.GA15859@matterhorn.lan>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi, 
> Here is a compile-tested patch since I haven't seen this fixed in mainline
> yet.  It applies to the tip of Linus' tree.
> 
> Attempting to remove usb_nop_xceiv_register() completely will require
> someone
> with more knowledge of davinci and blackfin archs to comment on what
> boards
> need the platform_device defined.

NAK..
This is an incorrect fix as it duplicates the code snippet which
is already present in nop file.

Here is a better fix for this (patch attached below). The approach
in this patch has already been discussed and was not agreed and I was
asked to move nop registration to board files.

------------ cut here ------------------
NOP transceiver is getting registered in board files of OAMP3EVM
and OMAP4430 SDP as they use ISP150x and internal transceivers.

This registration in board file forces NOP transceiver to be
built into the kernel.

Fixing this by removing NOP tranceiver from board files to omap
platform file within musb driver.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c  |    3 ---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ----
 drivers/usb/musb/omap2430.c          |   11 ++++++++++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..77af4c9 100644
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
@@ -374,8 +373,6 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 81bba19..83d3aa5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,7 +27,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl.h>
-#include <linux/usb/otg.h>
 #include <linux/smsc911x.h>
 
 #include <linux/regulator/machine.h>
@@ -682,9 +681,6 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 
-	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
-	usb_nop_xceiv_register();
-
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
 		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e06d65e..58acd0c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -198,6 +198,13 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
+#if defined(CONFIG_MACH_OMAP3EVM) || defined(CONFIG_MACH_OMAP_4430SDP)
+	/* OMAP3EVM used ISP150x and OMAP4 SDP uses internal transceiver
+	 * so register nop transceiver
+	 */
+	usb_nop_xceiv_register();
+#endif
+
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
@@ -325,6 +332,8 @@ int musb_platform_exit(struct musb *musb)
 {
 
 	musb_platform_suspend(musb);
-
+#if defined(CONFIG_MACH_OMAP3EVM) || defined(CONFIG_MACH_OMAP_4430SDP)
+	usb_nop_xceiv_unregister();
+#endif
 	return 0;
 }
-- 
1.6.2.4
----------------------------------------

Regards,
Ajay
> 
> Cheers,
> Amit

