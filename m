From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 00/23] OMAP4: big endian support and fixes
Date: Sat, 16 Nov 2013 02:01:03 +0200
Message-ID: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:62505 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3KPABd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 19:01:33 -0500
Received: by mail-ee0-f44.google.com with SMTP id d51so1390367eek.17
        for <linux-omap@vger.kernel.org>; Fri, 15 Nov 2013 16:01:32 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org

This series is a split up of Victor's initial BE series for Pandaboard.

The first 20 patches are trivial replacement of __raw_xxx functions
with xxx_relaxed endian neutral variant.
Patches #1-#16 covers OMAP drivers in 'drivers' and 'sound' directories.
Patch #17 covers 'mach-omap2' directory. Initially I've split
it into 10+ separate patches, but it didn't look like a good idea.
Patches #18-#20 covers 'plat-omap'. Some code here most probably won't
be used in BE mode (like debug-leds for OMAP1 boards), but changes
are made anyway to remove __raw_xxx() functions completely from
'mach-omap2' and 'plat-omap'. This will simplify future grep'ing for
new __raw_xxx() entries.

Patch #21 fixes LE data handling in assembler code.
Patch #22 switches CPU to BE after it returns from ROM code.
And the last one marks OMAP4 as BE ready.

Based on rmk/for-next commit fb95742a4a4f69323950d6d8f68bcb48c947b91f
Tested on Pandaboard (OMAP4430 and OMAP4460 variants).

Victor Kamensky (23):
  gpio/omap: raw read and write endian fix
  watchdog: omap_wdt: raw read and write endian fix
  OMAPDSS: raw read and write endian fix
  mmc: omap: raw read and write endian fix
  i2c: omap: raw read and write endian fix
  drivers: bus: omap_l3: raw read and write endian fix
  hwrng: omap - raw read and write endian fix
  crypto: omap-aes - raw read and write endian fix
  crypto: omap-sham - raw read and write endian fix
  Input: omap-keypad - raw read and write endian fix
  mfd: omap-usb-host: raw read and write endian fix
  mfd: omap-usb-tll: raw read and write endian fix
  spi: omap2-mcspi: raw read and write endian fix
  USB: ehci-omap: raw read and write endian fix
  usb: musb: raw read and write endian fix
  ASoC: omap: mcbsp, mcpdm, dmic: raw read and write endian fix
  ARM: OMAP2+: raw read and write endian fix
  ARM: OMAP: dmtimer: raw read and write endian fix
  ARM: OMAP: counter-32k: raw read and write endian fix
  ARM: OMAP: debug-leds: raw read and write endian fix
  ARM: OMAP4: sleep: byteswap data for big-endian
  ARM: OMAP4: sleep/smp: switch CPU to BE if compiled for BE
  ARM: OMAP4: enable big endian support

 arch/arm/mach-omap2/Kconfig               |    1 +
 arch/arm/mach-omap2/board-flash.c         |    4 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c   |    2 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c        |    8 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c        |    2 +-
 arch/arm/mach-omap2/clkt_clksel.c         |   10 +-
 arch/arm/mach-omap2/clkt_dpll.c           |    6 +-
 arch/arm/mach-omap2/clkt_iclk.c           |    8 +-
 arch/arm/mach-omap2/clock.c               |   16 +--
 arch/arm/mach-omap2/clock36xx.c           |    6 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h         |    4 +-
 arch/arm/mach-omap2/cm33xx.c              |    4 +-
 arch/arm/mach-omap2/cm3xxx.c              |    8 +-
 arch/arm/mach-omap2/cm44xx.c              |    8 +-
 arch/arm/mach-omap2/cminst44xx.c          |    4 +-
 arch/arm/mach-omap2/control.c             |   20 +--
 arch/arm/mach-omap2/dma.c                 |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c            |   32 ++---
 arch/arm/mach-omap2/dpll44xx.c            |   12 +-
 arch/arm/mach-omap2/gpmc.c                |    8 +-
 arch/arm/mach-omap2/id.c                  |    2 +-
 arch/arm/mach-omap2/irq.c                 |    4 +-
 arch/arm/mach-omap2/mux.c                 |    8 +-
 arch/arm/mach-omap2/omap-headsmp.S        |   13 ++
 arch/arm/mach-omap2/omap-hotplug.c        |    4 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   18 +--
 arch/arm/mach-omap2/omap-smp.c            |    4 +-
 arch/arm/mach-omap2/omap-wakeupgen.c      |   42 +++----
 arch/arm/mach-omap2/omap4-common.c        |   16 +--
 arch/arm/mach-omap2/omap_hwmod.c          |   10 +-
 arch/arm/mach-omap2/omap_phy_internal.c   |    6 +-
 arch/arm/mach-omap2/prcm_mpu44xx.c        |    4 +-
 arch/arm/mach-omap2/prm2xxx.h             |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |    4 +-
 arch/arm/mach-omap2/prm33xx.c             |    4 +-
 arch/arm/mach-omap2/prm3xxx.h             |    2 +-
 arch/arm/mach-omap2/prm44xx.c             |    4 +-
 arch/arm/mach-omap2/prminst44xx.c         |    4 +-
 arch/arm/mach-omap2/sdrc.h                |    8 +-
 arch/arm/mach-omap2/sdrc2xxx.c            |    4 +-
 arch/arm/mach-omap2/sleep44xx.S           |   23 ++++
 arch/arm/mach-omap2/sr_device.c           |    2 +-
 arch/arm/mach-omap2/sram.c                |   16 +--
 arch/arm/mach-omap2/timer.c               |    8 +-
 arch/arm/mach-omap2/vc.c                  |    4 +-
 arch/arm/mach-omap2/wd_timer.c            |    8 +-
 arch/arm/plat-omap/counter_32k.c          |    6 +-
 arch/arm/plat-omap/debug-leds.c           |   14 +--
 arch/arm/plat-omap/dmtimer.c              |    8 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |   16 +--
 drivers/bus/omap_l3_noc.c                 |    8 +-
 drivers/char/hw_random/omap-rng.c         |    4 +-
 drivers/crypto/omap-aes.c                 |    8 +-
 drivers/crypto/omap-sham.c                |    4 +-
 drivers/gpio/gpio-omap.c                  |  188 ++++++++++++++---------------
 drivers/i2c/busses/i2c-omap.c             |    6 +-
 drivers/input/keyboard/omap4-keypad.c     |   10 +-
 drivers/mfd/omap-usb-host.c               |    8 +-
 drivers/mfd/omap-usb-tll.c                |    8 +-
 drivers/mmc/host/omap.c                   |    4 +-
 drivers/mmc/host/omap_hsmmc.c             |    4 +-
 drivers/spi/spi-omap2-mcspi.c             |   38 +++---
 drivers/usb/host/ehci-omap.c              |    4 +-
 drivers/usb/musb/musb_io.h                |   18 +--
 drivers/video/omap2/dss/dispc.c           |    4 +-
 drivers/video/omap2/dss/dsi.c             |    4 +-
 drivers/video/omap2/dss/dss.c             |    4 +-
 drivers/video/omap2/dss/rfbi.c            |   16 +--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    4 +-
 drivers/video/omap2/dss/venc.c            |    4 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |   10 +-
 drivers/video/omap2/vrfb.c                |    6 +-
 drivers/watchdog/omap_wdt.c               |   36 +++---
 sound/soc/omap/mcbsp.c                    |   12 +-
 sound/soc/omap/omap-dmic.c                |    4 +-
 sound/soc/omap/omap-mcpdm.c               |    4 +-
 76 files changed, 446 insertions(+), 409 deletions(-)

-- 
1.7.9.5

