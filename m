From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Wed, 20 May 2015 15:36:05 -0700
Message-ID: <24089.1311470934$1432161461@news.gmane.org>
References: <pull-1432161303-403113>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1432161303-403113>
In-Reply-To: <pull-1432161303-403113>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/omap1

for you to fetch changes up to 685e2d08c54b1a1bf31bbe6562f06db089d31c7b:

  ARM: OMAP1: Change interrupt numbering for sparse IRQ (2015-05-20 09:01:21 -0700)

----------------------------------------------------------------
Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
to making omap1 support multiarch. After this series we still need to
make omap1 use the common clock framework and fix up the drivers to not
rely on includes from mach and plat directories.

Note that this branch depends on a GPIO driver fix in v4.1-rc3
d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").

----------------------------------------------------------------
Tony Lindgren (4):
      ARM: OMAP1: Move UART defines to prepare for sparse IRQ
      ARM: OMAP1: Switch to use generic irqchip in preparation for sparse IRQ
      ARM: omap1: Switch to use MULTI_IRQ
      ARM: OMAP1: Change interrupt numbering for sparse IRQ

 arch/arm/Kconfig                               |   2 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c          |   1 +
 arch/arm/mach-omap1/board-fsample.c            |   1 +
 arch/arm/mach-omap1/board-generic.c            |   1 +
 arch/arm/mach-omap1/board-h2.c                 |   1 +
 arch/arm/mach-omap1/board-h3.c                 |   1 +
 arch/arm/mach-omap1/board-htcherald.c          |   1 +
 arch/arm/mach-omap1/board-innovator.c          |   1 +
 arch/arm/mach-omap1/board-nokia770.c           |   1 +
 arch/arm/mach-omap1/board-osk.c                |   1 +
 arch/arm/mach-omap1/board-palmte.c             |   1 +
 arch/arm/mach-omap1/board-palmtt.c             |   1 +
 arch/arm/mach-omap1/board-palmz71.c            |   1 +
 arch/arm/mach-omap1/board-perseus2.c           |   1 +
 arch/arm/mach-omap1/board-sx1.c                |   1 +
 arch/arm/mach-omap1/board-voiceblue.c          |   1 +
 arch/arm/mach-omap1/common.h                   |   5 +-
 arch/arm/mach-omap1/dma.c                      |   2 +-
 arch/arm/mach-omap1/i2c.c                      |   3 +-
 arch/arm/mach-omap1/include/mach/entry-macro.S |  39 ------
 arch/arm/mach-omap1/include/mach/irqs.h        | 124 ++++++++++---------
 arch/arm/mach-omap1/include/mach/serial.h      |   5 -
 arch/arm/mach-omap1/include/mach/soc.h         |   4 +
 arch/arm/mach-omap1/irq.c                      | 157 +++++++++++++++----------
 arch/arm/mach-omap1/timer.c                    |   4 +-
 arch/arm/plat-omap/dma.c                       |   4 +
 include/uapi/linux/serial_reg.h                |   3 +
 28 files changed, 190 insertions(+), 180 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S
