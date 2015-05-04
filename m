From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: EDMA oftree entry for AM335x
Date: Mon, 4 May 2015 23:11:50 +0200
Message-ID: <20150504211150.GU15254@pengutronix.de>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60969 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbEDVLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 17:11:52 -0400
Content-Disposition: inline
In-Reply-To: <20150504141103.GD24469@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

Hi Tony,

On Mon, May 04, 2015 at 07:11:03AM -0700, Tony Lindgren wrote:
> Adding Peter to Cc as well.

You didn't :)
 
> > The patch description says the device should be split into more devices instead
> > of specifying several ti,hwmods entries, but unfortunately the Documentation
> > still suggests the above format in Documentation/devicetree/bindings/dma/ti-edma.txt.
> > 
> > How would a correct entry look like?
> 
> Each tptc instance has it's own sysconfig register. This means each
> one of them can be clocked and idled independently. They should be
> treated as separate device instances. I believe the interrupts all
> belong to the tpcc, which should be also treated as a separate
> device instance.
> 
> In order to get rid of the ti,hwmods property, we want to have a
> 1-1-1 mapping of the compatible property, ti,hwmod property, and
> the device entry.
> 
> Looking at the TRM "Table 2-1. L3 Memory Map", these all are on
> the L3, so they should be like this for now (assuming the
> interrupts all belong to tpcc):
> 
> ocp {
> 	...
> 
> 	edma: tpcc@49000000 {
> 		compatible = "ti,edma3";
> 		ti,hwmods = "tpcc"; 
> 		reg = <0x49000000 0x10000>;
> 		interrupts = <12 13 14>;
> 		#dma-cells = <1>;
> 	};
> 
> 	tptc0: tptc@49800000 {
> 		compatible = "ti,tptc3";
> 		ti,hwmods = "tptc0";
> 		reg = <0x49800000 0x10000>;
> 	};
> 
> 	tptc1: tptc@49900000 {
> 		compatible = "ti,tptc3";
> 		ti,hwmods = "tptc1";
> 		reg = <0x49900000 0x10000>;
> 	};
> 
> 	tptc2: tptc@49a00000 {
> 		compatible = "ti,tptc3";
> 		ti,hwmods = "tptc2";
> 		reg = <0x49a00000 0x10000>;
> 	};
> 	...
> };

I tried this, with the patch below, but it doesn't work:

----------8<---------- Output with 4.1-rc1 vanilla ----------8<----------

Loading ARM Linux zImage '/mnt/mmc0.1//boot/zImage'
Loading devicetree from '/mnt/mmc0.1//boot/am335x-afi-gf.dtb'
commandline: console=ttyO2,115200n8     root=/dev/mmcblk0p2 rootfstype=ext4 rootwait loglevel=6
[    0.000000] Linux version 4.1.0-rc1 (rsc@callisto) (gcc version 4.8.3 20131111 (prerelease) (OSELAS.Toolchain-2013.12.2 linaro-4.8-2013.11) ) #9 PREEMPT Mon May 4 22:24:41 CEST 2015
[    0.000000] earlycon: no match for ttyO2,115200n8
[    0.000000] Kernel command line: console=ttyO2,115200n8     root=/dev/mmcblk0p2 rootfstype=ext4 rootwait loglevel=6
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0674ed4   (6580 kB)
[    0.000000]       .init : 0xc0675000 - 0xc06b2000   ( 244 kB)
[    0.000000]       .data : 0xc06b2000 - 0xc06fd3e8   ( 301 kB)
[    0.000000]        .bss : 0xc0700000 - 0xc073a5d8   ( 234 kB)
[    0.145038] omap_hwmod: tptc0 using broken dt data from edma
[    0.145247] omap_hwmod: tptc1 using broken dt data from edma
[    0.145425] omap_hwmod: tptc2 using broken dt data from edma
[    0.151051] omap_hwmod: debugss: _wait_target_disable failed
[    0.323079] SCSI subsystem initialized
[    0.356218] NFS: Registering the id_resolver key type
[    0.356339] Key type id_resolver registered
[    0.356354] Key type id_legacy registered
[    0.518782] 47401300.usb-phy supply vcc not found, using dummy regulator
[    0.532356] 47401b00.usb-phy supply vcc not found, using dummy regulator
[    0.554370] Key type dns_resolver registered
[    0.559333] omap_voltage_late_init: Voltage driver support not added
[    0.775905] mmc0: host does not support reading read-only switch, assuming write-enable
[    1.140875] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_vrise (80, <SessEnd), retry #3, port1 0008010c
[    1.561977] random: systemd urandom read with 17 bits of entropy available

