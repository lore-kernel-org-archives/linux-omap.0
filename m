From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/23] mtd: rawnand: Stop passing mtd_info to drivers
Date: Fri, 17 Aug 2018 18:08:59 +0200
Message-ID: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

This is the first set of patches aiming at cleaning the raw NAND API.

This one focuses on inconsistencies we have in the API + the nand_chip
and nand_ecc_ctrl interfaces. Some functions/hooks are passed a
nand_chip object, some are passed an mtd_info object and some are
passed both.

Since mtd_info can be extracted from nand_chip, we can simply always
pass a nand_chip and make things consistent. Hopefully with these
changes merged we'll stop seeing new drivers reproducing the same
mistake (passing both mtd_info and nand_chip or using mtd_info where
nand_chip is more appropriate).

For those who want to see what's in the pipe, here is a branch [1]
containing all the cleanups I plan to merge.

Regards,

Boris

[1]https://github.com/bbrezillon/linux-0day/commits/nand/api-cleanup

Boris Brezillon (23):
  mtd: rawnand: plat_nand: Pass a nand_chip object to all
    platform_nand_ctrl hooks
  mtd: rawnand: Pass a nand_chip object to nand_scan() & co
  mtd: rawnand: Pass a nand_chip object to nand_release()
  mtd: rawnand: Pass a nand_chip object to nand_wait_ready()
  mtd: rawnand: Pass a nand_chip object to ecc->hwctl()
  mtd: rawnand: Pass a nand_chip object to ecc->calculate()
  mtd: rawnand: Pass a nand_chip object to ecc->correct()
  mtd: rawnand: Pass a nand_chip object to ecc->read_xxx() hooks
  mtd: rawnand: Pass a nand_chip object to ecc->write_xxx() hooks
  mtd: rawnand: Pass a nand_chip object to chip->read_xxx() hooks
  mtd: rawnand: Pass a nand_chip object to chip->write_xxx() hooks
  mtd: rawnand: Pass a nand_chip object to chip->select_chip()
  mtd: rawnand: Pass a nand_chip object to chip->block_xxx() hooks
  mtd: rawnand: Pass a nand_chip object to chip->cmd_ctrl()
  mtd: rawnand: Pass a nand_chip object to chip->dev_ready()
  mtd: rawnand: Pass a nand_chip object to chip->cmdfunc()
  mtd: rawnand: Pass a nand_chip object to chip->waitfunc()
  mtd: rawnand: Pass a nand_chip object to chip->erase()
  mtd: rawnand: Pass a nand_chip object to chip->{get,set}_features()
  mtd: rawnand: Pass a nand_chip object to chip->setup_read_retry()
  mtd: rawnand: Pass a nand_chip object to chip->setup_data_interface()
  mtd: rawnand: Pass a nand_chip object to all nand_xxx_bbt() helpers
  mtd: rawnand: Pass a nand_chip object nand_erase_nand()

 Documentation/driver-api/mtdnand.rst             |   4 +-
 arch/arm/mach-ep93xx/snappercl15.c               |   7 +-
 arch/arm/mach-ep93xx/ts72xx.c                    |   7 +-
 arch/arm/mach-imx/mach-qong.c                    |  11 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c             |   3 +-
 arch/arm/mach-omap1/board-fsample.c              |   2 +-
 arch/arm/mach-omap1/board-h2.c                   |   2 +-
 arch/arm/mach-omap1/board-h3.c                   |   2 +-
 arch/arm/mach-omap1/board-nand.c                 |   3 +-
 arch/arm/mach-omap1/board-perseus2.c             |   2 +-
 arch/arm/mach-omap1/common.h                     |   2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c             |  18 +-
 arch/arm/mach-pxa/balloon3.c                     |   8 +-
 arch/arm/mach-pxa/em-x270.c                      |   5 +-
 arch/arm/mach-pxa/palmtx.c                       |   5 +-
 arch/mips/alchemy/devboards/db1200.c             |   5 +-
 arch/mips/alchemy/devboards/db1300.c             |   5 +-
 arch/mips/alchemy/devboards/db1550.c             |   5 +-
 arch/mips/netlogic/xlr/platform-flash.c          |   4 +-
 arch/mips/pnx833x/common/platform.c              |   3 +-
 arch/mips/rb532/devices.c                        |   5 +-
 arch/sh/boards/mach-migor/setup.c                |   6 +-
 drivers/mtd/nand/raw/ams-delta.c                 |  24 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  74 ++-
 drivers/mtd/nand/raw/au1550nd.c                  |  70 ++-
 drivers/mtd/nand/raw/bcm47xxnflash/main.c        |   2 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  38 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  78 +--
 drivers/mtd/nand/raw/cafe_nand.c                 |  56 +--
 drivers/mtd/nand/raw/cmx270_nand.c               |  20 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  33 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  59 +--
 drivers/mtd/nand/raw/denali.c                    |  87 ++--
 drivers/mtd/nand/raw/diskonchip.c                | 116 ++---
 drivers/mtd/nand/raw/docg4.c                     |  83 ++--
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  52 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  46 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |  34 +-
 drivers/mtd/nand/raw/fsmc_nand.c                 |  42 +-
 drivers/mtd/nand/raw/gpio.c                      |  13 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c        |   3 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  99 ++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h       |   2 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |  44 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  39 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |  30 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  47 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  67 ++-
 drivers/mtd/nand/raw/marvell_nand.c              |  74 ++-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  40 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |  81 ++-
 drivers/mtd/nand/raw/mxc_nand.c                  |  85 ++--
 drivers/mtd/nand/raw/nand_base.c                 | 606 ++++++++++-------------
 drivers/mtd/nand/raw/nand_bbt.c                  |  21 +-
 drivers/mtd/nand/raw/nand_bch.c                  |  10 +-
 drivers/mtd/nand/raw/nand_ecc.c                  |  14 +-
 drivers/mtd/nand/raw/nand_hynix.c                |  12 +-
 drivers/mtd/nand/raw/nand_micron.c               |  16 +-
 drivers/mtd/nand/raw/nandsim.c                   |  28 +-
 drivers/mtd/nand/raw/ndfc.c                      |  25 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  27 +-
 drivers/mtd/nand/raw/omap2.c                     | 148 +++---
 drivers/mtd/nand/raw/orion_nand.c                |  14 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  19 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |  19 +-
 drivers/mtd/nand/raw/plat_nand.c                 |   6 +-
 drivers/mtd/nand/raw/qcom_nandc.c                |  52 +-
 drivers/mtd/nand/raw/r852.c                      |  54 +-
 drivers/mtd/nand/raw/s3c2410.c                   |  72 +--
 drivers/mtd/nand/raw/sh_flctl.c                  |  40 +-
 drivers/mtd/nand/raw/sharpsl.c                   |  24 +-
 drivers/mtd/nand/raw/sm_common.c                 |   5 +-
 drivers/mtd/nand/raw/socrates_nand.c             |  32 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |  82 ++-
 drivers/mtd/nand/raw/tango_nand.c                |  67 ++-
 drivers/mtd/nand/raw/tegra_nand.c                |  36 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |  53 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  38 +-
 drivers/mtd/nand/raw/vf610_nfc.c                 |  43 +-
 drivers/mtd/nand/raw/xway_nand.c                 |  27 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  33 +-
 include/linux/mtd/nand_bch.h                     |  11 +-
 include/linux/mtd/nand_ecc.h                     |   8 +-
 include/linux/mtd/rawnand.h                      | 142 +++---
 84 files changed, 1612 insertions(+), 1824 deletions(-)

-- 
2.14.1
