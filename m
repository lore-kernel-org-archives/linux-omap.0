From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2: Use hwmod to initialize mmc for 2420
Date: Tue, 26 Jun 2012 03:17:12 -0700
Message-ID: <20120626101711.GA31393@atomide.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
 <20120424000835.17783.50945.stgit@muffinssi.local>
 <alpine.DEB.2.00.1205081844530.28088@utopia.booyaka.com>
 <alpine.DEB.2.00.1205091426230.28088@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14527 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab2FZKRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 06:17:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205091426230.28088@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [120509 13:31]:
> Hi Tony,
> 
> On Tue, 8 May 2012, Paul Walmsley wrote:
> 
> > On Mon, 23 Apr 2012, Tony Lindgren wrote:
> > 
> > > This allows us to pass dma request lines in platform data to
> > > MMC driver the same way as we already do for omap2430 and later.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > This might save you some time, I updated this patch to move the device 
> > creation code to arch/arm/mach-omap2/msdi.c and to change the hwmod name 
> > to 'msdi1' to conform with the new data.  Updated patch below.
> 
> One other thing, the version that was sent yesterday was the 
> second-to-last revision.  Also needed are the following includes in 
> arch/arm/mach-omap2/msdi.c:
> 
> #include <linux/err.h>
> 
> #include "control.h"

Looks like I had this forgotten in testing-misc.. It needed an update
to add #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
for the omap242x_init_mmc() to avoid introducing a new build warning
when MMC_OMAP is not selected at all.

Also looking at the msdi.c file, that too should have the reset function
in drivers/mmc/msdi.h as discussed earlier for other driver resets.

After that's fixed, then we only need to build in msdi.o when we have

obj-msdi-$(CONFIG_MMC_OMAP)		:= msdi.o
obj-y					+= $(omap-msdi-m) $(omap-msdi-y)

But that's a separate patch, so I've applied the following version
of $Subject patch into devel-driver branch.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 26 Jun 2012 03:14:20 -0700
Subject: [PATCH] ARM: OMAP2: Use hwmod to initialize mmc for 2420

This allows us to pass dma request lines in platform data to
MMC driver the same way as we already do for omap2430 and later.

Also note that we need to only build this code if MMC_OMAP
is selected, so change Makefile accordingly and place it near
the MMC_OMAP_HS in the Makefile.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8cab358..91ef6699 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,7 +27,6 @@
 
 #include "iomap.h"
 #include <plat/board.h>
-#include <plat/mmc.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -603,75 +602,6 @@ static inline void omap_init_aes(void) { }
 
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
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	int id = 0;
-	char *oh_name = "msdi1";
-	char *dev_name = "mmci-omap";
-
-	if (!mmc_data[0]) {
-		pr_err("%s fails: Incomplete platform data\n", __func__);
-		return;
-	}
-
-	omap242x_mmc_mux(mmc_data[0]);
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return;
-	}
-	pdev = omap_device_build(dev_name, id, oh, mmc_data[0],
-				 sizeof(struct omap_mmc_platform_data), NULL, 0, 0);
-	if (IS_ERR(pdev))
-		WARN(1, "Can'd build omap_device for %s:%s.\n",
-					dev_name, oh->name);
-}
-
-#endif
-
 #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
 	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index ef2a692..fb5bc6c 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -22,11 +22,15 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/err.h>
 
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/mmc.h>
 
 #include "common.h"
+#include "control.h"
+#include "mux.h"
 
 /*
  * MSDI_CON_OFFSET: offset in bytes of the MSDI IP block's CON register
@@ -86,3 +90,72 @@ int omap_msdi_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
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
+#endif
