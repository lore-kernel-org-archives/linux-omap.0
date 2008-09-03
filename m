From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Wed, 3 Sep 2008 15:12:19 -0700
Message-ID: <20080903221218.GD23085@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55991 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYICWMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 18:12:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've updated our git tree to -rc5. Now drivers/usb is pretty close to
being in sync with mainline except for the following diff.

Dave, could you take a look at the following USB patch and see what
should be merged, fixed or removed?

The patch is mostly some ehci-omap.[ch] and musb include fixes. And
then there are also the H4 OTG patches from Imre still floating on
this list.

Regards,

Tony

--ibTvN161/egqYuK8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-usb-hacks.patch"

diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/gadget/Kconfig ./drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	2008-09-01 11:13:34.000000000 -0700
+++ b/drivers/usb/gadget/Kconfig	2008-09-03 11:19:58.000000000 -0700
@@ -297,7 +297,7 @@
 config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
 	depends on ARCH_OMAP
-	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
+	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/gadget/omap_udc.c ./drivers/usb/gadget/omap_udc.c
--- a/drivers/usb/gadget/omap_udc.c	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/gadget/omap_udc.c	2008-09-03 11:32:56.000000000 -0700
@@ -2313,6 +2313,13 @@
 
 	tmp = omap_readl(OTG_REV);
 	if (cpu_is_omap24xx()) {
+		/*
+		 * REVISIT: Not clear how this works on OMAP2.  trans
+		 * is ANDed to produce bits 7 and 8, which might make
+		 * sense for USB_TRANSCEIVER_CTRL on OMAP1,
+		 * but with CONTROL_DEVCONF, these bits have something to
+		 * do with the frame adjustment counter and McBSP2.
+		 */
 		ctrl_name = "control_devconf";
 		trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	} else {
@@ -2597,7 +2604,9 @@
 		 * and ignored for PIO-IN on newer chips
 		 * (for more reliable behavior)
 		 */
-		if (!use_dma || cpu_is_omap15xx() || cpu_is_omap24xx())
+		if ((!use_dma && (addr & USB_DIR_IN))
+				|| machine_is_omap_apollon()
+				|| cpu_is_omap15xx())
 			dbuf = 0;
 
 		switch (maxp) {
@@ -2687,7 +2696,7 @@
 	udc->gadget.name = driver_name;
 
 	device_initialize(&udc->gadget.dev);
-	dev_set_name(&udc->gadget.dev, "gadget");
+	strcpy (udc->gadget.dev.bus_id, "gadget");
 	udc->gadget.dev.release = omap_udc_release;
 	udc->gadget.dev.parent = &odev->dev;
 	if (use_dma)
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/host/ehci-hcd.c ./drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/host/ehci-hcd.c	2008-09-03 11:10:38.000000000 -0700
@@ -1009,6 +1009,11 @@
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
+#ifdef CONFIG_ARCH_OMAP34XX
+#include "ehci-omap.c"
+#define	PLATFORM_DRIVER		ehci_hcd_omap_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/host/ehci-omap.c ./drivers/usb/host/ehci-omap.c
--- a/drivers/usb/host/ehci-omap.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/usb/host/ehci-omap.c	2008-09-03 11:10:38.000000000 -0700
@@ -0,0 +1,562 @@
+/*
+ * ehci-omap.c - driver for USBHOST on OMAP 34xx processor
+ *
+ * Bus Glue for OMAP34xx USBHOST 3 port EHCI controller
+ * Tested on OMAP3430 ES2.0 SDP
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * 	Author: Vikram Pandita <vikram.pandita@ti.com>
+ *
+ * Based on "ehci-fsl.c" and "ehci-au1xxx.c" ehci glue layers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <mach/gpio.h>
+
+#include "ehci-omap.h"
+
+
+#ifdef CONFIG_OMAP_EHCI_PHY_MODE
+/* EHCI connected to External PHY */
+
+/* External USB connectivity board: 750-2083-001
+ * Connected to OMAP3430 SDP
+ * The board has Port1 and Port2 connected to ISP1504 in 12-pin ULPI mode
+ */
+
+/* ISSUE1:
+ *      ISP1504 for input clocking mode needs special reset handling
+ * 	Hold the PHY in reset by asserting RESET_N signal
+ * 	Then start the 60Mhz clock input to PHY
+ * 	Release the reset after a delay -
+ * 		to get the PHY state machine in working state
+ */
+#define EXTERNAL_PHY_RESET
+#define	EXT_PHY_RESET_GPIO_PORT1	(57)
+#define	EXT_PHY_RESET_GPIO_PORT2	(61)
+#define	EXT_PHY_RESET_DELAY		(10)
+
+/* ISSUE2:
+ * USBHOST supports External charge pump PHYs only
+ * Use the VBUS from Port1 to power VBUS of Port2 externally
+ * So use Port2 as the working ULPI port
+ */
+#define VBUS_INTERNAL_CHARGEPUMP_HACK
+
+#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
+
+/*-------------------------------------------------------------------------*/
+
+/* Define USBHOST clocks for clock management */
+struct ehci_omap_clock_defs {
+	struct clk	*usbhost_ick_clk;
+	struct clk	*usbhost2_120m_fck_clk;
+	struct clk	*usbhost1_48m_fck_clk;
+	struct clk	*usbtll_fck_clk;
+	struct clk	*usbtll_ick_clk;
+};
+
+/* Clock names as per clock framework: May change so keep as #defs */
+#define USBHOST_ICKL		"usbhost_ick"
+#define USBHOST_120M_FCLK	"usbhost_120m_fck"
+#define USBHOST_48M_FCLK	"usbhost_48m_fck"
+#define USBHOST_TLL_ICKL	"usbtll_ick"
+#define USBHOST_TLL_FCLK	"usbtll_fck"
+/*-------------------------------------------------------------------------*/
+
+
+#ifndef CONFIG_OMAP_EHCI_PHY_MODE
+
+static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
+{
+	int i;
+
+	/* Use UTMI Ports of TLL */
+	omap_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+						OMAP_UHH_HOSTCONFIG);
+	/* Enusre bit is set */
+	while (!(omap_readl(OMAP_UHH_HOSTCONFIG) &
+		(1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)));
+
+	dev_dbg(hcd->self.controller, "\nEntered UTMI MODE: success\n");
+
+	/* Program the 3 TLL channels upfront */
+
+	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+
+		/* Disable AutoIdle */
+		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+			    ~(1<<OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
+			    OMAP_TLL_CHANNEL_CONF(i));
+		/* Disable BitStuffing */
+		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
+			    OMAP_TLL_CHANNEL_CONF(i));
+		/* SDR Mode */
+		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
+			    OMAP_TLL_CHANNEL_CONF(i));
+
+	}
+
+	/* Program Common TLL register */
+	omap_writel((1 << OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT) |
+			(1 << OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT) |
+			(0 << OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT) |
+			(0 << OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT),
+				OMAP_TLL_SHARED_CONF);
+
+	/* Enable channels now */
+	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+
+		/* Enable only the channel that is needed */
+		if (!(tll_channel_mask & 1<<i))
+			continue;
+
+		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
+			    (1<<OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
+			    OMAP_TLL_CHANNEL_CONF(i));
+
+		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
+		dev_dbg(hcd->self.controller, "\nULPI_SCRATCH_REG[ch=%d]"
+			"= 0x%02x\n",
+			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
+	}
+}
+
+#else
+# define omap_usb_utmi_init(x, y)	0
+#endif
+
+
+/* omap_start_ehc
+ * 	- Start the TI USBHOST controller
+ */
+static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
+{
+	struct ehci_omap_clock_defs *ehci_clocks;
+
+	dev_dbg(hcd->self.controller, ": starting TI EHCI USB Controller\n");
+
+	ehci_clocks = (struct ehci_omap_clock_defs *)(
+				((char *)hcd_to_ehci(hcd)) +
+					sizeof(struct ehci_hcd));
+
+	/* Start DPLL5 Programming:
+	 * Clock Framework is not doing this now:
+	 * This will be done in clock framework later
+	 */
+	/* Enable DPLL 5 : Based on Input of 13Mhz*/
+	cm_write_mod_reg((12 << OMAP3430ES2_PERIPH2_DPLL_DIV_SHIFT)|
+			(120 << OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT),
+			PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
+
+	cm_write_mod_reg(1 << OMAP3430ES2_DIV_120M_SHIFT,
+			PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+
+	cm_write_mod_reg((7 << OMAP3430ES2_PERIPH2_DPLL_FREQSEL_SHIFT) |
+			(7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
+			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
+
+	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
+				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
+		dev_dbg(hcd->self.controller,
+			"idlest2 = 0x%x\n",
+			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
+	/* End DPLL5 programming */
+
+
+	/* PRCM settings for USBHOST:
+	 * Interface clk un-related to domain transition
+	 */
+	cm_write_mod_reg(0 << OMAP3430ES2_AUTO_USBHOST_SHIFT,
+				OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+
+	/* Disable sleep dependency with MPU and IVA */
+	cm_write_mod_reg((0 << OMAP3430ES2_EN_MPU_SHIFT) |
+				(0 << OMAP3430ES2_EN_IVA2_SHIFT),
+				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+
+	/* Disable Automatic transition of clock */
+	cm_write_mod_reg(0 << OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT,
+				OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
+
+	/* Enable Clocks for USBHOST */
+	ehci_clocks->usbhost_ick_clk = clk_get(&dev->dev,
+						USBHOST_ICKL);
+	if (IS_ERR(ehci_clocks->usbhost_ick_clk))
+		return PTR_ERR(ehci_clocks->usbhost_ick_clk);
+	clk_enable(ehci_clocks->usbhost_ick_clk);
+
+
+	ehci_clocks->usbhost2_120m_fck_clk = clk_get(&dev->dev,
+							USBHOST_120M_FCLK);
+	if (IS_ERR(ehci_clocks->usbhost2_120m_fck_clk))
+		return PTR_ERR(ehci_clocks->usbhost2_120m_fck_clk);
+	clk_enable(ehci_clocks->usbhost2_120m_fck_clk);
+
+	ehci_clocks->usbhost1_48m_fck_clk = clk_get(&dev->dev,
+						USBHOST_48M_FCLK);
+	if (IS_ERR(ehci_clocks->usbhost1_48m_fck_clk))
+		return PTR_ERR(ehci_clocks->usbhost1_48m_fck_clk);
+	clk_enable(ehci_clocks->usbhost1_48m_fck_clk);
+
+
+#ifdef EXTERNAL_PHY_RESET
+	/* Refer: ISSUE1 */
+	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT1);
+	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT1, 0);
+	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT2, 0);
+	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 0);
+	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 0);
+	/* Hold the PHY in RESET for enough time till DIR is high */
+	udelay(EXT_PHY_RESET_DELAY);
+#endif
+
+	/* Configure TLL for 60Mhz clk for ULPI */
+	ehci_clocks->usbtll_fck_clk = clk_get(&dev->dev, USBHOST_TLL_FCLK);
+	if (IS_ERR(ehci_clocks->usbtll_fck_clk))
+		return PTR_ERR(ehci_clocks->usbtll_fck_clk);
+	clk_enable(ehci_clocks->usbtll_fck_clk);
+
+	ehci_clocks->usbtll_ick_clk = clk_get(&dev->dev, USBHOST_TLL_ICKL);
+	if (IS_ERR(ehci_clocks->usbtll_ick_clk))
+		return PTR_ERR(ehci_clocks->usbtll_ick_clk);
+	clk_enable(ehci_clocks->usbtll_ick_clk);
+
+	/* Disable Auto Idle of USBTLL */
+	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL_SHIFT),
+				CORE_MOD, CM_AUTOIDLE3);
+
+	/* Wait for TLL to be Active */
+	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3) &
+		(1 << OMAP3430ES2_ST_USBTLL_SHIFT)));
+
+	/* perform TLL soft reset, and wait until reset is complete */
+	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
+			OMAP_USBTLL_SYSCONFIG);
+	/* Wait for TLL reset to complete */
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) &
+		(1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)));
+
+	dev_dbg(hcd->self.controller, "\n TLL RESET DONE\n");
+
+	/* (1<<3) = no idle mode only for initial debugging */
+	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
+			(1 << OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT) |
+			(1 << OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT),
+			OMAP_USBTLL_SYSCONFIG);
+
+
+	/* Put UHH in NoIdle/NoStandby mode */
+	omap_writel((0 << OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT) |
+			(1 << OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT) |
+			(1 << OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT) |
+			(1 << OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT) |
+			(1 << OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT),
+			OMAP_UHH_SYSCONFIG);
+
+#ifdef CONFIG_OMAP_EHCI_PHY_MODE
+	/* Bypass the TLL module for PHY mode operation */
+	omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+						OMAP_UHH_HOSTCONFIG);
+	/* Ensure that BYPASS is set */
+	while (omap_readl(OMAP_UHH_HOSTCONFIG) &
+		(1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT));
+
+	dev_dbg(hcd->self.controller, "Entered ULPI PHY MODE: success");
+
+#else
+	/* Enable UTMI mode for all 3 TLL channels */
+	omap_usb_utmi_init(hcd,
+		OMAP_TLL_CHANNEL_1_EN_MASK |
+		OMAP_TLL_CHANNEL_2_EN_MASK |
+		OMAP_TLL_CHANNEL_3_EN_MASK
+		);
+#endif
+
+#ifdef EXTERNAL_PHY_RESET
+	/* Refer ISSUE1:
+	 * Hold the PHY in RESET for enough time till PHY is settled and ready
+	 */
+	udelay(EXT_PHY_RESET_DELAY);
+	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 1);
+	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 1);
+#endif
+
+#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
+	/* Refer ISSUE2: LINK assumes external charge pump */
+
+	/* use Port1 VBUS to charge externally Port2:
+	 * 	So for PHY mode operation use Port2 only
+	 */
+	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
+			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
+			(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
+			(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
+			(0x26),
+			EHCI_INSNREG05_ULPI);
+
+	while (!(omap_readl(EHCI_INSNREG05_ULPI) &
+		(1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
+
+#endif
+
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
+{
+	struct ehci_omap_clock_defs *ehci_clocks;
+
+	ehci_clocks = (struct ehci_omap_clock_defs *)
+			(((char *)hcd_to_ehci(hcd)) + sizeof(struct ehci_hcd));
+
+	dev_dbg(hcd->self.controller, ": stopping TI EHCI USB Controller\n");
+
+	/* Reset OMAP modules for insmod/rmmod to work */
+	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)));
+	dev_dbg(hcd->self.controller,
+		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
+			omap_readl(OMAP_UHH_SYSSTATUS));
+
+	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)));
+	dev_dbg(hcd->self.controller, ":TLL RESEET DONE");
+
+	if (ehci_clocks->usbtll_fck_clk != NULL) {
+		clk_disable(ehci_clocks->usbtll_fck_clk);
+		clk_put(ehci_clocks->usbtll_fck_clk);
+		ehci_clocks->usbtll_fck_clk = NULL;
+	}
+
+	if (ehci_clocks->usbhost_ick_clk != NULL) {
+		clk_disable(ehci_clocks->usbhost_ick_clk);
+		clk_put(ehci_clocks->usbhost_ick_clk);
+		ehci_clocks->usbhost_ick_clk = NULL;
+	}
+
+	if (ehci_clocks->usbhost1_48m_fck_clk != NULL) {
+		clk_disable(ehci_clocks->usbhost1_48m_fck_clk);
+		clk_put(ehci_clocks->usbhost1_48m_fck_clk);
+		ehci_clocks->usbhost1_48m_fck_clk = NULL;
+	}
+
+	if (ehci_clocks->usbhost2_120m_fck_clk != NULL) {
+		clk_disable(ehci_clocks->usbhost2_120m_fck_clk);
+		clk_put(ehci_clocks->usbhost2_120m_fck_clk);
+		ehci_clocks->usbhost2_120m_fck_clk = NULL;
+	}
+
+	if (ehci_clocks->usbtll_ick_clk != NULL) {
+		clk_disable(ehci_clocks->usbtll_ick_clk);
+		clk_put(ehci_clocks->usbtll_ick_clk);
+		ehci_clocks->usbtll_ick_clk = NULL;
+	}
+
+
+#ifdef EXTERNAL_PHY_RESET
+	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT1);
+	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT2);
+#endif
+
+	dev_dbg(hcd->self.controller,
+		": Clock to USB host has been disabled\n");
+}
+
+static const struct hc_driver ehci_omap_hc_driver;
+
+/*-------------------------------------------------------------------------*/
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+/**
+ * ehci_hcd_omap_drv_probe - initialize TI-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
+{
+	int retval = 0;
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+
+	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()");
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
+		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ");
+		retval = -ENOMEM;
+	}
+
+	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
+	if (!hcd)
+		return -ENOMEM;
+
+	retval = omap_start_ehc(dev, hcd);
+	if (retval)
+		return retval;
+
+	hcd->rsrc_start = 0;
+	hcd->rsrc_len = 0;
+	hcd->rsrc_start = dev->resource[0].start;
+	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
+
+	hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs;
+
+	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	/* SET 1 micro-frame Interrupt interval */
+	writel(readl(&ehci->regs->command) | (1<<16), &ehci->regs->command);
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start,
+				IRQF_DISABLED | IRQF_SHARED);
+	if (retval == 0)
+		return retval;
+
+	dev_dbg(hcd->self.controller, "ERR: add_hcd");
+	omap_stop_ehc(dev, hcd);
+
+	usb_put_hcd(hcd);
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/**
+ * ehci_hcd_omap_drv_remove - shutdown processing for EHCI HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_ehci_hcd_omap_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ */
+static int ehci_hcd_omap_drv_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_remove()");
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(hcd);
+	omap_stop_ehc(dev, hcd);
+
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+#ifdef CONFIG_PM
+static int omap_ehci_bus_suspend(struct usb_hcd *hcd)
+{
+	return ehci_bus_suspend(hcd);
+}
+
+static int omap_ehci_bus_resume(struct usb_hcd *hcd)
+{
+	return ehci_bus_resume(hcd);
+}
+#endif
+/*-------------------------------------------------------------------------*/
+
+static const struct hc_driver ehci_omap_hc_driver = {
+	.description = hcd_name,
+	.product_desc = "OMAP-EHCI Host Controller",
+	.hcd_priv_size = sizeof(struct ehci_hcd)
+				+ sizeof(struct ehci_omap_clock_defs),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq = ehci_irq,
+	.flags = HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset = ehci_init,
+	.start = ehci_run,
+	.stop = ehci_stop,
+	.shutdown = ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue = ehci_urb_enqueue,
+	.urb_dequeue = ehci_urb_dequeue,
+	.endpoint_disable = ehci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number = ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data = ehci_hub_status_data,
+	.hub_control = ehci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend = omap_ehci_bus_suspend,
+	.bus_resume = omap_ehci_bus_resume,
+#endif
+};
+
+/*-------------------------------------------------------------------------*/
+MODULE_ALIAS("omap-ehci");
+static struct platform_driver ehci_hcd_omap_driver = {
+	.probe = ehci_hcd_omap_drv_probe,
+	.remove = ehci_hcd_omap_drv_remove,
+	.shutdown = usb_hcd_platform_shutdown,
+	/*.suspend      = ehci_hcd_omap_drv_suspend, */
+	/*.resume       = ehci_hcd_omap_drv_resume, */
+	.driver = {
+		.name = "ehci-omap",
+		.bus = &platform_bus_type
+	}
+};
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/host/ehci-omap.h ./drivers/usb/host/ehci-omap.h
--- a/drivers/usb/host/ehci-omap.h	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/usb/host/ehci-omap.h	2008-09-03 11:10:38.000000000 -0700
@@ -0,0 +1,125 @@
+/*
+ * ehci-omap.h - register definitions for USBHOST in OMAP 34xx
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * 	Author: Vikram Pandita <vikram.pandita@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __EHCI_OMAP_H
+#define __EHCI_OMAP_H
+
+#include <mach/hardware.h>
+#include "../../../arch/arm/mach-omap2/cm.h"
+#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
+
+/*
+ * OMAP USBHOST Register addresses: PHYSICAL ADDRESSES
+ * 	Use omap_readl()/omap_writel() functions
+ */
+
+/* USBHOST: TLL, UUH, OHCI, EHCI */
+#define	OMAP_USBHOST_BASE	(L4_34XX_BASE + 0x60000)
+
+/* TLL Register Set */
+#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
+#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
+#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
+	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
+	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
+	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT	2
+	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT	1
+	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE_SHIFT	0
+#define	OMAP_USBTLL_SYSSTATUS	(OMAP_USBHOST_TLL_BASE + 0x14)
+	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT	0
+#define	OMAP_USBTLL_IRQSTATUS	(OMAP_USBHOST_TLL_BASE + 0x18)
+#define	OMAP_USBTLL_IRQENABLE	(OMAP_USBHOST_TLL_BASE + 0x1C)
+
+#define	OMAP_TLL_SHARED_CONF	(OMAP_USBHOST_TLL_BASE + 0x30)
+	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT	6
+	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT	5
+	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT	2
+	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ_SHIFT		1
+	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT		0
+
+#define	OMAP_TLL_CHANNEL_CONF(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x040 + 0x004 * num))
+	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT	11
+	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE_SHIFT	10
+	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT	9
+	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT		8
+	#define	OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT		0
+
+#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x804 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x807 + 0x100 * num))
+#define	OMAP_TLL_ULPI_OTG_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x80A + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_EN_RISE(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x80D + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_EN_FALL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x810 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_STATUS(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x813 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_LATCH(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x814 + 0x100 * num))
+#define	OMAP_TLL_ULPI_DEBUG(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x815 + 0x100 * num))
+#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x816 + 0x100 * num))
+
+#define OMAP_TLL_CHANNEL_COUNT		3
+	#define OMAP_TLL_CHANNEL_1_EN_MASK	1
+	#define OMAP_TLL_CHANNEL_2_EN_MASK	2
+	#define OMAP_TLL_CHANNEL_3_EN_MASK	4
+
+/* UHH Register Set */
+#define	OMAP_USBHOST_UHH_BASE	(OMAP_USBHOST_BASE + 0x4000)
+#define	OMAP_UHH_REVISION	(OMAP_USBHOST_UHH_BASE + 0x00)
+#define	OMAP_UHH_SYSCONFIG	(OMAP_USBHOST_UHH_BASE + 0x10)
+	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT	12
+	#define	OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT	8
+	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT	3
+	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT	2
+	#define	OMAP_UHH_SYSCONFIG_SOFTRESET_SHIFT	1
+	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT	0
+
+#define	OMAP_UHH_SYSSTATUS	(OMAP_USBHOST_UHH_BASE + 0x14)
+#define	OMAP_UHH_HOSTCONFIG	(OMAP_USBHOST_UHH_BASE + 0x40)
+	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT	0
+	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT	2
+	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT	3
+	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT	4
+	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT	5
+
+#define	OMAP_UHH_DEBUG_CSR	(OMAP_USBHOST_UHH_BASE + 0x44)
+
+/* EHCI Register Set */
+#define	OMAP_USBHOST_EHCI_BASE	(OMAP_USBHOST_BASE + 0x4800)
+#define	EHCI_INSNREG05_ULPI		(OMAP_USBHOST_EHCI_BASE + 0xA4)
+	#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT	31
+	#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT	24
+	#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT		22
+	#define	EHCI_INSNREG05_ULPI_REGADD_SHIFT	16
+	#define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT	8
+	#define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT	0
+
+/* OHCI Register Set */
+#define	OMAP_USBHOST_OHCI_BASE	(OMAP_USBHOST_BASE + 0x4400)
+
+#endif/* __EHCI_OMAP_H*/
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/host/Kconfig ./drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig	2008-07-08 00:10:05.000000000 -0700
+++ b/drivers/usb/host/Kconfig	2008-09-03 11:10:38.000000000 -0700
@@ -41,6 +41,25 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ehci-hcd.
+choice
+	prompt "PHY/TLL mode"
+	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
+	---help---
+	Choose PHY or TLL mode of operation
+
+config OMAP_EHCI_PHY_MODE
+	bool "PHY mode: ISP1504 on Port1/2 (NEW 3430ES2.0)"
+	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
+	---help---
+	  EHCI PHY mode. Port1 and Port2 are connected to ISP1504 transcievers
+
+config OMAP_EHCI_TLL_MODE
+	bool "TLL mode: (EXPERIMENTAL)"
+	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
+	---help---
+	OMAP EHCI controller has TLL mode of operation for all 3 ports.
+	Use this mode when no transciever is present
+endchoice
 
 config USB_EHCI_ROOT_HUB_TT
 	bool "Root Hub Transaction Translators"
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/host/ohci-omap.c ./drivers/usb/host/ohci-omap.c
--- a/drivers/usb/host/ohci-omap.c	2008-09-03 11:06:52.000000000 -0700
+++ b/drivers/usb/host/ohci-omap.c	2008-09-03 11:19:59.000000000 -0700
@@ -231,7 +231,7 @@
 
 	omap_ohci_clock_power(1);
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		omap_1510_local_bus_power(1);
 		omap_1510_local_bus_init();
 	}
