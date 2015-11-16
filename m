From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 00/27] mtd: nand: refactor the NAND subsystem
 (part 1)
Date: Mon, 16 Nov 2015 14:37:33 +0100
Message-ID: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBPFYU6ZAKGQEA7URA4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>a
List-Id: linux-omap@vger.kernel.org

Hello,

This huge series aims at clarifying the relationship between the mtd and
nand_chip structures and hiding NAND framework internals to NAND
controller drivers.

The first part of the series provide an mtd_to_nand() helper to hide the
way mtd and nand_chip are linked together.

The second part of the series embeds the mtd structure into the nand_chip
one so that NAND controller drivers don't have to bother allocating the
MTD device and linking it with the NAND chip.

The last part of the series hides accesses to the chip->priv field behind
two helper functions.

This allows removal of some of the boilerplate code done in all NAND
controller drivers, but most importantly, it unifies a bit the way NAND
chip structures are instantiated (even though we still have two different
kinds of drivers: those embedding the nand_chip struct into their private
nand chip representation, and those allocating two different structures
and linking them together with the chip->priv field).

As said in the title, this refactoring is only the first step. I plan to
rework the NAND controller / NAND chip separation for pretty much the same
reasons: clarifying the separation between the two concepts, and getting
rid of more boilerplate code in NAND controller drivers.

Stay tuned ;-).

Best Regards,

Boris

