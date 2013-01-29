From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Subject: [PATCH v2 0/5] ARM: Manage the pl310 erratas in a dynamic way
Date: Tue, 29 Jan 2013 15:40:38 +0530
Message-ID: <20130129101026.GA1063@bnru10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, avorontsov@mvista.com, gregory.clement@free-electrons.com, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, shawn.guo@linaro.org, rubini@unipv.it, linus.walleij@linaro.org, linux-omap@vger.kernel.org, tony@atomide.com, horms@verge.net.au, magnus.damm@gmail.com, viresh.linux@gmail.com, shiraz.hashim@st.com
List-Id: linux-omap@vger.kernel.org

This series of patches attempts to manage the pl310 erratas dynamically rather 
allowing platforms to choose them during build time.

A bit of information which triggered the cause for this series is here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138066.html

v2:
- The commit 74ddcdb868a84f4a9f65e33c1ca0d24e1134e53a 
  (l2x0: Only set .set_debug on PL310 r3p0 and earlier) which makes the
  assumption that non-secure platforms will implement .set_debug interface.
  An attempt is made to set .set_debug only if 'smc' is passed either
  through DT or through legacy interface (l2x0_init).
  With this background, this series adds 'smc' identifier to differentiate
  the paltforms which implements SMC interface.

- Use the stashed value	instead of reading RTL revision all over the place(Will)

- Added l2x0_quirks to manage the errata in cpu_idle path. Tried to address
  Russell's comment on this, but could not completely. Because, neither I can
  keep the #ifdef CONFIG_PL310_ERRATA_769419 nor remove it entirely since
  the platform A suffers from this bug, whereas B do not but shares the same
  defconfig.

srinidhi kasagar (5):
  ARM: cache-l2x0: add 'smc' identifier
  ARM: cache-l2x0: Manage the errata at run time
  ARM: make the platforms not to select the l2x0 erratas
  ARM: Handle l2x0 quirks in cpu_idle path
  ARM: mach-omap2: apply the errata at run time rather

 arch/arm/boot/dts/omap4.dtsi                   |    1 +
 arch/arm/include/asm/hardware/cache-l2x0.h     |   16 ++++-
 arch/arm/kernel/process.c                      |    7 +-
 arch/arm/mach-cns3xxx/core.c                   |    4 +-
 arch/arm/mach-exynos/common.c                  |    4 +-
 arch/arm/mach-imx/Kconfig                      |    3 -
 arch/arm/mach-imx/mm-imx3.c                    |    4 +-
 arch/arm/mach-nomadik/cpu-8815.c               |    4 +-
 arch/arm/mach-omap2/Kconfig                    |    2 -
 arch/arm/mach-omap2/omap4-common.c             |    2 +-
 arch/arm/mach-omap2/sleep44xx.S                |   25 ++++++-
 arch/arm/mach-realview/realview_eb.c           |    4 +-
 arch/arm/mach-realview/realview_pb1176.c       |    4 +-
 arch/arm/mach-realview/realview_pb11mp.c       |    4 +-
 arch/arm/mach-realview/realview_pbx.c          |    4 +-
 arch/arm/mach-shmobile/board-ag5evm.c          |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 +-
 arch/arm/mach-shmobile/board-bonito.c          |    4 +-
 arch/arm/mach-shmobile/board-kota2.c           |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |    4 +-
 arch/arm/mach-shmobile/setup-r8a7779.c         |    4 +-
 arch/arm/mach-spear13xx/spear13xx.c            |    2 +-
 arch/arm/mach-tegra/Kconfig                    |    3 -
 arch/arm/mach-ux500/Kconfig                    |    1 -
 arch/arm/mach-ux500/cache-l2x0.c               |    2 +-
 arch/arm/mach-vexpress/Kconfig                 |    1 -
 arch/arm/mach-vexpress/ct-ca9x4.c              |    2 +-
 arch/arm/mm/cache-l2x0.c                       |   90 +++++++++++++-----------
 28 files changed, 121 insertions(+), 90 deletions(-)

-- 
1.7.2.dirty
