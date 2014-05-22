From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 1/5] [RFC-HACK] pinctrl-single: init by postcore_initcall()
Date: Fri, 23 May 2014 01:06:22 +0200
Message-ID: <1400799986-20043-2-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:38964 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaEVXGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:06:54 -0400
Received: by mail-la0-f53.google.com with SMTP id ty20so1720231lab.40
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:06:53 -0700 (PDT)
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Init pinctrl-single as postcore, because without this patch omap_gpio is
deferring probe which results in more deferring and finally NFS-Boot
doesn't work.

Diff of bootlog with (good) and without (fail) this patch:

--- good
+++ fail
@@ -60,15 +60,22 @@
 cpuidle: using governor ladder
 cpuidle: using governor menu
 Reprogramming SDRC clock to 400000000 Hz
-pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
-pinctrl-single 48002030.pinmux: 282 pins at pa fa002030 size 564
-pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
+omap_gpio 48310000.gpio: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_gpio1_pins, deferring probe
+platform 48310000.gpio: Driver omap_gpio requests probe deferral
 OMAP GPIO hardware version 2.5
+omap_gpio 49054000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_gpio4_pins, deferring probe
+platform 49054000.gpio: Driver omap_gpio requests probe deferral
+omap_gpio 49056000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_gpio5_pins, deferring probe
+platform 49056000.gpio: Driver omap_gpio requests probe deferral
+omap_gpio 49058000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb1_pins, deferring probe
+platform 49058000.gpio: Driver omap_gpio requests probe deferral
 platform 49022000.mcbsp: alias fck already exists
 omap-gpmc 6e000000.gpmc: GPMC revision 5.0
 gpmc_probe_nand_child: ti,elm-id property not found
 gpmc_read_settings_dt: page/burst-length set but not used!
 gpmc_read_settings_dt: read/write wait monitoring not enabled!
+irq: no irq domain found for /ocp/gpio@49056000 !
+irq: no irq domain found for /ocp/gpio@49054000 !
 omap3_dbb056_legacy_init: Late Reparent clkout2 to 96M_FCK
 omap3_dbb056_legacy_init: Set clkout2 to 24MHz for internal usb hub
 No ATAGs?
@@ -82,9 +89,14 @@
 usbcore: registered new interface driver usbfs
 usbcore: registered new interface driver hub
 usbcore: registered new device driver usb
-omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
-omap_i2c 48072000.i2c: bus 1 rev4.4 at 2600 kHz
-omap_i2c 48060000.i2c: bus 2 rev4.4 at 2600 kHz
+musb-omap2430 480ab000.usb_otg_hs: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb_otg_pins, deferring probe
+platform 480ab000.usb_otg_hs: Driver musb-omap2430 requests probe deferral
+omap_i2c 48070000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c1_pins, deferring probe
+platform 48070000.i2c: Driver omap_i2c requests probe deferral
+omap_i2c 48072000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c2_pins, deferring probe
+platform 48072000.i2c: Driver omap_i2c requests probe deferral
+omap_i2c 48060000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c3_pins, deferring probe
+platform 48060000.i2c: Driver omap_i2c requests probe deferral
 pps_core: LinuxPPS API ver. 1 registered
 pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
 PTP clock support registered
@@ -103,6 +115,8 @@
 RPC: Registered udp transport module.
 RPC: Registered tcp transport module.
 RPC: Registered tcp NFSv4.1 backchannel transport module.
+usbhs_omap 48064000.usbhshost: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_hsusb1_2_pins, deferring probe
+platform 48064000.usbhshost: Driver usbhs_omap requests probe deferral
 hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
 futex hash table entries: 16 (order: -3, 704 bytes)
 VFS: Disk quotas dquot_6.5.2
@@ -116,10 +130,14 @@
 io scheduler noop registered
 io scheduler deadline registered
 io scheduler cfq registered (default)
+pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
+pinctrl-single 48002030.pinmux: 282 pins at pa fa002030 size 564
+pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
 OMAP DSS rev 2.0
-omapdss_dpi.0 supply vdds_dsi not found, using dummy regulator
-Console: switching to colour frame buffer device 80x30
-omapfb omapfb: using display 'lcd' mode 640x480
+platform panel-dpi.0: Driver panel-dpi requests probe deferral
+omapfb omapfb: no displays
+omapfb omapfb: failed to setup omapfb
+platform omapfb: Driver omapfb requests probe deferral
 Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
 omap_uart 4806a000.serial: no wakeirq for uart0
 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
@@ -130,28 +148,6 @@
 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
 brd: module loaded
 loop: module loaded
