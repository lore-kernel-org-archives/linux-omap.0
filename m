From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] First set of omap1 related changes
Date: Wed, 29 Feb 2012 12:15:06 -0800
Message-ID: <E1S2pw8-0004bV-6v@merlin.infradead.org>
References: <pull-1330546506-268554>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1330546506-268554>
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

These too we considered too late for the last merge window,
there will be another set coming after this.

Regards,

Tony

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1

Janusz Krzysztofik (7):
      ARM: OMAP1: ams-delta: register latch dependent devices later
      ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
      ARM: OMAP1: ams-delta: supersede custom led device by leds-gpio
      LED: drop leds-ams-delta driver
      MTD: NAND: ams-delta: use GPIO instead of custom I/O
      omapfb: lcd_ams_delta: drive control lines over GPIO
      input: serio: ams-delta: toggle keyboard power over GPIO

Tony Lindgren (1):
      Merge branch 'omap1-part2' into omap1

 arch/arm/mach-omap1/Kconfig                       |    2 +
 arch/arm/mach-omap1/board-ams-delta.c             |  226 +++++++++++++++++----
 arch/arm/plat-omap/include/plat/board-ams-delta.h |   48 ++---
 drivers/input/serio/ams_delta_serio.c             |   54 +++--
 drivers/leds/Kconfig                              |    7 -
 drivers/leds/Makefile                             |    1 -
 drivers/leds/leds-ams-delta.c                     |  126 ------------
 drivers/mtd/nand/ams-delta.c                      |   74 +++++--
 drivers/video/omap/lcd_ams_delta.c                |   27 ++-
 sound/soc/omap/ams-delta.c                        |    2 +-
 10 files changed, 318 insertions(+), 249 deletions(-)
 delete mode 100644 drivers/leds/leds-ams-delta.c
