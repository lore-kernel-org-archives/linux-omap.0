From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH 00/12] mtd: get rid of of_mtd.{c,h} and of_get_nand_xx()
Date: Wed, 6 Apr 2016 18:33:03 -0500
Message-ID: <57059CAF.3030002@ti.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Han Xu <han.xu@nxp.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Agner <stefan@agner.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alex Smith <alex.smith@imgtec.com>, Harvey Hunt <harvey.hunt@imgtec.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-sunxi@googlegroups.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Zhou Wang <wangzhou1@hisilicon.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, bcm-kernel-feedback-list@broadcom.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Daniel Mack <daniel@zonque.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-omap@vger.kernel.org



On 04/01/2016 07:54 AM, Boris Brezillon wrote:
> Hello,
> 
> of_mtd.{h,c} are providing the of_get_nand_xxx() helpers to help NAND
> controller drivers parse some generic NAND DT properties.
> An infrastructure has recently been added to NAND core to automatically
> parse those properties when nand_scan_ident() is called, thus removing
> the need for NAND controller drivers to manually parse them.
> 
> This series modifies drivers still making use of those helpers to rely
> on NAND core initialization, and get rid of the of_mtd.{c,h} files by
> moving the of_get_nand_xx() helpers into nand_base.c.
> 

Nothing broke when I ran some NAND tests on my AM335x GP EVM (OMAP SOC).
Tested-by: Franklin S Cooper Jr. <fcooper@ti.com>

> Best Regards,
> 
> Boris
> 
> Boris Brezillon (12):
>   mtd: nand: remove unneeded of_mtd.h inclusions
>   mtd: nand: atmel: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: omap2: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: brcm: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: davinci: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: gpmi: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: hisi504: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: lpc32xx: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: mxc: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: pxa3xx: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: sh_flctl: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: move of_get_nand_xxx() helpers into nand_base.c
> 
>  drivers/memory/omap-gpmc.c             |   7 --
>  drivers/mtd/nand/atmel_nand.c          | 133 +++++++++++++++-------------
>  drivers/mtd/nand/brcmnand/brcmnand.c   |   5 +-
>  drivers/mtd/nand/davinci_nand.c        |  85 +++++++++---------
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  21 +++--
>  drivers/mtd/nand/hisi504_nand.c        |  14 +--
>  drivers/mtd/nand/jz4780_nand.c         |   1 -
>  drivers/mtd/nand/lpc32xx_mlc.c         |   1 -
>  drivers/mtd/nand/lpc32xx_slc.c         |  24 ++---
>  drivers/mtd/nand/mxc_nand.c            |  50 +++++------
>  drivers/mtd/nand/nand_base.c           |  99 ++++++++++++++++++++-
>  drivers/mtd/nand/omap2.c               |   9 +-
>  drivers/mtd/nand/pxa3xx_nand.c         |  28 +++---
>  drivers/mtd/nand/qcom_nandc.c          |   1 -
>  drivers/mtd/nand/sh_flctl.c            |  31 +++----
>  drivers/mtd/nand/sunxi_nand.c          |   1 -
>  drivers/mtd/nand/vf610_nfc.c           |   1 -
>  drivers/of/Makefile                    |   1 -
>  drivers/of/of_mtd.c                    | 155 ---------------------------------
>  include/linux/of_mtd.h                 |  56 ------------
>  20 files changed, 291 insertions(+), 432 deletions(-)
>  delete mode 100644 drivers/of/of_mtd.c
>  delete mode 100644 include/linux/of_mtd.h
> 