@@ -319,7 +319,7 @@
 	if (IS_ERR(usb_host_ck))
 		return PTR_ERR(usb_host_ck);
 
-	if (!cpu_is_omap1510())
+	if (!cpu_is_omap15xx())
 		usb_dc_ck = clk_get(0, "usb_dc_ck");
 	else
 		usb_dc_ck = clk_get(0, "lb_ck");
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/Kconfig ./drivers/usb/Kconfig
--- a/drivers/usb/Kconfig	2008-09-01 11:13:34.000000000 -0700
+++ b/drivers/usb/Kconfig	2008-09-03 11:19:58.000000000 -0700
@@ -55,6 +55,7 @@
 	default y if PPC_83xx
 	default y if SOC_AU1200
 	default y if ARCH_IXP4XX
+	default y if ARCH_OMAP34XX
 	default PCI
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/musb/davinci.c ./drivers/usb/musb/davinci.c
--- a/drivers/usb/musb/davinci.c	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/musb/davinci.c	2008-09-03 14:57:26.000000000 -0700
@@ -31,15 +31,15 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <asm/arch/hardware.h>
-#include <asm/arch/memory.h>
-#include <asm/arch/gpio.h>
+#include <mach/hardware.h>
+#include <mach/memory.h>
+#include <mach/gpio.h>
 #include <asm/mach-types.h>
 
 #include "musb_core.h"
 
 #ifdef CONFIG_MACH_DAVINCI_EVM
