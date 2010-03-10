From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Wed, 10 Mar 2010 09:15:49 -0800
Message-ID: <20100310171548.GI2900@atomide.com>
References: <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
 <20100309153827.GR2900@atomide.com>
 <20100309154754.GI3851@gandalf>
 <20100310004826.GD2900@atomide.com>
 <20100310062159.GB3878@gandalf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56939 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484Ab0CJROm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 12:14:42 -0500
Content-Disposition: inline
In-Reply-To: <20100310062159.GB3878@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <me@felipebalbi.com> [100309 22:18]:
> > --- a/arch/arm/plat-omap/include/plat/usb.h
> > +++ b/arch/arm/plat-omap/include/plat/usb.h
> > @@ -53,7 +53,7 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
> >  
> >  extern void usb_musb_init(struct omap_musb_board_data *board_data);
> >  
> > -extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
> > +extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
> >  
> >  #endif
> 
> won't this give you compile warnings ??

No, that just means the usb_ehci_init won't change *pdata. But to
keep this const and fix a related warning, we need to also make
setup_ehci_io_mux to be:

static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)

Updated patch below, is this what you want to do? Maybe reply with
an updated patch if you want usb_ehci_init not to use const?

Also, there are other ehci related warnings, see the attached
file for that.

Regards,

Tony

--neYutvxvOLaeuPCA
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="ehci-compile.patch"

>From 93a7dd4b441b3e43eae454e2e81a02014342c2c2 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Thu, 4 Mar 2010 09:45:53 +0200
Subject: [PATCH] arm: omap: ehci: avoid compiler error with touchbook

the early_param() call in board-omap3touchbook.c expands to:

static const char __setup_str_early_touchbook_revision[]
	__section(.init.rodata) _aligned(1) = tbr;
[...]

and we have a non-const variable being added to the
same section:

static struct ehci_hcd_omap_platform_data ehci_pdata
__section(.init.rodata);

because of that, gcc generates a section type conflict
which can (and actually should) be avoided by marking
const every variable marked with __initconst.

This patch fixes that for the ehci_hdc_omap_platform_data.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a101029..5822bcf 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -648,7 +648,7 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 4386d2b..a0a2a11 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -54,7 +54,7 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 70c1861..6ae8805 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -273,7 +273,7 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index afa77ca..2de4f79 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -612,7 +612,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3710190..5bfc13b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -636,7 +636,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 9958987..4f1accf 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -442,7 +442,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6eb77e1..962d377 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -410,7 +410,7 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d6bc88c..017bb2f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -635,7 +635,7 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_dss_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 4827f46..51a5315 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -537,7 +537,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_dss_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2a5bf5c..2504d41 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -493,7 +493,7 @@ static void __init omap3touchbook_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 50872a4..8848c7c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -394,7 +394,7 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index d3e3cd5..cd3e40c 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -52,7 +52,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index f1df873..ee9f548 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -70,7 +70,7 @@ static struct platform_device ehci_device = {
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
  */
-static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
+static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case EHCI_HCD_OMAP_MODE_PHY:
@@ -213,7 +213,7 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 	return;
 }
 
