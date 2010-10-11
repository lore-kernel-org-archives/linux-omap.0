From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] DSPBridge: convert OMAP3430 adaptation layer to use new
	SCM DSP boot control fns
Date: Mon, 11 Oct 2010 14:37:14 -0600
Message-ID: <20101011203713.24425.52021.stgit@twilight.localdomain>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40283 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab0JKUja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 16:39:30 -0400
In-Reply-To: <20101011203659.24425.2381.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: fernando.lugo@ti.com
Cc: linux-omap@vger.kernel.org

DSPBridge currently tries to __raw_writel() to the System Control
Module to control the DSP boot process.  This is a layering violation;
this is SoC-specific code, and belongs in a file in
arch/arm/mach-omap2/*.  None of those CM and PRM register accesses
through struct platform_data belong under drivers/.  (Nor would they
belong in DSP platform init code in arch/arm/mach-omap2/* - such code
must use the clock, clockdomain, powerdomain, omap_device, and
omap_hwmod layers that are provided for this purpose.)

The immediate problem, however, is that after commit
346a5c890a55495c718394b74214be1de9303cf6, this code can no longer compile.
So to fix this immediate problem, convert the DSP boot control code to
use platform_data function pointers.

The DSPBridge-on-OMAP3 people also need to implement a file in
arch/arm/mach-omap2/ to populate the platform_data function pointers.
Such a file does not yet exist in the mainline tree, so it's unlikely
that DSPBridge is usable in the mainline until this is done.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: <fernando.lugo@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |   13 ++++++-------
 .../tidspbridge/include/dspbridge/host_os.h        |    4 ++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f914829..3fd9551 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -21,7 +21,7 @@
 #include <dspbridge/host_os.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <plat/control.h>
+#include <plat/iva2_dsp.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -374,6 +374,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
+	u8 bootmode;
 	struct dspbridge_platform_data *pdata =
 				omap_dspbridge_dev->dev.platform_data;
 
@@ -415,15 +416,13 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 					OMAP3430_RST1_IVA2_MASK, OMAP3430_IVA2_MOD,
 					OMAP2_RM_RSTCTRL);
 			/* Mask address with 1K for compatibility */
-			__raw_writel(dsp_addr & OMAP3_IVA2_BOOTADDR_MASK,
-					OMAP343X_CTRL_REGADDR(
-					OMAP343X_CONTROL_IVA2_BOOTADDR));
+			dsp_addr &= OMAP3_IVA2_BOOTADDR_MASK;
+			(*pdata->set_dsp_bootaddr)(dsp_addr);
 			/*
 			 * Set bootmode to self loop if dsp_debug flag is true
 			 */
-			__raw_writel((dsp_debug) ? OMAP3_IVA2_BOOTMOD_IDLE : 0,
-					OMAP343X_CTRL_REGADDR(
-					OMAP343X_CONTROL_IVA2_BOOTMOD));
+			bootmode = dsp_debug ? OMAP_IVA2_DSP_BOOTMODE_IDLE : 0;
+			(*pdata->set_dsp_bootmode)(bootmode);
 		}
 	}
 	if (!status) {
diff --git a/drivers/staging/tidspbridge/include/dspbridge/host_os.h b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
index 6b4feb4..a251fe4 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/host_os.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
@@ -59,7 +59,11 @@ struct dspbridge_platform_data {
 	unsigned long (*cpu_get_freq) (void);
 	unsigned long mpu_speed[6];
 
+	void (*set_dsp_bootaddr)(u32 pa);
+	void (*set_dsp_bootmode)(u8 mode);
+
 	/* functions to write and read PRCM registers */
+	/* XXX None of this should be here */
 	void (*dsp_prm_write)(u32, s16 , u16);
 	u32 (*dsp_prm_read)(s16 , u16);
 	u32 (*dsp_prm_rmw_bits)(u32, u32, s16, s16);


