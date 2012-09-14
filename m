From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/7] omap makefile and sparse cleanup for v3.7 merge window
Date: Thu, 13 Sep 2012 19:18:45 -0700
Message-ID: <E1TCLVi-0003GO-8W@merlin.infradead.org>
References: <pull-1347589125-283636>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1347589125-283636>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:

  ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-makefile-sparse-for-v3.7

for you to fetch changes up to 3c101c41fbe5daf88afbbd575542aa1d047812bb:

  Merge tag 'omap-cleanup-b-for-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into cleanup-makefile-sparse (2012-09-12 20:42:36 -0700)

----------------------------------------------------------------

>From Paul Walmsley <paul@pwsan.com>:

Clean up and standardize several parts of
arch/arm/mach-omap2/Makefile.  Beyond readability and diffstat
improvements, the series should reduce the risk of conflicts during
future cleanups by ensuring related lines are in the same section of the
Makefile.

smatch and string-wrapping cleanups for the OMAP subarch code.

These changes fix some of the more meaningful warnings that smatch
returns for the OMAP subarch code, and unwraps strings that are
wrapped at the 80-column boundary, to conform with the current
practice.

----------------------------------------------------------------
Paul Walmsley (8):
      ARM: OMAP2+: clean up whitespace in Makefile
      ARM: OMAP2+: clean up omap_hwmod.o build directives in Makefile
      ARM: OMAP2+: move MPU INTCPS, secure monitor, SDRC build directives in Makefile
      ARM: OMAP2+: clean up OMAP4 PRM & sleep build directives in Makefile
      ARM: OMAP2+: clean up OMAP clock Makefile sections
      ARM: OMAP2+: clean up PRCM sections of the Makefile
      ARM: OMAP: clean up some smatch warnings, fix some printk(KERN_ERR ...
      ARM: OMAP: unwrap strings

Tony Lindgren (2):
      Merge tag 'omap-cleanup-a-for-3.7' of git://git.kernel.org/.../pjw/omap-pending into cleanup-makefile-sparse
      Merge tag 'omap-cleanup-b-for-3.7' of git://git.kernel.org/.../pjw/omap-pending into cleanup-makefile-sparse

 arch/arm/mach-omap1/board-htcherald.c       |    3 +-
 arch/arm/mach-omap1/clock.c                 |    4 +-
 arch/arm/mach-omap1/clock_data.c            |   13 ++--
 arch/arm/mach-omap1/dma.c                   |    5 +-
 arch/arm/mach-omap1/lcd_dma.c               |    6 +-
 arch/arm/mach-omap1/leds-h2p2-debug.c       |   12 +--
 arch/arm/mach-omap2/Makefile                |  108 +++++++++++----------------
 arch/arm/mach-omap2/board-n8x0.c            |    7 +-
 arch/arm/mach-omap2/board-overo.c           |    6 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c      |   10 +--
 arch/arm/mach-omap2/clkt_clksel.c           |   28 ++++---
 arch/arm/mach-omap2/clkt_dpll.c             |    8 +-
 arch/arm/mach-omap2/clock.c                 |   20 ++---
 arch/arm/mach-omap2/clock3xxx.c             |    3 +-
 arch/arm/mach-omap2/clockdomain.c           |   74 +++++++++---------
 arch/arm/mach-omap2/common-board-devices.c  |    3 +-
 arch/arm/mach-omap2/dpll3xxx.c              |    7 +-
 arch/arm/mach-omap2/gpio.c                  |    1 +
 arch/arm/mach-omap2/gpmc.c                  |    2 +-
 arch/arm/mach-omap2/id.c                    |    5 +-
 arch/arm/mach-omap2/irq.c                   |    5 +-
 arch/arm/mach-omap2/omap_hwmod.c            |   16 ++--
 arch/arm/mach-omap2/opp.c                   |   15 ++--
 arch/arm/mach-omap2/pm.c                    |    4 +-
 arch/arm/mach-omap2/pm34xx.c                |    8 +-
 arch/arm/mach-omap2/pm44xx.c                |    8 +-
 arch/arm/mach-omap2/powerdomain.c           |   36 +++++----
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    4 +-
 arch/arm/mach-omap2/powerdomain44xx.c       |    4 +-
 arch/arm/mach-omap2/prcm.c                  |    8 +-
 arch/arm/mach-omap2/serial.c                |   12 +--
 arch/arm/mach-omap2/sr_device.c             |   13 ++--
 arch/arm/mach-omap2/timer.c                 |    2 +-
 arch/arm/mach-omap2/vc.c                    |    5 +-
 arch/arm/mach-omap2/voltage.c               |   12 +--
 arch/arm/mach-omap2/vp.c                    |   16 ++--
 arch/arm/plat-omap/dma.c                    |   51 ++++++-------
 arch/arm/plat-omap/mux.c                    |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c           |   39 +++++-----
 arch/arm/plat-omap/omap_device.c            |   25 +++----
 41 files changed, 277 insertions(+), 340 deletions(-)
