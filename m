From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 00/58]  mtd: nand: refactor the NAND
 subsystem (part 1)
Date: Thu, 10 Dec 2015 08:59:44 +0100
Message-ID: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBNHCUSZQKGQEIOYR5HY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The first part of the series (patch 1 to 4) is a set of fixes/simple
reworks easing the migration to mtd_to_nand().

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

Changes since v3:
- fix some bugs introduced when migrating to nand_to_mtd()
- split the huge commit switching all drivers to nand_to_mtd() into several
  commits (one per driver) to ease review and integration
- add a simple fixes/reworks at the beginning of the series (mainly to
  ease migration to nand_to_mtd())
- drop already applied patches.

Changes since v2:
- fix some build warnings/erros

Changes since v1:
- dropped already applied patches
- fixed some typos
- manually fixed some modifications omitted by the coccinelle scripts
- manually reworked modifactions done by coccinelle scripts to improve
  readability and fix coding style issues

*** BLURB HERE ***

Boris Brezillon (58):
  mtd: nand: denali: add missing nand_release() call in denali_remove()
  mtd: nand: fsmc: create and use mtd_to_fsmc()
  mtd: nand: nuc900: create and use mtd_to_nuc900()
  mtd: nand: omap2: create and use mtd_to_omap()
  mtd: nand: ams-delta: use the mtd instance embedded in struct
    nand_chip
  mtd: nand: atmel: use the mtd instance embedded in struct nand_chip
  mtd: nand: au1550nd: use the mtd instance embedded in struct nand_chip
  mtd: nand: bcm47xx: use the mtd instance embedded in struct nand_chip
  mtd: nand: bf5xx: use the mtd instance embedded in struct nand_chip
  mtd: nand: brcm: use the mtd instance embedded in struct nand_chip
  mtd: nand: cafe: use the mtd instance embedded in struct nand_chip
  mtd: nand: cmx270: use the mtd instance embedded in struct nand_chip
  mtd: nand: cs553x: use the mtd instance embedded in struct nand_chip
  mtd: nand: davinci: use the mtd instance embedded in struct nand_chip
  mtd: nand: denali: use the mtd instance embedded in struct nand_chip
  mtd: nand: diskonchip: use the mtd instance embedded in struct
    nand_chip
  mtd: nand: docg4: use the mtd instance embedded in struct nand_chip
  mtd: nand: fsl_elbc: use the mtd instance embedded in struct nand_chip
  mtd: nand: fsl_ifc: use the mtd instance embedded in struct nand_chip
  mtd: nand: fsl_upm: use the mtd instance embedded in struct nand_chip
  mtd: nand: fsmc: use the mtd instance embedded in struct nand_chip
  mtd: nand: gpio: use the mtd instance embedded in struct nand_chip
  mtd: nand: gpmi: use the mtd instance embedded in struct nand_chip
  mtd: nand: hisi504: use the mtd instance embedded in struct nand_chip
  mtd: nand: jz4740: use the mtd instance embedded in struct nand_chip
  mtd: nand: lpc32xx: use the mtd instance embedded in struct nand_chip
  mtd: nand: mpc5121: use the mtd instance embedded in struct nand_chip
  mtd: nand: mxc: use the mtd instance embedded in struct nand_chip
  mtd: nand: nandsim: use the mtd instance embedded in struct nand_chip
  mtd: nand: ndfc: use the mtd instance embedded in struct nand_chip
  mtd: nand: nuc900: use the mtd instance embedded in struct nand_chip
  mtd: nand: omap2: use the mtd instance embedded in struct nand_chip
  mtd: nand: orion: use the mtd instance embedded in struct nand_chip
  mtd: nand: pasemi: use the mtd instance embedded in struct nand_chip
  mtd: nand: plat: use the mtd instance embedded in struct nand_chip
  mtd: nand: pxa3xx: use the mtd instance embedded in struct nand_chip
  mtd: nand: r852: use the mtd instance embedded in struct nand_chip
  mtd: nand: s3c2410: use the mtd instance embedded in struct nand_chip
  mtd: nand: sh_flctl: use the mtd instance embedded in struct nand_chip
  mtd: nand: sharpsl: use the mtd instance embedded in struct nand_chip
  mtd: nand: socrates: use the mtd instance embedded in struct nand_chip
  mtd: nand: sunxi: use the mtd instance embedded in struct nand_chip
  mtd: nand: tmio: use the mtd instance embedded in struct nand_chip
  mtd: nand: txx9ndfmc: use the mtd instance embedded in struct
    nand_chip
  mtd: nand: vf610: use the mtd instance embedded in struct nand_chip
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

 Documentation/DocBook/mtdnand.tmpl             | 31 +++++-----
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |  4 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c |  6 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c |  6 +-
 drivers/mtd/nand/ams-delta.c                   | 22 +++----
 drivers/mtd/nand/atmel_nand.c                  | 69 ++++++++++-----------
 drivers/mtd/nand/au1550nd.c                    | 18 +++---
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |  1 -
 drivers/mtd/nand/bcm47xxnflash/main.c          |  9 +--
 drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   | 18 +++---
 drivers/mtd/nand/bf5xx_nand.c                  | 13 ++--
 drivers/mtd/nand/brcmnand/brcmnand.c           | 44 +++++++------
 drivers/mtd/nand/cafe_nand.c                   | 35 ++++++-----
 drivers/mtd/nand/cmx270_nand.c                 | 14 ++---
 drivers/mtd/nand/cs553x_nand.c                 | 18 +++---
 drivers/mtd/nand/davinci_nand.c                | 29 ++++-----
 drivers/mtd/nand/denali.c                      | 68 ++++++++++++---------
 drivers/mtd/nand/denali.h                      |  1 -
 drivers/mtd/nand/diskonchip.c                  | 85 +++++++++++++-------------
 drivers/mtd/nand/docg4.c                       | 66 ++++++++++----------
 drivers/mtd/nand/fsl_elbc_nand.c               | 47 +++++++-------
 drivers/mtd/nand/fsl_ifc_nand.c                | 53 ++++++++--------
 drivers/mtd/nand/fsl_upm.c                     | 28 +++++----
 drivers/mtd/nand/fsmc_nand.c                   | 54 ++++++++--------
 drivers/mtd/nand/gpio.c                        | 20 +++---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c         | 52 ++++++++--------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |  1 -
 drivers/mtd/nand/hisi504_nand.c                | 34 +++++------
 drivers/mtd/nand/jz4740_nand.c                 | 10 ++-
 drivers/mtd/nand/lpc32xx_mlc.c                 | 27 ++++----
 drivers/mtd/nand/lpc32xx_slc.c                 | 28 ++++-----
 drivers/mtd/nand/mpc5121_nfc.c                 | 28 ++++-----
 drivers/mtd/nand/mxc_nand.c                    | 42 ++++++-------
 drivers/mtd/nand/nand_base.c                   | 18 +++---
 drivers/mtd/nand/nandsim.c                     | 17 +++---
 drivers/mtd/nand/ndfc.c                        | 39 ++++++------
 drivers/mtd/nand/nuc900_nand.c                 | 38 +++++-------
 drivers/mtd/nand/omap2.c                       | 68 ++++++++-------------
 drivers/mtd/nand/orion_nand.c                  |  9 ++-
 drivers/mtd/nand/pasemi_nand.c                 | 13 ++--
 drivers/mtd/nand/plat_nand.c                   | 16 ++---
 drivers/mtd/nand/pxa3xx_nand.c                 | 54 ++++++++--------
 drivers/mtd/nand/r852.c                        | 39 ++++++------
 drivers/mtd/nand/r852.h                        |  1 -
 drivers/mtd/nand/s3c2410.c                     | 25 ++++----
 drivers/mtd/nand/sh_flctl.c                    |  9 ++-
 drivers/mtd/nand/sharpsl.c                     | 21 ++++---
 drivers/mtd/nand/socrates_nand.c               | 17 +++---
 drivers/mtd/nand/sunxi_nand.c                  | 14 ++---
 drivers/mtd/nand/tmio_nand.c                   | 11 ++--
 drivers/mtd/nand/txx9ndfmc.c                   | 13 ++--
 drivers/mtd/nand/vf610_nfc.c                   |  9 +--
 drivers/staging/mt29f_spinand/mt29f_spinand.c  | 15 ++---
 include/linux/mtd/nand.h                       | 19 ++++--
 include/linux/mtd/sh_flctl.h                   |  3 +-
 56 files changed, 699 insertions(+), 752 deletions(-)

-- 
2.1.4
