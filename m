From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2: Use hwmod to initialize mmc for 2420
Date: Tue, 8 May 2012 18:46:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205081844530.28088@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local> <20120424000835.17783.50945.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59297 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab2EIAqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:46:34 -0400
In-Reply-To: <20120424000835.17783.50945.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony

On Mon, 23 Apr 2012, Tony Lindgren wrote:

> This allows us to pass dma request lines in platform data to
> MMC driver the same way as we already do for omap2430 and later.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This might save you some time, I updated this patch to move the device 
creation code to arch/arm/mach-omap2/msdi.c and to change the hwmod name 
to 'msdi1' to conform with the new data.  Updated patch below.


- Paul

From: Tony Lindgren <tony@atomide.com>
Date: Mon, 23 Apr 2012 17:08:35 -0700
Subject: [PATCH] ARM: OMAP2: Use hwmod to initialize mmc for 2420

This allows us to pass dma request lines in platform data to
MMC driver the same way as we already do for omap2430 and later.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   59 -----------------------------------
 arch/arm/mach-omap2/msdi.c    |   68 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e433603..263a85f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,7 +27,6 @@
 
 #include "iomap.h"
 #include <plat/board.h>
-#include <plat/mmc.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -574,64 +573,6 @@ static inline void omap_init_aes(void) { }
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-
-static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
-							*mmc_controller)
-{
-	if ((mmc_controller->slots[0].switch_pin > 0) && \
-		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
-					OMAP_PIN_INPUT_PULLUP);
-	if ((mmc_controller->slots[0].gpio_wp > 0) && \
-		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
-					OMAP_PIN_INPUT_PULLUP);
-
-	omap_mux_init_signal("sdmmc_cmd", 0);
-	omap_mux_init_signal("sdmmc_clki", 0);
-	omap_mux_init_signal("sdmmc_clko", 0);
-	omap_mux_init_signal("sdmmc_dat0", 0);
-	omap_mux_init_signal("sdmmc_dat_dir0", 0);
-	omap_mux_init_signal("sdmmc_cmd_dir", 0);
-	if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
-		omap_mux_init_signal("sdmmc_dat1", 0);
-		omap_mux_init_signal("sdmmc_dat2", 0);
-		omap_mux_init_signal("sdmmc_dat3", 0);
-		omap_mux_init_signal("sdmmc_dat_dir1", 0);
-		omap_mux_init_signal("sdmmc_dat_dir2", 0);
-		omap_mux_init_signal("sdmmc_dat_dir3", 0);
-	}
-
-	/*
-	 * Use internal loop-back in MMC/SDIO Module Input Clock
-	 * selection
-	 */
-	if (mmc_controller->slots[0].internal_clock) {
-		u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-		v |= (1 << 24);
-		omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-	}
-}
-
-void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
-{
-	char *name = "mmci-omap";
-
-	if (!mmc_data[0]) {
-		pr_err("%s fails: Incomplete platform data\n", __func__);
-		return;
-	}
-
-	omap242x_mmc_mux(mmc_data[0]);
-	omap_mmc_add(name, 0, OMAP2_MMC1_BASE, OMAP2420_MMC_SIZE,
-					INT_24XX_MMC_IRQ, mmc_data[0]);
-}
-
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
 #define OMAP_HDQ_BASE	0x480B2000
 static struct resource omap_hdq_resources[] = {
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index ef2a692..d75839a 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -24,9 +24,11 @@
 #include <linux/kernel.h>
 
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/mmc.h>
 
 #include "common.h"
+#include "mux.h"
 
 /*
  * MSDI_CON_OFFSET: offset in bytes of the MSDI IP block's CON register
@@ -86,3 +88,69 @@ int omap_msdi_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
+				    *mmc_controller)
+{
+	if ((mmc_controller->slots[0].switch_pin > 0) && \
+		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
+					OMAP_PIN_INPUT_PULLUP);
+	if ((mmc_controller->slots[0].gpio_wp > 0) && \
+		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
+					OMAP_PIN_INPUT_PULLUP);
+
+	omap_mux_init_signal("sdmmc_cmd", 0);
+	omap_mux_init_signal("sdmmc_clki", 0);
+	omap_mux_init_signal("sdmmc_clko", 0);
+	omap_mux_init_signal("sdmmc_dat0", 0);
+	omap_mux_init_signal("sdmmc_dat_dir0", 0);
+	omap_mux_init_signal("sdmmc_cmd_dir", 0);
+	if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
+		omap_mux_init_signal("sdmmc_dat1", 0);
+		omap_mux_init_signal("sdmmc_dat2", 0);
+		omap_mux_init_signal("sdmmc_dat3", 0);
+		omap_mux_init_signal("sdmmc_dat_dir1", 0);
+		omap_mux_init_signal("sdmmc_dat_dir2", 0);
+		omap_mux_init_signal("sdmmc_dat_dir3", 0);
+	}
+
+	/*
+	 * Use internal loop-back in MMC/SDIO Module Input Clock
+	 * selection
+	 */
+	if (mmc_controller->slots[0].internal_clock) {
+		u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+		v |= (1 << 24);
+		omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+	}
+}
+
+void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
+{
+	struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	int id = 0;
+	char *oh_name = "msdi1";
+	char *dev_name = "mmci-omap";
+
+	if (!mmc_data[0]) {
+		pr_err("%s fails: Incomplete platform data\n", __func__);
+		return;
+	}
+
+	omap242x_mmc_mux(mmc_data[0]);
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
+	pdev = omap_device_build(dev_name, id, oh, mmc_data[0],
+				 sizeof(struct omap_mmc_platform_data), NULL, 0, 0);
+	if (IS_ERR(pdev))
+		WARN(1, "Can'd build omap_device for %s:%s.\n",
+					dev_name, oh->name);
+}
+
-- 
1.7.10

