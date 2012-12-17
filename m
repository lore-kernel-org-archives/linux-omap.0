From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap fixes for v3.8 merge window
Date: Mon, 17 Dec 2012 11:10:46 -0800
Message-ID: <43417.8839125254$1355771493@news.gmane.org>
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

The following changes since commit 2b8318881ddbcb67c5e8d2178b42284749442222:

  Merge tag 'fbdev-for-3.8' of git://gitorious.org/linux-omap-dss2/linux (2012-12-15 13:03:48 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-for-merge-window-v4-signed

for you to fetch changes up to 2cb85a7bd2ca6db3ab3d632d0a1b6ca3770ddcf4:

  Merge branch 'omap-for-v3.8/fixes-for-merge-window' into omap-for-v3.8/fixes-for-merge-window-v2 (2012-12-16 11:28:10 -0800)

----------------------------------------------------------------

These patches fixes a build error caused by a merge
conflict with the fb code, few timer warnings, and longer
term regressions for tfp410 and omap h4 ethernet. Also
included is a GPIO mode fix for the legacy mux code.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: OMAP2+: common: remove use of vram

Jon Hunter (6):
      ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
      ARM: AM335x: Fix warning in timer.c
      ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
      ARM: OMAP: Remove debug-devices.c
      ARM: dts: OMAP2420: Correct H4 board memory size
      ARM: dts: Add build target for omap4-panda-a4

Oleg Matcovschi (1):
      OMAP2+: mux: Fixed gpio mux mode analysis

Roger Quadros (1):
      mfd: omap-usb-host: get rid of cpu_is_omap..() macros

Tomi Valkeinen (1):
      OMAP: board-files: fix i2c_bus for tfp410

Tony Lindgren (3):
      Merge branch 'fixes-timer-build' of git://github.com/jonhunter/linux into omap-for-v3.8/fixes-for-merge-window
      ARM: OMAP: Move plat/omap-serial.h to include/linux/platform_data/serial-omap.h
      Merge branch 'omap-for-v3.8/fixes-for-merge-window' into omap-for-v3.8/fixes-for-merge-window-v2

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix sparse warnings in timer.c

 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/omap2420-h4.dts                  |  2 +-
 arch/arm/mach-omap2/Kconfig                        |  3 +-
 arch/arm/mach-omap2/board-3430sdp.c                |  1 +
 arch/arm/mach-omap2/board-am3517evm.c              |  1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |  1 +
 arch/arm/mach-omap2/board-devkit8000.c             |  1 +
 arch/arm/mach-omap2/board-h4.c                     | 83 +++++--------------
 arch/arm/mach-omap2/board-omap3evm.c               |  1 +
 arch/arm/mach-omap2/board-omap3stalker.c           |  1 +
 arch/arm/mach-omap2/common.c                       |  3 -
 arch/arm/mach-omap2/mux.c                          | 10 +--
 arch/arm/mach-omap2/mux.h                          | 20 +++--
 arch/arm/mach-omap2/mux34xx.c                      |  2 +-
 arch/arm/mach-omap2/serial.c                       |  3 +-
 arch/arm/mach-omap2/timer.c                        |  6 +-
 arch/arm/mach-omap2/usb-host.c                     |  4 +
 arch/arm/plat-omap/Makefile                        |  1 -
 arch/arm/plat-omap/debug-devices.c                 | 92 ----------------------
 arch/arm/plat-omap/include/plat/debug-devices.h    |  2 -
 drivers/mfd/omap-usb-host.c                        |  3 +-
 drivers/tty/serial/omap-serial.c                   |  3 +-
 .../linux/platform_data/serial-omap.h              |  0
 include/linux/platform_data/usb-omap.h             |  3 +
 include/video/omap-panel-tfp410.h                  |  2 +-
 25 files changed, 64 insertions(+), 185 deletions(-)
 delete mode 100644 arch/arm/plat-omap/debug-devices.c
 delete mode 100644 arch/arm/plat-omap/include/plat/debug-devices.h
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (100%)