-twl 0-0048: PIH (irq 23) chaining IRQs 338..346
-twl 0-0048: power (irq 343) chaining IRQs 346..353
-VAUX1: at 3000 mV
-VAUX2_4030: 2800 mV
-VAUX3: at 2800 mV
-VAUX4: at 2800 mV
-VDD1: 600 <--> 1450 mV at 1200 mV
-VDAC: 1800 mV
-VIO: at 1800 mV
-VINTANA1: 1500 mV
-VINTANA2: at 2750 mV
-VINTDIG: 1500 mV
-VMMC1: 1850 <--> 3150 mV at 3000 mV
-VMMC2: 1850 <--> 3150 mV at 2600 mV
-VUSB1V5: 1500 mV
-VUSB1V8: 1800 mV
-VUSB3V1: 3100 mV
-VPLL1: at 1800 mV
-VPLL2: 1800 mV
-VSIM: 1800 <--> 3000 mV at 1800 mV
-twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs 354..371
-twl4030_usb twl4030-usb.29: Initialized TWL4030 USB module
 mtdoops: mtd device (mtddev=name/number) must be supplied
 nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xba
 nand: Micron MT29F2G16ABBEAHC
@@ -164,67 +160,28 @@
 0x000000260000-0x000000280000 : "u-boot-environment"
 0x000000280000-0x000000780000 : "kernel"
 0x000000780000-0x000010000000 : "filesystem"
+irq: no irq domain found for /ocp/gpio@48310000 !
 CAN device driver interface
 sja1000 CAN netdevice driver
-libphy: smsc911x-mdio: probed
-smsc911x 15000000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=15000000.etherne:01, irq=-1)
-smsc911x 15000000.ethernet eth0: MAC Address: e2:cc:98:d3:c6:56
-libphy: smsc911x-mdio: probed
-smsc911x 20000000.ethernet eth1: attached PHY driver [Generic PHY] (mii_bus:phy_addr=20000000.etherne:01, irq=-1)
-smsc911x 20000000.ethernet eth1: MAC Address: 00:50:c2:0d:6a:63
+smsc911x: Could not allocate irq resource
+smsc911x: Could not allocate irq resource
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 ehci-omap: OMAP-EHCI Host Controller driver
-ehci-omap 48064800.ehci: EHCI Host Controller
-ehci-omap 48064800.ehci: new USB bus registered, assigned bus number 1
-ehci-omap 48064800.ehci: irq 93, io mem 0x48064800
-ehci-omap 48064800.ehci: USB 2.0 started, EHCI 1.00
-usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
-usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
-usb usb1: Product: EHCI Host Controller
-usb usb1: Manufacturer: Linux 3.15.0-rc6+ ehci_hcd
-usb usb1: SerialNumber: 48064800.ehci
-hub 1-0:1.0: USB hub found
-hub 1-0:1.0: 3 ports detected
 ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
 ohci-omap3: OHCI OMAP3 driver
-ohci-omap3 48064400.ohci: OHCI Host Controller
-ohci-omap3 48064400.ohci: new USB bus registered, assigned bus number 2
-ohci-omap3 48064400.ohci: irq 92, io mem 0x48064400
-usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
-usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
-usb usb2: Product: OHCI Host Controller
-usb usb2: Manufacturer: Linux 3.15.0-rc6+ ohci_hcd
-usb usb2: SerialNumber: 48064400.ohci
-hub 2-0:1.0: USB hub found
-hub 2-0:1.0: 3 ports detected
 usbcore: registered new interface driver usb-storage
-musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
-musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 3
-usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
-usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
-usb usb3: Product: MUSB HDRC host driver
-usb usb3: Manufacturer: Linux 3.15.0-rc6+ musb-hcd
-usb usb3: SerialNumber: musb-hdrc.0.auto
-hub 3-0:1.0: USB hub found
-hub 3-0:1.0: 1 port detected
 mousedev: PS/2 mouse device common for all mice
-ads7846 spi2.0: touchscreen, irq 120
-input: ADS7846 Touchscreen as /devices/68000000.ocp/4809a000.spi/spi_master/spi2/spi2.0/input/input0
-twl_rtc rtc.8: Power up reset detected.
-twl_rtc rtc.8: Enabling TWL-RTC
-twl_rtc rtc.8: rtc core: registered rtc.8 as rtc0
+ads7846: probe of spi2.0 failed with error -22
 i2c /dev entries driver
-usb 1-1: new high-speed USB device number 2 using ehci-omap
 omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
-VMMC1: Restricting voltage, 3100000-1950000uV
-omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
+platform 4809c000.mmc: Driver omap_hsmmc requests probe deferral
+platform 480b4000.mmc: Driver omap_hsmmc requests probe deferral
+platform leds.3: Driver leds-gpio requests probe deferral
 usbcore: registered new interface driver usbhid
 usbhid: USB HID core driver
