From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: FW: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on
 OMAP3430
Date: Wed, 21 Oct 2009 10:28:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA23E5A7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbZJUE6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 00:58:30 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9L4wVgI012093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 23:58:33 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9L4wUJV009491
	for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2009 10:28:31 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Any comments would be taken in.
Thanks
Regards
Shweta

-----Original Message-----
From: Gulati, Shweta 
Sent: Tuesday, October 13, 2009 3:56 PM
To: linux-omap@vger.kernel.org
Cc: Gulati, Shweta; Gopinath, Thara
Subject: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on OMAP3430

From: Shweta Gulati <shweta.gulati@ti.com>

(Resending the patch with the subject line and some minor fixes)

According to Silicon Bug on context restore it is  found that the pad
configuration register for GPIO_28/GPIO_29(ETKD14/15) is corrupted after
returning from Core OFF mode. This happens if the MPU reads the
PADCONF_SAVEDONE bit very close to the end of context save sequence
for the pad conf registers, resulting in last context not being saved to the
scratchpad  memory. This is a h/w bug. The workaround is to delay the
MPU access of SAVEDONE bit until the last context has been saved.

This patch adds a configuration option to allow 300 us delay in
save path as recommended by TI. The other option is to let the
bug occur but store the value of pad configuration register explicitly
and write it back in resume path. But this option should be chosen
only if the ETKD14/15 pads are not in use as this workaround can
lead to glitch in the pin.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Signed-off-by: Thara Gopinath<thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig   |   17 +++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index cea3bca..4f9671a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #include <mach/sram.h>
 #include <mach/prcm.h>
@@ -54,10 +55,19 @@
 
 static int regset_save_on_suspend;
 
+/* A extra variable to store value of pad_config register if
+ * delay is not to be inserted and value is explicitly restored
+ * in resume path.
+ */
+#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
+static u32 store_pad_config;
+#endif
+
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
+#define CONTROL_PADCONF_ETK_D14			0x480025F8
 
 u32 enable_off_mode;
 u32 sleep_while_idle;
@@ -202,6 +212,17 @@ static void omap3_core_save_context(void)
 	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
 	control_padconf_off |= START_PADCONF_SAVE;
 	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
+#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
+	store_pad_config = omap_readl(CONTROL_PADCONF_ETK_D14);
+#else
+	/* Due to Silicon Bug on context restore it is found
+	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
+	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
+	 * for 300us for scm to finish saving task
+	 */
+	udelay(300);
+#endif
+
 	/* wait for the save to complete */
 	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
 			& PADCONF_SAVE_DONE)
@@ -217,6 +238,10 @@ static void omap3_core_save_context(void)
 
 static void omap3_core_restore_context(void)
 {
+	/* Restore the last padconf value if needed */
+#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
+	omap_writel(store_pad_config, CONTROL_PADCONF_ETK_D14);
+#endif
 	/* Restore the control module context, padconf restored by h/w */
 	omap3_control_restore_context();
 	/* Restore the GPMC context */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 2143db5..737d0aa 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -242,6 +242,23 @@ config OMAP_PM_SRF
 
 endchoice
 
+config DELAY_IN_PADCONF_SAVE
+	bool "Insert 300 us delay after the start of padconf saving"
+	depends on ARCH_OMAP3 && PM
+	help
+	 If this option is selected  a  300 us delay is inserted in the
+	 suspend path after writing into START_PADCONF_SAVE bit to ensure
+	 that pad configuration register is stored properly.If mpu tries to
+	 access SAVE_DOME bit before the entire save is over, there is a
+	 possibility that the last padconf register is not saved properly.
+	 The delay ensures that mpu does not acess SAVE_DONE bit before the
+	 save is complete.
+
+	 If this option is not selected the bug is let
+	 to happen and last pad configuration register
+	 is explicitly saved in SDRAM and written back
+	 in resume path.
+
 endmenu
 
 endif
-- 
1.5.4.7

