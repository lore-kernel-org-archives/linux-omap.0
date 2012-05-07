From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap sparse cleanup for v3.5 merge window
Date: Mon, 7 May 2012 15:38:42 -0700
Message-ID: <17112.11378356$1336430368@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-sparse-for-v3.5

for you to fetch changes up to 09f45b83109cb8e23a06d5efb1096a08a9545974:

  Merge tag 'omap-cleanup-a2-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into cleanup-sparse (2012-04-18 10:09:26 -0700)

----------------------------------------------------------------

Sparse and cppcheck warning fixes

----------------------------------------------------------------
Paul Walmsley (11):
      ARM: OMAP2+: declare file-local functions as static
      ARM: OMAP: add includes for missing prototypes
      ARM: OMAP1: OCPI: move to mach-omap1/
      ARM: OMAP1: OHCI: use platform_data fn ptr to enable OCPI bus
      ARM: OMAP2+: GPMC: resolve type-conversion warning from sparse
      ARM: OMAP: fix 'using plain integer as NULL pointer' sparse warnings
      ARM: OMAP: OCM RAM: use memset_io() when clearing SRAM
      ARM: OMAP: DMA: use constant array maximum, drop some LCD DMA code
      ARM: OMAP: USB: remove unnecessary sideways include
      ARM: OMAP1: board files: deduplicate and clean some NAND-related code
      ARM: OMAP2+: clean up some cppcheck warnings

Tony Lindgren (1):
      Merge tag 'omap-cleanup-a2-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into cleanup-sparse

 arch/arm/mach-omap1/Makefile                 |   13 ++++++---
 arch/arm/mach-omap1/ams-delta-fiq.c          |    2 +-
 arch/arm/mach-omap1/board-fsample.c          |   16 +----------
 arch/arm/mach-omap1/board-h2.c               |   17 +-----------
 arch/arm/mach-omap1/board-h3.c               |   16 +----------
 arch/arm/mach-omap1/board-nand.c             |   37 ++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-palmz71.c          |    4 +--
 arch/arm/mach-omap1/board-perseus2.c         |   16 +----------
 arch/arm/mach-omap1/clock.c                  |    3 +--
 arch/arm/mach-omap1/common.h                 |   11 +++++++-
 arch/arm/mach-omap1/fpga.c                   |    2 +-
 arch/arm/mach-omap1/id.c                     |    2 ++
 arch/arm/mach-omap1/io.c                     |    3 +--
 arch/arm/mach-omap1/irq.c                    |    2 ++
 arch/arm/mach-omap1/lcd_dma.c                |    7 +----
 arch/arm/{plat-omap => mach-omap1}/ocpi.c    |    7 +++--
 arch/arm/mach-omap1/pm.c                     |    9 +++----
 arch/arm/mach-omap1/reset.c                  |    2 ++
 arch/arm/mach-omap1/timer.c                  |    3 +--
 arch/arm/mach-omap1/usb.c                    |    3 +++
 arch/arm/mach-omap2/am35xx-emac.c            |   37 ++++++++++++--------------
 arch/arm/mach-omap2/board-omap3evm.c         |    8 +++---
 arch/arm/mach-omap2/board-omap4panda.c       |    8 +++---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +--
 arch/arm/mach-omap2/board-zoom-display.c     |    1 +
 arch/arm/mach-omap2/common.h                 |    2 --
 arch/arm/mach-omap2/devices.c                |    7 +++--
 arch/arm/mach-omap2/gpio.c                   |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c           |    3 +--
 arch/arm/mach-omap2/gpmc.c                   |    3 +--
 arch/arm/mach-omap2/hwspinlock.c             |    2 +-
 arch/arm/mach-omap2/io.c                     |    1 +
 arch/arm/mach-omap2/irq.c                    |    3 ++-
 arch/arm/mach-omap2/mux.c                    |    2 +-
 arch/arm/mach-omap2/omap-secure.c            |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                 |    3 ---
 arch/arm/mach-omap2/pm34xx.c                 |   10 +++----
 arch/arm/mach-omap2/prm_common.c             |    4 ++-
 arch/arm/mach-omap2/serial.c                 |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c           |    2 +-
 arch/arm/plat-omap/Makefile                  |    3 ---
 arch/arm/plat-omap/common.c                  |    1 +
 arch/arm/plat-omap/dma.c                     |   13 +++++++--
 arch/arm/plat-omap/dmtimer.c                 |    3 ++-
 arch/arm/plat-omap/include/plat/board.h      |    2 ++
 arch/arm/plat-omap/include/plat/common.h     |    2 ++
 arch/arm/plat-omap/include/plat/dma.h        |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h    |    4 +--
 arch/arm/plat-omap/omap_device.c             |    2 --
 arch/arm/plat-omap/sram.c                    |    4 +--
 arch/arm/plat-omap/usb.c                     |    4 ---
 drivers/usb/host/ohci-omap.c                 |    5 ++--
 53 files changed, 161 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-nand.c
 rename arch/arm/{plat-omap => mach-omap1}/ocpi.c (93%)
