From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v4 0/4] OMAP System Control Module
Date: Wed, 25 Jul 2012 15:05:09 +0400
Message-ID: <500FD2E5.2050406@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900000105090502060900"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58790 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754155Ab2GYLFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 07:05:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This is a multi-part message in MIME format.
--------------020900000105090502060900
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

 Hello.

This is a next version of series of patches(based on Eduardo Valentin's patch set) adding a basic support for system control module, on OMAP4+ context.
As Bandgap and usb phy drivers are now independent from control module driver and they will be sent separately. IIUC, Bandgap driver has already been sent.

OMAP system control module driver provides only one API function - read of CONTROL_STATUS register:
u32 omap_control_status_read(void) that is used in omap_type()

The physical address of CONTROL_STATUS register is specified in DT:
ctrl_module_core: ctrl_module_core@4A0022C4 {
	compatible = "ti,omap4-control";
	#address-cells = <1>;
	#size-cells = <1>;
	/* ranges; */
	ti,hwmods = "ctrl_module_core";
	reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
};

Eduardo Valentin (3):
  From d4c6cf571e403f30a97db32ba6198b0c35a864b7 Mon Sep 17 00:00:00
    2001
  From 116a0111a6e2e563a81b0aa2dbf7a18e9ef9dbd1 Mon Sep 17 00:00:00
    2001
  From dda5f1badbfb82718c9ff21098998a842ce6886e Mon Sep 17 00:00:00
    2001

Santosh Shilimkar (1):
  From 1c2af619cc34aafc027330fbb823595e3b2d139b Mon Sep 17 00:00:00
    2001

 .../devicetree/bindings/mfd/omap_control.txt       |   32 +
 arch/arm/boot/dts/omap4.dtsi                       |   10 +
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/control.h                      |   48 +-
 arch/arm/mach-omap2/id.c                           |   11 +-
 .../include/mach/ctrl_module_core_44xx.h           |  392 ------
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 --------------------
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ----
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 --
 arch/arm/plat-omap/Kconfig                         |    4 +
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/omap-control-core.c                    |  162 +++
 include/linux/mfd/omap_control.h                   |   35 +
 14 files changed, 300 insertions(+), 2139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
 delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
 create mode 100644 drivers/mfd/omap-control-core.c
 create mode 100644 include/linux/mfd/omap_control.h

-- 
1.7.7.6


--------------020900000105090502060900
Content-Type: text/plain; charset=UTF-8;
 name="Attached Message Part"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part"


--------------020900000105090502060900--
