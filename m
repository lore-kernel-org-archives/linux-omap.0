From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V3 00/15] cleanup cppcheck signed shifting errors
Date: Tue, 25 Jun 2019 11:03:41 +0700
Message-ID: <20190625040356.27473-1-tranmanphong@gmail.com>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

This is also do as the suggestion of "Linux Kernel Mentorship Task List"

https://wiki.linuxfoundation.org/lkmp/lkmp_task_list#cleanup_cppcheck_errors
"Shifting signed 32-bit value by 31 bits is undefined behaviour errors"

Change Log:

V2: Using BIT() macro instead of (1UL << nr) 

V3: 
* Update the comments from Russell King.
* Update commit message and cover letter for clearly the reason as request
  Peter Zijlstra
* For avoiding the broken only change (1<<nr) pattern to BIT(nr)

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
 arch/arm/mach-ep93xx/soc.h         | 134 ++++++++++++++++++-------------------
 arch/arm/mach-exynos/suspend.c     |   2 +-
 arch/arm/mach-footbridge/dc21285.c |   2 +-
 arch/arm/mach-imx/iomux-mx3.h      |  64 +++++++++---------
 arch/arm/mach-ks8695/regs-pci.h    |   4 +-
 arch/arm/mach-mmp/pm-mmp2.h        |  40 +++++------
 arch/arm/mach-mmp/pm-pxa910.h      |  74 ++++++++++----------
 arch/arm/mach-omap2/powerdomain.c  |   2 +-
 arch/arm/mach-orion5x/pci.c        |   8 +--
 arch/arm/mach-pxa/irq.c            |   4 +-
 arch/arm/mach-vexpress/spc.c       |   4 +-
 arch/arm/mm/fault.h                |   6 +-
 arch/arm/net/bpf_jit_32.c          |   2 +-
 arch/arm/vfp/vfpinstr.h            |   8 +--
 16 files changed, 183 insertions(+), 183 deletions(-)

-- 
2.11.0