-usb 1-1: New USB device found, idVendor=0424, idProduct=2512
-usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
-hub 1-1:1.0: USB hub found
-hub 1-1:1.0: 2 ports detected
-omap-twl4030 sound.4: twl4030-hifi <-> 49022000.mcbsp mapping ok
+omap-twl4030 sound.4: ASoC: CODEC twl4030-codec not registered
+omap-twl4030 sound.4: devm_snd_soc_register_card() failed: -517
+platform sound.4: Driver omap-twl4030 requests probe deferral
 TCP: cubic registered
 Initializing XFRM netlink socket
 NET: Registered protocol family 17
@@ -238,7 +195,61 @@
 ThumbEE CPU extension supported.
 Registering SWP/SWPB emulation handler
 registered taskstats version 1
-twl_rtc rtc.8: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
-smsc911x 15000000.ethernet eth0: SMSC911x/921x identified at 0xc8856000, IRQ: 241
-smsc911x 20000000.ethernet eth1: SMSC911x/921x identified at 0xc8858000, IRQ: 210
-Sending DHCP requests ...
+HS USB OTG: no transceiver configured
+musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
+platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
+twl 0-0048: PIH (irq 23) chaining IRQs 338..346
+twl 0-0048: power (irq 343) chaining IRQs 346..353
+twl_rtc rtc.8: Enabling TWL-RTC
+twl_rtc rtc.8: rtc core: registered rtc.8 as rtc0
+VAUX1: at 3000 mV
+VAUX2_4030: 2800 mV
+VAUX3: at 2800 mV
+VAUX4: at 2800 mV
+VDD1: 600 <--> 1450 mV at 1200 mV
+VDAC: 1800 mV
+VIO: at 1800 mV
+VINTANA1: 1500 mV
+VINTANA2: at 2750 mV
+VINTDIG: 1500 mV
+VMMC1: 1850 <--> 3150 mV at 3150 mV
+VMMC2: 1850 <--> 3150 mV at 2600 mV
+VUSB1V5: 1500 mV
+VUSB1V8: 1800 mV
+VUSB3V1: 3100 mV
+VPLL1: at 1800 mV
+VPLL2: 1800 mV
+VSIM: 1800 <--> 3000 mV at 1800 mV
+twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs 354..371
+twl4030_usb twl4030-usb.29: Initialized TWL4030 USB module
+omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
+omap_i2c 48072000.i2c: bus 1 rev4.4 at 2600 kHz
+omap_i2c 48060000.i2c: bus 2 rev4.4 at 2600 kHz
+omapdss_dpi.0 supply vdds_dsi not found, using dummy regulator
+Console: switching to colour frame buffer device 80x30
+omapfb omapfb: using display 'lcd' mode 640x480
+VMMC1: Restricting voltage, 3100000-1950000uV
+omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
+omap-twl4030 sound.4: twl4030-hifi <-> 49022000.mcbsp mapping ok
+musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
+musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
+usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
+usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
+usb usb1: Product: MUSB HDRC host driver
+usb usb1: Manufacturer: Linux 3.15.0-rc6+ musb-hcd
+usb usb1: SerialNumber: musb-hdrc.0.auto
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 1 port detected
+twl_rtc rtc.8: setting system clock to 2000-01-01 00:18:06 UTC (946685886)
+ALSA device list:
+  #0: lilly-a83x
+Root-NFS: no NFS server address
+VFS: Unable to mount root fs via NFS, trying floppy.
+VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
+Please append a correct "root=" boot option; here are the available partitions:
+1f00             512 mtdblock0  (driver?)
+1f01            1920 mtdblock1  (driver?)
+1f02             128 mtdblock2  (driver?)
+1f03            5120 mtdblock3  (driver?)
+1f04          254464 mtdblock4  (driver?)
+Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
See Bootlog:
---
 drivers/pinctrl/pinctrl-single.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 2960557..8582f29 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -2069,7 +2069,22 @@ static struct platform_driver pcs_driver = {
 #endif
 };
 
+#ifdef CONFIG_USE_OF
+static int __init pcs_driver_drv_init(void)
+{
+       return platform_driver_register(&pcs_driver);
+}
+postcore_initcall(pcs_driver_drv_init);
+
+static void __exit pcs_driver_drv_exit(void)
+{
+       platform_driver_unregister(&pcs_driver);
+}
+module_exit(pcs_driver_drv_exit);
+#else
 module_platform_driver(pcs_driver);
+#endif
+
 
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
-- 
1.7.10.4