Boris Brezillon (27):
  mtd: nand: fix drivers abusing mtd->priv
  mtd: nand: add an mtd_to_nand() helper
  mtd: nand: update examples in the documentation to use mtd_to_nand()
  ARM: nand: make use of mtd_to_nand() where appropriate
  blackfin: nand: make use of mtd_to_nand() where appropriate
  cris: nand: make use of mtd_to_nand() where appropriate
  mips: nand: make use of mtd_to_nand() where appropriate
  sh: nand: make use of mtd_to_nand() where appropriate
  mtd: nand: make use of mtd_to_nand() in NAND core code
  mtd: nand: make use of mtd_to_nand() in NAND drivers
  staging: mt29f_spinand: make use of mtd_to_nand()
  mtd: nand: embed an mtd_info structure into nand_chip
  mtd: nand: add nand_to_mtd() helper
  mtd: nand: use the mtd instance embedded in struct nand_chip
  mtd: nand: update the documentation to reflect framework changes
  staging: mt29f_spinand: use the mtd instance embedded in struct
    nand_chip
  cris: nand: use the mtd instance embedded in struct nand_chip
  mtd: nand: update mtd_to_nand()
  mtd: nand: remove useless mtd->priv = chip assignments
  cris: nand: remove useless mtd->priv = chip assignments
  staging: mt29f_spinand: remove useless mtd->priv = chip assignment
  mtd: nand: simplify nand_dt_init() usage
  mtd: nand: kill the chip->flash_node field
  mtd: nand: add helpers to access ->priv
  ARM: make use of nand_set/get_controller_data() helpers
  mtd: nand: make use of nand_set/get_controller_data() helpers
  staging: mt29f_spinand: make use of nand_set/get_controller_data()
    helpers

 Documentation/DocBook/mtdnand.tmpl             |  35 +++---
 arch/arm/mach-ep93xx/snappercl15.c             |   4 +-
 arch/arm/mach-ep93xx/ts72xx.c                  |   4 +-
 arch/arm/mach-imx/mach-qong.c                  |   2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |   6 +-
 arch/arm/mach-omap1/board-nand.c               |   2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |   6 +-
 arch/arm/mach-pxa/balloon3.c                   |   2 +-
 arch/arm/mach-pxa/em-x270.c                    |   2 +-
 arch/arm/mach-pxa/palmtx.c                     |   2 +-
 arch/blackfin/mach-bf537/boards/stamp.c        |   2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c      |   2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c |   8 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c |   8 +-
 arch/mips/alchemy/devboards/db1200.c           |   2 +-
 arch/mips/alchemy/devboards/db1300.c           |   2 +-
 arch/mips/alchemy/devboards/db1550.c           |   2 +-
 arch/mips/pnx833x/common/platform.c            |   2 +-
 arch/mips/rb532/devices.c                      |   2 +-
 arch/sh/boards/mach-migor/setup.c              |   2 +-
 drivers/mtd/nand/ams-delta.c                   |  26 ++---
 drivers/mtd/nand/atmel_nand.c                  | 116 ++++++++++---------
 drivers/mtd/nand/au1550nd.c                    |  40 +++----
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |   1 -
 drivers/mtd/nand/bcm47xxnflash/main.c          |   9 +-
 drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  34 +++---
 drivers/mtd/nand/bf5xx_nand.c                  |  27 +++--
 drivers/mtd/nand/brcmnand/brcmnand.c           |  54 +++++----
 drivers/mtd/nand/cafe_nand.c                   |  41 ++++---
 drivers/mtd/nand/cmx270_nand.c                 |  20 ++--
 drivers/mtd/nand/cs553x_nand.c                 |  30 +++--
 drivers/mtd/nand/davinci_nand.c                |  33 +++---
 drivers/mtd/nand/denali.c                      |  61 +++++-----
 drivers/mtd/nand/denali.h                      |   1 -
 drivers/mtd/nand/diskonchip.c                  | 148 ++++++++++++-------------
 drivers/mtd/nand/docg4.c                       |  93 ++++++++--------
 drivers/mtd/nand/fsl_elbc_nand.c               |  58 +++++-----
 drivers/mtd/nand/fsl_ifc_nand.c                |  67 ++++++-----
 drivers/mtd/nand/fsl_upm.c                     |  30 ++---
 drivers/mtd/nand/fsmc_nand.c                   |  72 ++++++------
 drivers/mtd/nand/gpio.c                        |  16 +--
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |   2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c         |  67 ++++++-----
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |   1 -
 drivers/mtd/nand/hisi504_nand.c                |  48 ++++----
 drivers/mtd/nand/jz4740_nand.c                 |  14 +--
 drivers/mtd/nand/lpc32xx_mlc.c                 |  32 +++---
 drivers/mtd/nand/lpc32xx_slc.c                 |  42 ++++---
 drivers/mtd/nand/mpc5121_nfc.c                 |  52 +++++----
 drivers/mtd/nand/mxc_nand.c                    |  76 +++++++------
 drivers/mtd/nand/nand_base.c                   | 102 +++++++++--------
 drivers/mtd/nand/nand_bbt.c                    |  32 +++---
 drivers/mtd/nand/nand_bch.c                    |   4 +-
 drivers/mtd/nand/nand_ecc.c                    |   4 +-
 drivers/mtd/nand/nandsim.c                     |  34 +++---
 drivers/mtd/nand/ndfc.c                        |  52 ++++-----
 drivers/mtd/nand/nuc900_nand.c                 |  23 ++--
 drivers/mtd/nand/omap2.c                       | 107 ++++++++++--------
 drivers/mtd/nand/orion_nand.c                  |  13 +--
 drivers/mtd/nand/pasemi_nand.c                 |  21 ++--
 drivers/mtd/nand/plat_nand.c                   |  16 +--
 drivers/mtd/nand/pxa3xx_nand.c                 |  66 ++++++-----
 drivers/mtd/nand/r852.c                        |  41 +++----
 drivers/mtd/nand/r852.h                        |   1 -
 drivers/mtd/nand/s3c2410.c                     |  29 ++---
 drivers/mtd/nand/sh_flctl.c                    |   9 +-
 drivers/mtd/nand/sharpsl.c                     |  20 ++--
 drivers/mtd/nand/sm_common.c                   |   2 +-
 drivers/mtd/nand/socrates_nand.c               |  24 ++--
 drivers/mtd/nand/sunxi_nand.c                  |  40 +++----
 drivers/mtd/nand/tmio_nand.c                   |  10 +-
 drivers/mtd/nand/txx9ndfmc.c                   |  25 ++---
 drivers/mtd/nand/vf610_nfc.c                   |   6 +-
 drivers/mtd/nand/xway_nand.c                   |   4 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c  |  19 ++--
 include/linux/mtd/nand.h                       |  29 ++++-
 include/linux/mtd/sh_flctl.h                   |   3 +-
 77 files changed, 1067 insertions(+), 1077 deletions(-)

-- 
2.1.4