-void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 {
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
@@ -229,7 +229,7 @@ void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
 
 #else
 
-void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 
 {
 }
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 288e29e..568578d 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -53,7 +53,7 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
-extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
+extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
 
 #endif
 

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="warnings.txt"

/tmp/build-ams_delta_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-ams_delta_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-ams_delta_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
--
/tmp/build-ams_delta_defconfig-  CC    In file included from arch/arm/mach-omap1/board-ams-delta.c:30:
/tmp/build-ams_delta_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-ams_delta_defconfig-  CC   drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-ams_delta_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-ams_delta_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-ams_delta_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
/tmp/build-ams_delta_defconfig-In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-ams_delta_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-ams_delta_defconfig-  CC   drivers/mtd/nand/ams-delta.c: In function 'ams_delta_write_byte':
/tmp/build-ams_delta_defconfig:drivers/mtd/nand/ams-delta.c:67: warning: passing argument 2 of 'omap_writew' makes integer from pointer without a cast
/tmp/build-ams_delta_defconfig-drivers/mtd/nand/ams-delta.c: In function 'ams_delta_read_byte':
/tmp/build-ams_delta_defconfig:drivers/mtd/nand/ams-delta.c:82: warning: passing argument 1 of 'omap_readw' makes integer from pointer without a cast
/tmp/build-ams_delta_defconfig-drivers/mtd/nand/ams-delta.c: In function 'ams_delta_init':
/tmp/build-ams_delta_defconfig:drivers/mtd/nand/ams-delta.c:181: warning: assignment makes pointer from integer without a cast
/tmp/build-ams_delta_defconfig:drivers/mtd/nand/ams-delta.c:182: warning: assignment makes pointer from integer without a cast
/tmp/build-ams_delta_defconfig-sound/soc/omap/omap-mcbsp.c: In function 'omap_mcbsp_dai_set_rcvr_src':
/tmp/build-ams_delta_defconfig:sound/soc/omap/omap-mcbsp.c:538: warning: unused variable 'reg'
--
/tmp/build-ams_delta_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-ams_delta_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-ams_delta_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-cm_t35_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-cm_t35_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-cm_t35_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-cm_t35_defconfig- drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-cm_t35_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-cm_t35_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-cm_t35_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-cm_t35_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-cm_t35_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-cm_t35_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-cm_t35_defconfig-  CC      fs/lockd/svc4drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
/tmp/build-cm_t35_defconfig:drivers/mtd/nand/omap2.c:504: warning: passing argument 2 of 'omap_nand_dma_transfer' discards qualifiers from pointer target type
/tmp/build-cm_t35_defconfig:drivers/usb/host/ehci-hub.c:997: warning: 'ehci_relinquish_port' defined but not used
/tmp/build-cm_t35_defconfig:drivers/usb/host/ehci-hub.c:1006: warning: 'ehci_port_handed_over' defined but not used
/tmp/build-cm_t35_defconfig:drivers/usb/host/ehci-hcd.c:425: warning: 'ehci_port_power' defined but not used
--
/tmp/build-devkit8000_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-devkit8000_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-devkit8000_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-devkit8000_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-devkit8000_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-devkit8000_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-devkit8000_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-devkit8000_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-devkit8000_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-devkit8000_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-devkit8000_defconfig-  CC      fs/nfs/nfs3proc.o
/tmp/build-devkit8000_defconfig:  CC      net/sunrpcdrivers/usb/host/ehci-hub.c:997: warning: 'ehci_relinquish_port' defined but not used
/tmp/build-devkit8000_defconfig:drivers/usb/host/ehci-hub.c:1006: warning: 'ehci_port_handed_over' defined but not used
/tmp/build-devkit8000_defconfig:drivers/usb/host/ehci-hcd.c:425: warning: 'ehci_port_power' defined but not used
--
/tmp/build-devkit8000_defconfig-  CCdrivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
/tmp/build-devkit8000_defconfig:drivers/mtd/nand/omap2.c:504: warning: passing argument 2 of 'omap_nand_dma_transfer' discards qualifiers from pointer target type
--
/tmp/build-htcherald_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-htcherald_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-htcherald_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-htcherald_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-htcherald_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
/tmp/build-htcherald_defconfig-In file included from arch/arm/mach-omap1/board-htcherald.c:41:
/tmp/build-htcherald_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-htcherald_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-htcherald_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-htcherald_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-htcherald_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
/tmp/build-htcherald_defconfig-In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-htcherald_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-htcherald_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-htcherald_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-htcherald_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-igep0020_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-igep0020_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-igep0020_defconfig-  CC      blockdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-igep0020_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-igep0020_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-igep0020_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-igep0020_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-igep0020_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-igep0020_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-igep0020_defconfig-  CC      fs/anon_inodes.o
/tmp/build-igep0020_defconfig:  Cdrivers/usb/host/ehci-hub.c:997: warning: 'ehci_relinquish_port' defined but not used
/tmp/build-igep0020_defconfig:drivers/usb/host/ehci-hub.c:1006: warning: 'ehci_port_handed_over' defined but not used
/tmp/build-igep0020_defconfig:drivers/usb/host/ehci-hcd.c:425: warning: 'ehci_port_power' defined but not used
--
/tmp/build-igep0020_defconfig-  CC      drivers/usb/core/endpoint.o
/tmp/build-igep0020_defconfig:  CC    drivers/video/omap2/dss/dsi.c:1609: warning: 'dsi_reset_tx_fifo' defined but not used
--
/tmp/build-n770_defconfig-  CC   In file included from arch/arm/mach-omap1/board-nokia770.c:33:
/tmp/build-n770_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
/tmp/build-n770_defconfig-drivers/cbus/cbus.c: In function 'cbus_transfer':
/tmp/build-n770_defconfig:drivers/cbus/cbus.c:150: warning: assignment makes integer from pointer without a cast
--
/tmp/build-n770_defconfig-  drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-n770_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-n770_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-n770_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-n770_defconfig-  CC      In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-n770_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-n770_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-n770_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-n770_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-n8x0_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-n8x0_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-n8x0_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-n8x0_defconfig:arch/arm/mach-omap2/irq.c:65: warning: 'intc_context' defined but not used
--
/tmp/build-n8x0_defconfig-  CC      arch/arm/plat-omap/usb.o
/tmp/build-n8x0_defconfig:  Carch/arm/mach-omap2/board-n8x0.c:38: warning: 'slot1_cover_open' defined but not used
/tmp/build-n8x0_defconfig:arch/arm/mach-omap2/board-n8x0.c:39: warning: 'slot2_cover_open' defined but not used
/tmp/build-n8x0_defconfig:arch/arm/mach-omap2/board-n8x0.c:40: warning: 'mmc_device' defined but not used
--
/tmp/build-n8x0_defconfig-  LD      kdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-n8x0_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-n8x0_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-n8x0_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-n8x0_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-n8x0_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-n8x0_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-n8x0_defconfig-  CC      drivers/usb/otdrivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
/tmp/build-n8x0_defconfig:drivers/usb/musb/musb_core.c:382: warning: unused variable 'mbase'
--
/tmp/build-omap_2430sdp_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_2430sdp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_2430sdp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_2430sdp_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-omap_2430sdp_defconfig:arch/arm/mach-omap2/irq.c:65: warning: 'intc_context' defined but not used
--
/tmp/build-omap_2430sdp_defconfig-  CC      mm/filemap.o
/tmp/build-omap_2430sdp_defconfig:  CC      arch/arm/mach-omap2/pm24xx.oarch/arm/mach-omap2/omap_hwmod_2430_data.c:72: warning: 'omap2430_mmc1_hwmod' defined but not used
/tmp/build-omap_2430sdp_defconfig:arch/arm/mach-omap2/omap_hwmod_2430_data.c:73: warning: 'omap2430_mmc2_hwmod' defined but not used
--
/tmp/build-omap_2430sdp_defconfig-  CC      drivers/badrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_2430sdp_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_2430sdp_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_2430sdp_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_2430sdp_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_2430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_2430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_3430sdp_defconfig-  CC    drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_3430sdp_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_3430sdp_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_3430sdp_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_3430sdp_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_3430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_3430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_3630sdp_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_3630sdp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_3630sdp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap_3630sdp_defconfig-  CC   drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_3630sdp_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_3630sdp_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_3630sdp_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_3630sdp_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_3630sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_3630sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap3_beagle_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap3_beagle_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_beagle_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap3_beagle_defconfig-  CC      crydrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap3_beagle_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap3_beagle_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap3_beagle_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap3_beagle_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap3_beagle_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap3_beagle_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap3_beagle_defconfig-  CC      lib/plist.o
/tmp/build-omap3_beagle_defconfig: drivers/usb/host/ehci-hub.c:997: warning: 'ehci_relinquish_port' defined but not used
/tmp/build-omap3_beagle_defconfig:drivers/usb/host/ehci-hub.c:1006: warning: 'ehci_port_handed_over' defined but not used
/tmp/build-omap3_beagle_defconfig:drivers/usb/host/ehci-hcd.c:425: warning: 'ehci_port_power' defined but not used
--
/tmp/build-omap3_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap3_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_defconfig:arch/arm/mach-omap2/io.c:284: warning: '_omap2_init_reprogram_sdrc' defined but not used
/tmp/build-omap3_defconfig-arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_resume_after_retention':
/tmp/build-omap3_defconfig:arch/arm/plat-omap/gpio.c:2096: warning: 'l' may be used uninitialized in this function
/tmp/build-omap3_defconfig-arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_prepare_for_retention':
/tmp/build-omap3_defconfig:arch/arm/plat-omap/gpio.c:2039: warning: 'l2' may be used uninitialized in this function
/tmp/build-omap3_defconfig:arch/arm/plat-omap/gpio.c:2039: warning: 'l1' may be used uninitialized in this function
--
/tmp/build-omap3_defconfig-  CC     In file included from arch/arm/mach-omap2/board-h4.c:40:
/tmp/build-omap3_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap3_defconfig-  CC      net/bluetooth/hdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap3_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap3_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap3_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap3_defconfig-  CC      kernel/posix-cpu-timers.o
/tmp/build-omap3_defconfig:  Carch/arm/mach-omap2/board-n8x0.c:38: warning: 'slot1_cover_open' defined but not used
/tmp/build-omap3_defconfig:arch/arm/mach-omap2/board-n8x0.c:39: warning: 'slot2_cover_open' defined but not used
/tmp/build-omap3_defconfig:arch/arm/mach-omap2/board-n8x0.c:40: warning: 'mmc_device' defined but not used
--
/tmp/build-omap3_defconfig-  CC      net/sunrpc/auth_gss/svcauth_gss.odrivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
/tmp/build-omap3_defconfig:drivers/mtd/nand/omap2.c:504: warning: passing argument 2 of 'omap_nand_dma_transfer' discards qualifiers from pointer target type
--
/tmp/build-omap3_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap3_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap3_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap3_evm_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap3_evm_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_evm_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap3_evm_defconfig-  CC      kernel/futedrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap3_evm_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap3_evm_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap3_evm_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap3_evm_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap3_evm_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap3_evm_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap3_pandora_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap3_pandora_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_pandora_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap3_pandora_defconfig-  CC      drivdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap3_pandora_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap3_pandora_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap3_pandora_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap3_pandora_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap3_pandora_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap3_pandora_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap3_pandora_defconfig-  CC      drivers/mtd/chips/chidrivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
/tmp/build-omap3_pandora_defconfig:drivers/mtd/nand/omap2.c:504: warning: passing argument 2 of 'omap_nand_dma_transfer' discards qualifiers from pointer target type
--
/tmp/build-omap3_pandora_defconfig- drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
/tmp/build-omap3_pandora_defconfig:drivers/usb/musb/musb_core.c:382: warning: unused variable 'mbase'
/tmp/build-omap3_pandora_defconfig:drivers/usb/host/ehci-hub.c:997: warning: 'ehci_relinquish_port' defined but not used
/tmp/build-omap3_pandora_defconfig:drivers/usb/host/ehci-hub.c:1006: warning: 'ehci_port_handed_over' defined but not used
/tmp/build-omap3_pandora_defconfig:drivers/usb/host/ehci-hcd.c:425: warning: 'ehci_port_power' defined but not used
--
/tmp/build-omap3_touchbook_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap3_touchbook_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap3_touchbook_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap3_touchbook_defconfig-  CC      driverdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap3_touchbook_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap3_touchbook_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap3_touchbook_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap3_touchbook_defconfig-  LD     drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
/tmp/build-omap3_touchbook_defconfig:drivers/mtd/nand/omap2.c:504: warning: passing argument 2 of 'omap_nand_dma_transfer' discards qualifiers from pointer target type
--
/tmp/build-omap3_touchbook_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap3_touchbook_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap3_touchbook_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_4430sdp_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_4430sdp_defconfig:arch/arm/mach-omap2/clockdomains.h:58: warning: 'gfx_sgx_wkdeps' defined but not used
/tmp/build-omap_4430sdp_defconfig:arch/arm/mach-omap2/io.c:284: warning: '_omap2_init_reprogram_sdrc' defined but not used
/tmp/build-omap_4430sdp_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-omap_4430sdp_defconfig-arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_resume_after_retention':
/tmp/build-omap_4430sdp_defconfig:arch/arm/plat-omap/gpio.c:2096: warning: 'l' may be used uninitialized in this function
/tmp/build-omap_4430sdp_defconfig-arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_prepare_for_retention':
/tmp/build-omap_4430sdp_defconfig:arch/arm/plat-omap/gpio.c:2039: warning: 'l2' may be used uninitialized in this function
/tmp/build-omap_4430sdp_defconfig:arch/arm/plat-omap/gpio.c:2039: warning: 'l1' may be used uninitialized in this function
--
/tmp/build-omap_4430sdp_defconfig-  CC      drivedrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_4430sdp_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_4430sdp_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_4430sdp_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_4430sdp_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_4430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_4430sdp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_apollon_2420_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_apollon_2420_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-omap_apollon_2420_defconfig:arch/arm/mach-omap2/irq.c:65: warning: 'intc_context' defined but not used
--
/tmp/build-omap_apollon_2420_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_apollon_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_apollon_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/build-omap_apollon_2420_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_apollon_2420_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_apollon_2420_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_apollon_2420_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_generic_1510_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-omap_generic_1510_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-omap_generic_1510_defconfig-  CC      kernel/printk.o
/tmp/build-omap_generic_1510_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
--
/tmp/build-omap_generic_1510_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_generic_1510_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_generic_1510_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/build-omap_generic_1510_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_generic_1510_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_generic_1510_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_generic_1510_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_generic_1510_defconfig-  CC      fs/jbd/rIn file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_generic_1510_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_generic_1610_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-omap_generic_1610_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-omap_generic_1610_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
--
/tmp/build-omap_generic_1610_defconfig-  CC      kernel/idrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_generic_1610_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_generic_1610_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_generic_1610_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_generic_1610_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_generic_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_generic_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_generic_1610_defconfig-  CC      nIn file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_generic_1610_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_generic_1710_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-omap_generic_1710_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-omap_generic_1710_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
--
/tmp/build-omap_generic_1710_defconfig-  CCdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_generic_1710_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_generic_1710_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_generic_1710_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_generic_1710_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_generic_1710_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_generic_1710_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/build-omap_generic_1710_defconfig-In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_generic_1710_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_generic_2420_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_generic_2420_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-omap_generic_2420_defconfig:arch/arm/mach-omap2/irq.c:65: warning: 'intc_context' defined but not used
--
/tmp/build-omap_generic_2420_defconfig-  CC  drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_generic_2420_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_generic_2420_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_generic_2420_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_generic_2420_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_generic_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_generic_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_h2_1610_defconfig-  LD      arch/arm/nwfpe/nwIn file included from arch/arm/mach-omap1/board-h2.c:46:
/tmp/build-omap_h2_1610_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_h2_1610_defconfig-  CC      drivedrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_h2_1610_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_h2_1610_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_h2_1610_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_h2_1610_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_h2_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_h2_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_h4_2420_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_h4_2420_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_h4_2420_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_h4_2420_defconfig:arch/arm/mach-omap2/mux.c:51: warning: 'mux_phys' defined but not used
/tmp/build-omap_h4_2420_defconfig:arch/arm/mach-omap2/irq.c:65: warning: 'intc_context' defined but not used
--
/tmp/build-omap_h4_2420_defconfig-  CC      arch/arm/In file included from arch/arm/mach-omap2/board-h4.c:40:
/tmp/build-omap_h4_2420_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_h4_2420_defconfig-  CC   drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_h4_2420_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_h4_2420_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_h4_2420_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_h4_2420_defconfig-  CC      net/In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_h4_2420_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_h4_2420_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_h4_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_h4_2420_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_innovator_1510_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-omap_innovator_1510_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-omap_innovator_1510_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
--
/tmp/build-omap_innovator_1510_defconfig-                 from arch/arm/mach-omap1/board-innovator.c:35:
/tmp/build-omap_innovator_1510_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-omap_innovator_1510_defconfig-In file included from arch/arm/mach-omap1/board-innovator.c:40:
/tmp/build-omap_innovator_1510_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
/tmp/build-omap_innovator_1510_defconfig:arch/arm/mach-omap1/board-innovator.c:162: warning: initialization makes integer from pointer without a cast
--
/tmp/build-omap_innovator_1510_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_innovator_1510_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_innovator_1510_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_innovator_1510_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_innovator_1510_defconfig-  CC In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_innovator_1510_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_innovator_1510_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_innovator_1510_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_innovator_1510_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_innovator_1610_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-omap_innovator_1610_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-omap_innovator_1610_defconfig-                 from arch/arm/mach-omap1/board-innovator.c:35:
/tmp/build-omap_innovator_1610_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-omap_innovator_1610_defconfig-In file included from arch/arm/mach-omap1/board-innovator.c:40:
/tmp/build-omap_innovator_1610_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_innovator_1610_defconfig-  CC  drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_innovator_1610_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_innovator_1610_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_innovator_1610_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_innovator_1610_defconfig-In file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_innovator_1610_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_innovator_1610_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_innovator_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_innovator_1610_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_ldp_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_ldp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_ldp_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap_ldp_defconfig-  CC      mdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_ldp_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_ldp_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_ldp_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_ldp_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_ldp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_ldp_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_osk_5912_defconfig-  CCdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_osk_5912_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_osk_5912_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_osk_5912_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_osk_5912_defconfig-  CC      net/sunrpc/autIn file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_osk_5912_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_osk_5912_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_osk_5912_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_osk_5912_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_perseus2_730_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_perseus2_730_defconfig:arch/arm/mach-omap1/pm.c:120:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle
/tmp/build-omap_perseus2_730_defconfig-In file included from arch/arm/mach-omap1/board-perseus2.c:35:
/tmp/build-omap_perseus2_730_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
/tmp/build-omap_perseus2_730_defconfig:arch/arm/mach-omap1/board-perseus2.c:290: warning: initialization makes integer from pointer without a cast
--
/tmp/build-omap_perseus2_730_defconfig-  Cdrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_perseus2_730_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_perseus2_730_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_perseus2_730_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_perseus2_730_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_perseus2_730_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_perseus2_730_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-omap_perseus2_730_defconfig-  CC      drivers/char/defkeymap.oIn file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-omap_perseus2_730_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-omap_zoom2_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-omap_zoom2_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-omap_zoom2_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-omap_zoom2_defconfig-  CC drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-omap_zoom2_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-omap_zoom2_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-omap_zoom2_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-omap_zoom2_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-omap_zoom2_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-omap_zoom2_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-overo_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-overo_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-overo_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-overo_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-overo_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-overo_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-overo_defconfig-  CC   drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-overo_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-overo_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-overo_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-palmte_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-palmte_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-palmte_defconfig-                 from arch/arm/mach-omap1/board-palmte.c:37:
/tmp/build-palmte_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-palmte_defconfig-In file included from arch/arm/mach-omap1/board-palmte.c:44:
/tmp/build-palmte_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
/tmp/build-palmte_defconfig:arch/arm/mach-omap1/board-palmte.c:315: warning: 'palmte_headphones_detect' defined but not used
--
/tmp/build-palmte_defconfig-  CC      mm/pagewaldrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-palmte_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-palmte_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-palmte_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-palmte_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-palmte_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-palmte_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-palmtt_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-palmtt_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-palmtt_defconfig-                 from arch/arm/mach-omap1/board-palmtt.c:34:
/tmp/build-palmtt_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-palmtt_defconfig-In file included from arch/arm/mach-omap1/board-palmtt.c:41:
/tmp/build-palmtt_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-palmtt_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-palmtt_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-palmtt_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-palmtt_defconfig-  LD drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-palmtt_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-palmtt_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-palmtt_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-palmz71_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-palmz71_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-palmz71_defconfig-                 from arch/arm/mach-omap1/board-palmz71.c:36:
/tmp/build-palmz71_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-palmz71_defconfig-In file included from arch/arm/mach-omap1/board-palmz71.c:43:
/tmp/build-palmz71_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-palmz71_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-palmz71_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-palmz71_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/build-palmz71_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-palmz71_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-palmz71_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-palmz71_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-rx51_defconfig-Building kernel for asdf board with: ARCH=arm CROSS_COMPILE="ccache /opt/arm-2009q1/bin/arm-none-linux-gnueabi-" INSTALL_MOD_PATH=/tmp make -j16 uImage
/tmp/build-rx51_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
/tmp/build-rx51_defconfig:arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
--
/tmp/build-rx51_defconfig-  CC      drivedrivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-rx51_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-rx51_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-rx51_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-rx51_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-rx51_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-rx51_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
--
/tmp/build-sx1_defconfig-In file included from arch/arm/mach-omap1/flash.c:10:
/tmp/build-sx1_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
--
/tmp/build-sx1_defconfig-                 from arch/arm/mach-omap1/board-sx1.c:36:
/tmp/build-sx1_defconfig:include/linux/mtd/map.h:127:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
/tmp/build-sx1_defconfig-In file included from arch/arm/mach-omap1/board-sx1.c:44:
/tmp/build-sx1_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-sx1_defconfig- drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_fixed_flag':
/tmp/build-sx1_defconfig:drivers/char/tty_buffer.c:251: warning: comparison of distinct pointer types lacks a cast
/tmp/build-sx1_defconfig-drivers/char/tty_buffer.c: In function 'tty_insert_flip_string_flags':
/tmp/build-sx1_defconfig:drivers/char/tty_buffer.c:288: warning: comparison of distinct pointer types lacks a cast
/tmp/build-sx1_defconfig-mm/slob.c: In function '__kmalloc_node':
/tmp/build-sx1_defconfig:mm/slob.c:481: warning: comparison of distinct pointer types lacks a cast
/tmp/build-sx1_defconfig-mm/slob.c: In function 'kfree':
/tmp/build-sx1_defconfig:mm/slob.c:530: warning: comparison of distinct pointer types lacks a cast
/tmp/build-sx1_defconfig-mm/slob.c: In function 'ksize':
/tmp/build-sx1_defconfig:mm/slob.c:549: warning: comparison of distinct pointer types lacks a cast
--
/tmp/build-sx1_defconfig-  CC      nIn file included from drivers/input/keyboard/omap-keypad.c:38:
/tmp/build-sx1_defconfig:arch/arm/plat-omap/include/plat/keypad.h:13:2: warning: #warning : Please update the board to use matrix_keypad.h instead
--
/tmp/build-sx1_defconfig-                 from kernel/elfcore.c:2:
/tmp/build-sx1_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/build-sx1_defconfig:/home/tmlind/src/linux-2.6/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want

--neYutvxvOLaeuPCA--
