From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 08/17] ARM: OMAP2+: Convert TUSB to use gpmc_cs_program_settings()
Date: Fri, 8 Mar 2013 10:58:29 -0600
Message-ID: <1362761918-8696-9-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933505Ab3CHQ7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 11:59:19 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

Convert the OMAP2+ TUSB code to use the gpmc_cs_program_settings()
function for configuring the various GPMC options instead of directly
programming the CONFIG1 register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |   43 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index faaf96d..1902b0b 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -27,12 +28,21 @@ static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
 static struct gpmc_settings tusb_async = {
+	.wait_on_read	= true,
+	.wait_on_write	= true,
+	.device_width	= GPMC_DEVWIDTH_16BIT,
 	.mux_add_data	= GPMC_MUX_AD,
 };
 
 static struct gpmc_settings tusb_sync = {
+	.burst_read	= true,
+	.burst_write	= true,
 	.sync_read	= true,
 	.sync_write	= true,
+	.wait_on_read	= true,
+	.wait_on_write	= true,
+	.burst_len	= GPMC_BURST_16,
+	.device_width	= GPMC_DEVWIDTH_16BIT,
 	.mux_add_data	= GPMC_MUX_AD,
 };
 
@@ -168,18 +178,12 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		return status;
 	}
 	tusb_resources[0].end = tusb_resources[0].start + 0x9ff;
+	tusb_async.wait_pin = waitpin;
 	async_cs = async;
-	gpmc_cs_write_reg(async, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_PAGE_LEN(2)
-			| GPMC_CONFIG1_WAIT_READ_MON
-			| GPMC_CONFIG1_WAIT_WRITE_MON
-			| GPMC_CONFIG1_WAIT_PIN_SEL(waitpin)
-			| GPMC_CONFIG1_READTYPE_ASYNC
-			| GPMC_CONFIG1_WRITETYPE_ASYNC
-			| GPMC_CONFIG1_DEVICESIZE_16
-			| GPMC_CONFIG1_DEVICETYPE_NOR
-			| GPMC_CONFIG1_MUXADDDATA);
 
+	status = gpmc_cs_program_settings(async_cs, &tusb_async);
+	if (IS_ERR_VALUE(status))
+		return status;
 
 	/* SYNC region, primarily for DMA */
 	status = gpmc_cs_request(sync, SZ_16M, (unsigned long *)
@@ -189,21 +193,12 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		return status;
 	}
 	tusb_resources[1].end = tusb_resources[1].start + 0x9ff;
+	tusb_sync.wait_pin = waitpin;
 	sync_cs = sync;
-	gpmc_cs_write_reg(sync, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_READMULTIPLE_SUPP
-			| GPMC_CONFIG1_READTYPE_SYNC
-			| GPMC_CONFIG1_WRITEMULTIPLE_SUPP
-			| GPMC_CONFIG1_WRITETYPE_SYNC
-			| GPMC_CONFIG1_PAGE_LEN(2)
-			| GPMC_CONFIG1_WAIT_READ_MON
-			| GPMC_CONFIG1_WAIT_WRITE_MON
-			| GPMC_CONFIG1_WAIT_PIN_SEL(waitpin)
-			| GPMC_CONFIG1_DEVICESIZE_16
-			| GPMC_CONFIG1_DEVICETYPE_NOR
-			| GPMC_CONFIG1_MUXADDDATA
-			/* fclk divider gets set later */
-			);
+
+	status = gpmc_cs_program_settings(sync_cs, &tusb_sync);
+	if (IS_ERR_VALUE(status))
+		return status;
 
 	/* IRQ */
 	status = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
-- 
1.7.10.4

