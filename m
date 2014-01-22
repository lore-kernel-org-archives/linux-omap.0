From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v2 0/5] ARM: add omap3 INCOstartec board support
Date: Wed, 22 Jan 2014 20:04:15 +0100
Message-ID: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:64269 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbaAVTEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 14:04:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This set of patches adds board support for an omap3 system from INCOstartec.
It's based on next-20140122.

Previously it was based on next-20140115. There, everything works as expected.

On branch git://git.linaro.org/people/ulf.hansson/clk.git linaro_clk/clk-next
which holdes all "clock DT conversion" commits, bootlog shows these abnormalities:

  [    0.559600] ------------[ cut here ]------------
  [    0.559631] WARNING: CPU: 0 PID: 1 at /home/honschu/media/linux/drivers/video/omap2/dss/dss.c:540 dss_set_clock_div+0xac/0xcc()
  [    0.559661] clk rate mismatch: 345600000 != 172800000
  [    0.559661] Modules linked in:
  [    0.559692] CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc7+ 0
  [    0.559722] [<c0012fc4>] (unwind_backtrace+0x0/0xf8) from [<c0010e10>] (show_stack+0x10/0x14)
  [    0.559753] [<c0010e10>] (show_stack+0x10/0x14) from [<c0033fdc>] (warn_slowpath_common+0x64/0x84)
  [    0.559783] [<c0033fdc>] (warn_slowpath_common+0x64/0x84) from [<c0034090>] (warn_slowpath_fmt+0x30/0x40)
  [    0.559814] [<c0034090>] (warn_slowpath_fmt+0x30/0x40) from [<c02b23c0>] (dss_set_clock_div+0xac/0xcc)
  [    0.559844] [<c02b23c0>] (dss_set_clock_div+0xac/0xcc) from [<c0778f48>] (omap_dsshw_probe+0x1ec/0x2e0)
  [    0.559875] [<c0778f48>] (omap_dsshw_probe+0x1ec/0x2e0) from [<c02ff360>] (platform_drv_probe+0x18/0x48)
  [    0.559906] [<c02ff360>] (platform_drv_probe+0x18/0x48) from [<c02fdf84>] (driver_probe_device+0x110/0x230)
  [    0.559936] [<c02fdf84>] (driver_probe_device+0x110/0x230) from [<c02fe138>] (__driver_attach+0x94/0x98)
  [    0.559967] [<c02fe138>] (__driver_attach+0x94/0x98) from [<c02fc724>] (bus_for_each_dev+0x54/0x88)
  [    0.559997] [<c02fc724>] (bus_for_each_dev+0x54/0x88) from [<c02fd720>] (bus_add_driver+0xd4/0x1d0)
  [    0.559997] [<c02fd720>] (bus_add_driver+0xd4/0x1d0) from [<c02fe76c>] (driver_register+0x78/0xf4)
  [    0.560028] [<c02fe76c>] (driver_register+0x78/0xf4) from [<c02ff2c4>] (platform_driver_probe+0x20/0xa4)
  [    0.560058] [<c02ff2c4>] (platform_driver_probe+0x20/0xa4) from [<c0778ce0>] (omap_dss_init+0x1c/0x98)
  [    0.560089] [<c0778ce0>] (omap_dss_init+0x1c/0x98) from [<c0008828>] (do_one_initcall+0xe4/0x144)
  [    0.560119] [<c0008828>] (do_one_initcall+0xe4/0x144) from [<c075eadc>] (kernel_init_freeable+0xe8/0x1b0)
  [    0.560150] [<c075eadc>] (kernel_init_freeable+0xe8/0x1b0) from [<c05522bc>] (kernel_init+0x8/0x118)
  [    0.560180] [<c05522bc>] (kernel_init+0x8/0x118) from [<c000e4c8>] (ret_from_fork+0x14/0x2c)
  [    0.560302] ---[ end trace 187e8d9dd0655394 ]---
  [    0.560424] OMAP DSS rev 2.0
  --snip--
  [    2.601745] usb 1-1: new high-speed USB device number 2 using ehci-omap
  [    2.767059] usb 1-1: device descriptor read/64, error -71
  [    3.007934] usb 1-1: device descriptor read/64, error -71
  [    3.237091] usb 1-1: new high-speed USB device number 3 using ehci-omap
  [    3.387054] usb 1-1: device descriptor read/64, error -71
  [    3.637054] usb 1-1: device descriptor read/64, error -71
  [    3.867065] usb 1-1: new high-speed USB device number 4 using ehci-omap
  [    4.296966] usb 1-1: device not accepting address 4, error -71
  [    4.417053] usb 1-1: new high-speed USB device number 5 using ehci-omap
  [    4.846954] usb 1-1: device not accepting address 5, error -71
  [    4.853179] hub 1-0:1.0: unable to enumerate USB device on port 1
  [    5.217041] usb 2-1: new full-speed USB device number 2 using ohci-omap3
  [    5.407043] usb 2-1: device descriptor read/64, error -62
  [    5.697052] usb 2-1: device descriptor read/64, error -62
  [    5.987060] usb 2-1: new full-speed USB device number 3 using ohci-omap3
  [    6.066955] .[    6.177062] usb 2-1: device descriptor read/64, error -62
  [    6.467041] usb 2-1: device descriptor read/64, error -62
  [    6.757049] usb 2-1: new full-speed USB device number 4 using ohci-omap3
  [    7.176971] usb 2-1: device not accepting address 4, error -62
  [    7.357055] usb 2-1: new full-speed USB device number 5 using ohci-omap3
  [    7.776977] usb 2-1: device not accepting address 5, error -62
  [    7.783233] hub 2-0:1.0: unable to enumerate USB device on port 1

On next-20140122 the tps65930 (which should be compatible to twl4030) doesn't
set voltage on IO.1P8 any more which leads to a lot of external subsystem
failings like dss:

[    0.602264] omapdss_dss: probe of omapdss_dss failed with error -22
[    0.602691] omapdss CORE error: Failed to initialize DSS platform driver
[    0.603240] panel-dpi panel-dpi.0: failed to find video source 'dpi.0'

Changes compared to previous version:
 - rebased on next-20140122 from next-20140115
 - using omap36xx.dtsi instead of unsupported 1ghz omap37xx100

Christoph Fritz (5):
  ARM: dts: omap3: Add support for INCOstartec a83x module
  ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
  ARM: OMAP2+: add legacy display for omap3 DBB056
  ARM: OMAP2+: Add pdata quirk for sys_clkout2 for omap3 DBB056
  [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from omap3

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi  |  445 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  160 +++++++++++
 arch/arm/mach-omap2/dss-common.c         |   49 ++++
 arch/arm/mach-omap2/dss-common.h         |    1 +
 arch/arm/mach-omap2/pdata-quirks.c       |   44 ++-
 drivers/video/omap2/dss/dss_features.c   |    1 -
 7 files changed, 699 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-lilly-a83x.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-lilly-dbb056.dts

-- 
1.7.10.4

