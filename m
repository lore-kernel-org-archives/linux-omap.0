From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 00/12] mtd: get rid of of_mtd.{c,h} and of_get_nand_xx()
Date: Fri,  1 Apr 2016 14:54:20 +0200
Message-ID: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBFW77G3QKGQEYR24RTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Zhou Wang <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Harvey Hunt <harvey.hunt-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

of_mtd.{h,c} are providing the of_get_nand_xxx() helpers to help NAND
controller drivers parse some generic NAND DT properties.
An infrastructure has recently been added to NAND core to automatically
parse those properties when nand_scan_ident() is called, thus removing
the need for NAND controller drivers to manually parse them.

This series modifies drivers still making use of those helpers to rely
on NAND core initialization, and get rid of the of_mtd.{c,h} files by
moving the of_get_nand_xx() helpers into nand_base.c.

Best Regards,

Boris

Boris Brezillon (12):
  mtd: nand: remove unneeded of_mtd.h inclusions
  mtd: nand: atmel: rely on generic DT parsing done in nand_scan_ident()
  mtd: nand: omap2: rely on generic DT parsing done in nand_scan_ident()
  mtd: nand: brcm: rely on generic DT parsing done in nand_scan_ident()
  mtd: nand: davinci: rely on generic DT parsing done in
    nand_scan_ident()
  mtd: nand: gpmi: rely on generic DT parsing done in nand_scan_ident()
  mtd: nand: hisi504: rely on generic DT parsing done in
    nand_scan_ident()
  mtd: nand: lpc32xx: rely on generic DT parsing done in
    nand_scan_ident()
  mtd: nand: mxc: rely on generic DT parsing done in nand_scan_ident()
  mtd: nand: pxa3xx: rely on generic DT parsing done in
    nand_scan_ident()
  mtd: nand: sh_flctl: rely on generic DT parsing done in
    nand_scan_ident()
  mtd: nand: move of_get_nand_xxx() helpers into nand_base.c

 drivers/memory/omap-gpmc.c             |   7 --
 drivers/mtd/nand/atmel_nand.c          | 133 +++++++++++++++-------------
 drivers/mtd/nand/brcmnand/brcmnand.c   |   5 +-
 drivers/mtd/nand/davinci_nand.c        |  85 +++++++++---------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  21 +++--
 drivers/mtd/nand/hisi504_nand.c        |  14 +--
 drivers/mtd/nand/jz4780_nand.c         |   1 -
 drivers/mtd/nand/lpc32xx_mlc.c         |   1 -
 drivers/mtd/nand/lpc32xx_slc.c         |  24 ++---
 drivers/mtd/nand/mxc_nand.c            |  50 +++++------
 drivers/mtd/nand/nand_base.c           |  99 ++++++++++++++++++++-
 drivers/mtd/nand/omap2.c               |   9 +-
 drivers/mtd/nand/pxa3xx_nand.c         |  28 +++---
 drivers/mtd/nand/qcom_nandc.c          |   1 -
 drivers/mtd/nand/sh_flctl.c            |  31 +++----
 drivers/mtd/nand/sunxi_nand.c          |   1 -
 drivers/mtd/nand/vf610_nfc.c           |   1 -
 drivers/of/Makefile                    |   1 -
 drivers/of/of_mtd.c                    | 155 ---------------------------------
 include/linux/of_mtd.h                 |  56 ------------
 20 files changed, 291 insertions(+), 432 deletions(-)
 delete mode 100644 drivers/of/of_mtd.c
 delete mode 100644 include/linux/of_mtd.h

-- 
2.5.0