Welcome to PTXdist / af inventions-GF!

<userspace starts>

----------8<---------- Output with patch ----------8<----------

[    0.000000] Linux version 4.1.0-rc1+ (rsc@callisto) (gcc version 4.8.3 20131111 (prerelease) (OSELAS.Toolchain-2013.12.2 linaro-4.8-2013.11) ) #10 PREEMPT Mon May 4 23:03:27 CEST 2015
[    0.000000] earlycon: no match for ttyO2,115200n8
[    0.000000] Kernel command line: console=ttyO2,115200n8     root=/dev/mmcblk0p2 rootfstype=ext4 rootwait loglevel=6
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0674ed4   (6580 kB)
[    0.000000]       .init : 0xc0675000 - 0xc06b2000   ( 244 kB)
[    0.000000]       .data : 0xc06b2000 - 0xc06fd3e8   ( 301 kB)
[    0.000000]        .bss : 0xc0700000 - 0xc073a5d8   ( 234 kB)
[    0.151101] omap_hwmod: debugss: _wait_target_disable failed
[    0.278517] edma 49000000.tpcc: failed to get DT data
[    0.278670] edma: probe of 49000000.tpcc failed with error -12
[    0.312864] SCSI subsystem initialized
[    0.345860] NFS: Registering the id_resolver key type
[    0.345977] Key type id_resolver registered
[    0.345992] Key type id_legacy registered
[    0.493001] spi spi1.0: not using DMA for McSPI
[    0.498211] spi spi1.1: not using DMA for McSPI
[    0.511199] 47401300.usb-phy supply vcc not found, using dummy regulator
[    0.524715] 47401b00.usb-phy supply vcc not found, using dummy regulator
[    0.546556] Key type dns_resolver registered
[    0.551522] omap_voltage_late_init: Voltage driver support not added
[    0.644175] omap_hsmmc 48060000.mmc: unable to obtain RX DMA engine channel 3473832464
[    1.133193] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_vrise (80, <SessEnd), retry #3, port1 0008010c

<hangs>

----------8<---------- patch ----------8<----------

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 21fcc44..34eb437 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -156,15 +156,32 @@
 			reg = <0x48200000 0x1000>;
 		};
 
-		edma: edma@49000000 {
+		edma: tpcc@49000000 {
 			compatible = "ti,edma3";
-			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
-			reg =	<0x49000000 0x10000>,
-				<0x44e10f90 0x40>;
+			ti,hwmods = "tpcc";
+			reg = <0x49000000 0x10000>;
 			interrupts = <12 13 14>;
 			#dma-cells = <1>;
 		};
 
+		tptc0: tptc@49800000 {
+			compatible = "ti,tptc3";
+			ti,hwmods = "tptc0";
+			reg = <0x49800000 0x10000>;
+		};
+
+		tptc1: tptc@49900000 {
+			compatible = "ti,tptc3";
+			ti,hwmods = "tptc1";
+			reg = <0x49900000 0x10000>;
+		};
+
+		tptc2: tptc@49a00000 {
+			compatible = "ti,tptc3";
+			ti,hwmods = "tptc2";
+			reg = <0x49a00000 0x10000>;
+		};
+
 		gpio0: gpio@44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