-#include <asm/arch/i2c-client.h>
+#include <mach/i2c-client.h>
 #endif
 
 #include "davinci.h"
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/musb/musb_core.c ./drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c	2008-09-03 11:02:56.000000000 -0700
+++ b/drivers/usb/musb/musb_core.c	2008-09-03 14:57:26.000000000 -0700
@@ -100,8 +100,8 @@
 #include <linux/io.h>
 
 #ifdef	CONFIG_ARM
-#include <asm/arch/hardware.h>
-#include <asm/arch/memory.h>
+#include <mach/hardware.h>
+#include <mach/memory.h>
 #include <asm/mach-types.h>
 #endif
 
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/musb/omap2430.c ./drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/musb/omap2430.c	2008-09-03 14:57:26.000000000 -0700
@@ -35,8 +35,8 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/mux.h>
+#include <mach/hardware.h>
+#include <mach/mux.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/musb/omap2430.h ./drivers/usb/musb/omap2430.h
--- a/drivers/usb/musb/omap2430.h	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/musb/omap2430.h	2008-09-03 14:57:26.000000000 -0700
@@ -11,8 +11,8 @@
 #define __MUSB_OMAP243X_H__
 
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
-#include <asm/arch/hardware.h>
-#include <asm/arch/usb.h>
+#include <mach/hardware.h>
+#include <mach/usb.h>
 
 /*
  * OMAP2430-specific definitions
diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/musb/tusb6010_omap.c ./drivers/usb/musb/tusb6010_omap.c
--- a/drivers/usb/musb/tusb6010_omap.c	2008-09-01 11:13:35.000000000 -0700
+++ b/drivers/usb/musb/tusb6010_omap.c	2008-09-03 14:57:26.000000000 -0700
@@ -15,8 +15,8 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/mux.h>
+#include <mach/dma.h>
+#include <mach/mux.h>
 
 #include "musb_core.h"
 

--ibTvN161/egqYuK8--
