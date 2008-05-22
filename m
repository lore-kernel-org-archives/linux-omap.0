From: Imre Deak <imre.deak@gmail.com>
Subject: [PATCH] USB: H4/OHCI/ISP1301 fixes
Date: Thu, 22 May 2008 16:24:25 +0300
Message-ID: <20080522132425.GC25056@FITFIESPPC177>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.telecasystems.de ([212.114.200.71]:51721 "EHLO
	mail.telecasystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760987AbYEVNeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 09:34:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dbrownell@users.sourceforge.net


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While trying to make H4 USB work I had the following issues,
attached are patches to fix those:

- Fix the H4 board config for the wiring of the ISP1301
  transceiver. The platform config had 4 wire configuration but
  the driver has the 3 wire mode hard-coded. It's also possible
  to set the ISP1301 to 4 wire mode, I wonder which one is more
  ideal?

- In the OMAP OHCI driver use 24xx specific clocks when running
  on 24xx. Rename variables for usb_dc/usb_lb and usb_hhc to the
  more generic usb_ick and usb_fck. Platforms other than OMAP1
  and 24xx are not supported by the driver at the moment.

- For OMAP OHCI SYSCON_2[UHOST_EN] needs to be set, otherwise we
  get an external abort at OHCI init time.

- Make the OMAP USB root hub power budget a platform specific
  option. Setting this to 0 will keep the current behaviour. There
  are boards not providing enough power for host mode, but still
  needing host mode functionality. This requires a special hub
  providing VBUS both on the downstream and upstream facing ports.
  For these .power_budget=-1 can be set meaning unlimited or
  no power budget control. Maybe a warning about the need for such
  a special hub would be nice?

- ISP1301 driver updated according to the new I2C framework.

- Update omap_h4_2420_defcofig to enable OTG, OHCI, Gadget
  driver. Use the onboard USB OTG plug instead of the download plug.

With these and the specail self powered hub, I have a working OTG,
at least I can connect in both host and gadget modes and can ping
through usb0/eth1.

--Imre


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-OMAP-USB-in-the-OHCI-driver-use-proper-clocks-for.patch"

>From 1fc1b0aa85414d153b7d290a483f09850c17bae3 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Thu, 15 May 2008 14:07:12 +0300
Subject: [PATCH] OMAP: USB: in the OHCI driver use proper clocks for 24xx

Instead of the OMAP1 specific usb_hhc, usb_dc/usb_lb use
usb_l4_ick and usb_fck for 24xx platforms. Other than OMAP1/
OMAP24xx platforms are not supported currently, so bail out
for those.

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 drivers/usb/host/ohci-omap.c |   57 ++++++++++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f14be49..335f414 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -65,21 +65,21 @@ static inline int tps65010_set_gpio_out_value(unsigned gpio, unsigned value)
 extern int usb_disabled(void);
 extern int ocpi_enable(void);
 
-static struct clk *usb_host_ck;
-static struct clk *usb_dc_ck;
+static struct clk *usb_ick;
+static struct clk *usb_fck;
 static int host_enabled;
 static int host_initialized;
 
 static void omap_ohci_clock_power(int on)
 {
 	if (on) {
-		clk_enable(usb_dc_ck);
-		clk_enable(usb_host_ck);
+		clk_enable(usb_ick);
+		clk_enable(usb_fck);
 		/* guesstimate for T5 == 1x 32K clock + APLL lock time */
 		udelay(100);
 	} else {
-		clk_disable(usb_host_ck);
-		clk_disable(usb_dc_ck);
+		clk_disable(usb_ick);
+		clk_disable(usb_fck);
 	}
 }
 
@@ -298,6 +298,7 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 	int retval, irq;
 	struct usb_hcd *hcd = 0;
 	struct ohci_hcd *ohci;
+	const char *ick_name, *fck_name;
 
 	if (pdev->num_resources != 2) {
 		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n",
@@ -311,20 +312,34 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 		return -ENODEV;
 	}
 
-	usb_host_ck = clk_get(0, "usb_hhc_ck");
-	if (IS_ERR(usb_host_ck))
-		return PTR_ERR(usb_host_ck);
-
-	if (!cpu_is_omap15xx())
-		usb_dc_ck = clk_get(0, "usb_dc_ck");
-	else
-		usb_dc_ck = clk_get(0, "lb_ck");
+	if (cpu_class_is_omap1()) {
+		if (!cpu_is_omap15xx())
+			ick_name = "usb_dc_ck";
+		else
+			ick_name = "lb_ck";
+		fck_name = "usb_hhc_ck";
+	} else {
+		if (cpu_is_omap24xx()) {
+			ick_name = "usb_l4_ick";
+			fck_name = "usb_fck";
+		} else {
+			pr_err("hcd probe: unsopported architecture\n");
+			return -ENODEV;
+		}
+	}
 
-	if (IS_ERR(usb_dc_ck)) {
-		clk_put(usb_host_ck);
-		return PTR_ERR(usb_dc_ck);
+	usb_ick = clk_get(0, ick_name);
+	if (IS_ERR(usb_ick)) {
+		pr_debug("hcd probe: can't get usb_ick %s", ick_name);
+		return PTR_ERR(usb_ick);
 	}
 
+	usb_fck = clk_get(0, fck_name);
+	if (IS_ERR(usb_fck)) {
+		pr_debug("hcd probe: can't get usb_fck %s", fck_name);
+		clk_put(usb_ick);
+		return PTR_ERR(usb_fck);
+	}
 
 	hcd = usb_create_hcd (driver, &pdev->dev, pdev->dev.bus_id);
 	if (!hcd) {
@@ -368,8 +383,8 @@ err2:
 err1:
 	usb_put_hcd(hcd);
 err0:
-	clk_put(usb_dc_ck);
-	clk_put(usb_host_ck);
+	clk_put(usb_ick);
+	clk_put(usb_fck);
 	return retval;
 }
 
@@ -399,8 +414,8 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 		omap_free_gpio(9);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-	clk_put(usb_dc_ck);
-	clk_put(usb_host_ck);
+	clk_put(usb_ick);
+	clk_put(usb_fck);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-ISP1301-update-isp1301_probe-to-the-new-i2c-interfa.patch"

>From 95ab9b7201db664d17b01b358d3084a2997d3cd9 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Thu, 15 May 2008 14:37:31 +0300
Subject: [PATCH] ISP1301: update isp1301_probe to the new i2c interface

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 drivers/i2c/chips/isp1301_omap.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 1525543..39e1bc4 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1479,7 +1479,8 @@ isp1301_start_hnp(struct otg_transceiver *dev)
 /*-------------------------------------------------------------------------*/
 
 /* no error returns, they'd just make bus scanning stop */
-static int __init isp1301_probe(struct i2c_client *client)
+static int __init isp1301_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
 {
 	int			status;
 	struct isp1301		*isp;
@@ -1594,12 +1595,19 @@ fail2:
 	return 0;
 }
 
+static const struct i2c_device_id isp1301_omap_id[] = {
+	{ "isp1301_omap", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isp1301_omap_id);
+
 static struct i2c_driver isp1301_driver = {
 	.driver = {
 		.name	= "isp1301_omap",
 	},
-	.probe	= isp1301_probe,
-	.remove	= __exit_p(isp1301_remove),
+	.probe		= isp1301_probe,
+	.remove		= __exit_p(isp1301_remove),
+	.id_table	= isp1301_omap_id,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-OMAP-H4-Change-the-ISP1301-wiring-to-3-wire-mode.patch"

>From 3be8bca0a40afb6459c8d606aec609724f53ae81 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Wed, 21 May 2008 17:45:06 +0300
Subject: [PATCH] OMAP: H4: Change the ISP1301 wiring to 3 wire mode

This is hard-coded in the ISP1301 driver at the moment.

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 arch/arm/mach-omap2/board-h4.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 101b455..a8c51e1 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -419,7 +419,10 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	 * S2.POS3 = OFF, S2.POS4 = ON ... to allow battery charging
 	 */
 	.otg		= 1,
-	.pins[0]	= 4,
+	/* NOTE: The ISP1301 supports both 3 and 4 wire signaling; at
+	 * the moment the 3 wire mode is hardcoded in the ISP1301 driver.
+	 */
+	.pins[0]	= 3,
 #ifdef	CONFIG_USB_GADGET_OMAP
 	/* use OTG cable, or standard A-to-MiniB */
 	.hmc_mode	= 0x14,	/* 0:dev/otg 1:host 2:disable */
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0004-OMAP-USB-make-HOST-OTG-mode-power_budget-a-platfor.patch"

>From ad2b5417eba816d104395841f0be1db557cc0ad4 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Wed, 21 May 2008 16:44:44 +0300
Subject: [PATCH] OMAP: USB: make HOST/OTG mode power_budget a platform config option

Boards can have a specific power budget they provide, or they might
not be able to provide any for HOST mode operation in which case
they require a (special) hub providing power on their upstream
facing port. Make this configurable from the board-* files.

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    1 +
 arch/arm/mach-omap1/board-osk.c      |    1 +
 arch/arm/mach-omap2/board-h4.c       |    8 ++++++++
 drivers/usb/host/ohci-omap.c         |   26 +++++++++++++++++---------
 include/asm-arm/arch-omap/board.h    |   10 ++++++++++
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 08f533e..1150767 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -212,6 +212,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.register_host	= 1,
 	.register_dev	= 1,
 	.hmc_mode	= 16,
+	.power_budget	= -1,
 	.pins[0]	= 6,
 };
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a66505f..421c416 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -309,6 +309,7 @@ static struct omap_usb_config osk_usb_config __initdata = {
 	.hmc_mode	= 16,
 	.rwc		= 1,
 #endif
+	.power_budget	= 250,
 	.pins[0]	= 2,
 };
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index a8c51e1..e95fd31 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -441,6 +441,14 @@ static struct omap_usb_config h4_usb_config __initdata = {
 /*	.hmc_mode	= 0x14,*/	/* 0:dev 1:host 2:disable */
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 #endif
+
+#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	.power_budget	= -1,	/*
+				 * Unlimited, requiring an external hub
+				 * providing VBUS on its upstream facing
+				 * port.
+				 */
+#endif
 };
 
 /* ----------------------------------------------------------------------- */
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 335f414..128b775 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -192,10 +192,24 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 
 	dev_dbg(hcd->self.controller, "starting USB Controller\n");
 
-	if (config->otg) {
+	if (config->otg)
 		ohci_to_hcd(ohci)->self.otg_port = config->otg;
-		/* default/minimum OTG power budget:  8 mA */
-		ohci_to_hcd(ohci)->power_budget = 8;
+
+	switch (config->power_budget) {
+	case 0:
+		if (config->otg)
+			/* default/minimum OTG power budget:  8 mA */
+			ohci_to_hcd(ohci)->power_budget = 8;
+		/* else leave it at the default */
+		break;
+	case (u16)-1:
+		/* Unlimited */
+		ohci_to_hcd(ohci)->power_budget = 0;
+		break;
+	default:
+		/* Board specific */
+		ohci_to_hcd(ohci)->power_budget = config->power_budget;
+		break;
 	}
 
 	/* boards can use OTG transceivers in non-OTG modes */
@@ -244,8 +258,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 
 		/* TPS2045 switch for internal transceiver (port 1) */
 		if (machine_is_omap_osk()) {
-			ohci_to_hcd(ohci)->power_budget = 250;
-
 			rh &= ~RH_A_NOCP;
 
 			/* gpio9 for overcurrent detction */
@@ -258,10 +270,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 		}
 		ohci_writel(ohci, rh, &ohci->regs->roothub.a);
 		distrust_firmware = 0;
-	} else if (machine_is_nokia770()) {
-		/* We require a self-powered hub, which should have
-		 * plenty of power. */
-		ohci_to_hcd(ohci)->power_budget = 0;
 	}
 
 	/* FIXME khubd hub requests should manage power switching */
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
index 0783e60..48dd9fa 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -87,6 +87,16 @@ struct omap_usb_config {
 	/* implicitly true if otg:  host supports remote wakeup? */
 	u8		rwc;
 
+	/* Host/OTG mode power budget in mA:
+	 *    -1 == Unlimited. This can be the case when the board itself
+	 *          cannot provide VBUS so an external hub that provides
+	 *          VBUS on it's upstream facing port is required.
+	 *     0 == Default; leave it up to USB core. For OTG mode this
+	 *          means a minimum of 8mA and unlimited for HOST mode.
+	 * 1-500 == Board specific.
+	 */
+	u16		power_budget;
+
 	/* signaling pins used to talk to transceiver on usbN:
 	 *  0 == usbN unused
 	 *  2 == usb0-only, using internal transceiver
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0005-OMAP-USB-Enable-USB-host-module-when-its-configure.patch"

>From e9cc1afff2779f4b5bac505ec848f77e350e3b96 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Wed, 21 May 2008 18:30:43 +0300
Subject: [PATCH] OMAP: USB: Enable USB host module when its configured in

SYSCON_2[UHOST_EN] needs to be set, otherwise OHCI is not accesible.

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 arch/arm/plat-omap/usb.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index a619475..587b5dc 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -551,6 +551,7 @@ void __init
 omap_otg_init(struct omap_usb_config *config)
 {
 	u32		syscon = OTG_SYSCON_1_REG & 0xffff;
+	u32		syscon2;
 	int		status;
 	int		alt_pingroup = 0;
 
@@ -571,16 +572,16 @@ omap_otg_init(struct omap_usb_config *config)
 	pr_debug("OTG_SYSCON_1_REG = %08x\n", syscon);
 	OTG_SYSCON_1_REG = syscon;
 
-	syscon = config->hmc_mode;
-	syscon |= USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
+	syscon2 = config->hmc_mode;
+	syscon2 |= USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
 #ifdef	CONFIG_USB_OTG
 	if (config->otg)
-		syscon |= OTG_EN;
+		syscon2 |= OTG_EN;
 #endif
 	if (cpu_class_is_omap1())
 		pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n", USB_TRANSCEIVER_CTRL_REG);
-	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon);
-	OTG_SYSCON_2_REG = syscon;
+	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon2);
+	OTG_SYSCON_2_REG = syscon2;
 
 	printk("USB: hmc %d", config->hmc_mode);
 	if (!alt_pingroup)
@@ -619,6 +620,7 @@ omap_otg_init(struct omap_usb_config *config)
 #if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	if (config->otg || config->register_host) {
 		syscon &= ~HST_IDLE_EN;
+		syscon2 |= UHOST_EN;
 		ohci_device.dev.platform_data = config;
 		if (cpu_is_omap730())
 			ohci_resources[1].start = INT_730_USB_HHC_1;
@@ -627,6 +629,8 @@ omap_otg_init(struct omap_usb_config *config)
 			pr_debug("can't register OHCI device, %d\n", status);
 	}
 #endif
+	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon2);
+	OTG_SYSCON_2_REG = syscon2;
 
 #ifdef	CONFIG_USB_OTG
 	if (config->otg) {
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0006-OMAP-H4-defconfig-update.patch"

>From 8ae289db9fd55d5af882d15a2ebcc07a2b17b01c Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@teleca.com>
Date: Thu, 22 May 2008 15:52:39 +0300
Subject: [PATCH] OMAP: H4: defconfig update

- select H4 OTG usb plug instead of download plug
- enable ISP1301
- enable OTG, OHCI, Gadget, Ethernet gadget (module)
- enable PM, needed by USB_SUSPEND

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 arch/arm/configs/omap_h4_2420_defconfig |  456 ++++++++++++++++++++++---------
 1 files changed, 324 insertions(+), 132 deletions(-)

diff --git a/arch/arm/configs/omap_h4_2420_defconfig b/arch/arm/configs/omap_h4_2420_defconfig
index 5bc8918..09f46a9 100644
--- a/arch/arm/configs/omap_h4_2420_defconfig
+++ b/arch/arm/configs/omap_h4_2420_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc6-omap1
-# Tue Sep 18 11:44:58 2007
+# Linux kernel version: 2.6.26-rc3-omap1
+# Thu May 22 15:32:25 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -21,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -40,12 +41,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -53,6 +57,7 @@ CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -60,6 +65,7 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -72,10 +78,20 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
@@ -99,6 +115,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # System Type
@@ -127,6 +144,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_ORION5X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -136,6 +154,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
+# CONFIG_ARCH_MSM7X00A is not set
 
 #
 # TI OMAP Implementations
@@ -149,6 +168,9 @@ CONFIG_ARCH_OMAP2=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_DEBUG_DEVICES=y
+CONFIG_OMAP_DEBUG_SRAM_PATCH=y
+# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
+# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
@@ -157,7 +179,6 @@ CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
-# CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
@@ -168,7 +189,6 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
-# CONFIG_OMAP_DSP is not set
 # CONFIG_MACH_OMAP_GENERIC is not set
 
 #
@@ -184,11 +204,10 @@ CONFIG_ARCH_OMAP2420=y
 # CONFIG_MACH_NOKIA_N800 is not set
 CONFIG_MACH_OMAP_H4=y
 # CONFIG_MACH_OMAP_H4_TUSB is not set
-# CONFIG_MACH_OMAP_H4_OTG is not set
+CONFIG_MACH_OMAP_H4_OTG=y
 # CONFIG_MACH_OMAP2_H4_USB1 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
-# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
-# CONFIG_MACH_OMAP_2430SDP is not set
+# CONFIG_MACH_OMAP_2430OSK is not set
 
 #
 # Boot options
@@ -229,10 +248,6 @@ CONFIG_ARM_THUMB=y
 #
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 
 #
@@ -241,6 +256,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_TICK_ONESHOT is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_PREEMPT is not set
 CONFIG_HZ=100
 CONFIG_AEABI=y
@@ -253,6 +269,8 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -297,8 +315,11 @@ CONFIG_BINFMT_MISC=y
 #
 # Power management options
 #
-# CONFIG_PM is not set
-CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_SUSPEND is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 
 #
 # Networking
@@ -315,6 +336,7 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 CONFIG_NET_KEY=y
 # CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
@@ -337,6 +359,7 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -344,8 +367,6 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -362,10 +383,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -373,6 +390,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 CONFIG_IRDA=y
 
 #
@@ -401,19 +419,16 @@ CONFIG_IRCOMM=y
 #
 # Dongle support
 #
-
-#
-# Old SIR device drivers
-#
-# CONFIG_IRPORT_SIR is not set
-
-#
-# Old Serial dongle support
-#
+# CONFIG_KINGSUN_DONGLE is not set
+# CONFIG_KSDAZZLE_DONGLE is not set
+# CONFIG_KS959_DONGLE is not set
 
 #
 # FIR device drivers
 #
+# CONFIG_USB_IRDA is not set
+# CONFIG_SIGMATEL_FIR is not set
+# CONFIG_MCS_FIR is not set
 CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -435,6 +450,7 @@ CONFIG_OMAP_IR=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -449,6 +465,7 @@ CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -461,6 +478,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -523,12 +541,19 @@ CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_OMAP_STI is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
@@ -546,24 +571,39 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
-CONFIG_NETDEV_1000=y
-CONFIG_NETDEV_10000=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -581,7 +621,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -596,6 +635,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_LM8323 is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
@@ -616,6 +656,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -639,14 +680,6 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
-CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=m
 CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
@@ -658,13 +691,6 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_GPIO is not set
@@ -674,75 +700,112 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
 #
-# CONFIG_SENSORS_DS1337 is not set
-# CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_ISP1301_OMAP is not set
+CONFIG_ISP1301_OMAP=y
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
 CONFIG_GPIOEXPANDER_OMAP=y
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_LP5521 is not set
 CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+CONFIG_HAVE_GPIO_LIB=y
 
 #
-# SPI support
+# GPIO Support
+#
+# CONFIG_DEBUG_GPIO is not set
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# SPI GPIO expanders:
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-CONFIG_MISC_DEVICES=y
-# CONFIG_EEPROM_93CX6 is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
-# CONFIG_NEW_LEDS is not set
+# CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
-CONFIG_DAB=y
+# CONFIG_VIDEO_MEDIA is not set
 
 #
-# Graphics support
+# Multimedia drivers
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_DAB=y
+# CONFIG_USB_DABUSB is not set
 
 #
-# Display device support
+# Graphics support
 #
-# CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_DDC is not set
-# CONFIG_FB_CFB_FILLRECT is not set
-# CONFIG_FB_CFB_COPYAREA is not set
-# CONFIG_FB_CFB_IMAGEBLIT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
 # CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
 # CONFIG_FB_SYS_FOPS is not set
-CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -753,11 +816,17 @@ CONFIG_FB_DEFERRED_IO=y
 # Frame buffer hardware drivers
 #
 # CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
-# CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -782,24 +851,123 @@ CONFIG_LOGO_LINUX_CLUT224=y
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# Enable Host or Gadget support to see Inventra options
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
+
+#
+# USB Device Class drivers
 #
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
-# USB Gadget Support
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
-# CONFIG_USB_GADGET is not set
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG is not set
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_PXA27X is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+CONFIG_USB_GADGET_OMAP=y
+CONFIG_USB_OMAP=y
+# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_USB_ZERO is not set
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_RNDIS=y
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_G_PRINTER is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -809,31 +977,22 @@ CONFIG_MMC=y
 #
 CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
+# CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
+# CONFIG_UIO is not set
 
 #
 # CBUS support
 #
 # CONFIG_CBUS is not set
+# CONFIG_OMAP_DSP is not set
 
 #
 # File systems
@@ -845,22 +1004,20 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
 # CONFIG_QFMT_V1 is not set
 CONFIG_QFMT_V2=y
 CONFIG_QUOTACTL=y
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -890,7 +1047,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -906,27 +1062,27 @@ CONFIG_RAMFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
 # CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_FS_XATTR is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -964,10 +1120,6 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -1008,22 +1160,15 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1034,6 +1179,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -1048,13 +1194,18 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
-CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
 CONFIG_DEBUG_LL=y
 # CONFIG_DEBUG_ICEDCC is not set
 
@@ -1063,49 +1214,90 @@ CONFIG_DEBUG_LL=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_GENERIC_FIND_NEXT_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
-- 
1.5.5.1.148.g88e9e


--rS8CxjVDS/+yyDmU--
