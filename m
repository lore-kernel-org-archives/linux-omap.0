From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes v4.11-rc cycle
Date: Mon,  6 Mar 2017 08:46:42 -0800
Message-ID: <21644.2054058009$1505298312@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc1-v2

for you to fetch changes up to e24bce8fb4c26bd0d8eca74cbbee1ad049246be3:

  Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes (2017-03-06 08:37:53 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.11-rc cycle:

- Fix smartreflex platform data regression where I accidentally
  removed legacy platform data still in use

- Fix hypervisor mode for thumb2 kernel

- Fix misplaced tpic2810 to move it to right bus

- Enable INPUT_MOUSEDEV as a loadable module have mice working

- Fix use of gpio-key,wakeup and use wakeup-source instead as
  this accidentally sneaked in during the merge window

- Fix error handling for onenand to properly return error

- Remove legacy gpmc-nand.c that's now dead code, this
  also removes dependency to the MTD tree for further driver
  changes

- Fix device node reference count errors for omap3 and
  related to it also release device nodes after no longer
  needed

----------------------------------------------------------------
Guenter Roeck (2):
      ARM: OMAP2+: Fix device node reference counts
      ARM: OMAP2+: Release device node after it is no longer needed.

Ladislav Michl (2):
      ARM: OMAP2+: gpmc-onenand: propagate error on initialization failure
      ARM: OMAP2+: Remove legacy gpmc-nand.c

Matthijs van Duin (1):
      ARM: OMAP5 / DRA7: Fix HYP mode boot for thumb2 build

Sekhar Nori (1):
      ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI

Teresa Remmet (1):
      ARM: dts: am335x-pcm953: Fix legacy wakeup source binding

Tony Lindgren (5):
      ARM: OMAP3: Fix smartreflex platform data regression
      Merge branch 'omap-for-v4.10/fixes' into omap-for-v4.11/fixes
      ARM: omap2plus_defconfig: Enable INPUT_MOUSEDEV as loadable modules
      Merge branch 'gpio-key-wakeup-fix' into omap-for-v4.11/fixes
      Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes

 arch/arm/boot/dts/am335x-pcm-953.dtsi      |   4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi   |  14 +--
 arch/arm/configs/omap2plus_defconfig       |   1 +
 arch/arm/mach-omap2/Makefile               |   3 -
 arch/arm/mach-omap2/gpmc-nand.c            | 154 -----------------------------
 arch/arm/mach-omap2/gpmc-onenand.c         |  10 +-
 arch/arm/mach-omap2/omap-headsmp.S         |   3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  45 +++++++--
 drivers/memory/omap-gpmc.c                 |   4 +-
 include/linux/omap-gpmc.h                  |  16 +--
 10 files changed, 59 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-nand.c
