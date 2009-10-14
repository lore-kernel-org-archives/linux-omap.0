From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Reorganize omap headers to have include/plat
Date: Wed, 14 Oct 2009 14:48:26 -0700
Message-ID: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here is a series for the merge window after 2.6.32 to reorganize
the omap headers as suggested by Russell earlier at [1].

Basically we currently have everything under a single mach directory:

arch/arm/plat-omap/include/mach

This series creates the common plat, and separate mach directories:

arch/arm/plat-omap/include/plat
arch/arm/mach-omap1/include/mach
arch/arm/mach-omap2/include/mach

This series is intentionally mostly search and replace, and only
splits a few headers in the first few patches to keep things
compiling.

The rest is done with shell scripts. I obviously will need to
refresh these patches and other patches that will get added
on top of these, but those changes should be quite minimal.

After this series further work on the headers can be done
easily.

Regards,

Tony


[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15085.html


---

Tony Lindgren (6):
      omap: headers: Move remaining headers from include/mach to include/plat
      omap: headers: Create headers necessary for compile under mach-omap1 and mach-omap2
      omap: headers: Move mtd-xip.h to be mach-omap1 specific
      omap: headers: Split entry-macro.S for mach-omap1 and mach-omap2
      omap: headers: Split debug-macro.S for mach-omap1 and mach-omap2
      omap: headers: Add mach patch to include files


 arch/arm/mach-omap1/board-ams-delta.c              |   12 
 arch/arm/mach-omap1/board-fsample.c                |   14 
 arch/arm/mach-omap1/board-generic.c                |    8 
 arch/arm/mach-omap1/board-h2-mmc.c                 |    2 
 arch/arm/mach-omap1/board-h2.c                     |   16 
 arch/arm/mach-omap1/board-h3-mmc.c                 |    2 
 arch/arm/mach-omap1/board-h3.c                     |   14 
 arch/arm/mach-omap1/board-innovator.c              |   14 
 arch/arm/mach-omap1/board-nokia770.c               |   22 
 arch/arm/mach-omap1/board-osk.c                    |   10 
 arch/arm/mach-omap1/board-palmte.c                 |   16 
 arch/arm/mach-omap1/board-palmtt.c                 |   18 
 arch/arm/mach-omap1/board-palmz71.c                |   18 
 arch/arm/mach-omap1/board-perseus2.c               |   14 
 arch/arm/mach-omap1/board-sx1-mmc.c                |    4 
 arch/arm/mach-omap1/board-sx1.c                    |   18 
 arch/arm/mach-omap1/board-voiceblue.c              |    8 
 arch/arm/mach-omap1/clock.c                        |    8 
 arch/arm/mach-omap1/devices.c                      |    8 
 arch/arm/mach-omap1/fpga.c                         |    2 
 arch/arm/mach-omap1/id.c                           |    2 
 arch/arm/mach-omap1/include/mach/clkdev.h          |    5 
 arch/arm/mach-omap1/include/mach/debug-macro.S     |   45 +
 arch/arm/mach-omap1/include/mach/entry-macro.S     |   58 +
 arch/arm/mach-omap1/include/mach/gpio.h            |    5 
 arch/arm/mach-omap1/include/mach/hardware.h        |    5 
 arch/arm/mach-omap1/include/mach/io.h              |    5 
 arch/arm/mach-omap1/include/mach/irqs.h            |    5 
 arch/arm/mach-omap1/include/mach/memory.h          |    5 
 arch/arm/mach-omap1/include/mach/mtd-xip.h         |   61 +
 arch/arm/mach-omap1/include/mach/smp.h             |    5 
 arch/arm/mach-omap1/include/mach/system.h          |    5 
 arch/arm/mach-omap1/include/mach/timex.h           |    5 
 arch/arm/mach-omap1/include/mach/uncompress.h      |    5 
 arch/arm/mach-omap1/include/mach/vmalloc.h         |    5 
 arch/arm/mach-omap1/io.c                           |    4 
 arch/arm/mach-omap1/irq.c                          |    2 
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    2 
 arch/arm/mach-omap1/leds.c                         |    2 
 arch/arm/mach-omap1/mailbox.c                      |    2 
 arch/arm/mach-omap1/mcbsp.c                        |   10 
 arch/arm/mach-omap1/mux.c                          |    2 
 arch/arm/mach-omap1/pm.c                           |   14 
 arch/arm/mach-omap1/serial.c                       |    6 
 arch/arm/mach-omap1/timer32k.c                     |    2 
 arch/arm/mach-omap2/board-2430sdp.c                |   12 
 arch/arm/mach-omap2/board-3430sdp.c                |   22 
 arch/arm/mach-omap2/board-4430sdp.c                |    8 
 arch/arm/mach-omap2/board-apollon.c                |   14 
 arch/arm/mach-omap2/board-generic.c                |    8 
 arch/arm/mach-omap2/board-h4.c                     |   18 
 arch/arm/mach-omap2/board-ldp.c                    |   14 
 arch/arm/mach-omap2/board-n8x0.c                   |   10 
 arch/arm/mach-omap2/board-omap3beagle.c            |   14 
 arch/arm/mach-omap2/board-omap3evm.c               |   12 
 arch/arm/mach-omap2/board-omap3pandora.c           |   12 
 arch/arm/mach-omap2/board-overo.c                  |   14 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   18 
 arch/arm/mach-omap2/board-rx51.c                   |   16 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    2 
 arch/arm/mach-omap2/board-zoom2.c                  |    6 
 arch/arm/mach-omap2/clock.c                        |   10 
 arch/arm/mach-omap2/clock.h                        |    2 
 arch/arm/mach-omap2/clock24xx.c                    |    8 
 arch/arm/mach-omap2/clock34xx.c                    |    8 
 arch/arm/mach-omap2/clock34xx.h                    |    2 
 arch/arm/mach-omap2/clockdomain.c                  |    6 
 arch/arm/mach-omap2/clockdomains.h                 |    2 
 arch/arm/mach-omap2/control.c                      |    4 
 arch/arm/mach-omap2/devices.c                      |   12 
 arch/arm/mach-omap2/gpmc-onenand.c                 |    6 
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    6 
 arch/arm/mach-omap2/gpmc.c                         |    4 
 arch/arm/mach-omap2/id.c                           |    6 
 arch/arm/mach-omap2/include/mach/clkdev.h          |    5 
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   59 +
 arch/arm/mach-omap2/include/mach/entry-macro.S     |  122 +++
 arch/arm/mach-omap2/include/mach/gpio.h            |    5 
 arch/arm/mach-omap2/include/mach/hardware.h        |    5 
 arch/arm/mach-omap2/include/mach/io.h              |    5 
 arch/arm/mach-omap2/include/mach/irqs.h            |    5 
 arch/arm/mach-omap2/include/mach/memory.h          |    5 
 arch/arm/mach-omap2/include/mach/smp.h             |    5 
 arch/arm/mach-omap2/include/mach/system.h          |    5 
 arch/arm/mach-omap2/include/mach/timex.h           |    5 
 arch/arm/mach-omap2/include/mach/uncompress.h      |    5 
 arch/arm/mach-omap2/include/mach/vmalloc.h         |    5 
 arch/arm/mach-omap2/io.c                           |   20 
 arch/arm/mach-omap2/iommu2.c                       |    2 
 arch/arm/mach-omap2/mailbox.c                      |    2 
 arch/arm/mach-omap2/mcbsp.c                        |    8 
 arch/arm/mach-omap2/mmc-twl4030.c                  |    6 
 arch/arm/mach-omap2/mux.c                          |    4 
 arch/arm/mach-omap2/omap3-iommu.c                  |    2 
 arch/arm/mach-omap2/omap_hwmod.c                   |   10 
 arch/arm/mach-omap2/omap_hwmod_2420.h              |    6 
 arch/arm/mach-omap2/omap_hwmod_2430.h              |    6 
 arch/arm/mach-omap2/omap_hwmod_34xx.h              |    6 
 arch/arm/mach-omap2/pm-debug.c                     |    8 
 arch/arm/mach-omap2/pm.h                           |    2 
 arch/arm/mach-omap2/pm24xx.c                       |   16 
 arch/arm/mach-omap2/pm34xx.c                       |   10 
 arch/arm/mach-omap2/powerdomain.c                  |    6 
 arch/arm/mach-omap2/powerdomains.h                 |    2 
 arch/arm/mach-omap2/powerdomains24xx.h             |    2 
 arch/arm/mach-omap2/powerdomains34xx.h             |    2 
 arch/arm/mach-omap2/prcm.c                         |    4 
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |    2 
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |    2 
 arch/arm/mach-omap2/sdrc.c                         |    8 
 arch/arm/mach-omap2/sdrc.h                         |    2 
 arch/arm/mach-omap2/sdrc2xxx.c                     |    8 
 arch/arm/mach-omap2/serial.c                       |    8 
 arch/arm/mach-omap2/sleep24xx.S                    |    2 
 arch/arm/mach-omap2/sleep34xx.S                    |    2 
 arch/arm/mach-omap2/timer-gp.c                     |    2 
 arch/arm/mach-omap2/usb-musb.c                     |    4 
 arch/arm/mach-omap2/usb-tusb6010.c                 |    4 
 arch/arm/plat-omap/clock.c                         |    2 
 arch/arm/plat-omap/common.c                        |   12 
 arch/arm/plat-omap/cpu-omap.c                      |    2 
 arch/arm/plat-omap/debug-devices.c                 |    2 
 arch/arm/plat-omap/debug-leds.c                    |    2 
 arch/arm/plat-omap/devices.c                       |   16 
 arch/arm/plat-omap/dma.c                           |    4 
 arch/arm/plat-omap/dmtimer.c                       |    2 
 arch/arm/plat-omap/fb.c                            |    6 
 arch/arm/plat-omap/i2c.c                           |    2 
 arch/arm/plat-omap/include/mach/blizzard.h         |   12 
 arch/arm/plat-omap/include/mach/board-ams-delta.h  |   76 --
 arch/arm/plat-omap/include/mach/board-sx1.h        |   52 -
 arch/arm/plat-omap/include/mach/board-voiceblue.h  |   19 
 arch/arm/plat-omap/include/mach/board.h            |  160 ----
 arch/arm/plat-omap/include/mach/clkdev.h           |   13 
 arch/arm/plat-omap/include/mach/clock.h            |  163 ----
 arch/arm/plat-omap/include/mach/clockdomain.h      |  111 --
 arch/arm/plat-omap/include/mach/common.h           |   71 --
 arch/arm/plat-omap/include/mach/control.h          |  227 -----
 arch/arm/plat-omap/include/mach/cpu.h              |  426 ---------
 arch/arm/plat-omap/include/mach/debug-macro.S      |   70 --
 arch/arm/plat-omap/include/mach/dma.h              |  675 ---------------
 arch/arm/plat-omap/include/mach/dmtimer.h          |   84 --
 arch/arm/plat-omap/include/mach/dsp_common.h       |   40 -
 arch/arm/plat-omap/include/mach/entry-macro.S      |  172 ----
 arch/arm/plat-omap/include/mach/fpga.h             |  197 ----
 arch/arm/plat-omap/include/mach/gpio-switch.h      |   54 -
 arch/arm/plat-omap/include/mach/gpio.h             |  128 ---
 arch/arm/plat-omap/include/mach/gpmc-smc91x.h      |   42 -
 arch/arm/plat-omap/include/mach/gpmc.h             |  112 --
 arch/arm/plat-omap/include/mach/hardware.h         |  290 ------
 arch/arm/plat-omap/include/mach/hwa742.h           |    8 
 arch/arm/plat-omap/include/mach/io.h               |  241 -----
 arch/arm/plat-omap/include/mach/iommu.h            |  168 ----
 arch/arm/plat-omap/include/mach/iommu2.h           |   96 --
 arch/arm/plat-omap/include/mach/iovmm.h            |   94 --
 arch/arm/plat-omap/include/mach/irda.h             |   33 -
 arch/arm/plat-omap/include/mach/irqs.h             |  568 ------------
 arch/arm/plat-omap/include/mach/keypad.h           |   42 -
 arch/arm/plat-omap/include/mach/lcd_mipid.h        |   29 -
 arch/arm/plat-omap/include/mach/led.h              |   24 -
 arch/arm/plat-omap/include/mach/mailbox.h          |   96 --
 arch/arm/plat-omap/include/mach/mcbsp.h            |  462 ----------
 arch/arm/plat-omap/include/mach/mcspi.h            |   15 
 arch/arm/plat-omap/include/mach/memory.h           |   96 --
 arch/arm/plat-omap/include/mach/menelaus.h         |   49 -
 arch/arm/plat-omap/include/mach/mmc.h              |  157 ---
 arch/arm/plat-omap/include/mach/mtd-xip.h          |   61 -
 arch/arm/plat-omap/include/mach/mux.h              |  914 --------------------
 arch/arm/plat-omap/include/mach/nand.h             |   24 -
 arch/arm/plat-omap/include/mach/omap-alsa.h        |  123 ---
 arch/arm/plat-omap/include/mach/omap-pm.h          |  301 -------
 arch/arm/plat-omap/include/mach/omap1510.h         |   50 -
 arch/arm/plat-omap/include/mach/omap16xx.h         |  202 ----
 arch/arm/plat-omap/include/mach/omap24xx.h         |   89 --
 arch/arm/plat-omap/include/mach/omap34xx.h         |   87 --
 arch/arm/plat-omap/include/mach/omap44xx.h         |   46 -
 arch/arm/plat-omap/include/mach/omap730.h          |  102 --
 arch/arm/plat-omap/include/mach/omap850.h          |  102 --
 arch/arm/plat-omap/include/mach/omap_device.h      |  141 ---
 arch/arm/plat-omap/include/mach/omap_hwmod.h       |  447 ----------
 arch/arm/plat-omap/include/mach/omapfb.h           |  398 ---------
 arch/arm/plat-omap/include/mach/onenand.h          |   43 -
 arch/arm/plat-omap/include/mach/param.h            |    8 
 arch/arm/plat-omap/include/mach/powerdomain.h      |  182 ----
 arch/arm/plat-omap/include/mach/prcm.h             |   35 -
 arch/arm/plat-omap/include/mach/sdrc.h             |  143 ---
 arch/arm/plat-omap/include/mach/serial.h           |   68 -
 arch/arm/plat-omap/include/mach/smp.h              |   51 -
 arch/arm/plat-omap/include/mach/sram.h             |   71 --
 arch/arm/plat-omap/include/mach/system.h           |   51 -
 arch/arm/plat-omap/include/mach/tc.h               |  106 --
 arch/arm/plat-omap/include/mach/timer-gp.h         |   17 
 arch/arm/plat-omap/include/mach/timex.h            |   41 -
 arch/arm/plat-omap/include/mach/uncompress.h       |   83 --
 arch/arm/plat-omap/include/mach/usb.h              |  145 ---
 arch/arm/plat-omap/include/mach/vmalloc.h          |   21 
 arch/arm/plat-omap/include/plat/blizzard.h         |   12 
 arch/arm/plat-omap/include/plat/board-ams-delta.h  |   76 ++
 arch/arm/plat-omap/include/plat/board-sx1.h        |   52 +
 arch/arm/plat-omap/include/plat/board-voiceblue.h  |   19 
 arch/arm/plat-omap/include/plat/board.h            |  160 ++++
 arch/arm/plat-omap/include/plat/clkdev.h           |   13 
 arch/arm/plat-omap/include/plat/clock.h            |  163 ++++
 arch/arm/plat-omap/include/plat/clockdomain.h      |  111 ++
 arch/arm/plat-omap/include/plat/common.h           |   71 ++
 arch/arm/plat-omap/include/plat/control.h          |  227 +++++
 arch/arm/plat-omap/include/plat/cpu.h              |  426 +++++++++
 arch/arm/plat-omap/include/plat/dma.h              |  675 +++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h          |   84 ++
 arch/arm/plat-omap/include/plat/dsp_common.h       |   40 +
 arch/arm/plat-omap/include/plat/fpga.h             |  197 ++++
 arch/arm/plat-omap/include/plat/gpio-switch.h      |   54 +
 arch/arm/plat-omap/include/plat/gpio.h             |  128 +++
 arch/arm/plat-omap/include/plat/gpmc-smc91x.h      |   42 +
 arch/arm/plat-omap/include/plat/gpmc.h             |  112 ++
 arch/arm/plat-omap/include/plat/hardware.h         |  290 ++++++
 arch/arm/plat-omap/include/plat/hwa742.h           |    8 
 arch/arm/plat-omap/include/plat/io.h               |  241 +++++
 arch/arm/plat-omap/include/plat/iommu.h            |  168 ++++
 arch/arm/plat-omap/include/plat/iommu2.h           |   96 ++
 arch/arm/plat-omap/include/plat/iovmm.h            |   94 ++
 arch/arm/plat-omap/include/plat/irda.h             |   33 +
 arch/arm/plat-omap/include/plat/irqs.h             |  568 ++++++++++++
 arch/arm/plat-omap/include/plat/keypad.h           |   42 +
 arch/arm/plat-omap/include/plat/lcd_mipid.h        |   29 +
 arch/arm/plat-omap/include/plat/led.h              |   24 +
 arch/arm/plat-omap/include/plat/mailbox.h          |   96 ++
 arch/arm/plat-omap/include/plat/mcbsp.h            |  462 ++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h            |   15 
 arch/arm/plat-omap/include/plat/memory.h           |   96 ++
 arch/arm/plat-omap/include/plat/menelaus.h         |   49 +
 arch/arm/plat-omap/include/plat/mmc.h              |  157 +++
 arch/arm/plat-omap/include/plat/mux.h              |  914 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/nand.h             |   24 +
 arch/arm/plat-omap/include/plat/omap-alsa.h        |  123 +++
 arch/arm/plat-omap/include/plat/omap-pm.h          |  301 +++++++
 arch/arm/plat-omap/include/plat/omap1510.h         |   50 +
 arch/arm/plat-omap/include/plat/omap16xx.h         |  202 ++++
 arch/arm/plat-omap/include/plat/omap24xx.h         |   89 ++
 arch/arm/plat-omap/include/plat/omap34xx.h         |   87 ++
 arch/arm/plat-omap/include/plat/omap44xx.h         |   46 +
 arch/arm/plat-omap/include/plat/omap730.h          |  102 ++
 arch/arm/plat-omap/include/plat/omap850.h          |  102 ++
 arch/arm/plat-omap/include/plat/omap_device.h      |  141 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |  447 ++++++++++
 arch/arm/plat-omap/include/plat/omapfb.h           |  398 +++++++++
 arch/arm/plat-omap/include/plat/onenand.h          |   43 +
 arch/arm/plat-omap/include/plat/param.h            |    8 
 arch/arm/plat-omap/include/plat/powerdomain.h      |  182 ++++
 arch/arm/plat-omap/include/plat/prcm.h             |   35 +
 arch/arm/plat-omap/include/plat/sdrc.h             |  143 +++
 arch/arm/plat-omap/include/plat/serial.h           |   68 +
 arch/arm/plat-omap/include/plat/smp.h              |   51 +
 arch/arm/plat-omap/include/plat/sram.h             |   71 ++
 arch/arm/plat-omap/include/plat/system.h           |   51 +
 arch/arm/plat-omap/include/plat/tc.h               |  106 ++
 arch/arm/plat-omap/include/plat/timer-gp.h         |   17 
 arch/arm/plat-omap/include/plat/timex.h            |   41 +
 arch/arm/plat-omap/include/plat/uncompress.h       |   83 ++
 arch/arm/plat-omap/include/plat/usb.h              |  145 +++
 arch/arm/plat-omap/include/plat/vmalloc.h          |   21 
 arch/arm/plat-omap/io.c                            |   12 
 arch/arm/plat-omap/iommu-debug.c                   |    4 
 arch/arm/plat-omap/iommu.c                         |    2 
 arch/arm/plat-omap/iovmm.c                         |    4 
 arch/arm/plat-omap/mailbox.c                       |    2 
 arch/arm/plat-omap/mcbsp.c                         |    4 
 arch/arm/plat-omap/mux.c                           |    2 
 arch/arm/plat-omap/omap-pm-noop.c                  |    4 
 arch/arm/plat-omap/omap_device.c                   |    4 
 arch/arm/plat-omap/sram.c                          |    8 
 arch/arm/plat-omap/usb.c                           |    8 
 drivers/input/keyboard/omap-keypad.c               |    6 
 drivers/leds/leds-ams-delta.c                      |    2 
 drivers/mfd/menelaus.c                             |    2 
 drivers/mfd/twl4030-core.c                         |    2 
 drivers/mmc/host/omap.c                            |   10 
 drivers/mmc/host/omap_hsmmc.c                      |    8 
 drivers/mtd/maps/omap_nor.c                        |    2 
 drivers/mtd/nand/ams-delta.c                       |    2 
 drivers/mtd/nand/omap2.c                           |    6 
 drivers/mtd/onenand/omap2.c                        |    8 
 drivers/pcmcia/omap_cf.c                           |    4 
 drivers/spi/omap2_mcspi.c                          |    4 
 drivers/spi/omap_uwire.c                           |    4 
 drivers/usb/gadget/omap_udc.c                      |    6 
 drivers/usb/host/ohci-omap.c                       |    6 
 drivers/usb/musb/omap2430.c                        |    2 
 drivers/usb/musb/omap2430.h                        |    2 
 drivers/usb/musb/tusb6010_omap.c                   |    4 
 drivers/usb/otg/isp1301_omap.c                     |    4 
 drivers/video/backlight/omap1_bl.c                 |    4 
 drivers/video/omap/blizzard.c                      |    6 
 drivers/video/omap/dispc.c                         |    6 
 drivers/video/omap/hwa742.c                        |    6 
 drivers/video/omap/lcd_2430sdp.c                   |    4 
 drivers/video/omap/lcd_ams_delta.c                 |    4 
 drivers/video/omap/lcd_apollon.c                   |    4 
 drivers/video/omap/lcd_h3.c                        |    2 
 drivers/video/omap/lcd_h4.c                        |    2 
 drivers/video/omap/lcd_inn1510.c                   |    4 
 drivers/video/omap/lcd_inn1610.c                   |    2 
 drivers/video/omap/lcd_ldp.c                       |    4 
 drivers/video/omap/lcd_mipid.c                     |    4 
 drivers/video/omap/lcd_omap2evm.c                  |    4 
 drivers/video/omap/lcd_omap3beagle.c               |    4 
 drivers/video/omap/lcd_omap3evm.c                  |    4 
 drivers/video/omap/lcd_osk.c                       |    4 
 drivers/video/omap/lcd_overo.c                     |    4 
 drivers/video/omap/lcd_palmte.c                    |    4 
 drivers/video/omap/lcd_palmtt.c                    |    2 
 drivers/video/omap/lcd_palmz71.c                   |    2 
 drivers/video/omap/lcdc.c                          |    4 
 drivers/video/omap/omapfb_main.c                   |    4 
 drivers/video/omap/rfbi.c                          |    2 
 drivers/video/omap/sossi.c                         |    4 
 drivers/watchdog/omap_wdt.c                        |    2 
 sound/soc/omap/ams-delta.c                         |    4 
 sound/soc/omap/n810.c                              |    2 
 sound/soc/omap/omap-mcbsp.c                        |    6 
 sound/soc/omap/omap-pcm.c                          |    2 
 sound/soc/omap/omap2evm.c                          |    2 
 sound/soc/omap/omap3beagle.c                       |    2 
 sound/soc/omap/omap3evm.c                          |    2 
 sound/soc/omap/osk5912.c                           |    2 
 sound/soc/omap/overo.c                             |    2 
 sound/soc/omap/sdp3430.c                           |    2 
 sound/soc/omap/zoom2.c                             |    2 
 328 files changed, 10192 insertions(+), 10040 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-omap1/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap1/include/mach/hardware.h
 create mode 100644 arch/arm/mach-omap1/include/mach/io.h
 create mode 100644 arch/arm/mach-omap1/include/mach/irqs.h
 create mode 100644 arch/arm/mach-omap1/include/mach/memory.h
 create mode 100644 arch/arm/mach-omap1/include/mach/mtd-xip.h
 create mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 create mode 100644 arch/arm/mach-omap1/include/mach/system.h
 create mode 100644 arch/arm/mach-omap1/include/mach/timex.h
 create mode 100644 arch/arm/mach-omap1/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-omap1/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-omap2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-omap2/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-omap2/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-omap2/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-omap2/include/mach/io.h
 create mode 100644 arch/arm/mach-omap2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-omap2/include/mach/memory.h
 create mode 100644 arch/arm/mach-omap2/include/mach/smp.h
 create mode 100644 arch/arm/mach-omap2/include/mach/system.h
 create mode 100644 arch/arm/mach-omap2/include/mach/timex.h
 create mode 100644 arch/arm/mach-omap2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-omap2/include/mach/vmalloc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/blizzard.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-ams-delta.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-sx1.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-voiceblue.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board.h
 delete mode 100644 arch/arm/plat-omap/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-omap/include/mach/clock.h
 delete mode 100644 arch/arm/plat-omap/include/mach/clockdomain.h
 delete mode 100644 arch/arm/plat-omap/include/mach/common.h
 delete mode 100644 arch/arm/plat-omap/include/mach/control.h
 delete mode 100644 arch/arm/plat-omap/include/mach/cpu.h
 delete mode 100644 arch/arm/plat-omap/include/mach/debug-macro.S
 delete mode 100644 arch/arm/plat-omap/include/mach/dma.h
 delete mode 100644 arch/arm/plat-omap/include/mach/dmtimer.h
 delete mode 100644 arch/arm/plat-omap/include/mach/dsp_common.h
 delete mode 100644 arch/arm/plat-omap/include/mach/entry-macro.S
 delete mode 100644 arch/arm/plat-omap/include/mach/fpga.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpio-switch.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpmc-smc91x.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpmc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/hardware.h
 delete mode 100644 arch/arm/plat-omap/include/mach/hwa742.h
 delete mode 100644 arch/arm/plat-omap/include/mach/io.h
 delete mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 delete mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 delete mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 delete mode 100644 arch/arm/plat-omap/include/mach/irda.h
 delete mode 100644 arch/arm/plat-omap/include/mach/irqs.h
 delete mode 100644 arch/arm/plat-omap/include/mach/keypad.h
 delete mode 100644 arch/arm/plat-omap/include/mach/lcd_mipid.h
 delete mode 100644 arch/arm/plat-omap/include/mach/led.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mailbox.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mcbsp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mcspi.h
 delete mode 100644 arch/arm/plat-omap/include/mach/memory.h
 delete mode 100644 arch/arm/plat-omap/include/mach/menelaus.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mmc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mux.h
 delete mode 100644 arch/arm/plat-omap/include/mach/nand.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap-alsa.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap-pm.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap1510.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap16xx.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap24xx.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap34xx.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap44xx.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap730.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap850.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap_device.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omap_hwmod.h
 delete mode 100644 arch/arm/plat-omap/include/mach/omapfb.h
 delete mode 100644 arch/arm/plat-omap/include/mach/onenand.h
 delete mode 100644 arch/arm/plat-omap/include/mach/param.h
 delete mode 100644 arch/arm/plat-omap/include/mach/powerdomain.h
 delete mode 100644 arch/arm/plat-omap/include/mach/prcm.h
 delete mode 100644 arch/arm/plat-omap/include/mach/sdrc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/serial.h
 delete mode 100644 arch/arm/plat-omap/include/mach/smp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/sram.h
 delete mode 100644 arch/arm/plat-omap/include/mach/system.h
 delete mode 100644 arch/arm/plat-omap/include/mach/tc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/timex.h
 delete mode 100644 arch/arm/plat-omap/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-omap/include/mach/usb.h
 delete mode 100644 arch/arm/plat-omap/include/mach/vmalloc.h
 create mode 100644 arch/arm/plat-omap/include/plat/blizzard.h
 create mode 100644 arch/arm/plat-omap/include/plat/board-ams-delta.h
 create mode 100644 arch/arm/plat-omap/include/plat/board-sx1.h
 create mode 100644 arch/arm/plat-omap/include/plat/board-voiceblue.h
 create mode 100644 arch/arm/plat-omap/include/plat/board.h
 create mode 100644 arch/arm/plat-omap/include/plat/clkdev.h
 create mode 100644 arch/arm/plat-omap/include/plat/clock.h
 create mode 100644 arch/arm/plat-omap/include/plat/clockdomain.h
 create mode 100644 arch/arm/plat-omap/include/plat/common.h
 create mode 100644 arch/arm/plat-omap/include/plat/control.h
 create mode 100644 arch/arm/plat-omap/include/plat/cpu.h
 create mode 100644 arch/arm/plat-omap/include/plat/dma.h
 create mode 100644 arch/arm/plat-omap/include/plat/dmtimer.h
 create mode 100644 arch/arm/plat-omap/include/plat/dsp_common.h
 create mode 100644 arch/arm/plat-omap/include/plat/fpga.h
 create mode 100644 arch/arm/plat-omap/include/plat/gpio-switch.h
 create mode 100644 arch/arm/plat-omap/include/plat/gpio.h
 create mode 100644 arch/arm/plat-omap/include/plat/gpmc-smc91x.h
 create mode 100644 arch/arm/plat-omap/include/plat/gpmc.h
 create mode 100644 arch/arm/plat-omap/include/plat/hardware.h
 create mode 100644 arch/arm/plat-omap/include/plat/hwa742.h
 create mode 100644 arch/arm/plat-omap/include/plat/io.h
 create mode 100644 arch/arm/plat-omap/include/plat/iommu.h
 create mode 100644 arch/arm/plat-omap/include/plat/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/plat/iovmm.h
 create mode 100644 arch/arm/plat-omap/include/plat/irda.h
 create mode 100644 arch/arm/plat-omap/include/plat/irqs.h
 create mode 100644 arch/arm/plat-omap/include/plat/keypad.h
 create mode 100644 arch/arm/plat-omap/include/plat/lcd_mipid.h
 create mode 100644 arch/arm/plat-omap/include/plat/led.h
 create mode 100644 arch/arm/plat-omap/include/plat/mailbox.h
 create mode 100644 arch/arm/plat-omap/include/plat/mcbsp.h
 create mode 100644 arch/arm/plat-omap/include/plat/mcspi.h
 create mode 100644 arch/arm/plat-omap/include/plat/memory.h
 create mode 100644 arch/arm/plat-omap/include/plat/menelaus.h
 create mode 100644 arch/arm/plat-omap/include/plat/mmc.h
 create mode 100644 arch/arm/plat-omap/include/plat/mux.h
 create mode 100644 arch/arm/plat-omap/include/plat/nand.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap-alsa.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap-pm.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap1510.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap16xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap24xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap34xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap44xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap730.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap850.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap_device.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap_hwmod.h
 create mode 100644 arch/arm/plat-omap/include/plat/omapfb.h
 create mode 100644 arch/arm/plat-omap/include/plat/onenand.h
 create mode 100644 arch/arm/plat-omap/include/plat/param.h
 create mode 100644 arch/arm/plat-omap/include/plat/powerdomain.h
 create mode 100644 arch/arm/plat-omap/include/plat/prcm.h
 create mode 100644 arch/arm/plat-omap/include/plat/sdrc.h
 create mode 100644 arch/arm/plat-omap/include/plat/serial.h
 create mode 100644 arch/arm/plat-omap/include/plat/smp.h
 create mode 100644 arch/arm/plat-omap/include/plat/sram.h
 create mode 100644 arch/arm/plat-omap/include/plat/system.h
 create mode 100644 arch/arm/plat-omap/include/plat/tc.h
 create mode 100644 arch/arm/plat-omap/include/plat/timer-gp.h
 create mode 100644 arch/arm/plat-omap/include/plat/timex.h
 create mode 100644 arch/arm/plat-omap/include/plat/uncompress.h
 create mode 100644 arch/arm/plat-omap/include/plat/usb.h
 create mode 100644 arch/arm/plat-omap/include/plat/vmalloc.h

-- 
Signature
