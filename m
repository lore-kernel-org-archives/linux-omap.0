From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/12] ARM: randconfig patches for platforms
Date: Thu, 20 Jul 2017 17:45:54 +0200
Message-ID: <20170720154616.3250481-1-arnd@arndb.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Wan ZongShun <mcuos.com@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-arm-kernel@lists.infradead.
List-Id: linux-omap@vger.kernel.org

I've gone through a lot of older patches in my randconfig test
tree, to see which ones are still needed to fix warnings we
get in mainline.

It seems that I posted one series in early 2016 and applied
the patches to my test tree, but never followed up on them.
Some other patches in this series are newer than that and
didn't make it in for some other reason.

Please have another look. If there are no objections, I'd
add them to the fixes-non-critical branch for the next merge
window. None of these seem to be of any importance other than
to shut up the warnings.

       Arnd

Arnd Bergmann (12):
  ARM: ixp4xx: fix ioport_unmap definition
  ARM: ep93xx: use ARM_PATCH_PHYS_VIRT
  ARM: normalize clk API for older platforms
  ARM: sa1100/pxa: fix MTD_XIP build
  ARM: mmp: mark usb_dma_mask as __maybe_unused
  ARM: omap2: mark unused functions as __maybe_unused
  ARM: omap1: avoid unused variable warning
  ARM: sirf: mark sirfsoc_init_late as __maybe_unused
  ARM: ixp4xx: use normal prototype for {read,write}s{b,w,l}
  [v2] ARM: s3c24xx: make H1940BT depend on RFKILL
  ARM: omap1/ams-delta: warn about failed regulator enable
  ARM: rpc: rename RAM_SIZE macro

Cc: Russell King <linux@armlinux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org


 arch/arm/Kconfig                            |  2 +-
 arch/arm/mach-davinci/clock.c               |  6 +++++
 arch/arm/mach-ep93xx/clock.c                | 21 ++++++++++++++++++
 arch/arm/mach-ixp4xx/include/mach/io.h      | 34 ++++++++++++++++++++++-------
 arch/arm/mach-mmp/clock.c                   | 22 +++++++++++++++++++
 arch/arm/mach-mmp/devices.c                 |  2 +-
 arch/arm/mach-omap1/board-ams-delta.c       | 12 ++++++++--
 arch/arm/mach-omap1/board-osk.c             |  4 ----
 arch/arm/mach-omap2/board-generic.c         |  2 +-
 arch/arm/mach-omap2/io.c                    |  2 +-
 arch/arm/mach-prima2/common.c               |  2 +-
 arch/arm/mach-pxa/include/mach/mtd-xip.h    | 10 ++++++---
 arch/arm/mach-rpc/include/mach/hardware.h   |  4 ++--
 arch/arm/mach-s3c24xx/Kconfig               |  2 +-
 arch/arm/mach-sa1100/clock.c                | 29 ++++++++++++++++++++++++
 arch/arm/mach-sa1100/include/mach/mtd-xip.h |  4 ++--
 arch/arm/mach-w90x900/clock.c               | 29 ++++++++++++++++++++++++
 17 files changed, 160 insertions(+), 27 deletions(-)

-- 
2.9.0
