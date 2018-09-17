From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 00/19] mtd: rawnand: API cleanup (2nd batch)
Date: Mon, 17 Sep 2018 10:29:39 +0200
Message-ID: <20180917102939.3ff716db@bbrezillon>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
 <20180915195440.251fea18@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180915195440.251fea18@xps13>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 15 Sep 2018 19:54:40 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Fri,  7 Sep 2018
> 00:38:32 +0200:
> 
> > Hello,
> > 
> > This is the 2nd batch of API cleanup patches. This time we move
> > deprecated hooks/fields to the nand_legacy struct, and then move some
> > of the code found in nand_base.c into separate source/header files.
> > 
> > With this new organization, new comers should more easily identify the
> > bits they can use in their NAND controller drivers and those that are
> > only meant for core code. It also shrink a bit nand_base.c which was
> > over 6000 lines of code.
> > 
> > Note that existing coding style issues (reported by checkpatch) in arch
> > or driver code are intentionally not fixed to keep the series focused
> > on the API/core cleanup.
> > 
> > Regards,
> > 
> > Boris
> > 
> > Boris Brezillon (19):
> >   mtd: rawnand: Leave chip->IO_ADDR_{R,W} to NULL when unused
> >   mtd: rawnand: Create a legacy struct and move ->IO_ADDR_{R,W} there
> >   mtd: rawnand: Deprecate ->{read,write}_{byte,buf}() hooks
> >   mtd: rawnand: Deprecate ->cmd_ctrl() and ->cmdfunc()
> >   mtd: rawnand: Deprecate ->dev_ready() and ->waitfunc()
> >   mtd: rawnand: Deprecate ->block_{bad,markbad}() hooks
> >   mtd: rawnand: Deprecate ->erase()
> >   mtd: rawnand: Deprecate ->{set,get}_features() hooks
> >   mtd: rawnand: Deprecate ->chip_delay
> >   mtd: rawnand: Move function prototypes after struct declarations
> >   mtd: rawnand: Get rid of nand_flash_dev forward declation
> >   mtd: rawnand: Get rid of the duplicate nand_chip forward declaration
> >   mtd: rawnand: Get rid of a few unused definitions
> >   mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h
> >   mtd: rawnand: Inline onfi_get_async_timing_mode()
> >   mtd: rawnand: Keep all internal stuff private
> >   mtd: rawnand: Move legacy code to nand_legacy.c
> >   mtd: rawnand: Move ONFI code to nand_onfi.c
> >   mtd: rawnand: Move JEDEC code to nand_jedec.c
> > 
> >  Documentation/driver-api/mtdnand.rst             |   30 +-
> >  arch/arm/mach-ep93xx/snappercl15.c               |    8 +-
> >  arch/arm/mach-ep93xx/ts72xx.c                    |    9 +-
> >  arch/arm/mach-imx/mach-qong.c                    |    6 +-
> >  arch/arm/mach-ixp4xx/ixdp425-setup.c             |    2 +-
> >  arch/arm/mach-omap1/board-fsample.c              |    3 +-
> >  arch/arm/mach-omap1/board-h2.c                   |    3 +-
> >  arch/arm/mach-omap1/board-h3.c                   |    2 +-
> >  arch/arm/mach-omap1/board-nand.c                 |    2 +-
> >  arch/arm/mach-omap1/board-perseus2.c             |    3 +-
> >  arch/arm/mach-orion5x/ts78xx-setup.c             |    9 +-
> >  arch/arm/mach-pxa/balloon3.c                     |    5 +-
> >  arch/arm/mach-pxa/em-x270.c                      |    9 +-
> >  arch/arm/mach-pxa/palmtx.c                       |    5 +-
> >  arch/mips/alchemy/devboards/db1200.c             |    9 +-
> >  arch/mips/alchemy/devboards/db1300.c             |    9 +-
> >  arch/mips/alchemy/devboards/db1550.c             |    9 +-
> >  arch/mips/netlogic/xlr/platform-flash.c          |    3 +-
> >  arch/mips/pnx833x/common/platform.c              |    5 +-
> >  arch/mips/rb532/devices.c                        |    5 +-
> >  arch/sh/boards/mach-migor/setup.c                |    8 +-
> >  drivers/mtd/nand/raw/Makefile                    |    4 +-
> >  drivers/mtd/nand/raw/ams-delta.c                 |   22 +-
> >  drivers/mtd/nand/raw/atmel/nand-controller.c     |   22 +-
> >  drivers/mtd/nand/raw/au1550nd.c                  |   43 +-
> >  drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |   22 +-
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c         |   15 +-
> >  drivers/mtd/nand/raw/cafe_nand.c                 |   22 +-
> >  drivers/mtd/nand/raw/cmx270_nand.c               |   28 +-
> >  drivers/mtd/nand/raw/cs553x_nand.c               |   42 +-
> >  drivers/mtd/nand/raw/davinci_nand.c              |   34 +-
> >  drivers/mtd/nand/raw/denali.c                    |   23 +-
> >  drivers/mtd/nand/raw/diskonchip.c                |   50 +-
> >  drivers/mtd/nand/raw/fsl_elbc_nand.c             |   18 +-
> >  drivers/mtd/nand/raw/fsl_ifc_nand.c              |   24 +-
> >  drivers/mtd/nand/raw/fsl_upm.c                   |   30 +-
> >  drivers/mtd/nand/raw/fsmc_nand.c                 |    1 -
> >  drivers/mtd/nand/raw/gpio.c                      |   16 +-
> >  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |   22 +-
> >  drivers/mtd/nand/raw/hisi504_nand.c              |   18 +-
> >  drivers/mtd/nand/raw/internals.h                 |  114 ++
> >  drivers/mtd/nand/raw/jz4740_nand.c               |   14 +-
> >  drivers/mtd/nand/raw/jz4780_nand.c               |   10 +-
> >  drivers/mtd/nand/raw/lpc32xx_mlc.c               |   12 +-
> >  drivers/mtd/nand/raw/lpc32xx_slc.c               |   26 +-
> >  drivers/mtd/nand/raw/mpc5121_nfc.c               |   14 +-
> >  drivers/mtd/nand/raw/mtk_nand.c                  |   12 +-
> >  drivers/mtd/nand/raw/mxc_nand.c                  |   20 +-
> >  drivers/mtd/nand/raw/nand_amd.c                  |    2 +-
> >  drivers/mtd/nand/raw/nand_base.c                 | 1260 +++-------------------
> >  drivers/mtd/nand/raw/nand_bbt.c                  |    5 +-
> >  drivers/mtd/nand/raw/nand_hynix.c                |    9 +-
> >  drivers/mtd/nand/raw/nand_ids.c                  |    4 +-
> >  drivers/mtd/nand/raw/nand_jedec.c                |  113 ++
> >  drivers/mtd/nand/raw/nand_legacy.c               |  642 +++++++++++
> >  drivers/mtd/nand/raw/nand_macronix.c             |    2 +-
> >  drivers/mtd/nand/raw/nand_micron.c               |    3 +-
> >  drivers/mtd/nand/raw/nand_onfi.c                 |  305 ++++++
> >  drivers/mtd/nand/raw/nand_samsung.c              |    2 +-
> >  drivers/mtd/nand/raw/nand_timings.c              |   18 +-
> >  drivers/mtd/nand/raw/nand_toshiba.c              |    2 +-
> >  drivers/mtd/nand/raw/nandsim.c                   |   14 +-
> >  drivers/mtd/nand/raw/ndfc.c                      |   14 +-
> >  drivers/mtd/nand/raw/nuc900_nand.c               |   22 +-
> >  drivers/mtd/nand/raw/omap2.c                     |   62 +-
> >  drivers/mtd/nand/raw/orion_nand.c                |   12 +-
> >  drivers/mtd/nand/raw/oxnas_nand.c                |   10 +-
> >  drivers/mtd/nand/raw/pasemi_nand.c               |   32 +-
> >  drivers/mtd/nand/raw/plat_nand.c                 |   17 +-
> >  drivers/mtd/nand/raw/qcom_nandc.c                |   39 +-
> >  drivers/mtd/nand/raw/r852.c                      |   14 +-
> >  drivers/mtd/nand/raw/s3c2410.c                   |   34 +-
> >  drivers/mtd/nand/raw/sh_flctl.c                  |   18 +-
> >  drivers/mtd/nand/raw/sharpsl.c                   |   12 +-
> >  drivers/mtd/nand/raw/sm_common.c                 |    2 +-
> >  drivers/mtd/nand/raw/socrates_nand.c             |   16 +-
> >  drivers/mtd/nand/raw/sunxi_nand.c                |   14 +-
> >  drivers/mtd/nand/raw/tango_nand.c                |   12 +-
> >  drivers/mtd/nand/raw/tmio_nand.c                 |   20 +-
> >  drivers/mtd/nand/raw/txx9ndfmc.c                 |   12 +-
> >  drivers/mtd/nand/raw/xway_nand.c                 |   12 +-
> >  drivers/staging/mt29f_spinand/mt29f_spinand.c    |   16 +-
> >  include/linux/mtd/jedec.h                        |   91 ++
> >  include/linux/mtd/onfi.h                         |  178 +++
> >  include/linux/mtd/platnand.h                     |   74 ++
> >  include/linux/mtd/rawnand.h                      |  555 ++--------
> >  86 files changed, 2300 insertions(+), 2191 deletions(-)
> >  create mode 100644 drivers/mtd/nand/raw/internals.h
> >  create mode 100644 drivers/mtd/nand/raw/nand_jedec.c
> >  create mode 100644 drivers/mtd/nand/raw/nand_legacy.c
> >  create mode 100644 drivers/mtd/nand/raw/nand_onfi.c
> >  create mode 100644 include/linux/mtd/jedec.h
> >  create mode 100644 include/linux/mtd/onfi.h
> >  create mode 100644 include/linux/mtd/platnand.h
> >   
> 
> Series reviewed, there is one typo in patch 2/19 and 16/19 and a
> s/ONFI/JEDEC/ in patch 19/19, otherwise I like the cleanup very much!
> Can I modify when applying or you plan to do more/other changes?

Yep, you can fix+apply the series if you're happy with it.

Thanks,

Boris
