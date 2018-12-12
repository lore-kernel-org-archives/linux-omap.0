From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap1 changes for v4.21
Date: Wed, 12 Dec 2018 10:13:14 -0800
Message-ID: <pull-1544638322-89579@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/omap1-signed

for you to fetch changes up to 5a87809b89b64c0ccd82261de53c41f2fffb56da:

  Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1 (2018-12-11 08:14:58 -0800)

----------------------------------------------------------------
Changes for omap1 variants for v4.21 merge window

In this set of changes Aaro Koskinen revives Palm Tungsten E for the
MMC and USB making it usable again. And Janusz Krzysztofik follows up
on the clean-up of  ams-delta GPIO handling. The other changes are
clean-up for DEFINE_SHOW_ATTRIBUTE by Yangtao Li.

----------------------------------------------------------------
Aaro Koskinen (4):
      ARM: OMAP1/2: fix SoC name printing
      ARM: OMAP1: devices: configure omap1_spi100k only on OMAP7xx
      ARM: OMAP1: add MMC configuration for Palm Tungsten E
      ARM: OMAP1: fix USB configuration for device-only setups

Janusz Krzysztofik (5):
      ARM: OMAP1: ams-delta: make board header file local to mach-omap1
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

Tony Lindgren (1):
      Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1

Yangtao Li (2):
      ARM: OMAP1: clock: Change to use DEFINE_SHOW_ATTRIBUTE macro
      ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro

 arch/arm/mach-omap1/Makefile                       |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c              | 106 ++++++---------------
 .../{include/mach => }/board-ams-delta.h           |  24 +----
 arch/arm/mach-omap1/board-palmte.c                 |  29 ++++++
 arch/arm/mach-omap1/clock.c                        |  14 +--
 arch/arm/mach-omap1/devices.c                      |   3 +
 arch/arm/mach-omap1/id.c                           |   6 +-
 arch/arm/mach-omap1/include/mach/usb.h             |   2 +-
 arch/arm/mach-omap1/pm.c                           |  13 +--
 arch/arm/mach-omap2/id.c                           |   4 +-
 12 files changed, 76 insertions(+), 132 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (66%)
