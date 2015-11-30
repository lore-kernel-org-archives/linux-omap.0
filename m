From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/7] ARM: make mach/*.h headers more local
Date: Tue,  1 Dec 2015 00:00:51 +0100
Message-ID: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I've already posted the mach-pxa cleanup along the same lines,
here is another bunch of patches. I'd like to put them into
the next/multiplatform branch in arm-soc.

They come from an old script of mine to look for headers that
are not used by drivers, and I've done thousands of randconfig
builds with them applied, so I'm rather sure that they are all
harmless.

Arnd Bergmann (7):
  ARM: omap1: make headers more local
  ARM: ks8695: make headers more local
  ARM: davinci: make headers more local
  ARM: iop13xx: make headers more local
  ARM: w90x900: make headers more local
  ARM: mvebu: remove unused mach/gpio.h
  ARM: netx: remove unused mach/param.h

 arch/arm/mach-davinci/board-da830-evm.c            |  2 +-
 arch/arm/mach-davinci/board-da850-evm.c            |  4 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  2 +-
 arch/arm/mach-davinci/clock.c                      |  2 +-
 arch/arm/mach-davinci/cp_intc.c                    |  2 +-
 arch/arm/mach-davinci/{include/mach => }/cp_intc.h |  0
 arch/arm/mach-davinci/cpuidle.c                    |  4 +-
 arch/arm/mach-davinci/{include/mach => }/cpuidle.h |  0
 arch/arm/mach-davinci/da830.c                      |  2 +-
 arch/arm/mach-davinci/da850.c                      |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |  2 +-
 arch/arm/mach-davinci/{include/mach => }/ddr2.h    |  0
 arch/arm/mach-davinci/devices-da8xx.c              |  4 +-
 arch/arm/mach-davinci/dm355.c                      |  2 +-
 arch/arm/mach-davinci/dm365.c                      |  2 +-
 arch/arm/mach-davinci/dm644x.c                     |  2 +-
 arch/arm/mach-davinci/dm646x.c                     |  2 +-
 arch/arm/mach-davinci/pm.c                         |  2 +-
 arch/arm/mach-davinci/psc.c                        |  2 +-
 arch/arm/mach-davinci/{include/mach => }/psc.h     |  0
 arch/arm/mach-davinci/sleep.S                      |  4 +-
 arch/arm/mach-davinci/sram.c                       |  2 +-
 arch/arm/mach-davinci/{include/mach => }/sram.h    |  0
 arch/arm/mach-iop13xx/include/mach/pci.h           | 57 ---------------------
 arch/arm/mach-iop13xx/iq81340mc.c                  |  2 +-
 arch/arm/mach-iop13xx/iq81340sc.c                  |  2 +-
 arch/arm/mach-iop13xx/irq.c                        |  2 +-
 arch/arm/mach-iop13xx/{include/mach => }/msi.h     |  0
 arch/arm/mach-iop13xx/pci.c                        |  2 +-
 arch/arm/mach-iop13xx/pci.h                        | 58 ++++++++++++++++++++++
 arch/arm/mach-ks8695/board-acs5k.c                 |  2 +-
 arch/arm/mach-ks8695/board-dsm320.c                |  2 +-
 arch/arm/mach-ks8695/board-micrel.c                |  2 +-
 arch/arm/mach-ks8695/board-og.c                    |  2 +-
 arch/arm/mach-ks8695/board-sg.c                    |  2 +-
 arch/arm/mach-ks8695/cpu.c                         |  2 +-
 arch/arm/mach-ks8695/devices.c                     |  6 +--
 arch/arm/mach-ks8695/{include/mach => }/devices.h  |  0
 arch/arm/mach-ks8695/pci.c                         |  4 +-
 .../arm/mach-ks8695/{include/mach => }/regs-hpna.h |  0
 arch/arm/mach-ks8695/{include/mach => }/regs-lan.h |  0
 arch/arm/mach-ks8695/{include/mach => }/regs-mem.h |  0
 arch/arm/mach-ks8695/{include/mach => }/regs-pci.h |  0
 arch/arm/mach-ks8695/{include/mach => }/regs-sys.h |  0
 arch/arm/mach-ks8695/{include/mach => }/regs-wan.h |  0
 arch/arm/mach-mvebu/include/mach/gpio.h            |  1 -
 arch/arm/mach-netx/include/mach/param.h            | 18 -------
 arch/arm/mach-omap1/board-ams-delta.c              |  2 +-
 arch/arm/mach-omap1/board-fsample.c                |  2 +-
 arch/arm/mach-omap1/board-h2.c                     |  2 +-
 arch/arm/mach-omap1/board-h3.c                     |  2 +-
 arch/arm/mach-omap1/board-innovator.c              |  2 +-
 arch/arm/mach-omap1/board-osk.c                    |  2 +-
 arch/arm/mach-omap1/board-palmte.c                 |  2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |  2 +-
 arch/arm/mach-omap1/board-palmz71.c                |  2 +-
 arch/arm/mach-omap1/board-perseus2.c               |  2 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                |  2 +-
 arch/arm/mach-omap1/board-sx1.c                    |  4 +-
 arch/arm/mach-omap1/{include/mach => }/board-sx1.h |  0
 arch/arm/mach-omap1/{include/mach => }/camera.h    |  0
 arch/arm/mach-omap1/devices.c                      |  2 +-
 arch/arm/mach-omap1/flash.c                        |  2 +-
 arch/arm/mach-omap1/{include/mach => }/flash.h     |  0
 arch/arm/mach-w90x900/cpu.c                        |  4 +-
 .../arm/mach-w90x900/{include/mach => }/regs-ebi.h |  0
 .../arm/mach-w90x900/{include/mach => }/regs-gcr.h |  0
 .../mach-w90x900/{include/mach => }/regs-timer.h   |  0
 .../arm/mach-w90x900/{include/mach => }/regs-usb.h |  0
 arch/arm/mach-w90x900/time.c                       |  2 +-
 71 files changed, 114 insertions(+), 132 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/cp_intc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cpuidle.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/ddr2.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/psc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/sram.h (100%)
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/pci.h
 rename arch/arm/mach-iop13xx/{include/mach => }/msi.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/devices.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-hpna.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-lan.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-mem.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-pci.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-sys.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-wan.h (100%)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-netx/include/mach/param.h
 rename arch/arm/mach-omap1/{include/mach => }/board-sx1.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/camera.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/flash.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-timer.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-usb.h (100%)

-- 
2.1.0.rc2
