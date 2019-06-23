From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 00/15] cleanup cppcheck signed shifting errors
Date: Sun, 23 Jun 2019 22:12:58 +0700
Message-ID: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

There are errors with cppcheck 

"Shifting signed 32-bit value by 31 bits is undefined behaviour errors"

This is just a mirror changing.

Phong Tran (15):
  arm: perf: cleanup cppcheck shifting error
  ARM: davinci: cleanup cppcheck shifting errors
  ARM: ep93xx: cleanup cppcheck shifting errors
  ARM: exynos: cleanup cppcheck shifting error
  ARM: footbridge: cleanup cppcheck shifting error
  ARM: imx: cleanup cppcheck shifting errors
  ARM: ks8695: cleanup cppcheck shifting error
  ARM: mmp: cleanup cppcheck shifting errors
  ARM: omap2: cleanup cppcheck shifting error
  ARM: orion5x: cleanup cppcheck shifting errors
  ARM: pxa: cleanup cppcheck shifting errors
  ARM: vexpress: cleanup cppcheck shifting error
  ARM: mm: cleanup cppcheck shifting errors
  ARM: bpf: cleanup cppcheck shifting error
  ARM: vfp: cleanup cppcheck shifting errors

 arch/arm/kernel/perf_event_v7.c    |   6 +-
 arch/arm/mach-davinci/ddr2.h       |   6 +-
 arch/arm/mach-ep93xx/soc.h         | 132 ++++++++++++++++++-------------------
 arch/arm/mach-exynos/suspend.c     |   2 +-
 arch/arm/mach-footbridge/dc21285.c |   2 +-
 arch/arm/mach-imx/iomux-mx3.h      |  64 +++++++++---------
 arch/arm/mach-ks8695/regs-pci.h    |   4 +-
 arch/arm/mach-mmp/pm-mmp2.h        |  40 +++++------
 arch/arm/mach-mmp/pm-pxa910.h      |  76 ++++++++++-----------
 arch/arm/mach-omap2/powerdomain.c  |   2 +-
 arch/arm/mach-orion5x/pci.c        |   8 +--
 arch/arm/mach-pxa/irq.c            |   4 +-
 arch/arm/mach-vexpress/spc.c       |  12 ++--
 arch/arm/mm/fault.h                |   6 +-
 arch/arm/net/bpf_jit_32.c          |   2 +-
 arch/arm/vfp/vfpinstr.h            |  28 ++++----
 16 files changed, 197 insertions(+), 197 deletions(-)

-- 
2.11.0
