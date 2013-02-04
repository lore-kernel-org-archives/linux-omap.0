From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap board changes for v3.9 merge window
Date: Mon, 4 Feb 2013 11:55:47 -0800
Message-ID: <E1U2S9J-0002oF-It@merlin.infradead.org>
References: <pull-1360007747-30585>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1360007747-30585>
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

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/board-signed

for you to fetch changes up to 7dc0f27ea43151889ae762d321e4068dd90cd9e2:

  ARM: OMAP2+: omap2plus_defconfig: enable omap1 rtc (2013-02-01 14:59:35 -0800)

----------------------------------------------------------------
Minimal updates to OMAP board-*.c files while converting
things to device tree based booting.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: nokia770: enable CBUS/Retu

AnilKumar Ch (1):
      ARM: OMAP2+: AM33XX: omap2plus_defconfig: Add support for few drivers

Igor Grinberg (1):
      ARM: OMAP3: cm-t3517: add MMC support

Javier Martinez Canillas (3):
      ARM: OMAP3: igep0020: simplify GPIO LEDs dependencies
      ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip support
      ARM: OMAP2+: omap2plus_defconfig: enable CMA allocator

Kim Milo (2):
      ARM: OMAP2+: craneboard: support NAND device
      ARM: OMAP2+: craneboard: support the TPS65910 PMU

Kyungmin Park (1):
      ARM: OMAP2+: Remove apollon board support

Mark Jackson (1):
      ARM: OMAP2+: omap2plus_defconfig: enable omap1 rtc

Pali Rohr (2):
      RX-51: Add leds lp5523 names from Maemo 5 2.6.28 kernel
      RX-51: Register twl4030-madc device

 arch/arm/configs/omap2plus_defconfig             |  25 ++
 arch/arm/mach-omap1/board-nokia770.c             |  43 +++
 arch/arm/mach-omap2/Kconfig                      |   6 -
 arch/arm/mach-omap2/Makefile                     |   1 -
 arch/arm/mach-omap2/board-am3517crane.c          |  59 ++++
 arch/arm/mach-omap2/board-apollon.c              | 342 -----------------------
 arch/arm/mach-omap2/board-cm-t3517.c             |  27 ++
 arch/arm/mach-omap2/board-igep0020.c             |  16 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c     |  20 ++
 arch/arm/mach-omap2/gpmc.c                       |   3 -
 drivers/video/omap2/displays/panel-generic-dpi.c |  24 --
 11 files changed, 182 insertions(+), 384 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-apollon.c
